% BibTeX bibliography style `cje' (Canadian Journal of Economics)
% this file is based on the `harvard' family of files
        % version 0.99a for BibTeX versions 0.99a or later, LaTeX version 2.09.
        % Copyright (C) 1991, all rights reserved.
        % Copying of this file is authorized only if either
        % (1) you make absolutely no changes to your copy, including name, or
        % (2) if you do make changes, you name it something other than
        % btxbst.doc, plain.bst, unsrt.bst, alpha.bst, abbrv.bst, agsm.bst,
        % dcu.bst, cje.bst, aer.bst, or kluwer.bst.
        % This restriction helps ensure that all standard styles are identical.

% ACKNOWLEDGEMENT:
%   This document is a modified version of alpha.bst to which it owes much of
%   its functionality.

% AUTHOR
%   Peter Williams, Key Centre for Design Quality, Sydney University
%   e-mail: peterw@archsci.arch.su.oz.au

ENTRY
  { address author booktitle chapter edition editor howpublished institution
    journal key month note number organization pages publisher school
    series title type volume year}
  { field.used }
  { canonical.label extra.label sort.label list.year }


INTEGERS {quoted italic bold plain attribute
        space comma tiedcomma semicolon colon period block empty separator
        prev.separator next.separator next.attribute}

STRINGS { s temp f name.list first.name.format later.name.formats name.style}

FUNCTION {init.state.consts}
{
  #100  'quoted :=
  #200  'italic :=
  #300  'bold   :=
  #400  'plain  :=

  #7 'space :=
  #6 'comma :=
%  #5 'tiedcomma :=
%  #4 'semicolon :=
%  #3 'colon :=
  #2 'period :=
  #1 'block :=
  #0 'empty :=
}

