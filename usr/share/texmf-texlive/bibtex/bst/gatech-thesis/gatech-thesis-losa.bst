% gatech-thesis-losa.bst: This style is used by the gatech-thesis-losa.sty
%   style to provide support for a 'List of Symbols or Abbreviations'
%   within the context of gatech-thesis.cls.  The advantages of 
%   creating a separate .bst file are that the formatting of the 
%   losa glossary can be different from that of other "real" glossaries
%   which are also based on the gloss.sty package.
%
% This file was adapted from the file `glsplain.bst' taken from the
% gloss package.
%
% Original information:
% ORIG: 
% ORIG:  (c) 1998 Jose Luis Diaz, 1999-2002 Jose Luis Diaz and Javier Bezos.
% ORIG:  All Rights Reserved.
% ORIG: 
% ORIG:  This file is part of the gloss distribution release 1.5.2
% ORIG:  --------------------------------------------------------
% ORIG: 
% ORIG:  This file can be redistributed and/or modified under the terms
% ORIG:  of the LaTeX Project Public License Distributed from CTAN
% ORIG:  archives in directory macros/latex/base/lppl.txt; either
% ORIG:  version 1 of the License, or any later version.
% ORIG: 
% ORIG: % History of v0.1
% ORIG: % ~~~~~~~~~~~~~~~
% ORIG: % 1997/06/25 (JLDdA) Original version, by Jose Luis Diaz de Arriba (and an
% ORIG: %                    unindicted co-conspirator)
% ORIG: % History of v1.0
% ORIG: % ~~~~~~~~~~~~~~~
% ORIG: % 1999/07/29 (JBL)   Rewritten in full. Now it warns if a required field is
% ORIG: %                    missing, conforms the new gloss.sty syntax, and
% ORIG: %                    writes headings for each letter. The heading,
% ORIG: %                    short, and group fiels have been added.
% ORIG: % History of v1.1-1.4
% ORIG: % ~~~~~~~~~~~~~~~~~~~
% ORIG: % 1999/10/10 (JBL)   Lots of changes.
% ORIG: % History of v.1.5
% ORIG: % ~~~~~~~~~~~~~~~~
% ORIG: % 2001/08/02 (JBL)   Added the sort-short field for compatility 
% ORIG: %                    with glsshort.bst

STRINGS { last.heading s t star.period}

ENTRY
  { word
    sort-word
    definition
    heading
    group
    short
	sort-short
  }
  {}
  { ucword }
  
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {has.period}
{ duplicate$
  add.period$ =
}

FUNCTION {str.length}
{ 't :=
  #0
    { t empty$ not }
    { t #2 global.max$ substring$
	  't :=
	  #1 +
    }
  while$
}


FUNCTION {upper.first}
{ duplicate$
  #1 text.prefix$
  duplicate$
  "u" change.case$
  's :=
  str.length
  #1 + entry.max$ substring$
  s swap$ *
}

FUNCTION {check.required}
{ 's :=
  duplicate$ empty$
    { "Empty " s * " in " * cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {push.sortword}
{ sort-word empty$ 
   { word field.or.null }
   'sort-word
  if$
}

FUNCTION {check.alpha}
{ duplicate$
  purify$
  empty$
    { "Non alphabetical " cite$ *
      " entry without group field" * warning$ }
    'skip$
  if$
}

FUNCTION {push.heading}
{ heading empty$
    { word field.or.null
      #1 text.prefix$
      check.alpha
    }
    'heading
    if$
}

FUNCTION {begin.entry}
{ newline$
  "\begin{losaitem" star.period * write$
  "}{" write$
  cite$ write$
  "}{" write$
  word write$
  "}{" write$
  ucword write$
  "}{" write$
  short field.or.null write$
  "}" write$
  newline$
}

FUNCTION {end.entry}
{ "\end{losaitem" star.period "}" * * write$
  newline$
}

FUNCTION {set.vars}
{ word field.or.null
  "word" check.required
  upper.first
  'ucword := 
}


FUNCTION {losadef}
{ definition field.or.null
  "definition" check.required
  duplicate$ has.period
    { "*" }
	{ "" }
  if$
  'star.period :=    % definition is stored for later writing
  begin.entry        % this outputs word, ucword, and short
  write$             % writes definition
  end.entry
}

FUNCTION {gd}
{ definition field.or.null
  "definition" check.required
  duplicate$ has.period
    { "*" }
	{ "" }
  if$
  'star.period :=    % definition is stored for later
  begin.entry        % this outputs word, ucword, and short
  write$             % writes definition
  end.entry
}

FUNCTION {default.type} { losadef }

FUNCTION {presort}
{ set.vars
  push.sortword
  group empty$
    { purify$ "L" }
    'group
  if$                    % sort-word heading
  swap$ *                % heading * sort-word
  "l" change.case$
  'sort.key$ :=
}

FUNCTION {begin.thelosa}
{ "\begin{thelosa}"   
  write$
  newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

FUNCTION {end.thelosa}
{ newline$
  "\end{thelosa}" write$
  newline$
}

FUNCTION {call.entries}
  { group empty$
      'push.heading
      { heading empty$
          'skip$
          { "Ignoring heading because there is group field in "
            cite$ *
            warning$
          }
        if$
        group
      }
    if$
    "u" change.case$
    duplicate$
    group empty$
      'skip$
      { "$$$$$" * }
    if$
    duplicate$
    last.heading =
      { pop$ pop$ }
      { newline$
		'last.heading :=
        group empty$
          { "\losaheading{" }
          { "\losagroup{" }
        if$
        swap$ * "}" *
        write$
        newline$
      }
    if$
    call.type$
  }

READ

ITERATE {presort}

SORT

EXECUTE {begin.thelosa}

ITERATE {call.entries}

EXECUTE {end.thelosa}


