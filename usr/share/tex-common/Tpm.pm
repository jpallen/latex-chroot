# $Id: Tpm.pm 3719 2007-01-23 01:44:19Z karl $
# Written 2004, Fabrice Popineau.
# Public domain.
# 
package Tpm;

BEGIN {

 # $Exporter::Verbose = 1;
 use Exporter ();
 use Carp;
 use XML::DOM;
 use File::Path;
 use FileUtils;
 use Cwd;
 @ISA = qw( Exporter );
 @EXPORT_OK = qw (
		  new 
		  $MasterDir 
		  %TexmfTreeOfType %TypeOfTexmfTree
		  $FtpDir $CurrentArch
		  @TpmCategories
		  @TexmfTrees
		  @ArchList
		  @StandAlonePackages
		  $IgnoredFiles
		  &toRDF &toString
		  &setAttribute &getAttribute
		  &setList &getList
		  &setHash &getHash
		  &patternsExpand 
		  &patternsUpdate
		  &buildPatternsPackage 
		  &buildPatternsDocumentation
		  &getPatterns
		  &fixDate
		  &fixRequires
		  &patternsAuto
		  &completeUsingCatalogue
		  &getAllFileList
		  &getRequiredFileList
		  &getRequiredTpm
		  &getFilesFromPatterns
		  &writeFile
		  &testSync
		  &Tpm2Zip
		  &Clean
		  &Remove
		  $Verbose
		 );

 use vars (@ISA);

}

$MasterDir = "c:/Source/TeXLive/Master";
$ZipDir = "c:/InetPub/ftp/fptex/0.7";
$CurrentArch = "all";
$Editor = ($^O =~ m/win32/i ? "notepad": "vi");

#print "$MasterDir $CurrentArch\n";

%TexmfTreeOfType = ( "TLCore" => "texmf",
		     "Documentation" => "texmf-doc",
		     "Package" => "texmf-dist");
%TypeOfTexmfTree = &reverse_hash(%TexmfTreeOfType);

@TpmCategories = keys %TexmfTreeOfType;
@TexmfTrees = values %TexmfTreeOfType;

# must match subdir names in Master/bin/ directory.
@ArchList = (
	     "alpha-linux",
	     "alpha-osf",
	     "hppa-hpux",
	     "i386-darwin",
	     "i386-freebsd",
	     "i386-linux",
	     "i386-openbsd",
	     "i386-solaris",
	     "mips-irix",
	     "powerpc-aix",
	     "powerpc-darwin",
	     "powerpc-linux",
	     "sparc-solaris",
	     "sparc-linux",
	     "win32",
	     "win32-static",
	     "x86_64-linux"
	    );

@StandAlonePackages = (
		       "TLCore/bin-afm2pl",
		       "TLCore/bin-aleph",
		       "TLCore/bin-dvipdfm",
		       "TLCore/bin-dvipdfmx",
		       "TLCore/bin-dvipsk",
		       "TLCore/bin-gsftopk",
		       "TLCore/bin-lcdftypetools",
		       "TLCore/bin-omega",
		       "TLCore/bin-pdftex",
		       "TLCore/bin-metapost",
		       "TLCore/bin-t1utils",
		       "TLCore/bin-tex4htk",
		       "TLCore/bin-windvi"
		      );

# this list is not up to date, therefore I think it is not needed.
#  . "bin/i386-freebsd|bin/i386-openbsd|bin/i386-solaris|bin/mips-irix"
#  . "|bin/powerpc-aix|bin/powerpc-darwin|bin/sparc-solaris"

# used both to ignore whole tpm's (?) and individual files?
# must match whole path
$IgnoredFiles = "("
  . 'source/.*'
  . '|texmf/tpm/(collection-binaries|texlive|xemtex|scheme-.*|.*-static)\.tpm'
  . '|texmf(-doc|-dist)?/(ls-R|aliases|lists/.*|README|tpm/tpm.dtd)'
  . '|.*/\.svn.*'
  . ")";

# The so-called engines
my @engines = (
               "aleph", "enctex", "eomega", "metafont", "metapost",
               "omega", "pdftex", "pdfetex", "tex", "vtex", 
	       "bibtex", "context", "dvipdfm", "dvips", "ispell",
	       "makeindex","mft", "psutils", "tex4ht", "texdoctk",
	       "ttf2pk");
# The so called formats
my @formats = (
	       "alatex", "amstex", "context", "cslatex", "csplain", "enctex",
	       "eplain", "fontinst", "generic", "jadetex", "lambda",
	       "latex", "latex3",
	       "mex", "physe", "phyzzx", "plain", "psizzl", 
	       "startex", "texinfo", "texsis", "xetex", "xelatex",
               "xmltex", "ytex", );
# Kind of font files
my @fonttypes = (
		 "afm", "misc", "ofm", "opentype", "ovf", "ovp", "pfb",
		 "pfm", "pk", "sfd", "source", "tfm", "truetype", "type1", "vf"
		);
# Font vendors
my @vendors = (
	       "adobe", "amsfonts", "arabi", "archaic", "arphic",
               "bakoma", "bh", "bitstrea", "bluesky",
               "cg", "cns", "cspsfonts-adobe", "groff",
	       "hoekwater", "ibm", "itc", "jknappen", "jmn", "korean", "lh",
	       "mathdesign", "misc", "monotype", "paragrap",
	       "public", "uhc", "urw", "urw35vf", "vntex", "wadalab",
	       "xetex", "yandy");
my @fontmodes = (
		 "ljfour", "ljfive", "cx"
		); 
my @languages = ("bulgarian", "chinese", "czechslovak", "dutch", "english",
                 "finnish", "french", "general", 
		 "german", "greek", "italian", "japanese", "korean",
		 "mongolian",
		 "polish", "portuguese", "russian", "slovak", "spanish",
		 "thai", "turkish", "ukrainian", "vietnamese");

my %dotfiles = (
		"texmf-dist/tex/latex/tools/*" => ( "texmf-dist/tex/latex/tools/.tex" ),
		"texmf/chktex/*" => ( "texmf/chktex/.chktexrc" )
		);

my $CatalogueDir = "${MasterDir}/texmf-doc/doc/english/catalogue";
my $Catalogue;

#
# %Tpm2Catalogue gives a mapping from tpm names to Catalogue entries
#
# missing entries
# ? bengali:pandey
# ? grotesq:urwvf
# ? helvetic:urwvf
# ? knuthotherfonts:halftone
# makedtx:makedtx not working!
# ? oberdiek:twoopt, tabularht, tabularkv, settobox, refcount, alphalph, chemar
# r, classlist, dvipscol, engord, hypbmsec, hypcap, ifdraft, ifpdf, ifvtexm pagese
# l, pdfcolmk pdfcrypt, pdflscape (somehing missing???)
my %Tpm2Catalogue = (
      "ctib" => "ctib4tex",
      "CJK" => "cjk",
      "bayer" => "universa",
      "bigfoot" => "suffix",
      "cb" => "cbgreek",
      "cd-cover" => "cdcover",
      "cmex" => "cmextra",
      "cs" => "csfonts", 
      "cyrplain" => "t2",
      "devanagr" => "devanagari",
      "eCards" => "ecards",
      "ESIEEcv" => "esieecv",
      "euclide" => "pst-eucl",
      "GuIT" => "guit",
      "HA-prosper" => "prosper",
      "ibycus" => "ibycus4",
      "ibygrk" => "ibycus4",
      "IEEEconf" => "ieeeconf",
      "IEEEtran" => "ieeetran",
      "iso" => "isostds",
      "iso10303" => "isostds",
      "jknapltx" => "jknappen",
      "kastrup" => "binhex",
      "le" => "frenchle",
      "mathtime" => "mathtime-ltx",
      "omega-devanagari" => "devanagari-omega",
      "pdftexdef" => "pdftex-def",
      "procIAGssymp" => "prociagssymp",
      "resume" => "res",
      "SIstyle" => "sistyle",
      "SIunits" => "siunits",
      "syntax" => "syntax2",
      "Tabbing" => "tabbing" );

my $Verbose = 0;