FUNCTION {output2}
{
% Wrap the attribute.
    attribute bold = {"{\bf " swap$ * "}" *} {} if$
    attribute italic = {"{\it " swap$ * "}" *} {} if$
    attribute quoted = {"`" swap$ * "'" *} {} if$
% Append additional separators
    separator comma = {"," * space 'separator :=} {} if$
%    separator tiedcomma = {",~" * empty 'separator :=} {} if$
    separator space = {" " *} {} if$
    write$
    separator block = {newline$ "\newblock " write$} {} if$
% Update variables, and put the new string back on the stack
    next.attribute 'attribute :=
    next.separator 'separator :=
    temp
}

% <string> <separator> <string> <attribute> <final separator> output <string>
FUNCTION {output.nonnull}
{   'next.separator :=
    'next.attribute :=
    'temp :=
    'prev.separator :=
% If the new separator is stronger than the previous one, use it.
    prev.separator separator < {prev.separator 'separator :=} {} if$
% Append most separators to the string.
    separator block = {add.period$} {} if$
    separator period = {add.period$ space 'separator :=} {} if$
    separator comma = {"," * space 'separator :=} {} if$
%    separator semicolon = {";" * space 'separator :=} {} if$
%    separator colon = {":" * space 'separator :=} {} if$
    output2
}

FUNCTION {output}
{   'next.separator :=
    'next.attribute :=
    duplicate$ empty$
        {pop$ pop$}
        {next.attribute next.separator output.nonnull}
        if$
}

FUNCTION {output.check}
{   's :=
    'next.separator :=
    'next.attribute :=
    duplicate$ empty$
        {pop$ pop$ "empty " s * " in " * cite$ * warning$ }
        {next.attribute next.separator output.nonnull}
        if$
}

FUNCTION {item.check}
{ 'temp :=
  empty$
    { "empty " temp * " in " * cite$ * warning$ }
    {}
  if$
}

FUNCTION {plain.space} { plain space }

FUNCTION {plain.space.output} { plain.space output }

FUNCTION {fin.entry}
{   block note plain.space.output

  empty 'separator :=
  empty "" plain empty output.nonnull pop$
  newline$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   {}
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    {}
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    {}
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {quote}
{ duplicate$ empty$
    { pop$ "" }
    { add.period$ "`" swap$ * "'" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 'name.list :=
  'name.style :=
  'later.name.formats :=
  's := % binary separator
  'first.name.format :=
  #1 'nameptr :=
  name.list num.names$ 'numnames :=
% If we're to make this entry bold or something, prepend to the string of names
  name.style "" = {} {"{" name.style *} if$
  numnames 'namesleft :=
    { namesleft #0 > }
    { name.list nameptr nameptr #1 = {first.name.format} {later.name.formats} if$
                format.name$ 'temp :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * temp * }
            { temp "others" =
                { " et~al." * }
                {nameptr #2 =   % handle ", and" vs " and "
                    {s * temp *}
                    {", and " * temp * }
                    if$
                }
                if$
            }
            if$
        }
        'temp
        if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
% If we're to make this entry bold or something, append to the string of names
  name.style "" = {} {"}" * *}  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { extra.label "\bysame" =
         {"\bysame"}
         { "{vv~}{ll}{, jj}{, ff}" ", and " "{ff~}{vv~}{ll}{, jj}" "" author
                format.names }
         if$
    }
    if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { "{vv~}{ll}{, jj}{, ff}" ", and " "{ff~}{vv~}{ll}{, jj}" ""
                editor format.names
      editor num.names$ #1 >
        { ", eds" * }
        { ", ed." * }
      if$
    }
  if$
}

FUNCTION {format.editors.reverse}
{ editor empty$
    { "" }
    { "ed. "
      "{ff~}{vv~}{ll}{, jj}" " and " "{ff~}{vv~}{ll}{, jj}" ""
                editor format.names
      *
    }
  if$
}

FUNCTION {format.title}
{ space
  title empty$
    { "" }
    { title "t" change.case$}
  if$
 quoted period
}

FUNCTION {n.dashify}
{ 'temp :=
  ""
    { temp empty$ not }
    { temp #1 #1 substring$ "-" =
        { temp #1 #2 substring$ "--" = not
            { "--" *
              temp #2 global.max$ substring$ 'temp :=
            }
            {   { temp #1 #1 substring$ "-" = }
                { "-" *
                  temp #2 global.max$ substring$ 'temp :=
                }
              while$
            }
          if$
        }
        { temp #1 #1 substring$ *
          temp #2 global.max$ substring$ 'temp :=
        }
      if$
    }
  while$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "vol." volume tie.or.space.connect
      series empty$
        {}
        { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {mid.sentence.q}
{
    separator empty = separator block = separator period = or or not
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        {series field.or.null}
        { mid.sentence.q
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { add.period$ " In " * series quote * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition
      mid.sentence.q { "l"} { "t"} if$
      change.case$ " ed." * 
    }
  if$
}

FUNCTION {format.publisher.address}
{
    publisher empty$ address empty$ and
        {}
        { space
            address empty$ {"("} {"(" address *} if$
            publisher empty$ address empty$ or {} {": " *} if$
            publisher empty$ {} {publisher *} if$
            ")" * plain.space output.nonnull
        }
        if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 'temp :=
  #0 'multiresult :=
    { multiresult not
      temp empty$ not
      and
    }
    { temp #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { temp #2 global.max$ substring$ 'temp := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "pp.~" pages n.dashify * }
        { "p.~" pages * }
      if$
    }
  if$
}

FUNCTION {output.vol.num.pages}
{ space
  volume field.or.null
  number empty$
    {}
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        {}
      if$
    }
  if$
  pages empty$
    {}
    { duplicate$ empty$
        { pop$ format.pages }
        { ",~" * pages n.dashify * }
      if$
    }
  if$
  plain.space.output
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        {}
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {output.in.ed.booktitle}
{   booktitle empty$
    { booktitle "booktitle" item.check }
    { space "In" plain.space output.nonnull
      editor empty$
        { space booktitle quoted space output.nonnull}
        { space booktitle italic comma output.nonnull
          comma format.editors.reverse plain.space output.nonnull}
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
    {}
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    {}
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    {  }
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
        { "in {\it " journal * "\/} \cite{" * crossref * "}" *}
      if$
    }
    { add.period$ "In \citeasnoun{" crossref * "}" * }
  if$
 
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "in "
    }
    { "Vol." volume tie.or.space.connect
      " of " *
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
            { "{\it " * series * "\/} \cite{" * crossref * "}" *}
          if$
        }
        { " \citeasnoun{" * crossref * "}" * }
      if$
    }
    { " \citeasnoun{" * crossref * "}" * }
  if$
}

FUNCTION {output.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
            }
            { period "In {\it " booktitle * "\/}" * " \cite{" * crossref * "}" * plain.space output.nonnull}
          if$
        }
        { period "In \citeasnoun{" crossref * "}" * plain.space output.nonnull}
      if$
    }
    { period "In \citeasnoun{" crossref * "}" * plain.space output.nonnull}
  if$
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

INTEGERS { author.field editor.field organization.field title.field key.field }

FUNCTION {init.field.constants}
{ #0 'author.field :=
  #1 'editor.field :=
  #2 'organization.field :=
  #3 'title.field :=
  #4 'key.field :=
}

FUNCTION {format.lab.names.abbr}
{ 'name.list :=
  name.list num.names$ 'numnames :=
  numnames #1 >
    { numnames #2 >
        { name.list #1 "{vv~}{ll}" format.name$ " et al." * }
        { name.list #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { name.list #1 "{vv~}{ll}" format.name$ " et al." * }
            { name.list #1 "{vv~}{ll}" format.name$ " and " *
              name.list #2 "{vv~}{ll}" format.name$ * 
            }
          if$
        }
      if$
      field.used editor.field = {", eds" *} {} if$
    }
    {
        name.list #1 "{vv~}{ll}" format.name$
        field.used editor.field = {", ed" *} {} if$
    }
  if$
}

FUNCTION {format.lab.names.full}
{ 'name.list :=
  #1 'nameptr :=
  name.list num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { name.list nameptr "{vv~}{ll}" format.name$ 'temp :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * temp * }
            { temp "others" =
                { " et~al." * }
                { " and " * temp * }
              if$
            }
          if$
        }
        'temp
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  numnames #1 > field.used editor.field = and {", eds" *} {} if$
  numnames #1 = field.used editor.field = and {", ed" *} {} if$
}

FUNCTION {make.list.label}
{ author.field field.used =
    { format.authors }
    { editor.field field.used =
        { format.editors }
        { organization.field field.used =
            { "The " #4 organization chop.word}
            { title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {make.full.label}
{ author.field field.used =
    { author format.lab.names.full }
    { editor.field field.used =
        { editor format.lab.names.full }
        { organization.field field.used =
            { "The " #4 organization chop.word #3 text.prefix$ }
            { title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {make.abbr.label}
{ author.field field.used =
    { author format.lab.names.abbr }
    { editor.field field.used =
        { editor format.lab.names.abbr }
        { organization.field field.used =
            { "The " #4 organization chop.word #3 text.prefix$ }
            { title.field field.used =
                { format.btitle }
                { key.field field.used =
                    { key #3 text.prefix$ }
                    { "Internal error :001 on " cite$ * " label" * warning$ }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\harvarditem[" write$
  make.abbr.label write$
  "]{" write$
  make.full.label write$
  "}{" write$
  list.year write$
  "}{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  empty 'separator :=
  plain 'attribute :=


% FUNCTION {list.label.output}

space make.list.label plain.space output.nonnull
  "n.d." list.year = 
        {}
        { space "(" list.year * ")" * plain.space output.nonnull}
        if$
}

FUNCTION {format.title.if.not.sortkey}
{title.field field.used =
    {}
    { format.title output }
  if$}

FUNCTION {format.title.if.not.sortkey.check}
{title.field field.used =
    {}
    { format.title "title" output.check }
  if$}

FUNCTION {article}
{ output.bibitem
  author "author" item.check
  format.title.if.not.sortkey.check
  crossref missing$
    { space journal italic space "journal" output.check
      pages empty$
        {}
        {output.vol.num.pages}
        if$
    }
    { space format.article.crossref plain.space output.nonnull
      comma format.pages plain.space.output
    }
  if$
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { editor "author and editor" item.check }
    { crossref missing$
        { "author and editor" editor either.or.check }
        {}
      if$
    }
  if$
  title.field field.used =
    {}
    { space title italic space "title" output.check }
  if$
  crossref missing$
    {
      space format.number.series plain.space.output
      comma format.edition plain.space.output
      comma format.bvolume plain.space.output
      format.publisher.address
    }
    { space format.book.crossref plain.space output.nonnull
      comma format.edition plain.space.output
    }
  if$
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.title.if.not.sortkey.check
  space howpublished plain.space.output
  space address plain.space.output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { editor "author and editor" item.check }
    { crossref missing$
        { "author and editor" editor either.or.check }
        {}
      if$
    }
  if$
  title.field field.used =
    {}
    { space title italic space "title" output.check }
  if$
  crossref missing$
    { space format.number.series plain.space.output
      comma format.edition plain.space.output
      comma format.bvolume plain comma output
      format.publisher.address
%      space publisher plain.space "publisher" output.check
%      space address plain.space.output
    }
    { space format.book.crossref plain.space output.nonnull
      comma format.edition plain.space.output
    }
  if$
  format.chapter.pages "chapter and pages" output.check
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.title.if.not.sortkey.check
  author "author" item.check
  crossref missing$
    { output.in.ed.booktitle
      comma format.edition plain.space.output
      comma format.bvolume plain.space.output
      space format.number.series plain.space.output
      format.publisher.address
    }
    { output.incoll.inproc.crossref }
  if$
  space format.chapter.pages plain.space.output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.title.if.not.sortkey.check
  author "author" item.check
  crossref missing$
    { output.in.ed.booktitle
      comma format.bvolume plain.space.output
      space format.number.series plain.space.output
      address empty$
        { space organization plain.space.output
          space publisher plain.space.output
        }
        { space organization plain.space.output
          space publisher plain.space.output
          space address plain.space output.nonnull
        }
      if$
    }
    { output.incoll.inproc.crossref}
  if$
  space format.pages plain.space.output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  title.field field.used =
    {}
    {author empty$ {comma}{space} if$
     title italic space "title" output.check }
  if$
  organization.field field.used = organization empty$ or
        {} {space organization plain.space output.nonnull} if$
  comma format.edition plain.space.output
  format.publisher.address
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  author "author" item.check
  format.title.if.not.sortkey.check  space "Master's thesis" format.thesis.type plain.space output.nonnull
  comma school plain.space "school" output.check
  comma address plain.space.output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.title.if.not.sortkey
  space howpublished plain.space.output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  author "author" item.check
  format.title.if.not.sortkey.check
  space "PhD dissertation" format.thesis.type plain.space output.nonnull
  comma school plain.space "school" output.check
  comma address plain.space.output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  title.field field.used =
    {}
    { space title italic space "title" output.check }
  if$
  comma format.bvolume plain.space.output
  space format.number.series plain.space.output
  address empty$
    { editor empty$
        {}
        { space organization plain.space.output
        }
      if$
      space publisher plain.space.output
    }
    { editor empty$
        {}
        { space organization plain.space.output }
      if$
      space publisher plain.space.output
      space address plain.space output.nonnull
    }
  if$
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  author "author" item.check
  format.title.if.not.sortkey.check
  space format.tr.number plain.space output.nonnull
  institution empty$
    {}
    { comma institution plain.space "institution" output.check }
    if$
  comma address plain.space.output
  comma month plain.space.output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  author "author" item.check
  format.title.if.not.sortkey.check
  note "note" item.check
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

READ

EXECUTE {init.field.constants}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {author.key.label}
{ author empty$
    { title empty$
        { key.field 'field.used := }
        { title.field 'field.used := }
      if$
    }
    { author.field 'field.used := }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { title empty$
            { key.field 'field.used := }
            { title.field 'field.used := }
          if$
        }
        { editor.field 'field.used := }
      if$
    }
    { author.field 'field.used := }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { organization empty$
        { title empty$
            { key.field 'field.used := }
            { title.field 'field.used := }
          if$
        }
        { organization.field 'field.used := }
        if$
    }
    { author.field 'field.used := }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { organization empty$
        { title empty$
            { key.field 'field.used := }
            { title.field 'field.used := }
             if$
            }
       { organization.field 'field.used := }
       if$
    }
    { editor.field 'field.used := }
  if$
}

FUNCTION {sort.format.title}
{ 'temp :=
  "A " #2
    "An " #3
      "The " #4 temp chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "manual" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  make.abbr.label
  title.field field.used =
    { sort.format.title }
    { sortify }
  if$
  year field.or.null purify$ #-1 #4 substring$ sortify
  *
  'sort.label :=
}

FUNCTION {first.presort}
{ calc.label
  sort.label
  title.field field.used =
    {}
    { "    "
      *
      make.list.label sortify
      *
      "    "
      *
      title field.or.null
      sort.format.title
      *
    }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {first.presort}

SORT

STRINGS { last.sort.label next.extra }

INTEGERS { last.extra.num }

FUNCTION {initialize.last.extra.num}
{ #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    {}
  if$
  year empty$
    { "n.d." extra.label * 'list.year := }
    { year extra.label * 'list.year := }
  if$
  extra.label 'next.extra :=
}

EXECUTE {initialize.last.extra.num}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {second.presort}
{ make.list.label
  title.field field.used =
    { sort.format.title }
    { sortify }
  if$
  "    "
  *
  list.year field.or.null sortify
  *
  "    "
  *
  title.field field.used =
    {}
    { title field.or.null
      sort.format.title
      *
    }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {second.presort}

SORT

STRINGS { prev.author }

INTEGERS { number.label }

FUNCTION {initialize.longest.label}
{
  #1 'number.label :=
  "abcxyz" 'prev.author :=
}

FUNCTION {longest.label.pass}
{ 
author empty$ { editor empty$ {"foo"} {editor} if$} {author} if$
                 prev.author =
    { "\bysame" 'extra.label := }
    { "" 'extra.label :=
author empty$ { editor empty$ {"abcxyz"} {editor} if$} {author} if$
    'prev.author := 
    }
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    {}
    { preamble$ write$ newline$ }
  if$
  "\ifx\undefined\bysame" write$ newline$
  "\newcommand{\bysame}{\leavevmode\hbox to\leftmargin{\hrulefill\,\,}}"
       write$ newline$
  "\fi" write$ newline$
  "\begin{thebibliography}{xx}" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
        {newline$ "\end{thebibliography}" write$ newline$ }

EXECUTE {end.bib}

