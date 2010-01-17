%%
%% This is file `smfplain.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% smfbib.dtx  (with options: `plain')
%% 
%%% ==================================================================== %%%
%%% FORMATS BibTeX SMF
%%% Styles BibTeX pour la SMF
%%% (c) A. Chambert-Loir et SMF, 1996-98
%%% ==================================================================== %%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
%%  @BibTeX-style-file{"smfplain.bst"
%%  date="1998/06/15",
%%  version="v0.1"}
%% Types of entries currently allowed in a BibTeX file:
%% ARTICLE -- An article from a journal or magazine.
%% BOOK -- A book with an explicit publisher.
%% BOOKLET -- A work that is printed and bound,
%%     but without a named publisher or sponsoring institution.
%% CONFERENCE -- The same as INPROCEEDINGS,
%%     included for Scribe compatibility.
%% INBOOK -- A part of a book,
%%     which may be a chapter (or section or whatever) and/or a range of pages.
%% INCOLLECTION -- A part of a book having its own title.
%% INPROCEEDINGS -- An article in a conference proceedings.
%% MANUAL -- Technical documentation.
%% MASTERSTHESIS -- A Master's thesis.
%% MISC -- Use this type when nothing else fits.
%% PHDTHESIS -- A PhD thesis.
%% PROCEEDINGS -- The proceedings of a conference.
%% TECHREPORT -- A report published by a school or other institution,
%%     usually numbered within a series.
%% UNPUBLISHED -- A document having an author and title, but not formally
%%     published.
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    language
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  { label extra.label }

INTEGERS { output.state before.all mid.sentence after.name }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'after.name :=
  #2 'mid.sentence :=
}


STRINGS { s t }
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {guillemetize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\og " swap$ * "\fg}" * }
   if$
}

FUNCTION {scapify}
{ duplicate$ empty$
    { pop$ "" }
    { "{\scshape " swap$ * "}" * }
  if$
}


FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
{ t #1 #2 substring$ "--" = not
    { "--" *
      t #2 global.max$ substring$ 't :=
    }
    {   { t #1 #1 substring$ "-" = }
{ "-" *
  t #2 global.max$ substring$ 't :=
}
      while$
    }
  if$
}
{ t #1 #1 substring$ *
  t #2 global.max$ substring$ 't :=
}
      if$
    }
  while$
}


FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {add.space.if.necessary}
{ duplicate$ "" =
    'skip$
    { " " * }
  if$
}


FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}


FUNCTION {output.nonnull}
{ 's :=
  output.state after.name =
    { extra.label "\bysame" =
      { ", " * write$ }
      { " -- " * write$ }
      if$
      mid.sentence  'output.state := }
    {  output.state mid.sentence =
       { ", " * write$ }
       { output.state before.all =
         'write$
          { add.period$ " " * write$ }
         if$
         after.name 'output.state := }
     if$ }
   if$
  s
}


FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}


FUNCTION {missing.warning}
{ "missing " swap$ * " in " * cite$ * warning$ }


FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ t missing.warning }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}


FUNCTION {format.language}
{ language empty$
    { "" }
    { " (" language * ")" * }
  if$
}
INTEGERS { nameptr namesleft numnames }


FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
{ namesleft #1 >
    { ", " * t * }
    { numnames #2 >
{ "" * }
'skip$
      if$
      t "others" =
{ " {\normalfont et~al.}" * }
{ " {\normalfont \smfandname} " * t * }
      if$
    }
  if$
}
't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { extra.label "\bysame" =
         { "\bysame " }
         { author format.names scapify }
     if$
    }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { extra.label "\bysame" =
         { "\bysame " }
         { editor format.names scapify }
      if$
      editor num.names$ #1 >
  { " (\smfedsname)" * }
      { " (\smfedname)" * }
      if$
      "\nomorebysame" 'extra.label :=
    }
  if$
}

FUNCTION {format.nonauthor.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
{ ", \smfedsname" * }
{ ", \smfedname" * }
      if$
    }
  if$
}

FUNCTION {format.booktitle}
{ title empty$
    { "" }
    { title "t" change.case$ emphasize }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ guillemetize }
  if$
}