sub reverse_hash {
{
  my (%direct) = @_;
  my %reversed;
  my ($key, $value);
  foreach $key (keys %direct) { 
    $reversed{$direct{$key}} = $key;
  }
  return %reversed;
}



}
#----------------------------------------------------------------------
# Helper functions
sub getTextField {
  my ($doc, $f) = @_;
  my $nodelist = $doc->getElementsByTagName("TPM:$f");

  my %s = ( );
  return %s if ($nodelist->getLength <= 0);
  my $node = $nodelist->item(0);
  return %s if (! $node);
  foreach my $k (@{$node->getAttributes->getValues}) {
    $k = $k->getName;
    $s{$k} = $node->getAttribute($k);
  }
  $node = $node->getFirstChild();
  return %s  if (! $node);
  my $str = $node->toString;
  $str = $node->expandEntityRefs($str);
  $s{"text"} = $str;
  return %s;
}

sub getListField {
  my ($doc, $f) = @_;

  my %s = getTextField($doc, $f);
  my $str = $s{"text"};
  $str = "" if (!defined($str));
  $str =~ s/^\n*//;
  $str =~ s/\n*$//;
  $str =~ s/\n/ /gomsx;
  @{$s{"text"}} = split(" ", $str);
  return %s;
}

sub getMultipleTextField {
  my ($doc, $f) = @_;
  my $nodelist = $doc->getElementsByTagName("TPM:$f");
  my @stringlist = ( );

  for (my $i = 0; $i < $nodelist->getLength; $i++) {
    my $node = $nodelist->item($i);
    my %s = ( );
    foreach my $k (@{$node->getAttributes->getValues}) {
      $k = $k->getName;
      $s{$k} = $node->getAttribute($k);
    }
    $node = $node->getFirstChild();
    if ($node) {
      my $text = $node->toString;
      $text =~ s/\n/ /gomsx;
      push @{$s{"text"}}, split(" ", $text);
    }
    push @stringlist, \%s;
  }

  return @stringlist;
}

sub getAttributes {
  my ($doc, $f) = @_;
  my $nodelist = $doc->getElementsByTagName("TPM:$f");
  my %attr = ( );
  return %attr if ($nodelist->getLength <= 0);
  my $node = $nodelist->item(0);

  foreach my $k (@{$node->getAttributes->getValues}) {
    $k = $k->getName;
    $attr{$k} = $node->getAttribute($k);
  }
  return %attr;
}
#----------------------------------------------------------------------

sub new {
  my $type = shift;
  my ($filename) = @_;
  my $self = { };
  bless $self, $type;
  if ($filename) {
    $filename =~ s@\\@/@g;
    $filename .= ".tpm" if ($filename !~ m@\.tpm$@);
    if (! &FileUtils::is_absolute($filename)) {
      $filename = "${Tpm::MasterDir}/${filename}";
    }
    if (! -f $filename) {
      $filename =~ m@^.*/(.*)/(.*)$@;
      if (&FileUtils::member($1, @TpmCategories)) {
	$filename = "${Tpm::MasterDir}/" . $TexmfTreeOfType{$1} . "/tpm/$2";
      }
    }
	die (`pwd` . "$filename not found!\n") if (! -f $filename);
    my $parser = new XML::DOM::Parser;
    $doc = $parser->parsefile($filename);
    my ($type, $name);
    $filename =~ m@^(.*/|)([^/]+)[/\\]tpm[/\\]([^/\.]+)\.tpm$@;
    $type = $TypeOfTexmfTree{$2}; $name = $3;
    $self->initialize($type,$name,$doc);
  }
  return $self;
}

sub initialize {
  my ($self, $type, $name, $doc) = @_;
  my $parser = new XML::DOM::Parser;

  my $text;
  my @list;
  my %field;
  
  %field = &getTextField($doc, "Name");
  $text = $field{"text"};
  if ($text ne $name) {
    print "Warning: $filename has wrong Name attribute ($text should be $name) ... fixing it.\n";
  }
  $self->setAttribute("Name", $name);
  
  %field = &getTextField($doc, "Type");
  $text = $field{"text"};
  if ($text ne $type) {
    print "Warning: $filename has wrong Type attribute ($text should be $type) ... fixing it.\n";
  }
  $self->setAttribute("Type", $type);
  
  for my $tag ("Date", "Version", "Creator", "Size", "Author", "Title", "Description", "Provides") {
    %field =  &getTextField($doc, "$tag");
    $text = $field{"text"};
    $self->setAttribute("$tag", $text);
  }
  
  $text = $self->getAttribute("Provides");
  if ("$type/$name" ne $text) {
    print "Warning: $filename has wrong Provides attribute ($text should be $type/$name) ... fixing it.\n";
  }
  $self->setAttribute("Provides", "$type/$name");
  
  %field = &getAttributes($doc, "Flags");
  $self->setHash("Flags", %field);
  #    map { print "$_ = $field{$_}\n"; } (keys %field);
  
  for my $tag ("BinPatterns", "RunPatterns", "DocPatterns", "SourcePatterns", "RemotePatterns") {
    %field = &getListField($doc, "$tag");
    @list = @{$field{"text"}};
    $self->setList("$tag", @list);
  }
  
  # FIXME ! several architectures !
  @list = &getMultipleTextField($doc, "BinFiles");
  $self->setList("BinFiles", @list);
  
  for my $tag ("RunFiles", "DocFiles", "SourceFiles", "RemoteFiles") {
    %field = &getListField($doc, "$tag");
    $self->setHash("$tag", %field);
  }
  
  my %requires = ();
  for my $tag (@TpmCategories) {
    my $nodelist = $doc->getElementsByTagName("TPM:$tag");
    for (my $i = 0; $i < $nodelist->getLength; $i = $i+1) {
      my $package = $nodelist->item($i)->getAttribute("name");
      push @{$requires{$tag}}, $package;
    }
  }
  $self->setHash("Requires",%requires);
  
  # Installation instructions
  my @instructions = ();
  $nodelist = $doc->getElementsByTagName("TPM:Installation");
  if ($nodelist->getLength > 0) {
    my $executelist = $doc->getElementsByTagName("TPM:Execute");
    for (my $i = 0; $i < $executelist->getLength; $i++) {
      my $inst = $executelist->item($i);
      my %execute = ();
      foreach my $attr (@{$inst->getAttributes->getValues}) {
	$attr = $attr->getName;
	$execute{$attr} =  $inst->getAttribute($attr);
      }
      push @instructions, \%execute;
    }
  }
  
  $self->setList("Installation", @instructions);
  
}

#
# Create a fresh package of $name and $type
#
sub fresh {
  my $type = shift;
  my $self = { };
  bless $self, $type;
  my ($provides) = @_;
  my $name;
  $provides =~ m@^([^/]+)[/\\]([^/\.]+)$@;
  $type = $1; $name = $2;
  my $texmf = $TexmfTreeOfType{$type};
  print "Creating new $type $name tpm file\n";
  my $parser = new XML::DOM::Parser;
  chomp (my $user = `whoami`);  # for Creator field.
  my $doc = $parser->parse("\
<!DOCTYPE rdf:RDF SYSTEM \"../../support/tpm.dtd\">\
<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:TPM=\"http://texlive.dante.de/\">\
  <rdf:Description about=\"http://texlive.dante.de/texlive/tlcore/${name}.zip\">\
    <TPM:Name>${name}</TPM:Name>\
    <TPM:Type>${type}</TPM:Type>\
    <TPM:Date>1970/01/01 01:00:00</TPM:Date>\
    <TPM:Version></TPM:Version>\
    <TPM:Creator>$user</TPM:Creator>\
    <TPM:Author></TPM:Author>\
    <TPM:Title>The ${name} package.</TPM:Title>\
    <TPM:Size>314</TPM:Size>\
    <TPM:Description></TPM:Description>\
    <TPM:Build>\
      <TPM:RunPatterns>${texmf}/tpm/${name}.tpm</TPM:RunPatterns>\
    </TPM:Build>\
    <TPM:RunFiles size=\"270\">${texmf}/tpm/${name}.tpm</TPM:RunFiles>\
    <TPM:Provides>${type}/${name}</TPM:Provides>\
  </rdf:Description>\
</rdf:RDF>\
");
  $self->initialize($type, $name, $doc);
  return $self;
}

