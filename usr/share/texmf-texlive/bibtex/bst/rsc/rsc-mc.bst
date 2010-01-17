%%
%% This is file `rsc-mc.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% rsc.dtx  (with options: `bib,rsc,mc')
%%  ----------------------------------------------------------------
%%  The rsc package - BibTeX and macro support for Royal Society
%%  of Chemistry and Wiley chemistry articles
%%  Maintained by Joseph A. Wright
%%  E-mail: joseph.wright@morningstar2.co.uk
%%  Released under the GNU General Public License
%%  See http://www.gnu.org/licenses/gpl.txt
%%  ----------------------------------------------------------------
ENTRY
  { address
    author
    booktitle
    chapter
    doi
    edition
    editor
    howpublished
    institution
    journal
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
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence }
INTEGERS { after.block after.item author.or.editor }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'after.item :=
}

FUNCTION {add.comma}
{ ", " * }

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { add.comma write$ }
    { output.state after.block =
      { add.comma write$
        newline$
        "\newblock " write$
      }
      { output.state before.all =
          'write$
          { output.state after.item =
            { " " * write$ }
            { add.period$ " " * write$ }
          if$
          }
        if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "Empty " t * " in " * cite$ * warning$ }
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
{ write$
  "\relax" write$
  newline$
  "\relax" write$
}

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

FUNCTION {boldface}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}

FUNCTION {paren}
{ duplicate$ empty$
    { pop$ "" }
    { "(" swap$ * ")" * }
  if$
}

FUNCTION {bbl.and}
{ "and" }

FUNCTION {bbl.chapter}
{ "ch." }

FUNCTION {bbl.editor}
{ "ed." }

FUNCTION {bbl.edition}
{ "edn." }

FUNCTION {bbl.etal}
{ "et~al." emphasize }

FUNCTION {bbl.in}
{ "in" }

FUNCTION {bbl.inpress}
{ "in press" }

FUNCTION {bbl.msc}
{ "M.Sc. thesis" }

FUNCTION {bbl.page}
{ "p." }

FUNCTION {bbl.pages}
{ "pp." }

FUNCTION {bbl.phd}
{ "Ph.D. thesis" }

FUNCTION {bbl.submitted}
{ "submitted for publication" }

FUNCTION {bbl.techreport}
{ "Technical Report" }

FUNCTION {bbl.volume}
{ "vol." }

FUNCTION {bbl.first}
{ "1st" }

FUNCTION {bbl.second}
{ "2nd" }

FUNCTION {bbl.third}
{ "3rd" }

FUNCTION {bbl.fourth}
{ "4th" }

FUNCTION {bbl.fifth}
{ "5th" }

FUNCTION {bbl.st}
{ "st" }

FUNCTION {bbl.nd}
{ "nd" }

FUNCTION {bbl.rd}
{ "rd" }

FUNCTION {bbl.th}
{ "th" }

FUNCTION {eng.ord}
{ duplicate$ "1" swap$ *
  #-2 #1 substring$ "1" =
     { bbl.th * }
     { duplicate$ #-1 #1 substring$
       duplicate$ "1" =
         { pop$ bbl.st * }
         { duplicate$ "2" =
             { pop$ bbl.nd * }
             { "3" =
                 { bbl.rd * }
                 { bbl.th * }
               if$
             }
           if$
          }
       if$
     }
   if$
}