FUNCTION {format.journal.vol.year}
{ journal empty$
    { "journal name" missing.warning ""}
    { journal emphasize }
  if$
  volume empty$
    'skip$
    { " \textbf{" * volume * "}" * }
  if$
  year empty$
    { "year" missing.warning }
    { " (" * year * ")" * }
  if$
}


FUNCTION {format.number}
{ number empty$
    { "" }
    { "no.~" number * }
  if$
}


FUNCTION {format.date}
{ year empty$
    { month empty$
{ "" }
{ "there's a month but no year in " cite$ * warning$
  month
}
      if$
    }
    { month empty$
'year
{ month " " * year * }
      if$
    }
  if$
}


FUNCTION {format.bookvolume.series.number}
{ volume empty$
    { "" % Push the empty string as a placeholder in case everything else
         % is empty too.
      series empty$
        'skip$
        { pop$ series } % if series is not empty put in stack
      if$
      number empty$
        'skip$
        { duplicate$ empty$ % if no preceding material,
            'skip$          % do nothing, otherwise
            { ", " * }      % add a comma and space to separate.
          if$
          "no." number tie.or.space.connect * % add the number information
        }
      if$
    }
%% If the volume is NOT EMPTY:
    { "vol." volume tie.or.space.connect % vol. XX
      number empty$
        { series empty$
            'skip$
            { series ", " * swap$ *}    % Series Name, vol. XX
          if$
        }
        { series empty$
            { "can't use both volume and number if series info is missing"
              warning$
              "in BibTeX entry type `" type$ * "'" * top$
            }
            { ", " * series * ", no." * number tie.or.space.connect }
          if$
        }
      if$
    }
  if$

}  % end of format.bookvolume.series.number

%% format.inproc.title.where.editors is used by inproceedings entry types

FUNCTION {format.inproc.title.address.editors}
{ booktitle empty$
    { "" }
%%      Emphasizing the title.  We want initial caps, roman.
    { booktitle emphasize }
  if$
%%      We add parentheses around the address (place where conference
%%      was held).
  address empty$
    'skip$
    { add.space.if.necessary "(" * address * ")" * }
  if$
%%      Likewise we add parentheses around the editors' names.
  editor empty$
    'skip$
    { add.space.if.necessary "(" * format.nonauthor.editors * ")" * }
  if$
}

%% format.incoll.title.editors is similar to format.inproc... but
%% omits the address. For collections that are not proceedings volumes.

FUNCTION {format.incoll.title.editors}
{ booktitle empty$
    { "" }
%%      No case changing or emphasizing for the title.  We want initial
%%      caps, roman.
    { booktitle }
  if$
%%      We add parentheses around the editors' names.
  editor empty$
    'skip$
    { add.space.if.necessary "(" * format.nonauthor.editors * ")" * }
  if$
}