sub toRDF {
  my ($self) = @_;
  my $parser = new XML::DOM::Parser;

  $doc = $parser->parse("<!DOCTYPE rdf:RDF\n\
  SYSTEM \"../../support/tpm.dtd\">\n\
<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns\#\"\n\
 xmlns:TPM=\"http://texlive.dante.de/\">\n</rdf:RDF>\n");

  my ($node, $child, $father, $nodelist, %attr);
  # Add an 'about' field
  my $tpmdesc = $doc->createElement("rdf:Description");

  my $name = $self->getAttribute("Name");
  my $type = $self->getAttribute("Type");
  if ($name) {
    # Add an about node
    $node = $doc->createAttribute("about", "http://texlive.dante.de/texlive/" . $type . "/" . $name . ".zip");
    #  my $tpmhref = $doc->createAttribute("href", $href);
    $tpmdesc->setAttributeNode($node);
    #  $tpmdesc->setAttributeNode($tpmhref);
  }
  else {
    warn " toRDF(), no Name found!\n" if (! $name);
  }

  for my $tag ("Name", "Type", "Date", "Version", "Creator", "Title",
               "Description", "Author", "Size", "License") { 
    my $attribute = $self->getAttribute("$tag");
    # None of these are optional
    $node = $doc->createElement("TPM:$tag");
    $child = $doc->createTextNode($attribute);
    $node->appendChild($child);
    $tpmdesc->appendChild($node);
    warn " toRDF($name), no $tag found\n" if ! $attribute && $::opt_warnings;
  }

  # Flags are optional
  $node = $doc->createElement("TPM:Flags");
  %attr = $self->getHash("Flags");
  if (%attr) {
    foreach $key (keys %attr) {
      $child = $doc->createAttribute($key, ${attr}{$key});
      $node->setAttributeNode($child);
    }
    # Only if there are attributes
    $tpmdesc->appendChild($node);
  }

  # Globbed expressions
  $father = $doc->createElement("TPM:Build");

  for my $tag ("BinPatterns", "RunPatterns", "DocPatterns", "SourcePatterns", "RemotePatterns") {
    $node = $doc->createElement("TPM:$tag");
    $text = $self->getList("$tag");
    if ($text ne "" && $text !~ m/^[\s\n]+$/sx) {
      $child = $doc->createTextNode($text);
      $node->appendChild($child);
      $father->appendChild($node);
    }
  }

  $tpmdesc->appendChild($father);
  # End of globbed expressions

  my @binfiles = $self->getList("BinFiles");
  if (@binfiles) {
    for (my $i = 0; $i <= $#binfiles; $i++) {
      $node = $doc->createElement("TPM:BinFiles");
      my %archbin = %{$binfiles[$i]};
      my $tpmattr = $doc->createAttribute("arch", $archbin{"arch"});
      $node->setAttributeNode($tpmattr);
      $tpmattr = $doc->createAttribute("size", $archbin{"size"});
      $node->setAttributeNode($tpmattr);
      my @files = @{$archbin{"text"}};
      if (@files) {
	my $strfiles = (join "\n", @files) . "\n";
	$child = $doc->createTextNode($strfiles);
	$node->appendChild($child);
	$tpmdesc->appendChild($node);
      }
    }
  }

  for my $tag ("RunFiles", "DocFiles", "SourceFiles", "RemoteFiles") {
    $node = $doc->createElement("TPM:$tag");
    %field = $self->getHash("$tag");
    if (%field) {
      my $tpmattr = $doc->createAttribute("size", $field{"size"});
      $node->setAttributeNode($tpmattr);
      my @files = @{$field{"text"}};
      if (@files) {
	my $strfiles = (join "\n", @files) . "\n";
	$child = $doc->createTextNode($strfiles);
	$node->appendChild($child);
	$tpmdesc->appendChild($node);
      }
    }
  }

  $node = $doc->createElement("TPM:Requires");
  my %requires = $self->getHash("Requires");
  if (%requires) {
    foreach my $k (sort @TpmCategories) {
      my @taglist = @{$requires{$k}};
      for my $tag (sort @taglist) {
        my $tpmbin = $doc->createElement("TPM:$k");
        my $a = $doc->createAttribute("name", $tag);
        $tpmbin->setAttributeNode($a);
        $node->appendChild($tpmbin);
      }
    }
    $tpmdesc->appendChild($node);
  }

  $node = $doc->createElement("TPM:Installation");
  my @installation = $self->getList("Installation");
  if (@installation) {
    for(my $i = 0 ; $i <= $#installation; $i++) {
      my $tpmexec = $doc->createElement("TPM:Execute");
      my %execute = %{$installation[$i]};
      my $attr = $doc->createAttribute("function", $execute{"function"});
      $tpmexec->setAttributeNode($attr);
      print " kfunc = $execute{function}\n" if ($::opt_debug);
      
      foreach my $kparam (sort keys %execute) {
        print "  kparam = $kparam\n" if $::opt_debug;
        if ($kparam ne "function") {
	  $attr = $doc->createAttribute($kparam, $execute{$kparam});
          $tpmexec->setAttributeNode($attr);
        }
      }
      $node->appendChild($tpmexec);
    }
    $tpmdesc->appendChild($node);
  }

  $node = $doc->createElement("TPM:Provides");
  $text = $self->getAttribute("Provides");
  $text = $name if (! $text);
  if ($text) {
    $child = $doc->createTextNode($text);
    $node->appendChild($child);
    $tpmdesc->appendChild($node);
  }

  # Set the fragment
  $doc->getElementsByTagName("rdf:RDF")->item(0)->appendChild($tpmdesc);

  return $doc;
}

sub toString {
  my ($self) = @_;
  return $self->toRDF()->toString();
}

sub writeFile {
  my ($self, $name) = @_;
  if (! $name) {
    $name = "${MasterDir}/" . $TexmfTreeOfType{$self->getAttribute("Type")} . "/tpm/" . $self->getAttribute("Name") . ".tpm";
  }
  open (OUT, ">$name") || die "open(>$name) failed: $!";
  # rewrite them without ^M
  binmode(OUT) if ($^O =~ /MSWin32/);
  print OUT $self->toString();
  close (OUT) || warn "close(>$name) failed: $!";
}

sub setAttribute {
  my ($self, $n, $v) = @_;
  $self->{$n} = $v;
}

sub getAttribute {
  my ($self, $n) = @_;
  return ($self->{$n});
}

sub setList {
  my ($self, $n, @v) = @_;
  @{$self->{$n}} = @v;
}

sub getFileList {
  my ($self, $n) = @_;
  my @l = ();
  if ($n eq "BinFiles") {
    foreach $v (@{$self->{$n}}) {
      if (($CurrentArch eq "all" && FileUtils::member(${$v}{"arch"}, @Tpm::ArchList))
	  || ${$v}{"arch"} eq ${CurrentArch}) {
        my @val = @{${$v}{"text"}};
	#print "getfilelist pushing for $v: @val\n";
        push @l, @val;
      }
    }
  }
  elsif ($n =~ /^(Run|Doc|Source|Remote)Files$/) {
    my %v = %{$self->{$n}};
    @l = @{$v{"text"}};
  }
  else {
    @l = @{$self->{$n}};
  }

  if (wantarray) {
    #print "getfilelist($n) returning list: @l\n";
    #&debug_hash ($n, $self->{$n});
    #print "$n {text} = " . @{$n{text}} . "\n";
    return @l;
  }
  else {
    #print "getfilelist($n) returning scalar: @l\n";
    if (@l) {
      return (join "\n", @l);
    }
    else {
      return "";
    }
  }
}

# Need to test forcycles !
sub getRequiredFileList {
  my ($self, $n) = @_;
  my @l = ();
#  print "name = " . $self->getAttribute('Name') . "\n";
  if ($n eq 'all') {
    push @l, $self->getAllFileList();
  }
  else {
    push @l, $self->getFileList($n);
  }

  my %requires = $self->getHash("Requires");
  my @reqlist = ();
  foreach my $k (keys %requires) {
    foreach my $e (@{$requires{$k}}) {
      push @reqlist, ${Tpm::TexmfTreeOfType}{$k} . "/tpm/$e.tpm";
    }
  }
  map {
    my $tpm = Tpm->new($_);
    push @l, $tpm->getRequiredFileList($n);
  } @reqlist;
  return @l;
}

