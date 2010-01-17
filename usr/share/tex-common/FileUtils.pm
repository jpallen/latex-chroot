# $Id: FileUtils.pm 2402 2006-11-08 01:45:28Z karl $
# Written 2004, Fabrice Popineau.
# Public domain.
# 
package FileUtils;

BEGIN {
  use Exporter ();
  use Cwd;
  use File::Path;
  #  use File::Copy qw(copy);
  use vars qw( @ISA @EXPORT_OK);
 if ($^O eq 'MSWin32')
  { $Separator = "\\" ;}
 else
  { $Separator = "/" ;}

  @ISA = qw(Exporter);

  @EXPORT_OK = qw(
		  &basename
		  &build_path
		  &build_tree
		  &calc_file_size
		  &canon_dir
		  &check_path
		  &cleandir
		  &set_file_time
		  &copy
		  &diff_list
		  &dirname
		  &globexpand
		  &is_absolute
		  &is_dirsep
		  &look_for
		  &make_link
		  &member
		  &min max
		  &move
		  &newer
		  &newpath
		  &normalize
		  &print_tree
		  &push_uniq
		  &rec_copy
		  &rec_mkdir
		  &rec_rmdir
		  &regexpify
		  &remove_list
		  &sort_uniq
		  &start_redirection
		  &stop_redirection
		  &substitute_var_val
		  &sync_dir
		  &walk_dir
		  &walk_tree
		 );
}

# Is the character a directory separator ?
sub is_dirsep {
  my ($c) = @_;
  if ($c =~ /[\/\\]/) {
    return 1;
  } else {
    return 0;
  }
}

# Is the path absolute ?
sub is_absolute {
  my ($d) = @_;
  if ($d =~ m@^([A-Za-z]:)?[/\\]@) {
    return 1;
  } else {
    return 0;
  }
}

# Rewrite '\\' into '/' and deletes multiple ones/
sub canon_dir {
  my ($p, $rep) = @_;
  if ($p =~ m@^(.*)[/\\]$@) {
    $p = $1;
  }
  if (($rep eq '') || ($rep eq '\\')) {
    $p =~ s@/@\\@g;
    $p =~ s@\\[\\]+@\\@g;
    $p =~ s@\\\.\\@\\@g;
    while ($p =~ m/\\\.\./) {
      $p =~ s@\\([^\\]+)\\\.\.@\\@g;
      $p =~ s@\\[\\]+@\\@g;
    }
  } elsif ($rep eq '/') {
    $p =~ s@\\@/@g;
    $p =~ s@/[/]+@/@g;
    $p =~ s@/\./@/@g;
    while ($p =~ m/\/\.\./) {
      $p =~ s@/([^/]+)/\.\.@/@g;
      $p =~ s@/[/]+@/@g;
    }
  } else {
    die ("canon_dir($p) : invalid separator $rep.\n");
  }
  return $p;
}

# Merges all elements in the list into a single path, adding
# directory separators as needed.
sub build_path {
  my($p, $s);
  # Concatenates the arguments, adding path separators as needed
  $p = $_[0];
  for ($i = 1; $i <= $#_; $i++) {
    $p = $p . $Separator . $_[$i];
  }
  return &canon_dir($p);
}

sub sort_uniq {
  my (@l) = @_;
  my ($e, $f, @r);
  @l = sort(@l);
  foreach $e (@l) {
    if ($e ne $f) {
      $f = $e;
      push @r, $e;
    }
  }
  return @r;
}

sub remove_list {
  local (*l, $e) = @_;
  my (@r, $f);
  foreach $f (@l) {
    if ($f !~ m/$e/) {
      push @r, $f;
    }
  }
  @l = @r;
}

sub member {
  my ($e, @l) = @_;
  my ($f);
  foreach $f (@l) {
    if ($e eq $f) {
      return 1;
    }
  }
  return 0;
}