FUNCTION{is.a.digit}
{ duplicate$ "" =
    {pop$ #0}
    {chr.to.int$ #48 - duplicate$
     #0 < swap$ #9 > or not}
  if$
}

FUNCTION{is.a.number}
{
  { duplicate$ #1 #1 substring$ is.a.digit }
    {#2 global.max$ substring$}
  while$
  "" =
}

FUNCTION {extract.num}
{ duplicate$ 't :=
  "" 's :=
  { t empty$ not }
  { t #1 #1 substring$
    t #2 global.max$ substring$ 't :=
    duplicate$ is.a.number
      { s swap$ * 's := }
      { pop$ "" 't := }
    if$
  }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}

FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    { pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}

FUNCTION {convert.edition}
{ extract.num "l" change.case$ 's :=
  s "first" = s "1" = or
    { bbl.first 't := }
    { s "second" = s "2" = or
        { bbl.second 't := }
        { s "third" = s "3" = or
            { bbl.third 't := }
            { s "fourth" = s "4" = or
                { bbl.fourth 't := }
                { s "fifth" = s "5" = or
                    { bbl.fifth 't := }
                    { s #1 #1 substring$ is.a.number
                        { s eng.ord 't := }
                        { edition 't := }
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
  if$
  t
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {space.connect}
{ " " swap$ * * }

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
            { add.comma t * }
            { numnames #2 >
              { "" * }
              'skip$
            if$
            t "others" =
              { bbl.etal space.connect }
              { bbl.and space.connect t space.connect }
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
    { #1 'author.or.editor :=
      author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { #2 'author.or.editor :=
      bbl.editor " " * *
      editor format.names
    }
  if$
}

FUNCTION {n.separate.multi}
{ 't :=
  ""
  #0 'numnames :=
  t text.length$ #4 > t is.a.number and
    {
      { t empty$ not }
      { t #-1 #1 substring$ is.a.number
          { numnames #1 + 'numnames := }
          { #0 'numnames := }
        if$
        t #-1 #1 substring$ swap$ *
        t #-2 global.max$ substring$ 't :=
        numnames #4 =
          { duplicate$ #1 #1 substring$ swap$
            #2 global.max$ substring$
            "\," swap$ * *
            #1 'numnames :=
          }
          'skip$
        if$
      }
      while$
    }
    { t swap$ * }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.volume volume tie.or.space.connect }
  if$
}

FUNCTION {format.title.noemph}
{ 't :=
  t empty$
    { "" }
    { t }
  if$
}

FUNCTION {format.title}
{ 't :=
  t empty$
    { "" }
    { t emphasize }
  if$
}

FUNCTION {n.dashify} { 't :=
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

FUNCTION {format.date}
{ year empty$
    { "" }
    'year
  if$
}

FUNCTION {format.bdate}
{ year empty$
    { "There's no year in " cite$ * warning$ }
    'year
  if$
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "Can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.edition}
{ edition duplicate$ empty$
    'skip$
    { convert.edition
      bbl.edition bibinfo.check
      " " * bbl.edition *
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
    { pages multi.page.check
      { bbl.pages pages n.dashify tie.or.space.connect }
      { bbl.page pages tie.or.space.connect }
    if$
    }
  if$
}


FUNCTION {format.pages.required}
{ pages empty$
    { ""
      "There are no page numbers for " cite$ * warning$
      output
    }
    { pages multi.page.check
      { bbl.pages pages n.dashify tie.or.space.connect }
      { bbl.page pages tie.or.space.connect }
    if$
    }
  if$
}

FUNCTION {format.pages.nopp}
{ pages empty$
    { ""
      "There are no page numbers for " cite$ * warning$
      output
    }
    { pages multi.page.check
      { pages n.dashify space.connect }
      { pages space.connect }
    if$
    }
  if$
}

FUNCTION {format.pages.patent}
{ pages empty$
    { "There is no patent number for " cite$ * warning$ }
    { pages multi.page.check
      { pages n.dashify }
      { pages n.separate.multi }
      if$
    }
  if$
}

FUNCTION {format.vol.pages}
{ volume boldface field.or.null
  duplicate$ empty$
    { pop$ format.pages.required }
    { add.comma pages n.dashify * }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
    { bbl.chapter }
    { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
    'skip$
    { add.comma format.pages * }
      if$
    }
  if$
}

FUNCTION {format.title.in}
{ 's :=
  s empty$
    { "" }
    { editor empty$
      { bbl.in s format.title space.connect }
      { bbl.in s format.title space.connect
      add.comma format.editors *
      }
    if$
    }
  if$
}

FUNCTION {format.pub.address}
{ publisher empty$
    { "" }
    { address empty$
        { publisher }
        { publisher add.comma address *}
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  year empty$ note empty$
  and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {empty.doi.note}
{ doi empty$ note empty$ and
    { "Need either a note or DOI for " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type emphasize
    }
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  journal emphasize "journal" output.check
  format.date "year" output.check
  volume empty$
  { ""
    format.pages.nopp output
  }
  { format.vol.pages output }
  if$
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { title format.title "title" output.check
      editor empty$
        { "Need either an author or editor for " cite$ * warning$ }
        { "" format.editors * "editor" output.check }
      if$
    }
    { format.authors output
      "author and editor" editor either.or.check
      title format.title "title" output.check
    }
  if$
  format.pub.address "publisher" output.check
  format.edition output
  format.bdate "year" output.check
  format.bvolume output
  pages empty$
    'skip$
    { format.pages output }
  if$
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  title format.title "title" output.check
  howpublished output
  address output
  format.date output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { title format.title "title" output.check
      editor empty$
      { "Need at least an author or an editor for " cite$ * warning$ }
      { "" format.editors * "editor" output.check }
    if$
    }
    { format.authors output
      title format.title.in "title" output.check
    }
  if$
  format.pub.address "publisher" output.check
  format.edition output
  format.bdate "year" output.check
  format.bvolume output
  format.chapter.pages "chapter and pages" output.check
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  author empty$
    { booktitle format.title "booktitle" output.check
      editor empty$
        { "Need at least an author or an editor for " cite$ * warning$ }
        { "" format.editors * "editor" output.check }
      if$
    }
    { format.authors output
      booktitle format.title.in "booktitle" output.check
    }
  if$
  format.pub.address "publisher" output.check
  format.edition output
  format.bdate "year" output.check
  format.bvolume output
  format.chapter.pages "chapter and pages" output.check
  fin.entry
}

FUNCTION {inpress}
{ output.bibitem
  format.authors "author" output.check
  journal emphasize "journal" output.check
  bbl.inpress output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  booktitle format.title.noemph "booktitle" output.check
  address output
  format.date "year" output.check
  pages empty$
    'skip$
    { format.pages output }
  if$
  fin.entry
}

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
      'skip$
      { organization output
        address output
      }
      if$
    }
    { format.authors output }
  if$
  title format.title "title" output.check
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
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  bbl.msc emphasize format.thesis.type output
  school "school" output.check
  address output
  format.date "year" output.check
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  title format.title output
  howpublished output
  year output
  note output
  fin.entry
  empty.misc.check
}

FUNCTION {patent}
{ output.bibitem
  organization empty$
    { format.authors "author and organization" output.check }
    { author empty$
        { organization }
        {  format.authors organization paren space.connect }
      if$
      "author and organization" output.check
    }
  if$
  journal emphasize "journal" output.check
  format.pages.patent "pages" output.check
  format.date "year" output.check
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  bbl.phd emphasize format.thesis.type output
  school "school" output.check
  address output
  format.date "year" output.check
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  title format.title.noemph "title" output.check
  address output
  format.date "year" output.check
  pages empty$
    'skip$
    { format.pages output }
  if$
  fin.entry
}

FUNCTION {remark}
{ output.bibitem
  note "note" output.check
  fin.entry
}

FUNCTION {submitted}
{ output.bibitem
  format.authors "author" output.check
  bbl.submitted output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  title format.title "title" output.check
  institution
  type empty$
    'bbl.techreport
    'type
  if$
  space.connect
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
  output
  format.pub.address output
  format.date "year" output.check
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  journal empty$
    'skip$
    { journal emphasize "journal" output.check }
  if$
  doi empty$
    {  note output }
    {  format.date output
       "DOI:" doi tie.or.space.connect output
    }
  if$
  fin.entry
  empty.doi.note
}

FUNCTION {conference} {inproceedings}

FUNCTION {other} {patent}

FUNCTION {default.type} {misc}

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

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
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
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{mcbibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{mcbibliography}" write$ newline$
}

EXECUTE {end.bib}
%% 
%%
%% End of file `rsc-mc.bst'.