sub getRequiredTpm {
  my ($self, $recursive) = @_;

  my %requires = $self->getHash("Requires");
  my @reqlist = ();
  foreach my $k (keys %requires) {
    foreach my $e (@{$requires{$k}}) {
      push @reqlist, "$k/$e";
    }
  }

  my @l = ();

  if ($recursive) {
    while (@reqlist) {
      my $tpmname = pop @reqlist;
      &FileUtils::push_uniq(\@l, $tpmname);
      my $tpm = Tpm->new($tpmname);
      print "tpmname = $tpmname\n";
      %requires = $tpm->getHash("Requires");
      foreach my $k (keys %requires) {
	foreach my $e (@{$requires{$k}}) {
	  &FileUtils::push_uniq(\@reqlist, "$k/$e");
	}
      }
    }
  }
  else {
    @l = @reqlist;
  }
  print $self->getAttribute("Name") . " requires @l\n";
  return @l;

}

sub getList {
  my ($self, $n) = @_;
  my @l = @{$self->{$n}};
  if ($n eq "BinFiles") {
    # the elements of BinFiles are hash references; we want to sort by
    # the arch name, so the output will be stable.
    @l = sort { $a->{"arch"} cmp $b->{"arch"} } @l;

  } elsif ($n eq "Installation") {
    # Need these alphabetically, too, e.g.,
    @l = sort tpm_inst_sort @l;

  } else {
    @l = sort @l;
  }

  if (wantarray) {
    return @l;
  } elsif (@l) {
    return (join "\n", @l);
  } else {
    return "";
  }
}

# This function is used to sort the TPM:Installation elements for
# getList.  Include both key names and values, e.g.,
# <TPM:Execute function="addMap" mode="mixed" parameter="cm-super-t1.map"/>
# <TPM:Execute function="addMap" mode="mixed" parameter="cm-super-x2.map"/>
# should be sorted in that order.
# 
sub tpm_inst_sort
{
  $astr = join (" ", map { $_ . "=" . $a->{$_} } keys %$a);
  $bstr = join (" ", map { $_ . "=" . $b->{$_} } keys %$b);
  return $astr cmp $bstr;
}

sub setHash {
  my ($self, $n, %v) = @_;
  %{$self->{$n}} = %v;
}

sub getHash {
  my ($self, $n) = @_;
  return %{$self->{$n}};
}

sub getPatterns {
  my ($self, $recurse) = @_;
  my @patterns = ();

  warn "Doing " . $self->getAttribute("Name") . "\n";
  my $type = $self->getAttribute("Type");
  if ($type =~ m/tlcore/i) {
    # already there
#    push @patterns, $self->getList("RunPatterns");
#    push @patterns, $self->getList("DocPatterns");
#    push @patterns, $self->getList("SourcePatterns");
  }  
  elsif ($type =~ m/package/i) {
    $self->buildPatternsPackage();
    # Add them
    push @patterns, $self->getList("RunPatterns");
    push @patterns, $self->getList("DocPatterns");
    push @patterns, $self->getList("SourcePatterns");

    $self->setList("RunPatterns", () );
    $self->setList("DocPatterns",  () );
    $self->setList("SourcePatterns", () );

  }  
  elsif ($type =~ m/documentation/i) {
    $self->buildPatternsDocumentation();
    push @patterns, $self->getList("RunPatterns");
    push @patterns, $self->getList("DocPatterns");
    push @patterns, $self->getList("SourcePatterns");
    
    $self->setList("RunPatterns", () );
    $self->setList("DocPatterns",  () );
    $self->setList("SourcePatterns", () );
  }
  if ($recurse) {
    my %requires = $self->getHash("Requires");
    my @reqlist = ();
    foreach my $k (keys %requires) {
      foreach my $e (@{$requires{$k}}) {
	push @reqlist, ${Tpm::TexmfTreeOfType}{$k} . "/tpm/$e.tpm";
      }
    }
    map {
      print "testing $_\n";
      if (&FileUtils::member("$_", @patterns)) {
	print "Already done: $_\n";
      }
      else {
	my $tpm = Tpm->new("${MasterDir}/$_");
	push @patterns, $tpm->getPatterns($recurse);
      }
    } @reqlist;
  }
  return @patterns;
}

