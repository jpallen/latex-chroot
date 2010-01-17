%%
%% Copyright (C) 2006 by:
%% Josef Kleber
%% <josef.kleber@gmx.net>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
%% This Current Maintainer of this work is Josef Kleber.
%%
%% This work consists of all files listed in manifest.txt.
%%
%
\NeedsTeXFormat{LaTeX2e}%
%
\ProvidesClass{dvdcoll}[2006/10/06 dvdcoll.cls v0.6a - Josef Kleber (C) 2006]%
%
\RequirePackage{xkeyval}%
\RequirePackage{ifthen}%
%
%
\define@key{dvdcoll.cls}{language}[babel]%
{%
  \ifthenelse{\NOT\equal{#1}{babel}}%
  {%no babel
    \def\dc@option@language{#1}%
  }%
  {%babel
    \def\dc@option@language{#1}%
	\AtBeginDocument%
	{%
	  \ifthenelse{\NOT\equal{\dc@option@language}{babel}}%
	  {%no babel
	    \InputIfFileExists{\dc@option@language.dcl}%
        {}%
        {%
          \input{english.dcl}%
	      \ClassWarningNoLine{dvdcoll}%
	      {%
	        You tried to use option language=\dc@option@language\MessageBreak
	        <\dc@option@language> is at the moment not available\MessageBreak
	        dvdcoll.cls is using english instead!\MessageBreak
	        Please take a look at <english.dcl>,\MessageBreak
	        translate it to your language and email\MessageBreak
	        it to:  dvdcoll@web.de
	      }%
        }%
	  }%
	  {%babel
	    \@ifpackageloaded{babel}%
		{% yes
	      \def\dc@option@language{\languagename}%
	      \InputIfFileExists{\dc@option@language.dcl}%
          {}%
          {%
            \input{english.dcl}%
	        \ClassWarningNoLine{dvdcoll}%
	        {%
	          You tried to use babel with option <\dc@option@language>\MessageBreak
	          <\dc@option@language> is at the moment not available\MessageBreak
	          dvdcoll.cls is using english instead!\MessageBreak
	          Please take a look at <english.dcl>,\MessageBreak
	          translate it to your language and email\MessageBreak
	          it to:  dvdcoll@web.de
	        }%
          }%
		}%
		{% no
		  \input{english.dcl}%
		  \ClassWarningNoLine{dvdcoll}%
		  {%
		    You did not specify a language via Package <babel>\MessageBreak
			or with the dvdcoll option language.\MessageBreak
			dvdcoll is using <english> as default instead
		  }%
		}%
	  }%
	}%
  }%
}%
%
\define@choicekey*{dvdcoll.cls}{dvdlabel}[\valuedvdcoll\nr]{wide,narrow}[wide]%
{%
  \ifcase\nr\relax%
    \def\dc@option@dvdlabel{\hfill}%
  \or%
    \def\dc@option@dvdlabel{\hspace{1em}}%
  \fi%
}%
%
\define@choicekey*{dvdcoll.cls}{dvdskip}[\valuedvdskip\nr]{small,medium,big}[medium]%
{%
  \ifcase\nr\relax%
    \def\dc@addvspace@endDvd{\dc@smallskip}%
  \or%
    \def\dc@addvspace@endDvd{\dc@medskip}%
  \or%
    \def\dc@addvspace@endDvd{\dc@bigskip}%
  \fi%
}%
%
\define@choicekey*{dvdcoll.cls}{pagenumbers}[\valuepagenumbers\nr]{yes,no}[yes]%
{%
  \ifcase\nr\relax%
    {}%
  \or%
    \AtBeginDocument%
	{%
	  \pagestyle{empty}%
	  \let\ps@plain=\ps@empty% LaTeX Begleiter S.231
	}%
  \fi%
}%
%
\define@choicekey*{dvdcoll.cls}{heading}[\valueheading\nr]{number,nonumber}[nonumber]%
{%
  \ifcase\nr\relax%
  {%
	\AtBeginDocument%
	{%
	  \setcounter{secnumdepth}{4}%
	  \SetTOCSecIndent{1em}%
	  \SetLFRSecNumwidth{4.5em}%
	}%
  }%
  \or%
    \AtEndOfClass{\SetTOCNumwidth{2.2em}}% default
    \AtBeginDocument%
	{%
	  \setcounter{secnumdepth}{-2}%
	  \SetTOCSecIndent{1em}%
	  \SetLFRSecNumwidth{0em}%
	}%
  \fi%
}%
%
\define@choicekey*{DvdSeries}{dvdnumbering}[\valuedvdnumbering\nr]{normal,season}[normal]%
{%
  \ifcase\nr\relax%
    \renewcommand{\dc@option@dvdnumbering}{normal}%
  \or%
    \renewcommand{\dc@option@dvdnumbering}{season}%
  \fi%
}%
%
\define@choicekey*{DvdSeries}{titlenumbering}[\valuetitlenumbering\nr]{normal,season}[normal]%
{%
  \ifcase\nr\relax%
    \renewcommand{\dc@option@titlenumbering}{normal}%
  \or%
    \renewcommand{\dc@option@titlenumbering}{season}%
  \fi%
}%
%
%
\ExecuteOptionsX{dvdlabel,dvdskip,pagenumbers,heading,language}%
%
\ProcessOptionsX\relax%
%
\LoadClassWithOptions{scrreprt}%
%
\RequirePackage{tabularx}%
\RequirePackage{booktabs}%
\RequirePackage{array}%
\RequirePackage{pdfnotiz}%
\RequirePackage[naturalnames=true,hypertexnames=false]{hyperref}%
%--- naturalnames=true,hypertexnames=false --- verhindert das mehrfache Anlegen von hyperref-Ankern
%                                              (bedingt durch das Rücksetzen des Zahlers chapter)
%                                              und beseitigt die Warnungen (ext4) von hyperref   
%
%
%--- Package adjustments ---
%
%avoid ugly looking frame overlays in \DvdTitleWithDescription
\setlength\extrarowheight{2pt}%
%
%
%--- Counters ---
%
\newcounter{dvdcount}[chapter]%
\newcounter{titlecount}[dvdcount]%
\newcounter{season}%
\newcounter{seasontitlecount}%
\newcounter{seasondvd}%
%
%
%--- Variables ---
%
\def\dc@part{}%
\def\dc@series{}%
\def\dc@title{}%
%
%
%--- Internal Commands ---
%
\def\dc@third{min}%
\def\dc@addhspace@title@count{0.7em}%
%
% \***skip aus source2e; etwas vergrößert
\def\dc@smallskip{\vspace{6pt plus 2pt minus 2pt}}%
\def\dc@medskip{\vspace{12pt plus 4pt minus 4pt}}%
\def\dc@bigskip{\vspace{18pt plus 6pt minus 6pt}}%
%
% font sizes used in the tables
\def\dc@size@table@cells{\large}%
\def\dc@size@table@title{\Large}%
%
% dummy for .dcl definitons
\newcommand*\dc@miss{}%
\newcommand*\dc@lfrname{}%
\newcommand*\dc@pdf@subject{}%
%
%
\newcommand*\dc@option@titlenumbering{}%
\newcommand*\dc@option@dvdnumbering{}%
%
%
\newcommand*\dc@pcwlz[1]% PrintCounterWithLeadingZero
{%
  \ifnum\value{#1}<10{0}\fi%
  \arabic{#1}%
}%
%
%
\newcommand*\dc@print@counter%
{%
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {%season
    \dc@pcwlz{season}x\dc@pcwlz{seasontitlecount}%
  }%
  {%normal
    \thetitlecount{}.%
  }%
}%
%
%
\newcommand*\dc@calc@dvdcounter%
{%
  \ifthenelse{\equal{\dc@option@dvdnumbering}{season}}%
  {%season
    \def\dc@dvdcounter{\theseason.\theseasondvd}%
  }%
  {%normal
    \def\dc@dvdcounter{\thedvdcount}%
  }%
}%
%
%
\newcommand*\dc@print@dvdlabel[1]%
{%
  \ifthenelse{\equal{}{#1}}%
  {}% no label!
  {%
    \textbf{[#1]}%
  }%
}%
%
%
%--- Commands ---
%
\newcommand*\SetLFRName[1]%
{%
  \renewcommand*\dc@lfrname{#1}%
}%
%
%
\newcommand\Description[1]%
{%
  \gdef\pn@pdf@desc{#1}%
}%
%
%
\newcommand*\SetCounterSpace[1]%
{%
  \def\dc@addhspace@title@count{#1}%
}%
%
%
\newcommand*\SetThirdColumnAddition[1]%
{%
  \def\dc@third{#1}%
}%
%
%
\newcommand*\DvdCounter%
{%
  \DvdSpace\dc@dvdcounter%
}%
%
%
\newcommand*\AutoTitle%
{%
  \dc@series\DvdCounter\DvdSpace%
}%
%
%
\newcommand*\DvdSpace%
{%
  \hspace{\dc@addhspace@title@count}%
}%
%
%
\newcommand*\SetSeason[2][1]%
{%
  \setcounter{season}{#2}%
  \ifthenelse{#1 = 1}%
  {\setcounter{seasondvd}{0}}% just reset if #1 equal 1
  {}%
  \setcounter{seasontitlecount}{#1}%
  \addtocounter{seasontitlecount}{-1}%
}%
%
%
\newcommand*\DvdPart[1]%
{%
  \part{#1}%
  \def\dc@part{#1}%
  \setcounter{chapter}{0}%
}%
%
%
\newcommand*\DvdSeries[2][titlenumbering=normal,dvdnumbering=normal]%
{%default - default setting of xkeyval seem not to work??? all or nothing???
  \renewcommand*\dc@option@dvdnumbering{normal}%
  \renewcommand*\dc@option@titlenumbering{normal}%
%
  \setkeys{DvdSeries}{#1}%
  \SetSeason{1}%
  \chapter{#2}%
  \def\dc@series{#2}%
  \setcounter{season}{-1}%
  \ifthenelse{\equal{\valueheading}{nonumber}}%
  {%
    \setcounter{dvdcount}{0}%
  }%
  % durch heading=nonumber (secnumdepth=-2) funktioniert das automatische 
  % Zurücksetzen von dvdcount nicht mehr, da chapter offensichtlich nicht
  % mehr zurückgesetzt wird!
  {}%
}%
%
%
\newcommand*\DvdTitle[2]%
{%
  %increasing counter depending on titlenumbering
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {\refstepcounter{seasontitlecount}}%
  {\refstepcounter{titlecount}}%
  \ifthenelse{\equal{\dc@miss}{#2}}%
  {%
    %Eintrag in lfr unbedingt vor Tabelleneintrag, ansonsten Fehler in der Tabelle - don't no why!
    %Eintrag in lfr bei heading=nonumber OHNE Nummern
	\ifthenelse{\equal{\valueheading}{nonumber}}%
    {%
      \addcontentsline{lfr}{lfrsec}{\protect\numberline{} \dc@series\ - #1}%
    }%
    {%
	  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
      {%season
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\theseason.\theseasontitlecount} \dc@series\ - #1}%
      }%
      {%normal
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\thedvdcount.\thetitlecount} \dc@series\ - #1}%
      }%
    }%	
    \dc@print@counter & #1\strut & \hfill\dc@miss \tabularnewline%
  }%
  {%
    \ifthenelse{\equal{}{#2}}%
	  % keine Minutenangabe
      {\dc@print@counter & #1\strut & \tabularnewline}%
	  % mit Minutenangabe
      {\dc@print@counter & #1\strut & \hfill{}#2~\dc@third \tabularnewline}%
  }%
}%
%
%
\newcommand*\DvdTitleWithDescription[2]%
{%
  %increasing counter depending on titlenumbering
  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
  {\refstepcounter{seasontitlecount}}%
  {\refstepcounter{titlecount}}%
  \ifthenelse{\equal{\dc@miss}{#2}}%
  {%
    %Eintrag in lfr unbedingt vor Tabelleneintrag, ansonsten Fehler in der Tabelle - don't no why!
    %Eintrag in lfr bei heading=nonumber OHNE Nummern
	\ifthenelse{\equal{\valueheading}{nonumber}}%
    {%
      \addcontentsline{lfr}{lfrsec}{\protect\numberline{} \dc@series\ - #1}%
    }%
    {%
	  \ifthenelse{\equal{\dc@option@titlenumbering}{season}}%
      {%season
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\theseason.\theseasontitlecount} \dc@series\ - #1}%
      }%
      {%normal
        \addcontentsline{lfr}{lfrsec}{\protect\numberline{\thepart.\thechapter.\thedvdcount.\thetitlecount} \dc@series\ - #1}%
      }%
	}%	
    \dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \hfill\dc@miss \tabularnewline%
  }%
  {%
    \ifthenelse{\equal{}{#2}}%
	  % keine Minutenangabe
      {\dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \tabularnewline}%
	  % mit Minutenangabe
      {\dc@print@counter & \makebox[0pt]{}\pdfnote{#1\strut} & \hfill{}#2~\dc@third \tabularnewline}%
  }%  
}%
%
%
\newcommand{\listoffaultyrecordings}%
{%
  \setboolean{@restonecol}{false}%
  \ifthenelse{\boolean{@twocolumn}}%
    {\setboolean{@restonecol}{true}\onecolumn}%
    {}%
  \@ifundefined{chapter}%
    {\section*{\dc@lfrname\@mkboth{\dc@lfrname}{\dc@lfrname}}}%
    {\chapter*{\dc@lfrname\@mkboth{\dc@lfrname}{\dc@lfrname}}}%
  {%
    \setlength{\parindent}{0pt}%
    \@starttoc{lfr}%
  }%
  \ifthenelse{\boolean{@restonecol}}%
    {\twocolumn}%
    {}%
}%
%
%
\newcommand\l@lfrsec{\@dottedtocline{1}{0em}{0em}}%
%
%
\newcommand\SetLFRSecNumwidth[1]%
{%
  \renewcommand*\l@lfrsec{\@dottedtocline{1}{0pt}{#1}}%
}%
%
%
\newcommand\SetTOCSecIndent[1]%
{%
  \renewcommand*\l@section{\@dottedtocline{1}{#1}{0pt}}%
}%
%
%
\newcommand*\SetTOCNumwidth[1]%
{%
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne%
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@%
    \setlength\@tempdima{#1}%
    \if@tocleft%
      \ifx\toc@l@number\@empty\else%
        \setlength\@tempdima{0\toc@l@number}%
      \fi%
    \fi%
    \begingroup%
      \parindent \z@ \rightskip \@pnumwidth%
      \parfillskip -\@pnumwidth%
      \leavevmode \sectfont%
      \advance\leftskip\@tempdima%
      \hskip -\leftskip%
      ##1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss ##2}\par%
      \penalty\@highpenalty%
    \endgroup%
  \fi}%
%
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax%
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{#1}%
    \if@tocleft%
      \ifx\toc@l@number\@empty\else%
        \setlength\@tempdima{0\toc@l@number}%
      \fi%
    \fi%
    \begingroup%
      \parindent \z@ \rightskip \@pnumwidth%
      \parfillskip -\@pnumwidth%
      \leavevmode\sectfont\large%
      \advance\leftskip\@tempdima%
      \hskip -\leftskip%
      ##1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss ##2}\par%
      \penalty\@highpenalty%
    \endgroup%
  \fi}%
}%
%
%  
%--- Environments ---
%
%
\newenvironment{Dvd}[2]%
{%
%
  \endlinechar=-1%
  %Hack von Markus Kohm zur Behebung des \bottomrule-Problems bei \endtabularx in Environments (-> Google-Groups)
  \expandafter\let\expandafter\SavedEndTab\csname endtabular*\endcsname%
  \expandafter\renewcommand\expandafter*\csname endtabular*\endcsname{%
    \midrule%
    \SavedEndTab%
  }%
  \refstepcounter{dvdcount}% \refstepcounter für hyperref-Link auf die jeweilige DVD
  \refstepcounter{seasondvd}%
  \dc@calc@dvdcounter% to have correct counter in "text" form
  \ifthenelse{\equal{}{#1}}{\def\dc@title{\dc@series\DvdCounter}}{\def\dc@title{#1}}%
  \addcontentsline{toc}{section}{\dc@title}%
  \phantomsection% korrigiert fehlerhafte (falsch positionierte) Links auf dvd-Tabellen
  \noindent%
  % verhindert overfull \hbox Errors wegen \tabularx{\linewidth}...
  \tabularx{\linewidth}{>{\dc@size@table@cells}l>{\dc@size@table@cells}X>{\dc@size@table@cells}r}%
	\multicolumn{3}{l}{\dc@size@table@title\dc@title\dc@option@dvdlabel\dc@print@dvdlabel{#2}}\\%
    \midrule%
}%
{%
  %\midrule% bereits in der Definition enthalten durch Hack von Markus Kohm siehe oben
  \endtabularx%
  \dc@addvspace@endDvd%
}%
%
\endinput%