sub push_uniq {
  local (*l, @le) = @_;
  my ($e);
  foreach $e (@le) {
    if (! &member($e, @l)) {
      push @l, $e;
    }
  }
}

sub dirname {
  my ($f) = @_;
  $f =~ m@(^.*)[\\/][^\\/]*$@;
  return $1;
}

sub basename {
  my ($f) = @_;
  $f =~ m@([^\\/]*)$@;
  return $1;
}

sub normalize {
  my ($p, $sep) = @_;
  if ($sep eq '/') {
    $p =~ s@\\@/@g;
    $p =~ s@/(/|\./)*@/@g;
    return $p;
  } elsif ((! $sep) || ($sep eq '\\')) {
    $p =~ s@/@\\@g;
    $p =~ s@\\(\\|\.\\)*@\\@g;
    return $p;
  } else {
    print STDERR "normalize : invalid separator, $sep\n";
    return $p;
  }
}

sub walk_dir {
  # Walks the directory, executing $proc for each file,
  # until done is returned.
  my ($dir, $proc, $prune) = @_;
  my (@l, $f, $done, $src, $DIR);

  #print " walking $dir with $proc, $prune\n" if $::opt_debug;

  if ((! $prune) || ($prune && ! &{$prune}($dir))) {
    $done = 0;
    # Walk the directory tree
    opendir (DIR, $dir) || die "opendir($dir) failed: $!";
    while (my $d = readdir (DIR)) {
      # do not forget to remove "." and ".."
      next if $d =~ /^\.(\.?|svn)$/;
      push (@l, $d);
    }
    closedir (DIR) || warn "closedir($dir) failed: $!";

    # top-down
    &{$proc}($dir, @l);

    foreach $f (@l) {
      my $try = $dir . $Separator . $f;
      # Don't descend symlinks, since they are only used for generic
      # architecture names in bin.  The tpm files use the real arch
      # directory names (with system version numbers).
      if (-d $try && ! -l $try) {
	&walk_dir($try, $proc, $prune);
      }
    }
  }
}

# Builds up a tree from pathes
# $node is a reference to a hash
sub build_tree {
  my (@elts) = @_;
  my $node = { };
  foreach my $p (@elts) {
    &add_path_to_tree($node, split("[/\\\\]", $p));
  }
  return $node;
}

sub add_path_to_tree {
  my ($node, @path) = @_;
  my ($current);

  while (@path) {
    $current = shift @path;
    if ($$node{$current}) {
      $node = $$node{$current};
    } else {
      $$node{$current} = { };
      $node = $$node{$current};
    }
  }
  return $node;
}

# walks the tree, calling the function at each node
sub walk_tree {
  local (@stack_dir);
  walk_tree1(@_);
}

sub walk_tree1 {
  my ($node, $pre_proc, $post_proc) = @_;
  for $k (keys(%{$node})) {
    push @stack_dir, $k;
    $v = $node->{$k};
    if ($pre_proc) { &{$pre_proc}($v, @stack_dir) }
    walk_tree1 (\%{$v}, $pre_proc, $post_proc);
    $v = $node->{$k};
    if ($post_proc) { &{$post_proc}($v, @stack_dir) }
    pop @stack_dir;
  }
}

sub print_node {
  my ($node, @stackdir) = @_;
  if (! keys(%{$node})) {
    print join("/", @stackdir) . "\n";
  }
}

sub print_tree {
  my ($node) = @_;
  &walk_tree($node, \&print_node);
}

sub node2list {
  my ($node, @stackdir) = @_;
  if (! keys(%{$node})) {
    push @list, join("/", @stackdir);
  }
}

sub tree2list {
  my ($node) = @_;
  local @list;
  &walk_tree($node, \&node2list);
  return @list;
}