sub getFilesFromPatterns {
  my ($self, $n, $recurse) = @_;
  my @patterns = ();
  if ($n eq "BinFiles") {
    if ($CurrentArch eq "all") {
      my @l = $self->getList("BinPatterns");
      my @lgen = ();
      my @lwin32 = ();
      my @lothers = ();
      while (@l) {
	my $f = shift @l;
	if ($f =~ m/\/\$\{ARCH\}\//) {
	  push @lgen, $f;
	}
	elsif ($f =~ m/\/win32(-static)?\//) {
	  push @lwin32, $f;
	}
	else {
	  push @lothers, $f;
	}
      }

      foreach my $a (@ArchList) {
	# Skip win32, since they are processed separately anyway
	next if ($a =~ m/^win32(-static)?/);
	my @l = @lgen;
	map { $_ =~ s/\$\{ARCH\}/${a}/sxo } @l;
	push @patterns, @l;
      }
      push @patterns, @lwin32;
      push @patterns, @lothers;
    }
    elsif ($CurrentArch =~ m/win32/) {
      my @l = grep { /\/${CurrentArch}\// } $self->getList("BinPatterns");
      push @patterns, @l;
    }
    else {
      push @patterns, (map {s/\$\{ARCH\}/$CurrentArch/ } $self->getList("BinPatterns"));
      push @patterns, (grep { /\/${CurrentArch}\// } $self->getList("BinPatterns"));

    }
  }
  else {
    $n =~ s/Files/Patterns/;
    my @files = $self->getList($n);
    push @patterns, @files;
  }
  my @files = ();
  if (@patterns) {
    @files = ();
    map { 
      push @files, $dotfiles{$_};
      $_ = "$MasterDir/" . $_ ; 
    } @patterns;
    for my $p (@patterns) {
      push @files, &FileUtils::globexpand ($recurse, $p);
      #print "  files after $p: @files\n" if $::opt_debug;
    }
    map { $_ =~ s/^${MasterDir}\///; } @files;
    @files = &FileUtils::sort_uniq(@files);
  }
  return @files;
}

sub patternsExpand {
  my ($self, $recurse) = @_;
  my (%v, $size);
  my @allbinfiles = $self->getFilesFromPatterns("BinFiles", 0);
  my @files = ();
  my $file_number = $#allbinfiles + 1;

  foreach my $a (@ArchList) {
    my @archbinfiles = grep { /\/$a\// } @allbinfiles;
    if (@archbinfiles) {
      $size = &FileUtils::calc_file_size($MasterDir, @archbinfiles);
      my %v = ( );
      $v{"arch"} = $a;
      $v{"size"} = $size;
      push @{$v{"text"}}, @archbinfiles;
      push @files, \%v;
    }
  }
  $self->setList("BinFiles", @files);
  #print "binfiles = @files\n";

  for my $tag ("RunFiles", "DocFiles", "SourceFiles", "RemoteFiles") {
    #print ($self->getAttribute("Name") . ", tag $tag\n") if $::opt_debug;
    my %v = ( );
    @files = $self->getFilesFromPatterns($tag, $recurse);
    #print "  files = @files\n" if $::opt_debug;
    $file_number += $#files + 1;
    $size = &FileUtils::calc_file_size($MasterDir, @files);
    $v{"arch"} = $a;
    $v{"size"} = $size;
    @{$v{"text"}} = @files;
    $self->setHash($tag, %v);
  }

  if ($file_number == 1) {
    # No need to complain about the collection tpm's,
    # they aren't intended to have files.
    my $name = $self->getAttribute("Provides");
    print "Package $name has no files !\n"
      unless $name =~ m!/(collection-*|scheme-*|xemtex|texlive)!;
  }
}

sub compress_bin {
  my (@files) = @_;
  my @result = ();
  # Compute architectures list without win32
  my @al = @ArchList;
  @al = grep { $_ !~ m@win32(-static)?@ } @al;
  
  # Process patterns one by one
  while (@files) {
    # First file in the list
    my $f = $files[0];

    # If it is a win32 file, nothing to do
    if ($f =~ m@/win32(-static)?/@) {
      push @result, $f;
      shift @files;
      next;
    }
    # Else, try to match an architecture in its path
    my $re = $f;
    my $a;			# Keep the architecture that matched
    for my $arch (@al) {
      # Replace the architecture by a catch all pattern
       if ($re =~ s@/(${arch})/@/[^\/]*/@x) {
	 $re = "^${re}\$";
	 $a = $1; last;
       }
    }
    # Because of bg5+latex
    $re =~ s/\+/\\\+/;

    # Compute how many files in the list will match this pattern
    my @match = grep {$_ =~ m@${re}@ } @files;
    # If all the architectures are present, then do the replacement
    if (@match == @al) {
      @files = grep { $_ !~ m@${re}@ } @files;
      $f =~ s@/${a}/@/\${ARCH}/@;
    }
    else {
      shift @files;
    }
    push @result, $f;
  }

  return @result;
}

sub patternsUpdate {
  my ($self) = @_;

  my @patterns = &compress_bin(&FileUtils::regexpify(0, $MasterDir, $self->getFileList("BinFiles")));
  $self->setList("BinPatterns", @patterns);
  @patterns = &FileUtils::regexpify(0, $MasterDir, $self->getFileList("DocFiles"));
  $self->setList("DocPatterns", @patterns);
  @patterns = &FileUtils::regexpify(0, $MasterDir, $self->getFileList("RunFiles"));
  $self->setList("RunPatterns", @patterns);
  @patterns = &FileUtils::regexpify(0, $MasterDir, $self->getFileList("SourceFiles"));
  $self->setList("SourcePatterns", @patterns);
  @patterns = &FileUtils::regexpify(0, $MasterDir, $self->getFileList("RemoteFiles"));
  $self->setList("RemotePatterns", @patterns);
}

sub testSync {
  my ($self) = @_;

  my @files_from_patterns = () ;
  push @files_from_patterns, $self->getFilesFromPatterns("BinFiles");
  push @files_from_patterns, $self->getFilesFromPatterns("RunFiles");
  push @files_from_patterns, $self->getFilesFromPatterns("DocFiles");
  push @files_from_patterns, $self->getFilesFromPatterns("SourceFiles");
  push @files_from_patterns, $self->getFilesFromPatterns("RemoteFiles");

  my @files = ();
  push @files, $self->getFileList("BinFiles");
  push @files, $self->getFileList("RunFiles");
  push @files, $self->getFileList("DocFiles");
  push @files, $self->getFileList("SourceFiles");
  push @files, $self->getFileList("RemoteFiles");
  my @l1 = (); 
  my @l2 = ();
  &FileUtils::diff_list(@files_from_patterns, @files, \@l1, \@l2);
  if ($#l1 < 0 && $#l2 < 0) {
    return 1;
  }
  else {
    print $self->getAttribute("Name") . ": patterns and file lists not in sync\n";
    print "Files in patterns not in lists :\n";
    map { print "$_\n"; } @l1;
    print "Files in lists not in patterns :\n";
    map { print "$_\n"; } @l2;
    return 0;
  }
}


sub formatdate {
  return sprintf("%4d/%02d/%02d %02d:%02d:%02d", 
	       $_[5]+1900, $_[4]+1, $_[3], $_[2], $_[1], $_[0]);
}

sub printdate {
  my ($strDate) = @_;
  my @mytime;
  my ($s, $strTime);

  ($strDate, $strTime) = split " ", $strDate;
  # print "strDate = $strDate; strTime = $strTime\n";
  if ($strDate =~ m@(\d\d\d\d|\d\d)/(\d\d)/(\d\d)@) {
    $mytime[5] = eval $1;
    $mytime[4] = eval $2;
    $mytime[3] = eval $3;
    if ($strTime =~ m@(\d\d):(\d\d):(\d\d)@) {
      $mytime[2] = eval $1;
      $mytime[1] = eval $2;
      $mytime[0] = eval $3;
    }
    $mytime[5] -= 1900 if ($mytime[5] > 1900);
    $mytime[4] -= 1;
  }
  else {
    @mytime = gmtime;
  }

  return &formatdate(@mytime);
}

sub debug_date
{
  my ($str,$date) = @_;
  #warn "$str " . &formatdate(gmtime($date)) . "\n";
}

# if any of FILES are newer than OLDDATE, return the newest mtime.
# 
sub max_date
{
  my ($olddate, @files) = @_;
  my $tpmdate = 0;
  &debug_date ("  max_date files=@files, olddate=", $olddate);
  for my $f (@files) {
    # although the texmf/tpm/*.tpm files are mostly hand-maintained, it
    # still seems best for the TPM:Date to reflect the newest date of
    # the actual files in the package; the sizes and such might still
    # get autoupdated.
    if ($f =~ m,/tpm/.*\.tpm$,) {
      $tpmdate = (stat("$MasterDir/$f"))[9];
      &debug_date ("   tpm itself, found ", $tpmdate);
    }
    elsif (-f "$MasterDir/$f") {
      my @st = stat("$MasterDir/$f");
      &debug_date ("   file $f is ", $st[9]);
      if ($st[9] > $olddate) {
	&debug_date ("    replacing olddate ", $olddate);
        $olddate = $st[9];
      }
    }
  }
  if ($olddate == 0 && $tpmdate) {
    &debug_date ("  max_date using tpm date", $tpmdate);
    $olddate = $tpmdate;
  }
  &debug_date ("  max_date returning ", $olddate);
  return $olddate;
}

sub fixDate {
  my ($self) = @_;
  my $newdate = 0;
  my @binfiles = $self->getFileList("BinFiles");
  #warn "binfiles=@binfiles";
  if ($CurrentArch ne "all") {
    @binfiles = grep { m@/${CurrentArch}/@ } @binfiles;
    warn "arch-filtered for $CurrentArch binfiles=@binfiles";
  }
  $newdate = &max_date($newdate, @binfiles);
  &debug_date (" newdate after bin: ", $newdate);
  #
  $newdate = &max_date($newdate, $self->getFileList("DocFiles"));
  &debug_date (" newdate after doc: ", $newdate);
  #
  $newdate = &max_date($newdate, $self->getFileList("SourceFiles"));
  &debug_date (" newdate after source: " , $newdate);
  #
  $newdate = &max_date($newdate, $self->getFileList("RemoteFiles"));
  &debug_date (" newdate after remote: " , $newdate);
  #
  # Check the RunFiles last, because it includes the tpm itself, and we
  # only want to use that as a last resort.
  $rundate = &max_date($newdate, $self->getFileList("RunFiles"));
  &debug_date (" newdate after run: ", $newdate);
  $self->setAttribute("Date", &formatdate(gmtime($newdate)));
}


sub fixRequires {
  my ($self, $test) = @_;

  my %requires = $self->getHash("Requires");
  if (%requires) {
    foreach my $k (@TpmCategories) {
      my @taglist = @{$requires{$k}};
      my $texmf = $TexmfTreeOfType{$k};
      my @newtaglist = ( );
      for my $tag (@taglist) {
	if (-f "${MasterDir}/${texmf}/tpm/${tag}.tpm") {
	  push @newtaglist, $tag;
	}
	elsif ($test == 0) {
	  print "Requirement ${MasterDir}/${texmf}/tpm/${tag}.tpm is not found.\n";
	}
      }
#      @{$requires{$k}} = @newtaglist;
    }
#    if ($test >= 1) {
#      $self->setHash("Requires",%requires);
#    }
  }
}
#
# This function will print every text node under given nodes
# and catenate the result.
#
sub myToText {
  my (@nodes) = @_;
  return
    join '', ( map { 
      if ($_->isTextNode) {
	my $s =$_->toString; chomp($s); $s;
      } 
      else {
	if ($_->hasChildNodes) { 
	  myToText($_->getChildNodes) . " "; 
	} 
	else { 
	  ''; 
	} 
      }
    } @nodes ) ;
}

sub trim {
  my ($str) = @_;
  $str =~ s/^[\n\s]+//;
  $str =~ s/[\n\s]+$//;
  return $str;
}

#
# Look into the Catalogue to find any supplementary information
# Get the license information, version and release numbers
#
sub completeUsingCatalogue {
  my ($self) = @_;
  my($author, $version, $license, $title, $description);

  my $pkgname = $self->getAttribute("Name");
  $pkgname =~ s/^(bin-|lib-|tex-)//;

  # handle several cases where the Catalogue name
  # is not the package name...
  if (defined($Tpm2Catalogue{$pkgname})) {
    $pkgcat = $Tpm2Catalogue{$pkgname};
  } else {
    $pkgcat = $pkgname;
  }print STDERR "Looking for $pkgname (as $pkgcat) in the Catalogue.\n" if $Verbose;
  my $fletter = substr($pkgcat, 0, 1);
  my $catname = "${CatalogueDir}/entries/$fletter/${pkgcat}.xml"; 
  return if (! -f $catname);
#  print "catname = $catname\n";
  my $parser = new XML::DOM::Parser;
  my $catdoc = $parser->parsefile($catname);

  my $nodelist = $catdoc->getElementsByTagName("author");
  $author = '';
  for (my $i = 0; $i < $nodelist->getLength; $i++) {
    if ($nodelist->item($i)->getElementsByTagName("name")->item(0)->getFirstChild) {
      $author .= ($i == 0 ? "" : " and ") . $nodelist->item($i)->getElementsByTagName("name")->item(0)->getFirstChild->toString;
    }
  }
#  print "author = $author \n";
  $nodelist = $catdoc->getElementsByTagName("version")->item(0);
  if ($nodelist && $nodelist->getElementsByTagName("number")->item(0)) {
    $version = $nodelist->getElementsByTagName("number")->item(0)->getFirstChild;
    if ($version) {
      $version = $version->toString;
#      print "version = $version\n";
    }
  }
  my $node = $catdoc->getElementsByTagName("license")->item(0);
  if ($node) {
    $license = $node->getAttribute("type");
  }
  $node = $catdoc->getElementsByTagName("caption")->item(0);
  if ($node) {
    $title = &trim($node->getFirstChild->toString);
 }
 
  $node = $catdoc->getElementsByTagName("description")->item(0);
  if ($node) {
    my $abstract = $node->getElementsByTagName("abstract")->item(0);
    $node = $abstract if ($abstract);
    $description = myToText( $node );
#    $description = join '', (map { ($_->isTextNode ? $_->toString : '') } $node->getChildNodes);
    $description = &trim($node->expandEntityRefs($description));
#    print "description = |$description|\n";
  }
  my $old_author = &trim($self->getAttribute("Author"));
  my $old_version = &trim($self->getAttribute("Version"));
  my $old_title = &trim($self->getAttribute("Title"));
  my $old_description = &trim($self->getAttribute("Description"));
  my $old_license = &trim($self->getAttribute("License"));

  if ($author && $author ne $old_author) {
    $self->setAttribute("Author", $author);
    print "Replacing $old_author by $author\n";
  }
  if ($version && $version ne $old_version) {
    $self->setAttribute("Version", $version);
    print "Replacing $old_version by $version\n";
  }
  if ($title && $title ne $old_title) {
    $self->setAttribute("Title", $title);
    print "Replacing $old_title by $title\n";
  }
  if ($description && ($description ne $old_description)) {
    $self->setAttribute("Description", $description);
    print "Replacing $old_description by $description\n";
  }
  if ($license && ($license ne $old_license)) {
    $self->setAttribute("License", $license);
    print "Replacing $old_license by $license\n";
  }
}

sub buildPatternsPackage {
  my ($self) = @_;

  my $type = $self->getAttribute("Type");
  return unless $type eq 'Package';

  my $name = $self->getAttribute("Name");
  my $texmf = $TexmfTreeOfType{$type};

  # set run patterns
  my @run_patterns = ( );
  my @doc_patterns = ( );
  my @source_patterns = ( );

  # 
  # Usually the package name and the directory name match.
  # Here are the special cases when they don't.
  if (&FileUtils::member(${name}, @engines)) {
    print "special engine patterns for $name\n" if $::opt_debug;
    # If our $name is one of the engines
    push @run_patterns, (
			 $texmf . "/${name}/base/*",
			 $texmf . "/${name}/data/*",      # for context
			 $texmf . "/${name}/misc/*",
			 $texmf . "/${name}/config/*",
			 $texmf . "/metapost/${name}/*",  # also for context
			 $texmf . "/tex/${name}/*"
			);	
    push @doc_patterns, ( $texmf . "/doc/${name}/base/*" );
    push @source_patterns, ( $texmf . "/source/${name}/base/*" );
    # Shouldn't we chose between the previous patterns
    # and these ones?
    map {
      push @run_patterns, $texmf . "/tex/$_/${name}/*";
      push @doc_patterns, ( $texmf . "/doc/$_/${name}/*" );
      push @source_patterns, ( $texmf . "/source/$_/${name}/*" );
    } @formats;

    # Exception for dvips and ttf2pk !
    if (${name} eq 'dvips' || ${name} eq 'ttf2pk') {
      push @run_patterns, 
	( $texmf . "/fonts/map/${name}/base/*", $texmf . "/fonts/map/${name}/config/*",
	  $texmf . "/fonts/enc/${name}/base/*", $texmf . "/fonts/enc/${name}/config/*" );

    # exception for context doc, since everything belongs to context.tpm.
    } elsif (${name} eq 'context') {
      push (@doc_patterns, "$texmf/doc/context/*");

    # Exception for metapost !
    } elsif (${name} eq 'metapost') {
      push @run_patterns, $texmf . "/metapost/support/*";

    # Exception for tex4ht, since we just want everything.
    } elsif (${name} eq 'tex4ht') {
      push @run_patterns,
           ("$texmf/tex4ht/bin/*",
            "$texmf/tex4ht/ht-fonts/*",
            "$texmf/tex4ht/xttl/*",
           );

    # Exception for omega !
    } elsif (${name} eq 'omega') {
      push @run_patterns, 
	( $texmf . "/tex/generic/encodings/*",
	  $texmf . "/tex/generic/omegahyph/*",
	  $texmf . "/omega/otp/char2uni/*",
	  $texmf . "/omega/otp/uni2char/*",
	  $texmf . "/omega/ocp/char2uni/*",
	  $texmf . "/omega/ocp/uni2char/*" );

    # Exception for vtex -- extra map files.
    } if (${name} eq 'vtex') {
      push @run_patterns, $texmf . "/fonts/map/${name}/*";

    }

  # 
  } elsif (&FileUtils::member(${name}, @formats)) {
    print "special format patterns for $name\n" if $::opt_debug;
    # if our $name is one of the formats
    map {
      my $e = $_;
      push @run_patterns, (  $texmf . "/$e/${name}/base/*",
			     $texmf . "/$e/${name}/config/*",
			  );
      push @run_patterns, $texmf . "/$e/${name}/*"
        unless ($_ eq 'tex' || $_ eq 'omega')
    } @engines;

    map {
      push @run_patterns, $texmf . "/tex/$_/${name}/*";
    } @formats;

    # for xetex
    push @run_patterns, "$texmf/fonts/misc/$name/*";
    push @doc_patterns, ( $texmf . "/doc/$name/*" ) if $name eq "xetex";

    push @doc_patterns, ( $texmf . "/doc/${name}/base/*" );

    push @source_patterns, ( $texmf . "/source/${name}/base/*" );

    # exception for texinfo since it has no subdirs.
    if (${name} eq 'texinfo') {
      push @run_patterns, $texmf . "/tex/texinfo/*";

    # exception for eplain since it has no subdirs either.
    } elsif (${name} eq 'eplain') {
      push @run_patterns, "$texmf/tex/eplain/*";
      push @doc_patterns, "$texmf/doc/eplain/*";
      push @source_patterns, "$texmf/source/eplain/*";

    # Exception for fontinst, since it has lots of subdirs, including misc.
    # cyrfinst is really a separate package, but let's not clean that up now.
    } elsif (${name} eq 'fontinst') {
      push @run_patterns, $texmf . "/tex/fontinst/*/*";
    }
    
  # 
  } elsif (&FileUtils::member(${name}, @vendors)) {
    print "special vendor patterns for $name\n" if $::opt_debug;
    push @run_patterns, $texmf . "/dvips/${name}/*";
    
    if ($name eq "groff") {
      # Exception for groff: we do not want subdirectories (e.g.,
      # times), we only want actual files (psyrgo.tfm).  Let groff/times
      # end up in times.tpm.
      map { push @run_patterns, "$texmf/fonts/$_/${name}/*.*"; }
      @fonttypes;      
    } else {
      # Everything but groff:
      map { push @run_patterns, "$texmf/fonts/$_/${name}/*"; }
      @fonttypes;
    }

    map { 
      my $e = $_;
      map {
	push @run_patterns, $texmf . "/$e/$_/${name}/*"
            # keep fontinst/misc in fontinst:
          unless ($name eq "misc" && $_ eq "fontinst");
      } @formats;
    } @engines;
    
    # Exception for lh: also have source/latex/lh.
    push @source_patterns, ( $texmf . "/source/latex/$name/*" );  # lh
    
    # Exception for mathdesign: doc is in doc/latex instead of doc/fonts.
    push @doc_patterns, ( $texmf . "/doc/latex/$name/*" );  # mathdesign

    # Exception for vntex: doc is in doc/generic instead of doc/fonts.
    push @doc_patterns, ( $texmf . "/doc/generic/$name/*" );  # vntex

  # 
  } else {
    print "normal patterns for $name\n" if $::opt_debug;
    map {
      my $e = $_;
      push @run_patterns, $texmf . "/$e/${name}/*";
      push @doc_patterns, $texmf . "/doc/$e/${name}/*";
      push @source_patterns, $texmf . "/source/$e/${name}/*";
      map {
	push @run_patterns, $texmf . "/$e/$_/${name}/*"
	  # keep tex/context/pgf in context.
	  unless $name eq "pgf" && $_ eq "context" && $e eq "tex";
      } @formats;
      #warn "run_patterns after engine $e = @run_patterns\n";
    } @engines;

    map {
      push @run_patterns, $texmf . "/tex/$_/${name}/*"
        # keep tex/context/pgf in context.
	unless $name eq "pgf" && $_ eq "context";
      #warn "run_patterns after format $_ = @run_patterns\n";

      push @doc_patterns, $texmf . "/doc/$_/${name}/*";
      push @source_patterns, $texmf . "/source/$_/${name}/*";
    } @formats;
    
    push @doc_patterns, $texmf . "/doc/${name}/*";
    push @source_patterns, $texmf . "/source/${name}/*";
    
    # Exceptions for fontname and glyphlist: their own odd map files.
    if ($name eq 'fontname') {
      push @run_patterns, "$texmf/fonts/map/${name}/*";
    } elsif ($name eq 'glyphlist') {
      push @run_patterns, "$texmf/fonts/map/${name}/*";
    }
  }
  
  #  common to all.
  map {
    my $v = $_;
    map {
      push @run_patterns, $texmf . "/fonts/$_/$v/${name}/*";
    } @fonttypes;
    map {
      push @run_patterns, $texmf . "/fonts/pk/$_/$v/${name}/*";
    } @fontmodes;
  } @vendors;
  
  push @run_patterns, $texmf . "/scripts/${name}/*";
  push @run_patterns, $texmf . "/dvips/${name}/*";
  
  my $bibe = (${name} eq 'bibtex' ? 'base' : ${name});
  push @run_patterns, 
    ( $texmf . "/bibtex/bib/${bibe}/*",
      $texmf . "/bibtex/bst/${bibe}/*",
      $texmf . "/bibtex/csf/${bibe}/*" );
  
  push @run_patterns, 
    ( $texmf . "/fonts/map/dvips/${name}/*", 
      $texmf . "/fonts/map/dvipdfm/${name}/*", 
      $texmf . "/fonts/map/pdftex/${name}/*", 
      $texmf . "/fonts/map/ttf2pk/${name}/*",
      $texmf . "/fonts/enc/dvips/${name}/*", 
      $texmf . "/fonts/enc/dvipdfm/${name}/*", 
      $texmf . "/fonts/enc/pdftex/${name}/*", 
      $texmf . "/fonts/enc/ttf2pk/${name}/*" );
  
  push @run_patterns, "usergrps/$name/*";
  
  push @doc_patterns, $texmf . "/doc/fonts/${name}/*";
  
  push @run_patterns, $texmf . "/omega/ocp/${name}/*";
  push @run_patterns, $texmf . "/omega/otp/${name}/*";
  
  push @source_patterns, $texmf . "/source/fonts/${name}/*";
  push @run_patterns, $texmf. "/tpm/$name.tpm";
  
  #warn "final run_patterns for $name: @run_patterns\n";
  $self->setList("RunPatterns", @run_patterns);
  $self->setList("DocPatterns", @doc_patterns);
  $self->setList("SourcePatterns", @source_patterns);
}


sub autoPatternsCore {
  my ($self) = @_;

  return if ($self->getAttribute("Type") ne 'TLCore');
  my $type = $self->getAttribute("Type");
  my $name = $self->getAttribute("Name");
  my $texmf = $TexmfTreeOfType{$type};

}

sub buildPatternsDocumentation {
  my ($self) = @_;

  return if ($self->getAttribute("Type") ne 'Documentation');
  my $type = $self->getAttribute("Type");
  my $name = $self->getAttribute("Name");
  my $texmf = $TexmfTreeOfType{$type};

  # set run patterns
  my @run_patterns = ( );
  my @doc_patterns = ( );
  my @source_patterns = ( );

  map {
    push @doc_patterns, $texmf . "/doc/$_/${name}/*";
    push @source_patterns, $texmf . "/source/$_/${name}/*";
  } @languages;
    
  push @run_patterns, $texmf. "/tpm/$name.tpm";

  $self->setList("RunPatterns", @run_patterns);
  $self->setList("DocPatterns", @doc_patterns);
  $self->setList("SourcePatterns", @source_patterns);

}

sub autoPatternsPackage {
  my ($self) = @_;

  # map { print "$_\n"; } @run_patterns;
  # map { print "$_\n"; } @doc_patterns;
  # map { print "$_\n"; } @source_patterns;

  $self->buildPatternsPackage();
  $self->patternsExpand(1);

  $self->setList("RunPatterns", () );
  $self->setList("DocPatterns",  () );
  $self->setList("SourcePatterns", () );
}

sub autoPatternsDocumentation {
  my ($self) = @_;

  $self->buildPatternsDocumentation();
  $self->patternsExpand(1);
  
  $self->setList("RunPatterns", () );
  $self->setList("DocPatterns",  () );
  $self->setList("SourcePatterns", () );
}

sub patternsAuto {
  my ($self) = @_;
  my $type = $self->getAttribute("Type");
  if ($type =~ m/tlcore/i) {
    $self->autoPatternsCore();
  }  
  elsif ($type =~ m/package/i) {
    $self->autoPatternsPackage();
  }  
  elsif ($type =~ m/documentation/i) {
    $self->autoPatternsDocumentation();
  }
}

#
# Get all files, optionnaly only for architecture $arch
#
sub getAllFileList {
  my ($self, $arch) = @_;
  my @files = ();
#  print "Getting all file list for " . $self->getAttribute("Name") . "\n";
  ($arch = $CurrentArch) if (undef $arch);

  push @files, $self->getFileList("BinFiles");
  push @files, $self->getFileList("RunFiles");
  push @files, $self->getFileList("DocFiles");
  push @files, $self->getFileList("SourceFiles");
  push @files, $self->getFileList("RemoteFiles");

  return @files;
}

sub fixSize {
  my ($self, $arch) = @_;
  my $size = 0;
  my @files = $self->getList("BinFiles");

  foreach my $f (@files) {
    $size += ${$f}{"size"};
  }

  foreach my $tag ("RunFiles", "DocFiles", "SourceFiles", "RemoteFiles") {
    my %v = $self->getHash("$tag");
    $size += $v{"size"};
  }
  if ($size != $self->getAttribute("Size")) {
    my $name = $self->getAttribute("Name");
    my $old_size = $self->getAttribute("Size");
    print " $name\t size=$size\t old size=$old_size\t diff=" 
          . ($size - $old_size) . "\n";
    $self->setAttribute("Size", $size);
  }
  return $size;
}

sub Tpm2Zip {
  my ($self, $destdir, $full, $standalone) = @_;
  if (! $destdir) {
    $destdir = $ZipDir;
  }
  my $name = $self->getAttribute("Name");
  my $type = $self->getAttribute("Type");
  my $version = $self->getAttribute("Version");

  my @files = (); 
  if ($full eq "full") {
    push @files, $self->getRequiredFileList("RunFiles");
    push @files, $self->getRequiredFileList("DocFiles");
    push @files, $self->getRequiredFileList("SourceFiles");
  }
  else {
    push @files, $self->getFileList("RunFiles");
    push @files, $self->getFileList("DocFiles");
    push @files, $self->getFileList("SourceFiles");
  }

  my ($zipname, $tpmname, $zipcmd, $nul);

  # Create zip files for all $arch if type = binary

  # First, common files
  if ($#files >=0) {

#    if ($name =~ m/-static$/) {
    if ($standalone && &FileUtils::member("$type/$name", @StandAlonePackages)) {
      # static packages are expected to have more complete names
      if ($full eq "full") {
	push @files, $self->getRequiredFileList("BinFiles");
      } else {
	push @files, $self->getFileList("BinFiles");
      }
      $zipname = "$destdir/../standalone/$name";
      $zipname .= "-${version}-${CurrentArch}.zip";
    }
    else {
      $tpmname = "$destdir/$type/$name.tpm";
      $zipname = "$destdir/$type/$name.zip";
    }
  if ($^O =~ /MSWin32/) {
    $nul = "nul";
  }
  else {
    $nul = "/dev/null";
  }
    @files = &FileUtils::sort_uniq(@files);

  if ($zipname =~ /\/binary/ && $^O !~ /MSWin32/) {
    $zipcmd = "| zip -9\@ory "
  }
  else {
    $zipcmd = "| zip -9\@or "
  }

    &mkpath(&FileUtils::dirname($zipname)) if (! -d &FileUtils::dirname($zipname));
    my $cwd = &getcwd;
    chdir($MasterDir);
    unlink $zipname;
    print $zipcmd . $zipname . " > $nul\n" if ($::opt_debug);
    open ZIP, $zipcmd . $zipname . " > $nul";
    map { 
      if (! -f $_) {
	print STDERR "!!!Error: non-existent $_\n";
      } else {
	print ZIP "$_\n";
      }
    } @files;
    close ZIP;
    print "Done $zipname\n" if ($::opt_debug);
  }

  if (! $standalone) {
    # Binaries
    my $DoCurrentArch = ${CurrentArch};
    foreach my $arch (@{ArchList}) {
      if (${DoCurrentArch} eq "all" || ${DoCurrentArch} eq ${arch}) {
	${CurrentArch} = $arch;
	my @binfiles;
	if ($full eq "full") {
	  @binfiles = $self->getRequiredFileList("BinFiles");
	}
	else {
	  @binfiles = $self->getFileList("BinFiles");
	}
	$zipname = "$destdir/$type/$name-$arch.zip";
	
	if ($#binfiles >=0) {
	  &mkpath(&FileUtils::dirname($zipname)) if (! -d &FileUtils::dirname($zipname));
	  my $cwd = &getcwd;
	  chdir($MasterDir);
	  unlink $zipname;
	  print $zipcmd . $zipname . " > $nul\n" if ($::opt_debug);
	  open ZIP, $zipcmd . $zipname . " > $nul";
	  map { 
	    if (! -f $_) {
	      print STDERR "!!!Error: non-existent $_\n";
	    } else {
	      print ZIP "$_\n";
	    }
	  } @binfiles;
	  close ZIP;
	  print "Done $zipname\n" if ($::opt_debug);
	}
      }
    }
    ${CurrentArch} = ${DoCurrentArch};
  }

  # Write the tpm file together with the zip file in the current scheme
  $self->writeFile($tpmname) if ($tpmname);
  chdir($cwd);

}

sub Clean {
  my ($self, $patterns, $fixreq) = @_;

  # Update the Date to the date of the latest file in the package
  $self->fixDate();

  # Find missing information in the Catalogue if possible
  $self->completeUsingCatalogue();

  # Compute the overall size
  $self->fixSize();

  # Fix the tpm file
  my @run_patterns = $self->getList("RunPatterns");

  # First remove all tpm file present in the package
  #print "run_patterns before remove_list = @run_patterns\n";
  &FileUtils::remove_list(\@run_patterns, "\.tpm\$");
  #print "run_patterns after remove_list = @run_patterns\n";

  # Second, add the right one
  my $name = $self->getAttribute("Name");
  my $type = $self->getAttribute("Type");
  push @run_patterns, ${Tpm::TexmfTreeOfType}{$type} . "/tpm/$name.tpm";
  $self->setList("RunPatterns", @run_patterns);

  # Fix the Title
  if (! $self->getAttribute("Title")) {
    $self->setAttribute("Title", "The " . $self->getAttribute("Name") . " package.");
  }

  # Big step, get fiels from patterns.
  if ($patterns eq 'auto') {
    $self->patternsAuto();
  } elsif ($patterns eq 'to') {
    # Update patterns
    $self->patternsUpdate();
  } elsif ($patterns eq 'from') {
    $self->patternsExpand(0);
  }

  # Fix Requires field
  $self->fixRequires(undef $fixreq || $fixreq == 0 || $fixreq eq '' ? 0 : 1);

  $self->setList("RunPatterns", &FileUtils::sort_uniq($self->getList("RunPatterns")));
  $self->setList("DocPatterns", &FileUtils::sort_uniq($self->getList("DocPatterns")));
  $self->setList("SourcePatterns", &FileUtils::sort_uniq($self->getList("SourcePatterns")));

  # Alternatively you could expand patterns if for example you have just edited them
  # See the 'process2_tpm' function below
  # Test that patterns and files list are n sync
  if ($self->testSync()) {
    print "Writing $type/$name\n";
    $self->writeFile();
  }
  else {
    print "ERROR: out of sync between patterns and files in $tpmname (not written).\n";
  }
}


sub Remove {
  my ($self, $patterns, $dry) = @_;
  my @run_patterns = $self->getList("RunPatterns");
  # First remove all tpm file present in the package
  # print "run_patterns = @run_patterns\n";
  &FileUtils::remove_list(\@run_patterns, "\.tpm\$");
  # print "run_patterns = @run_patterns\n";
  # Second, add the right one
  my $name = $self->getAttribute("Name");
  my $type = $self->getAttribute("Type");
  push @run_patterns, ${Tpm::TexmfTreeOfType}{$type} . "/tpm/$name.tpm";
  $self->setList("RunPatterns", @run_patterns);
  if ($patterns eq 'auto') {
    $self->patternsAuto();
  }
  elsif ($patterns eq 'to') {
    # Update patterns
    $self->patternsUpdate();
  }
  elsif ($patterns eq 'from') {
    $self->patternsExpand(0);
  }
  $self->setList("RunPatterns", &FileUtils::sort_uniq($self->getList("RunPatterns")));
  $self->setList("DocPatterns", &FileUtils::sort_uniq($self->getList("DocPatterns")));
  $self->setList("SourcePatterns", &FileUtils::sort_uniq($self->getList("SourcePatterns")));

  map {
    my $file = "${MasterDir}/$_";
    if ($dry) {
      print "would unlink $file\n";
    } else {
      unlink($file) || warn "unlink($file) failed: $!";
      print "unlinked $file\n";
    }
  } $self->getAllFileList();
}


# Log LABEL followed by hash elements, all on one line.
#
sub debug_hash
{
  my ($label) = shift;
  my (%hash) = (ref $_[0] && $_[0] =~ /.*HASH.*/) ? %{$_[0]} : @_;

  my $str = "$label: {";
  my @items = ();
  for my $key (sort keys %hash) {
    my $val = $hash{$key};
    $key =~ s/\n/\\n/g;
    $val =~ s/\n/\\n/g;
    push (@items, "$key:$val");
  }
  $str .= join (",", @items);
  $str .= "}";

  print "$str\n";
}

1;
