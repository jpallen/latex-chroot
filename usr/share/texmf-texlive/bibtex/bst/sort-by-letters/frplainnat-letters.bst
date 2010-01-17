%% File: `frplainnat-letters.bst'
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or any later version.
%%
%% A modification of `plain.bst' for use with natbib package 
%% Copyright 1993-2005 Patrick W Daly
%% Max-Planck-Institut f\"ur Sonnensystemforschung
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@mps.mpg.de
%%
%% Modification de `plainnat.bst' du package natbib (citations "auteur-année")
%% pour être utilisé avec le package french (incluant l'ancien frbib.sty)
%% 
%% - francisation des termes de la bibliographie via le package french ;
%% - les noms d'auteurs sont en "small caps" ;
%% - dans les citations le "et al." est en italique ;
%%
%% Olivier Andrieu <andrieu@oxygene.ijm.jussieu.fr>
%%
%% 02-11-2000
%%
%% (penser à renseigner les \*name s'il est besoin)
%%
%% Thomas van Oudenhove <vanouden@enstimac.fr>
%%
%% Modifications du 25-11-2003
%%
%% - mettre les particules en "small caps" (van, de, ...)
%%     (fonctions format.names, format.full.names, format.lab.names)
%% - enlever la dernière virgule d'une liste d'auteurs
%%     (L. 202, numnames => nameleft)
%% - \textit => \emph (abbréviations latines)
%%
%% Modifications du 20-04-2006
%%
%% - ajouts des fonctions find.firstletter, editor.find.first.letter,
%%   organization.find.first.letter, author.find.first.letter et 
%%   output.letter
%% - pour créer une biblio avec les lettres séparant chaque "auteur"
%%   dont le nom commence par la même lettre
%% - Attention : les entrées DOIVENT avoir un 'author', un 'editor'
%%   ou une 'organization'
%% - la définition de \alphabibitem est l'oeuvre de Mael Hilléreau
%%   <mael.hillereau@free.fr> - merci de m'avoir donné l'autorisation
%%   de la reproduire ici.
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    isbn
    issn
    journal
    key
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
    url
    volume
    year
  }
  {}
  { label extra.label sort.label short.list }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t cur.letter first.letter }
INTEGERS { first.letter.place first.letter.ascii }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
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
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
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

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
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
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION { author.find.first.letter }
{ author #1 "{vv }{ll }{ff }, {jj }" format.name$ "u" change.case$
  purify$ first.letter.place #1 substring$ 'first.letter := 
  first.letter chr.to.int$ 'first.letter.ascii :=
}

FUNCTION { editor.find.first.letter }
{ editor #1 "{vv }{ll }{ff }, {jj }" format.name$ "u" change.case$ 
  purify$ first.letter.place #1 substring$ 'first.letter :=
  first.letter chr.to.int$ 'first.letter.ascii :=
}

FUNCTION { organization.find.first.letter }
{ organization #1 "{vv }{ll }{ff }, {jj }" format.name$ "u" change.case$
  purify$ first.letter.place #1 substring$ 'first.letter := 
  first.letter chr.to.int$ 'first.letter.ascii :=
}

FUNCTION { find.firstletter }
{ author empty$
    { editor empty$
%        { organization empty$
          { "Nor author, editor neither organization for entry " cite$ * warning$ }
%          { organization.find.first.letter
%            { first.letter.ascii #64 > first.letter.ascii #91 < and
%              first.letter.ascii #96 > first.letter.ascii #123 < and or not }
%            { first.letter.place #1 + 'first.letter.place :=
%              organization.find.first.letter }
%          while$ }
%          if$ }
        { editor.find.first.letter
          { first.letter.ascii #64 > first.letter.ascii #91 < and
            first.letter.ascii #96 > first.letter.ascii #123 < and or not }
          { first.letter.place #1 + 'first.letter.place :=
            editor.find.first.letter }
        while$
        }
      if$
    }
    { author.find.first.letter
      { first.letter.ascii #64 > first.letter.ascii #91 < and
        first.letter.ascii #96 > first.letter.ascii #123 < and or not }
      { first.letter.place #1 + 'first.letter.place :=
        author.find.first.letter }
    while$
    }
  if$
  #1 'first.letter.place :=
}

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff~}\bsc\bgroup {vv~}{ll}\egroup{{}}{, jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { namesleft #2 >
                { ", " * }
                'skip$
              if$
              t "others" =
                { " \emph{et~al.}" * }
                { " \andname{} " * t * }
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

FUNCTION {format.key}
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", \editornames{}" * }
        { ", \editorname{}" * }
      if$
    }
  if$
}

FUNCTION {format.isbn}
{ isbn empty$
    { "" }
    { new.block "ISBN " isbn * }
  if$
}

FUNCTION {format.issn}
{ issn empty$
    { "" }
    { new.block "ISSN " issn * }
  if$
}

%%FUNCTION {format.url}
%%{ url empty$
%%    { "" }
%%    { new.block "URL " url * }
%%  if$
%%}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {format.full.names}
{'s :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "\bsc\bgroup {vv~}{ll}\egroup{{}}" format.name$ 't :=
      nameptr #1 >
        {
          namesleft #1 >
            { ", " * t * }
            {
              numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " \emph{et~al.}" * }
                { " \andname{} " * t * }
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

FUNCTION {author.editor.full}
{ author empty$
    { editor empty$
        { "" }
        { editor format.full.names }
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {author.full}
{ author empty$
    { "" }
    { author format.full.names }
  if$
}

FUNCTION {editor.full}
{ editor empty$
    { "" }
    { editor format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.full
    { type$ "proceedings" =
        'editor.full
        'author.full
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  ")" make.full.names duplicate$ short.list =
     { pop$ }
     { * }
   if$
  "]{" * write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {output.letter}
{ first.letter cur.letter =
    { skip$ }
    { newline$
      "\alphabibitem{" first.letter * "}" * write$
      newline$ 
      first.letter 'cur.letter := }
  if$

  cur.letter "\" = 
    { first.letter 'cur.letter := }
    { skip$ }
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

FUNCTION {format.date}
{ year duplicate$ empty$
    { "empty year in " cite$ * warning$
       pop$ "" }
    'skip$
  if$
  month empty$
    'skip$
    { month
      " " * swap$ *
    }
  if$
  extra.label *
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
    { "\volumename{}" volume tie.or.space.connect
      series empty$
        'skip$
        { " \ofname{} " * series emphasize * }
      if$
      "\volumename{} \andname{} \numbername{}" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "\numbername{}" }
            { "\Numbername{}" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " \inname{} " * series * }
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
    { output.state mid.sentence =
        { edition "l" change.case$ " \editionname{}" * }
        { edition "t" change.case$ " \editionname{}" * }
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
    { pages multi.page.check
        { "\pagesname{}" pages n.dashify tie.or.space.connect }
        { "\pagename{}" pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "\penalty0 (" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { "\string:\penalty0 " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "\chaptername{}" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "\Inname{} " booktitle emphasize * }
        { "\Inname{} " format.editors * ", " * booktitle emphasize * }
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
    { "\technicalreportname{}" }
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
        { "\Inname{} {\em " journal * "\/}" * }
      if$
    }
    { "\Inname{} " key * }
  if$
  " \citep{" * crossref * "}" *
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "\Inname{} "
    }
    { "\Volumename{}" volume tie.or.space.connect
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
            { "{\em " * series * "\/}" * }
          if$
        }
        { key * }
      if$
    }
    'skip$
  if$
  " \citet{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
              ""
            }
            { "\Inname{} {\em " booktitle * "\/}" * }
          if$
        }
        { "\Inname{} " key * }
      if$
    }
    { "\Inname{} " }
  if$
  " \citet{" * crossref * "}" *
}

FUNCTION {article}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  format.issn output
%  url output
  fin.entry
}

FUNCTION {book}
{ find.firstletter
  output.letter
  output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {booklet}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors output
  author format.key output
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {inbook}
{ find.firstletter
  output.letter
  output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {incollection}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {inproceedings}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
        { organization publisher new.sentence.checkb
          organization output
          publisher output
          format.date "year" output.check
        }
        { address output.nonnull
          format.date "year" output.check
          new.sentence
          organization output
          publisher output
        }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors output
  author format.key output
  new.block
  format.btitle "title" output.check
  organization address new.block.checkb
  organization output
  address output
  format.edition output
  format.date output
%  url output
  fin.entry
}

FUNCTION {mastersthesis}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
  new.block
  "Mémoire" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
%  url output
  fin.entry
}

FUNCTION {misc}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors output
  author format.key output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  format.date output
  format.issn output
%  url output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.btitle "title" output.check
  new.block
  "Thèse de doctorat" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  fin.entry
}

FUNCTION {proceedings}
{ find.firstletter
  output.letter
  output.bibitem
  format.editors output
  editor format.key output
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address output
  format.date "year" output.check
  new.sentence
  organization output
  publisher output
  format.isbn output
%  url output
  fin.entry
}

FUNCTION {techreport}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
%  url output
  fin.entry
}

FUNCTION {unpublished}
{ find.firstletter
  output.letter
  output.bibitem
  format.authors "author" output.check
  author format.key output
  new.block
  format.title "title" output.check
%  url output
  format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"\janname{}"}

MACRO {feb} {"\febname{}"}

MACRO {mar} {"\marname{}"}

MACRO {apr} {"\aprname{}"}

MACRO {may} {"\mayname{}"}

MACRO {jun} {"\junname{}"}

MACRO {jul} {"\julname{}"}

MACRO {aug} {"\augname{}"}

MACRO {sep} {"\sepname{}"}

MACRO {oct} {"\octname{}"}

MACRO {nov} {"\novname{}"}

MACRO {dec} {"\decname{}"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

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

FUNCTION {format.lab.names}
{ 's :=
  s #1 "\bsc\bgroup {vv~}{ll}\egroup{{}}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " \emph{et~al.}" * }
    { #2 <
        'skip$
        { s #2 "{ff }\bsc\bgroup {vv }{ll}\egroup{{}}{ jj}" format.name$ "others" =
            { " \emph{et~al.}" * }
            { " \andname{} " * s #2 "\bsc\bgroup {vv~}{ll}\egroup{{}}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.short.authors}
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
  'short.list :=
}

FUNCTION {calc.label}
{ calc.short.authors
  short.list
  "("
  *
  year duplicate$ empty$
  short.list key field.or.null = or
     { pop$ "" }
     'skip$
  if$
  *
  'label :=
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
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "\emph{et~al}" * }
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
{ calc.label
  label sortify
  "    "
  *
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
  'sort.label :=
  sort.label *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label last.label next.extra }

INTEGERS { longest.label.width last.extra.num number.label }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  "\" 'cur.letter :=
  #1 'first.letter.place :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

FUNCTION { def.alphabibitem }
{ "\def\alphabibitem#1{%" write$ newline$
  "\expandafter\ifx\csname firstalphabibitem\endcsname" write$ newline$
  "\relax\def\firstalphabibitem{}" write$ newline$
  "\else\expandafter" write$ newline$
  "\ifx\csname alphabibitemskip\endcsname" write$ newline$
  "\relax\bigskip" write$ newline$
  "\else\alphabibitemskip" write$ newline$
  "\fi" write$ newline$
  "\fi" write$ newline$
  "\penalty-200\expandafter" write$ newline$
  "\ifx\csname alphabibitemlabel\endcsname" write$ newline$
  "\relax\expandafter" write$ newline$
  "\ifx\csname alphabibitemcontent\endcsname\relax" write$ newline$
  "\item[\LARGE\bfseries\MakeUppercase{#1}]" write$ newline$
  "\hfill\vskip 1ex\hrule\medskip" write$ newline$
  "\else\item[\Large\bfseries\MakeUppercase{#1}]" write$ newline$
  "\alphabibitemcontent{\MakeUppercase{#1}}%" write$ newline$
  "\fi" write$ newline$
  "\else\expandafter" write$ newline$
  "\ifx\csname alphabibitemcontent\endcsname\relax" write$ newline$
  "\item[\alphabibitemlabel{\MakeUppercase{#1}}]" write$ newline$
  "\vskip 1ex\hrule\medskip" write$ newline$
  "\else\item[\alphabibitemlabel{\MakeUppercase{#1}}]" write$ newline$
  "\alphabibitemcontent{\MakeUppercase{#1}}%" write$ newline$
  "\fi" write$ newline$
  "\fi}" write$ newline$
   newline$
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {bib.sort.order}
{ sort.label  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT

FUNCTION {begin.bib}
{   preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  def.alphabibitem
  "\begin{thebibliography}{" number.label int.to.str$ * "}" *
  write$ newline$
  "\expandafter\ifx\csname natexlab\endcsname\relax\def\natexlab#1{#1}\fi"
  write$ newline$
  "\expandafter\ifx\csname url\endcsname\relax" write$ newline$
  "  \def\url#1{{\tt #1}}\fi" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