FUNCTION {format.number.series}
{ series empty$
    { number empty$
        { "" }
        { "there's a number but no series in " cite$ * warning$ }
      if$
    }
    { series
      number empty$
        'skip$
        { "\ \textbf{" * number * "}" * }
      if$
    }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
{ edition "l" change.case$ " \smfedname" * }
{ edition "t" change.case$ " \smfedname" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
{ #1 'multiresult := }
{ t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { "p.~" pages n.dashify * }
  if$
}

FUNCTION {format.book.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
{ "p.~" pages n.dashify * }
{ "p.~" pages * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
{ "ch.~" }
{ type "l" change.case$ " " * }
      if$
      chapter *
      pages empty$
'skip$
{ ", " * format.book.pages * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Tech. Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
{ "need key or journal for " cite$ * " to crossref " * crossref *
  warning$
  ""
}
{ "in " journal * }
      if$
    }
    { "in " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
'skip$
{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
    { " et~al." * }
    { " \smfandname\ " * editor #2 "{vv~}{ll}" format.name$ * }
  if$
}
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "in "
    }
    { "vol." volume tie.or.space.connect
      " de " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
{ series empty$
    { "need editor, key, or series for " cite$ * " to crossref " *
      crossref * warning$
      "" *
    }
    { series * }
  if$
}
{ key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ key empty$
  { booktitle empty$
    { editor empty$
      editor field.or.null author field.or.null =
      or
         { "need editor, key, or booktitle for " cite$ * "to crossref " *
           crossref * warning$ "" }
         { "in " format.crossref.editor * }
      if$ }
    { "in \emph{" booktitle * "}" * }
    if$ }
  { "in " key * }
  if$
  " \cite{" * crossref * "}" *
}


FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    { format.journal.vol.year output
      format.number output
      format.pages "pages" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  format.language *
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
{ "author and editor" editor either.or.check }
'skip$
      if$
    }
  if$
  format.booktitle "title" output.check
  format.edition output
  crossref missing$
    { format.bookvolume.series.number output
      publisher "publisher" output.check
      address output
    }
    { format.book.crossref output.nonnull
    }
  if$
  format.date "year" output.check
  format.language *
  note output
  fin.entry
}
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  format.booktitle "title" output.check
  howpublished output
  address output
  format.date output
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
{ "author and editor" editor either.or.check }
'skip$
      if$
    }
  if$
  format.title "title" output.check
  crossref missing$
    { format.bookvolume.series.number output
      format.chapter.pages "chapter and pages" output.check
      format.number.series output
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  format.language *
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    { format.incoll.title.editors "booktitle" output.check
      format.bookvolume.series.number output
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
    }
  if$
  note output
  format.book.pages output
  format.language *
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    { format.inproc.title.address.editors "booktitle" output.check
      format.bookvolume.series.number output
      organization output
      publisher output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
    }
  if$
  note output
  format.book.pages output
  format.language *
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
'skip$
{ organization output.nonnull
  address output
}
      if$
    }
    { format.authors output.nonnull }
  if$
  format.booktitle "title" output.check
  author empty$
    { organization empty$
{ address output }
'skip$
      if$
    }
    { organization output
      address output
    }
  if$
  format.edition output
  format.date output
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  format.booktitle "title" output.check
  "\smfmastersthesisname" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  "\smfphdthesisname" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  note output
  format.book.pages output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  format.booktitle "title" output.check
  format.bookvolume.series.number output
  address empty$
    { editor empty$
        'skip$
{ organization output }
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      editor empty$
'skip$
{ organization output }
      if$
      publisher output
      format.date "year" output.check
    }
  if$
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  note output
  fin.entry
}


FUNCTION {misc}
{ output.bibitem
  format.authors output
  format.title output
  howpublished output
  format.date output
  note output
  format.book.pages output
  fin.entry
  empty.misc.check
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  format.title "title" output.check
  note "note" output.check
  format.date output
  fin.entry
}
FUNCTION {default.type} { misc }
READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
{ "   " * }
'skip$
      if$
%%      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      s nameptr "{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
{ "et~al" * }
{ t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
{ "to sort, need author or key in " cite$ * warning$
  ""
}
{ key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
{ key empty$
    { "to sort, need author, editor, or key in " cite$ * warning$
      ""
    }
    { key sortify }
  if$
}
{ editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
{ key empty$
    { "to sort, need author, organization, or key in " cite$ * warning$
      ""
    }
    { key sortify }
  if$
}
{ "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
{ key empty$
    { "to sort, need editor, organization, or key in " cite$ * warning$
      ""
    }
    { key sortify }
  if$
}
{ "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
'editor.organization.sort
{ type$ "manual" =
    'author.organization.sort
    'author.sort
  if$
}
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT
STRINGS { longest.label prev.author this.author }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
  "abcxyz" 'prev.author :=
  "" 'this.author :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  author empty$
    { editor empty$
      { "" }
      'editor
      if$
    }
    'author
  if$
  'this.author :=
  this.author prev.author =
    { "\bysame" 'extra.label := }
    { "" 'extra.label :=
      this.author "" =
        { "abcxyz" }
        'this.author
      if$
      'prev.author :=
    }
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}
FUNCTION {begin.bib}
{
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\providecommand{\bysame}{\leavevmode ---\ }" write$ newline$
  "\providecommand{\og}{``}" write$ newline$
  "\providecommand{\fg}{''}" write$ newline$
  "\providecommand{\smfandname}{et}" write$ newline$
  "\providecommand{\smfedsname}{\'eds.}" write$ newline$
  "\providecommand{\smfedname}{\'ed.}" write$ newline$
  "\providecommand{\smfmastersthesisname}{M\'emoire}" write$ newline$
  "\providecommand{\smfphdthesisname}{Th\`ese}" write$ newline$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
%%
%% End of file `smfplain.bst'.
