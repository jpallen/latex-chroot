%%
%% This is file `adrfax.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% adrconv.dtx  (with options: `bst,fax')
%% Copyright (c) 2001 Axel Kielhorn
%% 
%% This file will generate fast loadable files from adrconv.dtx when
%% run through LaTeX or TeX.
%% 
%% This file is part of the adrconv bundle.
%% 
%% This file can be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of the license
%% or (at you option) any later version.
%% The latest version of this license is in
%%   http://www.latex-procejt.org/lppl.txt
%% and version 1.2 or later ist part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% The adrconv bundle consists at least of the files adrconv.dtx,
%% adrconv.ins and adrguide.tex.
%% 
%% You are NOT ALLOWED to change this file.
%% 
%% You are NOT ALLOWED to distribute this file without adrconv.dtx,
%% adrconv.ins or adrguide.tex.
ENTRY
  { name
    title
    organization
    city
    zip
    country
    street
    phone
    mobile
    fax
    url
    email
    note
    key
    birthday
    nbirthday
  }
  {}
  { adr.char }
INTEGERS { cur.adr.char }
FUNCTION {get.names}
{ name empty$
   { organization empty$
      { "{}{}" }
      { organization "{}" * }
     if$
   }
   { "{" name #1 "{ll}" format.name$ "}" * *
     "{" name #1 "{ff}{ vv}" format.name$ "}" * * *
   }
   if$
}
FUNCTION {print.adrchr}
{ adr.char chr.to.int$ cur.adr.char >
  { newline$ "\adrchar{" adr.char "}" * * write$ newline$
    adr.char chr.to.int$ 'cur.adr.char :=
  }
  'skip$
  if$
}
FUNCTION{format.phone.and.fax}
{ phone empty$
    { "" }
    { phone }
  if$
  fax empty$
    'skip$
    { phone empty$
      { fax * }
      { "\\Fax:\\" fax * * }
      if$
    }
  if$
}
FUNCTION{address}
{
    print.adrchr
    "\adrentry" write$
    get.names write$ newline$
    "{"
    street empty$
      { "" }
      { street " \\ " *}
    if$
    *
    zip empty$
      { "" }
      { zip }
    if$
    " " * *
    city empty$
      { "" }
      { city }
    if$
    "}{" * *
    format.phone.and.fax
    "}{}{}{}{" * *
    key empty$
      { "" }
      { key }
    if$
    "}" * * write$ newline$
}
FUNCTION{presort}
{
  name empty$
  { organization empty$
    { key empty$
      { "No name, organization, or key to sort " cite$ * warning$
        "???"
      }
      { key }
      if$
    }
    { organization }
    if$
  }
  { name #1 "{ll},{f }{v }{, j}" format.name$ }
  if$
  duplicate$
  'sort.key$ :=
  #1 #1 substring$
  'adr.char :=
}
READ
ITERATE {presort}
SORT
FUNCTION {begin.bib}
{
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  #0 'cur.adr.char :=
}
EXECUTE {begin.bib}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$ }
EXECUTE {end.bib}