# Check that a path exists in a tree
# exactly or as a subpath
sub check_path {
  my ($node, @path, $exact) = @_;
  my ($current);
  #  print "Checking for " . join('/', @path) . " exact = $exact\n";
  while (@path) {
    $current = shift @path;
    if ($$node{$current} == undef) {
      return 0;
    } else {
      $node = $$node{$current};
    }
  }
  #  print "left " .  join('/', @path) . " leaf " .  $#{keys %{$node}} . "\n";
  if ($exact) {
    # We are at a leaf !
    return ($#{keys %{$node}} == -1);
  } else {
    return 1;
  }
}



# Removes everything in the directory
# Can't use walk_dir because it could not remove directories.
sub cleandir {
  my ($dir)= @_;
  my ($DIR, $f, @l, $name);

  if (-d $dir) {
    opendir DIR, "$dir";
    # do not forget to remove "." and ".."
    @l = readdir (DIR); shift @l; shift @l;
    closedir DIR;
    foreach $f (@l) {
      $name = $dir . $Separator . $f;
      if (-d $name) {
	&rmtree($name);
	print "rmdir $name\n" if $opt_verbose;
	rmdir "$name";
      } elsif (-f "$name") {
	print "Removing $name\n" if $opt_verbose;
	unlink "$name";
      } else {
	print "Can't remove $name!\n";
      }
    }
  }
}

sub rec_rmdir {
  my (@files) = @_;
  map { &cleandir($_); rmdir($_) } @files;
}

# Builds up a new directory together with any of its parents
sub rec_mkdir {
  my ($path) = @_;
  my $tmp;
  my $old_dir = &getcwd;
  my @l = split ("[/\\\\]", $path);
  if ($path =~ m@[/\\]@) {
    chdir "/"; shift @l;
  }
  elsif ($l[0] =~ m/[A-Za-z]:/) {
    chdir "$l[0]/";
    shift @l;
  }
  while (@l) {
    $tmp = shift(@l);
    mkdir($tmp, 755) if (! -d $tmp);
    print "mkdir $tmp\n";
    chdir $tmp;
  }
  chdir $old_dir;
}

sub copy {
  my (@src, $dest, $l, $t);
  @l = @_;
  $dest = pop @l;

  @src = ();
  if ($#l == 0 && -f $l[0]) {
    @src = @l;
  }
  else {
    map { 
      my @expand = ($_ =~ m/ / ? <"$_"> : <$_>);
#      print "expanding $_ => @expand\n";
      push @src, @expand; 
    } @l;
  }
  my $target;
  map {
    if (! -d $_) {
      open IN, "<$_";
      $target = $dest;
      if (-d $target) {
	$target =  &newpath($dest, &basename($_));
      }
      open OUT, ">$target";

#      print "Copying $_ to " . &newpath($dest, &basename($_)) . "\n";
      binmode(IN);
      binmode(OUT);
      print OUT <IN>;
      close(OUT);
      close(IN);
      &set_file_time($_, $target);
    }
  } @src;
}

sub set_file_time {
  my ($from, $to) = @_;
  @st = stat($from);
  utime($st[8], $st[9], $to);
}

sub rec_copy {
  my (@src, $dest, $l, $dir);
  @l = @_;
  $dest = pop @l;

  @src = ();
  map { 
    my @expand = ($_ =~ m/ / ? <"${_}"> : <${_}>);
#    print "expanding $_ => @expand\n";
    push @src, @expand; 
  } @l;

  if (! -d $dest) {
    mkdir ($dest, 777);
  }

  $dir = &getcwd;
  if (! is_absolute($dest) ) {
    $dest = &canon_dir("$dir/$dest");
    print "new dest = $dest\n";
  }

  map {
    $l = $_;
    if (-d $l) {
      chdir($l);
      &rec_copy("*", "$dest/" . &basename($l));
      chdir($dir);
    } else {
      &copy($l, "$dest/" . &basename($l));
      &set_file_time($l, "$dest/" . &basename($l));
    }
  }  @src;
}

sub move {
  my ($dest) = pop @_;
  my ($src, $f, $l);

  @l = @_;
  foreach $f (@l) {
    # Handle globbing
    if ($f =~ m/[*?]/) {
      my @expand = ($f =~ m/ / ? <"${f}"> : <${f}>);
#      print "expanding $f => @expand\n";
      push @src, @expand;
    } else {
      push @src, $f;
    }
  }
  if (($#src > 2) && (! -d $dest)) {
    print STDERR "*** Move : can't move to $dest, not a directory.\n";
    return;
  }

  foreach $f (@src) {
    if (-d $dest) {
      rename($f, &newpath($dest, &basename($f)));
    } else {
      &copy($f, $dest);
      &set_file_time($f, $dest);
      unlink($f);
    }
  }
}

# Simulate links by copying
sub make_link {
  my ($to, $from) = @_;
  $to = canon_dir($to);
  $from = &newpath(dirname($to), $from);
  print "linking $from -> $to ...";
  if (-e $to) {
    unlink($to);
  }
  if (-d $from) {
    system("xcopy $from $to /f/r/i/e/d/k");
  } else {
    &copy($from, $to);
    &set_file_time($from, $to);
  }
  print " done\n";
}

# Merges all elements in the list into a single path, adding
# directory separators as needed.
sub newpath {
  return &canon_dir(join ($Separator, @_));
}

#
# Search for $key = $val in $file
#
sub look_for {
  my($key, $file) = @_;
  my($ret);
  open FIN, "<$file";
  while (<FIN>) {
    if ($_ =~ m/^$key\s*=\s*(\S*)/) {
      $ret = $1;
      last;
    } elsif (/^\#define\s+$key\s+(\S*)/) {
      $ret = $1;
      last;
    }
  }
  close FIN;
  return $ret;
}


sub max {
  $m = shift;
  while ($_ = shift) {
    $m = $_ if ($_ > $m);
  }
  return $m;
}

sub min {
  $m = shift;
  while ($_ = shift) {
    $m = $_ if ($_ < $m);
  }
  return $m;
}

# Changes lines of the form:
# $var=... to
# $var='$val' in $file
#
sub substitute_var_val {
  my($file, $var, $val) = @_;
  my($success);

  @success = ( );

  if (! -f $file) {
    print STDERR "$0: $file is not a file\n";
    return $success;
  }
  open IN, "<$file";
  open OUT, ">$file.bak";

  while (<IN>) {
    s/^$var\s*=\s*(.*)$/do {
			    push @success, $1;
			    #		   "\$" . $var . "=" . eval('$val') . ";" .
			    "$var = $val"
			   }/e;
    print OUT;
  }
  close IN;
  close OUT;

  &copy("$file.bak", "$file");
  unlink("$file.bak");

  return @success;
}

#
# Used by globexpand($recurse, $dir)
#
sub globexpand_push {
  my ($dir, @l) = @_;
  #print "globexpand_push($dir, @l)\n" if $::opt_debug;
  my ($file);
  $dir =~ s@\\@/@g;
  foreach $file (@l) {
    next if $file =~ /^\.(\.?|svn)$/;
    my $path = "$dir/$file";
    next if $path =~ m/^${Tpm::IgnoredFiles}$/;
    if (-f $path) {
      #print "    push $dir/$file\n" if $::opt_debug;
      push @listglob, $path;
    }
  }
}

#
# Returns the list of files that match $pattern
# Recursively walking directories if $recurse
#
sub globexpand {
  my ($recurse, $pattern) = @_;
  local @listglob = ( );
#  $opt_verbose = ($pattern =~ m/GsTools/i ? 1 : 0);
  if (-f $pattern) {
    push @listglob, $pattern;
  }
  else {
    my @expand = ($pattern =~ m/ / ? <"${pattern}"> : <${pattern}>);
    #print "  globexpanding $pattern => @expand\n" if $::opt_debug;
    while ( @expand ) {
      $_ = shift @expand;
      #print "elt $_\n" if $::opt_debug;
      if (-f $_) {
	#print "    pushing $_\n" if $::opt_debug;
	push @listglob, $_;
      } elsif (($_ ne "") && (-d $_) && ($recurse)) {
	&walk_dir($_, \&globexpand_push);
      }
    }
  }
  #print "  globexpanded $pattern => @listglob\n" if $::opt_debug;
  return @listglob;
}

sub diff_list {
  local ($l1, $l2, *l1_l2, *l2_l1) = @_;

  #   print "Before sorting:\n";
  #   map { print "$_\n"; } @$l1;
  #   print "\n";
  #   map { print "$_\n"; } @$l2;
  #  $opt_verbose = 1;
  #  $opt_debug = 1;

  @l1 = sort(@$l1);
  @l2 = sort(@$l2);

  #   print "After sorting:\n";
  #   map { print "$_\n"; } @l1;
  #   print "\n";
  #   map { print "$_\n"; } @l2;

  while ($#l1 >= 0 || $#l2 >= 0) {
    if ($#l1 == -1) {
      print "No more elements in l1, over.\n" if $opt_debug;
      push (@l2_l1, @l2);
      @l2 = ();
    } elsif ($#l2 == -1) {
      print "No more elements in l2, over.\n" if $opt_debug;
      push (@l1_l2, @l1);
      @l1 = ();
    } else {
      my $comp = $l1[0] cmp $l2[0];

      if ($comp == 0) {
	print "Same element $l1[0], shifting both.\n" if $opt_debug;
	shift @l1;
	shift @l2;
      } elsif ($comp > 0) {
	print "Greater element $l1[0] than $l2[0], shifting l2.\n" if $opt_debug;
	push (@l2_l1, shift @l2);
      } else {
	print "Smaller element $l1[0] than $l2[0], shifting l1.\n" if $opt_debug;
	push (@l1_l2, shift @l1);
      }
    }
  }

  if ($opt_verbose) {
    print "$#l1_l2, $#l2_l1\n";

    print "Elts in l1 and not in l2 : \n";
    map { print "$_\n"; } @l1_l2; print "\n";

    print "Elts in l2 and not in l1 : \n";
    map { print "$_\n"; } @l2_l1; print "\n";
  }
  return ($#l1_l2 == -1 && $#l2_l1 == -1);
}

sub sync_dir {
  my ($src, $dst, $opt_proc, $opt_prune, $opt_dry, $opt_mirror, $opt_nomkdir) = @_;
  local ($cwd, $dry, $mirror, $proc, $prune, $nomkdir);

  $cwd = &getcwd;
  $dry = $opt_dry;
  $mirror = $opt_mirror;
  $proc = $opt_proc;
  $prune = $opt_prune;
  $nomkdir = $opt_nomkdir;

  print "src = $src\ndst = $dst\n";
  if (! chdir($src)) {
    print "Error: can't chdir to $src\n";
    return;
  }
  sync_dir_1(".", $dst);
  chdir($cwd);
}

sub newer {
  my ($f1, $f2) = @_;
  my (@t1, @t2, $t11, $t12);
  @t1 = stat($f1);
  @t2 = stat($f2);
  $t11 = $t1[9];
  $t12 = $t2[9];
  return -1 if ($t11 < $t12);
  return 1 if ($t11 > $t12);
  return 0;
}

sub sync_dir_1 {
  # Walks the directory, executing $proc for each file,
  # until done is returned.
  my ($dir, $dst) = @_;
  my (@l, $f, $done, $src, $DIR);

  print "Walking $dir\n" if $opt_verbose;

  if (! -d $dst) {
    if (-f $dst) {
      # Clash
      print "!!!Clash: $dir is a directory and $dst is a file.\n";
      return;
    } elsif (! $nomkdir) {
      print "Creating missing directory $dst\n";
      mkdir $dst if (! $dry);
    }
  }

  if ((! $prune) || ($prune && ! &{$prune}($dir))) {
    $done = 0;
    # Walk the directory tree
    opendir DIR, "$dir";
    # do not forget to remove "." and ".."
    @l = readdir (DIR); shift @l; shift @l;
    closedir DIR;
    # Apply the filter
    @l = &{$proc}($dir, $dst, @l) if ($proc);

    foreach $f (@l) {
      if (-d $dir . $Separator . $f) {
	# source is directory
	&sync_dir_1($dir . $Separator . $f, $dst . $Separator . $f);
      } elsif (-d $dst . $Separator . $f) {
	# source is file and destination is directory
	print "!!!Clash: $dir is a file and $dst is a directory.\n";
	next;
      } elsif (! -f $dst . $Separator . $f) {
	# source is file and destination is missing
	print "Copying missing file " . $dst . $Separator . $f . "\n";
	if (! $dry) {
	  &copy ($dir . $Separator . $f, $dst . $Separator . $f);
	  &set_file_time($dir . $Separator . $f, $dst . $Separator . $f);
	}
      } else {
	my $compare = &newer($dir . $Separator . $f, $dst . $Separator . $f);
	if ($compare > 0 || ($mirror && $compare < 0)) {
	  # source is file and destination is older than source
	  print "Copying newer file " . $dir . $Separator . $f . " than " . $dst . $Separator . $f . "\n";
	  if (! $dry) {
	    &copy ($dir . $Separator . $f, $dst . $Separator . $f);
	    &set_file_time($dir . $Separator . $f, $dst . $Separator . $f);
	  }
	}
      }
    }
    # Look at the other side
    opendir DIR, "$dst";
    # do not forget to remove "." and ".."
    @l = readdir (DIR); shift @l; shift @l;
    closedir DIR;
    # Apply the same filter procedure
    @l = &{$proc}($dir, $dst, @l) if ($proc);
    foreach $f (@l) {
      # We should look only for things to remove on the destination side
      next if (-e "$dir$Separator$f");
      # If it does not exist on the source side, then remove it.
      if (-d "$dst$Separator$f") {
	print "Removing directory $dst$Separator$f\n";
	&rmtree("$dst$Separator$f") if (! $dry);
      } elsif (-f "$dst$Separator$f") {
	print "Removing file $dst$Separator$f\n";
	unlink("$dst$Separator$f") if (! $dry);
      } else {
	print "Unknown file type $f\n";
      }
    }
  }
}

sub start_redirection {
  local ($log) = @_;

  # start redirection if asked
  if ($log) {
    print "Logging onto $log\n";
    open(SO, ">&STDOUT");
    open(SE, ">&STDERR");

    close(STDOUT);
    close(STDERR);

    open(STDOUT, ">$log");
    open(STDERR,">&STDOUT");

    select(STDERR); $| = 1;
    select(STDOUT); $| = 1;
  }
}

sub stop_redirection {

  local($log) = @_;

  if ($log) {
    close(STDOUT);
    close(STDERR);
    open(STDOUT, ">&SO");
    open(STDERR, ">&SE");
  }
}

sub calc_file_size {
  my ($dir, @files) = @_;
  my ($size, @st);

  # print "calc_file_size : $dir, files = $#files\n"; # if $opt_debug;
  if (! -d $dir) {
    print STDERR "$0: $dir is not a directory!\n";
    return 0;
  }
  $size = 0;
  @files = map { &globexpand(1, "$dir/$_"); } @files;
  map {
    @st = stat($_);
    $size += $st[7];
  } @files;
  # print "size = $size\n" if ($opt_debug);
  return $size;
}

# sub globtest {
#   my ($s1, $s2) = @_;
#   my @l1 = reverse(split("\\/", $s1));
#   my @l2 = reverse(split("\\/", $s2));
#   my $match = 1;
#   #  pop @l1; pop @l2;
#   my $debug = 0;
#   print "l1 = (@l1), l2 = (@l2)\n" if ($debug);

#   while ($match) {
#     my $e1 = pop @l1;
#     my $e2 = pop @l2;
#     print "e1 = $e1, e2 = $e2\n" if ($debug);
#     last if ($e1 eq "" && $e2 eq "");

#     next if ($e1 eq $e2);
#     if ($e1  eq "*") {
#       return 1 if ($#l1 < 0);
#       $e1 = pop @l1;
#       print "e1 = $e1 $#l1 " if ($debug);
#       do {
# 	$e2 = pop @l2;
# 	print "e2 = $e2 " if ($debug);
#       } while ($e1 ne $e2 && $#l2 >= 0);
#       print "\n" if ($debug);
#       return ($e1 eq $e2 ? 1 : 0) if ($#l2 < 0);
#     }
#     if ($e2  eq "*") {
#       return 1 if ($#l2 < 0);
#       $e2 = pop @l2;
#       do {
# 	$e1 = pop @l1;
#       } while ($e2 ne $e1 && $#l1 >= 0);
#       return ($e1 eq $e2 ? 1 : 0) if ($#l1 < 0);
#     }
#     $match = ($e1 eq $e2 ? 1 : 0);
#   }
#   print "returning $match\n" if ($debug);
#   return $match;
# }

sub regexpify_node {
  my ($node, @stackdir) = @_;
  my $relative = join "/", @stackdir;

  @l2 = keys(%{$node});
  # remove directories
  @l2 = grep { ! (keys %{$node->{$_}}) } @l2;
  if (@l2) {
    opendir DIR, "$dir/$relative";
    # do not forget to remove "." and ".."
    my @l = readdir (DIR); shift @l; shift @l;
    closedir DIR;
    @l = grep { ! -d "$dir/$relative/$_" } @l;
    # compare @l and keys(%{$node})
    my (@l3, @l4);
    @l3 = ();
    @l4 = ();
    my $diff = &diff_list(\@l, \@l2, \@l3, \@l4);
    if ($diff) {
      foreach $k (keys(%{$node})) {
	delete $$node{$k} if (! (keys %{$node->{$k}}));;
      }
      $$node{'*'} = { };
    }
  }
  else {

  }
}

sub regexpify_recursive_node {
  my ($node, @stackdir) = @_;
  my $relative = join "/", @stackdir;

  @l2 = keys(%{$node});
  if (@l2) {
    opendir DIR, "$dir/$relative";
    # do not forget to remove "." and ".."
    my @l = readdir (DIR); shift @l; shift @l;
    closedir DIR;
    # compare @l and keys(%{$node})
    my (@l3, @l4);
    @l3 = ();
    @l4 = ();
    my $diff = &diff_list(\@l, \@l2, \@l3, \@l4);
    if ($diff) {
      my $test = 1;
      foreach $k (keys(%{$node})) {
	$test = $test && ! $node->{$k}->{'__noregexpify'};
      }
      if ($test) {
	foreach $k (keys(%{$node})) {
	  delete $$node{$k};
	}
	$$node{'*'} = { };
      }
    } else {
      $node->{'__noregexpify'} = 1;
    }
  }
  else {

  }
}

sub regexpify_cleanup {
  my ($node, @stackdir) = @_;
  if ($node->{'__noregexpify'}) {
    delete $node->{'__noregexpify'};
  }
}

sub regexpify {
  my ($recursive, $texdir, @files) = @_;
  my ($node);
  local $dir = $texdir;

  $node = &FileUtils::build_tree(@files);

  if ($recursive) {
    &FileUtils::walk_tree($node, '', \&regexpify_recursive_node);
    &FileUtils::walk_tree($node, '', \&regexpify_cleanup);
  }
  else {
    &FileUtils::walk_tree($node, '', \&regexpify_node);
  }
  return &FileUtils::tree2list($node);
}

# Print Perl backtrace, for debugging.
sub backtrace {
  my $subr;
  my $stackframe = 0;
  while (($pkg,$filename,$line,$subr) = caller ($stackframe)) {
    print "$filename:$line: $pkg::$subr called\n";
    $stackframe++;
  }
}

END { }

1;
