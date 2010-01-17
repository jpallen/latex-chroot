%%
%% This is file `weekly.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% weekly.dtx  (with options: `class')
%% This file is part of the Calendar package,
%% Copyright (C) 1996, 1997 Frank Bennett, Jr.
%% All rights reserved.
%% ------------------------------------------
%% 
%% IMPORTANT NOTICE:
%% 
%% You are not allowed to change this file.  You may however copy
%% this file to a file with a different name and then change the
%% copy if (a) you do not charge for the modified code, (b) you
%% acknowledge the author of this file in the new file, if it
%% is distributed to others, and (c) you attach these same
%% conditions to the new file.
%% 
%% You are not allowed to distribute this file alone.  You are not
%% allowed to take money for the distribution or use of this file
%% (or a changed version) except for a nominal charge for copying
%% etc.
%% 
%% You are allowed to distribute this file under the condition that
%% it is distributed with all of its contents, intact.
%% 
%% For error reports, or offers to help make this a more powerful,
%% friendlier, and altogether more thrilling package, please contact me on
%% fb@soas.ac.uk.  Better yet, make a contribution to
%% my pension.  Account details available on request.
%% ------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{weekly}
          [1998/01/17 18:15:32 3.1.1.1 Weekly Calendar (Frank Bennett)]
\newif\ifwk@usecolor
\newif\ifwk@overthetop
\newcount\wk@firstday
\newcount\wk@tempcount
\newlength\wk@itemheight
\parindent=0pt
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\input calopts.cfg
\InputIfFileExists{dates.cfg}{}{}
\ProcessOptions
\LoadClass{article}
\RequirePackage{calendar}
\RequirePackage{lscape}
\RequirePackage{multicol}
\RequirePackage{autofilo}
\multicolsep=0pt\relax
\AtBeginDocument{%
  \pagestyle{empty}
  \parindent=0pt}
\define@key{opt}{firstday}{%
  \wk@firstday=#1}
\wk@firstday=5%
\wk@tempcount=0
\expandafter\newsavebox\csname wk@box\the\wk@tempcount\endcsname
\loop\advance\wk@tempcount by1\relax
\ifnum\wk@tempcount<8
  \expandafter\newsavebox\csname wk@box\the\wk@tempcount\endcsname
\repeat
\def\wk@spitoutboxes{%
    \wk@tempcount=-1\relax%
    \loop\advance\wk@tempcount by1\relax%
    \ifnum\wk@tempcount<3\relax%
      \hbox to\linewidth{%
        \expandafter\usebox\csname wk@box\the\wk@tempcount\endcsname}%
    \repeat%
      \hbox to\linewidth{\vbox to\wk@itemheight{%
        \hrule width\linewidth height0.4pt depth0pt%
        \hbox to\linewidth{\hfil}\vfill}}%
    \wk@tempcount=2\relax%
    \loop\advance\wk@tempcount by1\relax%
    \ifnum\wk@tempcount<7\relax%
      \hbox to\linewidth{%
        \expandafter\usebox\csname wk@box\the\wk@tempcount\endcsname}%
    \repeat}%
\def\wk@getitemheight{%
  \setlength\wk@itemheight\textheight\relax%
  \addtolength\wk@itemheight{-4pt}%
  \addtolength\wk@itemheight{-5\normallineskip}%
  \divide\wk@itemheight by4\relax}%
\newcalendar%
{weekly}
{\cal@insert}
{8}
{7}
{7}
{\relax}
{I}
{\expandafter\autofilo\expandafter{\cal@optionslist}\wk@getitemheight}
{\wk@spitoutboxes\endautofilo}
{\wk@spitoutboxes}
{\relax}
{\dates@requiremonthtrue\dates@requiredaytrue}
{\global\dates@date\cal@range@start%
 \prevday\wk@firstday%
 \cal@range@start\dates@date%
 \caldate%
  \message{^^JStart: \theshortweekday\space%
    \theday\space\theshortmonth\space\theyear}%
  \global\dates@date\cal@range@end%
  \caldate%
  \advance\wk@firstday by-1%
  \ifnum\wk@firstday=7\wk@firstday=0\fi%
  \nextday\wk@firstday%
  \caldate%
  \cal@range@end\dates@date%
  \message{^^JEnd: \theshortweekday\space%
    \theday\space\theshortmonth\space\theyear}%
  \global\dates@date=\cal@range@start%
  \caldate}%
{\par}%
{\cal@get@appointments\cal@get@events}%
{\relax%
   \ifnum\dates@time@start>0\relax%
    \ifnum\dates@time@start=\dates@time@end%
      \protected@edef\cal@entry@text{%
        \thetimestart\space%
        \cal@textcolor{\calcolor}{\theshorttext}}%
    \else%
      \protected@edef\cal@entry@text{%
        \thetimestart--\thetimeend\space%
        \cal@textcolor{\calcolor}{\theshorttext}}%
    \fi%
  \else%
      \protected@edef\cal@entry@text{%
        \cal@textcolor{\calcolor}{\theshorttext}}%
  \fi}%
{\global\wk@overthetopfalse%
 \expandafter\sbox\csname wk@box\the\cal@subgroup@count\endcsname{%
    \vbox to\wk@itemheight{\hbox{\parbox{\linewidth}{%
\hrule width\linewidth%
\vskip1pt\relax%
\ifnum\cal@subgroup@count<3\relax%
      \textbf{\theweekday\hfill%
              \theday\space\themonth\space\theyear}\par%
\else%
      \textbf{\theday\space\themonth\space\theyear\hfill%
              \theweekday}\par%
\fi%
\vskip0.5pt\relax%
\hrule width\linewidth%
\vskip1pt\relax%
      \raggedright\small%
      \ifcat$\theevents$%
      \else%
        \theevents\par%
      \fi%
      \ifcat$\theappointments$%
      \else%
        \theappointments%
      \fi}% parbox
}%          hbox
\vfill}%    vbox
\ifnum\badness=1000000\relax\global\wk@overthetoptrue\fi%
}%          sbox
\ifwk@overthetop%
  \message{Resetting this date in two-columns.}%
\expandafter\sbox\csname wk@box\the\cal@subgroup@count\endcsname{%
    \vbox to\wk@itemheight{\hbox{\parbox{\linewidth}{%
\hrule width\linewidth%
\vskip1pt\relax%
\ifnum\cal@subgroup@count<3\relax%
      \textbf{\theweekday\hfill%
              \theday\space\themonth\space\theyear}\par%
\else%
      \textbf{\theday\space\themonth\space\theyear\hfill%
              \theweekday}\par%
\fi%
\vskip0.5pt\relax%
\hrule width\linewidth%
\vskip1pt\relax%
      \raggedright\small%
      \begin{multicols}{2}%
      \ifcat$\theevents$%
      \else%
        \theevents\par%
      \fi%
      \ifcat$\theappointments$%
      \else%
        \theappointments%
      \fi%
      \end{multicols}%
}% parbox
}%          hbox
\vfill}%    vbox
}%          sbox
\fi%
 \advance\wk@tempcount by1\relax%
 \ifnum\wk@tempcount>6\relax%
   \wk@tempcount=0\relax%
 \fi}

\endinput
%%
%% End of file `weekly.cls'.
