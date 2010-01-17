%
% apa.cls  version 1.3.0
%
% NOTE CHANGE IN VERSION NUMBERING : 1.21--1.28 should have been 1.2.1--1.2.8
%
% Athanassios Protopapas, August 2002
% protopap@ilsp.gr
%
% This package may be distributed under the terms of the LaTeX Project Public
% License, as described in lppl.txt in the base LaTeX distribution.  Either
% version 1.0 or, at your option, any later version.
%
% Use with LaTeX2e, \documentclass[man|jou|doc]{apa}
% Default mode is doc. Conforms to the APA manual 5th ed.
%
% ** Read apacls.txt and examples.txt carefully before using **
%
%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{apa}[2002/08/30 American Psychological Association format v1.3.0]

\DeclareOption{man}{%
\def\def@man{\@manmode}
}

\DeclareOption{jou}{%
\def\def@jou{\@joumode}
}

\DeclareOption{doc}{%
\def\def@doc{\@docmode}
}

\DeclareOption{notimes}{%
\@ifundefined{def@jou}{}{\def\def@notimes{\@notimes}}
}

\DeclareOption{nosf}{%
\@ifundefined{def@man}{}{\def\def@nosf{\@nosf}}
}

\DeclareOption{fignum}{%
\@ifundefined{def@man}{}{\def\fig@num{\relax}}
}

\DeclareOption{floatmark}{%
\@ifundefined{def@man}{}{\def\float@mark{\relax}}
}

\DeclareOption{longtable}{%
%\@ifundefined{def@man}{}{\def\long@table{\relax}}
\def\long@table{\relax}
}

\DeclareOption{tt}{%
\@ifundefined{def@man}{}{\def\tt@family{\relax}}
}

\DeclareOption{helv}{%
\@ifundefined{def@man}{}{\def\helv@family{\relax}}
}

\DeclareOption{notab}{\def\no@tab{\relax}}

\DeclareOption{nobf}{\def\no@bf@title{\relax}}

\DeclareOption*{%
\PassOptionsToClass{\CurrentOption}{article}%
%\ClassWarning{apa}{Supported options are: man, jou, doc, notimes, nosf, fignum, notab, nobf}
}

\ProcessOptions

\@ifundefined{def@man}{%
 \@ifundefined{def@jou}{%
  \@ifundefined{def@doc}{%
   \def\def@doc{\@docmode}
   \ClassWarningNoLine{apa}{Using default mode (doc)}
  }{}
 }{}
}{}

%=================================================================

\@ifundefined{def@man}{}{%
\LoadClass[11pt]{article}
% \RequirePackage{ulem}[1995/12/17] %% not any more, since APA manual 5th ed
%
% endnotes and endfloat loaded later
% longtable must be loaded before endfloat
%
\@ifundefined{long@table}{}{%
 \RequirePackage{longtable}
%
% longtable messes with captions too, we need to intervene to match style
%
\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox{\columnwidth}{%
      \vskip 10pt%
      #1{#2}\par\emph{#3}%
    \endgraf\vskip\baselineskip}%
  \hss}}}
}% END of loading longtable
%
% Switch font family for manuscript if required
%
\@ifundefined{tt@family}{}{%
% A typewriter font can be used as in the APA manual example. Since tt has
% no bold (or bold-italic), the cmss font metrics are loaded instead
% \DeclareFontShape{OT1}{cmtt}{bx}{n}{ <-> sub * cmss/bx/n }{} % this fails
 \DeclareFontShape{OT1}{cmtt}{bx}{n}{ <-> cmssbx10 }{}  % probably not the
 \DeclareFontShape{OT1}{cmtt}{bx}{it}{ <-> cmssbxo10}{} % right way to do it
 \renewcommand{\familydefault}{cmtt}
 }
\@ifundefined{helv@family}{}{%
 \renewcommand{\familydefault}{phv}}
}

%
% For jou mode, load times (and related math fonts) if available
%
\@ifundefined{def@jou}{}{%
 \LoadClass[twoside]{article}
 \@ifundefined{def@notimes}{%
  \IfFileExists{pslatex.sty}{\RequirePackage{pslatex}}{
   \RequirePackage{times}
   \IfFileExists{mathptm.sty}{\RequirePackage{mathptm}}{}}}{}
}

\@ifundefined{def@doc}{}{%
\LoadClass[11pt]{article}
}

%========= Language portability parameters ===========

\def\GreekDefs{%
 \def\rheadname{Up'ertitlos:}
 \def\acksname{Shmei'wseis tou suggraf'ea}
 \def\figurecaptionsname{Lez'antes sqhm'atwn}
 \def\notesname{Uposhmei'wseis}
%
% Bibliography definitions for Greek
 \renewcommand{\BBC}{\textgreek{;} }
 \renewcommand{\BBAA}{\textgreek{kai}}
 \renewcommand{\BOthers}{\textgreek{k.\nobreakspace syn.}}
}

\AtBeginDocument{% so that we know already what language is active in babel
 \def\refname{\bibname} % This is defined as 'References' in apacite.sty
                        % and should change appropriately in babel for other languages
 \def\rheadname{Running head:}
 \def\acksname{Author Note}
 \def\figurecaptionsname{Figure Captions}
 \def\notesname{Footnotes}
 \@ifundefined{iflanguage}{}% then we are not using babel!
  {\edef\str@grk{greek}\ifx\languagename\str@grk\GreekDefs\fi}
}

%========== Alterations to apacite ===================

\RequirePackage{apacite}

\def\thebibliography#1{%
     \bibnewpage
     \@ifundefined{chapter}%
       {\section*{\refname}%
        \@mkboth{\MakeUppercase{\refname}}{\MakeUppercase{\refname}}
        \addcontentsline{toc}{section}{\refname}}%
       {\chapter*{\bibname}%
        \@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}
        \addcontentsline{toc}{chapter}{\bibname}}
     \bibsize
     \list
     {\relax}{\bib@indent}
     \sloppy\clubpenalty4000\widowpenalty4000
     \sfcode`\.=1000\relax}

%========== APA Section heading & seriation, from theapa.sty

%
% \apa@startsection{Heading Indent}{Beforeskip}{Afterskip}{Heading}
%
\def\apa@startsection#1#2#3{\@startsection{}{}{#1}{#2}{#3}{\relax}*}

%
% \b@level@LEVEL-NO@skip
%       Skip before heading: If >= 0, the following par is NOT indented.
%                            If < 0, it is indented.
%                            \b@level@LEVEL-NO@skip = vertical skip
%
% \e@level@LEVEL-NO@skip
%       Skip after heading: If > 0, the following par starts in a new line;
%                               \e@level@LEVEL-NO@skip = vertical skip
%                           If <= 0, it starts just after the heading;
%                               \e@level@LEVEL-NO@skip = horizontal skip
%
\newskip\b@level@one@skip   \b@level@one@skip=2.5ex plus 1ex minus .2ex
\newskip\e@level@one@skip   \e@level@one@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@two@skip   \b@level@two@skip=2.5ex plus 1ex minus .2ex
\newskip\e@level@two@skip   \e@level@two@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@three@skip \b@level@three@skip=2.0ex plus .8ex minus .2ex
\newskip\e@level@three@skip \e@level@three@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@four@skip  \b@level@four@skip=1.8ex plus .8ex minus .2ex
\newskip\e@level@four@skip  \e@level@four@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@five@skip  \b@level@five@skip=1.8ex plus .8ex minus .2ex
\newskip\e@level@five@skip  \e@level@five@skip=0ex

%
% Selecting the Levels of Headings
%

% One Level
\def\OneLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
}

% Two Levels
\def\TwoLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelfour{##1}}%
    \def\@subsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
}

% Two Levels - Variation
\def\TwoLevelHeadingA{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \let\subsection=\levelfive%
}

% Three Levels
\def\ThreeLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelfour{##1}}%
    \def\@subsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \let\subsubsection=\levelfive
}

% Four Levels
\def\FourLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelthree{##1}}%
    \def\@subsectionb[##1]##2{\levelthree{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelthree{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \def\subsubsection{\@ifnextchar*{\@subsubsections}%
                      {\@ifnextchar[{\@subsubsectionb}{\@subsubsection}}}%
    \def\@subsubsections*##1{\levelfour{##1}}%
    \def\@subsubsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsubsection}{##1}}%
    \def\@subsubsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsubsection}{##1}}%
%
    \let\paragraph=\levelfive%
}

% Five Levels
\def\FiveLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\levelone{##1}}%
    \def\@sectionb[##1]##2{\levelone{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\levelone{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\leveltwo{##1}}%
    \def\@subsectionb[##1]##2{\leveltwo{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\leveltwo{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \def\subsubsection{\@ifnextchar*{\@subsubsections}%
                      {\@ifnextchar[{\@subsubsectionb}{\@subsubsection}}}%
    \def\@subsubsections*##1{\levelthree{##1}}%
    \def\@subsubsectionb[##1]##2{\levelthree{##2}%
        \addcontentsline{toc}{subsubsection}{##1}}%
    \def\@subsubsection##1{\levelthree{##1}%
        \addcontentsline{toc}{subsubsection}{##1}}%
%
    \let\paragraph=\levelfour%
    \let\subparagraph=\levelfive%
}

%
% APA Seriations: ONE level of seriation only.
%  \begin{seriate} \item ... \end{seriate}
%           within a paragraph or sentence
%  \begin{APAenumerate} \item ... \end{APAenumerate}
%           at the start of each paragraph in a series
%           with enumeration
%  \begin{APAitemize} \item ... \end{APAitemize}
%           at the start of each paragraph in a series
%           without enumeration
%

% Refer to LaTeX book to modify, if you want, spaces before and after of
%  \begin{...} ... \end{...} or spaces between \item-s.
\newcounter{APAenum}
\newskip\@text@par@indent
\def\APAenumerate{\@text@par@indent\parindent\setbox0\hbox{1. }%
    \list{\arabic{APAenum}.}{\usecounter{APAenum}
    \labelwidth\z@\labelsep\z@\leftmargin\z@\parsep\z@
    \rightmargin\z@\itemsep\z@\topsep\z@\partopsep\z@
    \itemindent\@text@par@indent\advance\itemindent by\wd0
    \def\makelabel##1{\hss\llap{##1 }}}}
\let\endAPAenumerate=\endlist

\def\seriate{\@bsphack\begingroup%
   \setcounter{APAenum}{0}%
   \def\item{\addtocounter{APAenum}{1}(\alph{APAenum})\space}%
   \ignorespaces}
\def\endseriate{\endgroup\@esphack}

\def\APAitemize{\@text@par@indent\parindent\setbox0\hbox{$\bullet$}%
    \list{$\bullet$}{%
    \labelwidth\z@\labelsep.5em\leftmargin\z@\parsep\z@
    \rightmargin\z@\itemsep\z@\topsep\z@\partopsep\z@
    \itemindent\@text@par@indent
    \advance\itemindent by\wd0\advance\itemindent by.5em
    \def\makelabel##1{\hss\llap{##1}}}}
\let\endAPAitemize=\endlist

\let\enumerate=\APAenumerate
\let\endenumerate=\endAPAenumerate
\let\itemize=\APAitemize
\let\enditemize=\endAPAitemize

%=============================================================
%
% End of code from theapa.sty
%
%=============================================================

%===== apa.cls main declarations for title page contents =====

\long\def\title#1{\long\def\@title{#1}}
\long\def\author#1{\long\def\@author{#1}}
\long\def\twoauthors#1#2{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@author{#1}}
\long\def\onetwoauthors#1#2#3{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@author{#1}}
\long\def\twooneauthors#1#2#3{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@author{#1}\def\@twofirst{1}}
\let\threeauthors=\onetwoauthors
\long\def\fourauthors#1#2#3#4{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@authorFour{#4}\long\def\@author{#1}}
\long\def\affiliation#1{\long\def\@affil{#1}}
\long\def\twoaffiliations#1#2{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
\long\def\@affil{#1}}
\long\def\onetwoaffiliations#1#2#3{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affil{#1}}
\long\def\twooneaffiliations#1#2#3{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affil{#1}}
\let\threeaffiliations=\onetwoaffiliations
\long\def\fouraffiliations#1#2#3#4{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affilFour{#4}\long\def\@affil{#1}}
\long\def\note#1{\long\def\@note{#1}}
\long\def\abstract#1{\long\def\@abstract{#1}}
\long\def\acknowledgements#1{\long\def\@acks{#1}}
\def\journal#1{\RequirePackage{fancyhdr}\def\@journal{#1}}
\def\volume#1{\def\@vvolume{#1}}
\def\ccoppy#1{\def\@ccoppy{#1}}
\def\copnum#1{\def\@copnum{#1}}
\def\@error@toomanyauthors{\ClassWarningNoLine{apa}{More authors than affiliations defined}}
\def\@error@toomanyaffils{\ClassWarningNoLine{apa}{More affiliations than authors defined}}
\def\check@author{%
 \@ifundefined{@author}{%
  \ClassWarningNoLine{apa}{Author not defined}\def\@author{Author}}{}
 \@ifundefined{@title}{%
  \ClassWarningNoLine{apa}{Title not defined}\def\@title{Title}}{}
 \@ifundefined{@affil}{%
  \ClassWarningNoLine{apa}{Affiliation not defined}\def\@affil{Affiliation}}{}
 \@ifundefined{@abstract}{%
  \ClassWarningNoLine{apa}{Abstract not defined}}{}
 \@ifundefined{@authorFour}{%
  \@ifundefined{@authorThree}{%
   \@ifundefined{@authorTwo}{%
   }{\@ifundefined{@affilTwo}{\@error@toomanyauthors}{}}
  }{\@ifundefined{@affilThree}{\@error@toomanyauthors}{}}
 }{\@ifundefined{@affilFour}{\@error@toomanyauthors}{}}
 \@ifundefined{@affilFour}{%
  \@ifundefined{@affilThree}{%
   \@ifundefined{@affilTwo}{%
   }{\@ifundefined{@authorTwo}{\@error@toomanyaffils}{}}
  }{\@ifundefined{@authorThree}{\@error@toomanyaffils}{}}
 }{\@ifundefined{@authorFour}{\@error@toomanyaffils}{}}
}

%==== Conditional compilation macros depending on mode ====

\long\def\ifapamodeman#1#2{\@ifundefined{def@man}{#2}{#1}}
\long\def\ifapamodejou#1#2{\@ifundefined{def@jou}{#2}{#1}}
\long\def\ifapamodedoc#1#2{\@ifundefined{def@doc}{#2}{#1}}
\long\def\ifapamode#1#2#3{%
 \@ifundefined{def@man}{%
  \@ifundefined{def@jou}{%
   \@ifundefined{def@doc}{\ClassError{apa}{Undefined mode state!}}{#3}%
  }{#2}%
 }{#1}%
}

%==== Automatic figure size and orientation determination ====

\newsavebox\gr@box
\newlength\gr@boxwidth
\newlength\gr@boxheight

\newcommand{\fitfigure}[2][0.5]{%
\ifapamodeman
{% man
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settowidth{\gr@boxwidth}{\usebox\gr@box}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\gr@boxwidth{% display upright (h)
 \ifdim\gr@boxheight>\textheight%
  \centerline{\vspace{\fill}\includegraphics[height=\textheight]{#2}\vspace{\fill}}%
 \else%
  \usebox\gr@box%
 \fi}
\else{% display rotated
 \sbox\gr@box{\includegraphics[angle=90,width=\linewidth]{#2}}
 \settoheight{\gr@boxheight}{\usebox\gr@box}
 \ifdim\gr@boxheight>\textheight%
  \centerline{\vspace{\fill}\includegraphics[angle=90,height=\textheight]{#2}\vspace{\fill}}%
 \else%
  \usebox\gr@box%
 \fi}
\fi}
{% jou, doc
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\textheight%
 \centerline{\includegraphics[height=#1\textheight]{#2}}% need to leave space for caption
\else%
 \usebox\gr@box%
\fi}
}

\newcommand{\fitbitmap}[2][0.5]{ % like fitfigure but no scaling in man mode for best quality
\ifapamodeman
{% man
\sbox\gr@box{\includegraphics{#2}}
\settowidth{\gr@boxwidth}{\usebox\gr@box}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxwidth>\textwidth% display rotated
  \centerline{\vspace{\fill}\includegraphics[angle=90]{#2}\vspace{\fill}}%
  \ifdim\gr@boxheight>\textwidth\ClassWarning{apa}{Figure #2 too high!}\fi% display rotated
  \ifdim\gr@boxwidth>\textheight\ClassWarning{apa}{Figure #2 too wide!}\fi% display rotated
\else% display upright
  \centerline{\vspace{\fill}\includegraphics{#2}\vspace{\fill}}%
  \ifdim\gr@boxheight>\textheight\ClassWarning{apa}{Figure #2 too high!}\fi% display rotated
\fi}
{% jou, doc
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\textheight%
 \centerline{\includegraphics[height=#1\textheight]{#2}}% need to leave space for caption
\else%
 \centerline{\usebox\gr@box}%
\fi}
}

%==== Miscellaneous definitions

\setlength{\doublerulesep}{\arrayrulewidth}
\newcommand\thickline{\hline\hline}
\renewcommand\footnoterule{%
  \kern-3\p@
%  \hrule.5\@width.4\columnwidth
  \hrule height0.125pt width.5in
  \kern2.6\p@}

\let\old@tabular=\tabular
\def\apatabular#1{\def\@halignto{to\linewidth}\@tabular{@{\extracolsep{\fill}}#1}}

%\let\old@endtabular=\endtabular
%\newlength{\@tabwd}
%\def\endtabular{\global\setlength{\@tabwd}{\z@}\old@endtabular\par\framebox[\@tabwd][c]{test}}
%\def\tab@footnotes{\relax}
%\def\endtabular{\tab@footnotes\old@endtabular} %% \relax causes extra line!! thp 15/3

% Define footnote mark commands for tables that won't mess up vertical alignment
\def\@tab@fn#1{\ensuremath{^{\mbox{{\scriptsize #1}}}}}
\def\tabfnm#1{\rlap{\@tab@fn{#1}}}
\def\tabfnt#1#2{\par\raggedright\@tab@fn{#1}#2}

% Provide a command to display vector symbols appropriately in each mode, thp 10/00
\def\apavector#1{\ifapamodeman
{\raisebox{-1.0ex}{\ensuremath{\stackrel{\mbox{#1}}{\scriptscriptstyle\sim}}}}
{\ensuremath{\bf #1}}}

% Circumvent the bug that shows up when the first accented character occurs 
% inside a citation field -- something about apacite, OT1,and recent LaTeX/old babel...
\newbox\@dummy@box\sbox\@dummy@box{\'{\i}}

%==== Appendix macros added by Michael Erickson 2000/07/11, revised by thp 2000/07/18

\newcounter{appendix}\setcounter{appendix}{0}
\renewcommand{\theappendix}{\@Alph\c@appendix} 
\def\apaappfig{%
 \renewcommand\thefigure{\theappendix\@arabic\c@figure}% 
 \ifapamodeman{\renewcommand\thepostfig{\theappendix\arabic{postfig}}}{}}
\def\apaapptab{%
 \renewcommand\thetable{\theappendix\@arabic\c@table}%
 \ifapamodeman{\renewcommand\theposttbl{\theappendix\arabic{posttbl}}}{}}
\newif\ifoneappendix            
\oneappendixtrue % one appendix by default
\newif\ifappendix
\appendixfalse

\def\appendix{%
  \appendixtrue
  \apaappfig                      
  \apaapptab                      
  \ifapamodejou{}{\clearpage}
  \let\old@apa@section=\leveltwo % This will not work right with five levels in appendix.
                                 % Should go into \section, not \leveltwo but would also require
                                 % changes to section* and section[ (see \def\section above)
                                 % Who uses five level heading appendices anyway?
  \newlength{\app@t@width}
  \setlength{\app@t@width}{\columnwidth}
  \addtolength{\app@t@width}{-8em}%% leveltwo is defined with leftskip=rightskip=4em plus 1fill
  \long\def\leveltwo##1{%
                   \ifapamodeman{%
                    \clearpage
                    \setcounter{postfig}{0}
                    \setcounter{posttbl}{0}
                    \efloat@condopen{fff}
                    \efloat@iwrite{fff}{\string\addtocounter{appendix}{1}}
                    \efloat@iwrite{fff}{\string\setcounter{figure}{0}}
                    \efloat@condopen{ttt}
                    \efloat@iwrite{ttt}{\string\addtocounter{appendix}{1}}
                    \efloat@iwrite{ttt}{\string\setcounter{table}{0}}%
                   }{%
                    \setcounter{figure}{0}%
                    \setcounter{table}{0}%
%                    %\small% the appendix should be set in smaller type in jou, including headers!
                   }%
%                   \addtocounter{appendix}{1}%
                   \refstepcounter{appendix}% 2002/07/20 this takes care of references too
                   \ifnum\c@appendix>1 \immediate\write\@auxout{\global\string\oneappendixfalse}\fi%
                   \old@apa@section{%
                      \old@tabular[t]{@{}p{\app@t@width}@{}}% tabular may have been redefined
                         \centering{%
                          \appendixname\ifoneappendix\else~\theappendix\fi\\
                          ##1%
                      }\endtabular
                   }%
                  }%
} % end of appendix definition

%==== End of general apa.cls macro definitions ====


%%%%%%%%%%%%%%%%%%%%%%%
%                     %
%  MANUSCRIPT FORMAT  %
%                     %
%%%%%%%%%%%%%%%%%%%%%%%

\@ifundefined{def@man}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase\expandafter{#1}}}    % <- \bf
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\@ifundefined{no@bf@title}{\bf}{} #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\em #1}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}.}\hskip .5em plus 1pt minus .5pt}

%========== End of code from theapa.sty ===============

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{#1}}}
\def\leftheader#1{\def\r@headl{#1}}
\def\shorttitle#1{\def\s@title{#1}}%\markright{\hfill #1 \thepage} %% no rm - thp 020227

\def\@@spacing{1.75}

%========== Alterations to endnotes ===================

\RequirePackage{endnotes}

\def\@makeenmark{\hbox{$^{\mbox{\small\@ifundefined{hrm}{}{\sf}\@theenmark}}$}}
\def\enoteformat{\rightskip\z@ \leftskip\z@
     \raggedright\fussy\hyphenpenalty 10000 \parindent=0.4in 
     \leavevmode\llap{\hbox{$^{\mbox{\small\@ifundefined{hrm}{}{\sf}\@theenmark}}$}}}
%\def\notesname{Footnotes} % moved to language portability section
\AtEndDocument{%
 \ifappendix% set section back to no numbering after appendix
  \appendixfalse\let\leveltwo=\old@apa@section%
 \fi
 \@ifundefined{@acks}{}{\newpage\section{\acksname}\@acks}
 \@ifundefined{hrm}{\def\enotesize{\normalsize}}
                   {\def\enotesize{\normalsize\@ifundefined{hrm}{}{\sf}}}
 \@ifundefined{NoEndnotes}{\if@enotesopen\newpage\theendnotes\fi}{}
 \let\footnote=\oldfootnote
}

%========= Alterations to endfloat ====================

\@ifundefined{float@mark}{% Figure and table in-text markers are no longer required
 \RequirePackage[notablist,figlist,notabhead,nofighead,tablesfirst,nomarkers]{endfloat}[1995/10/11]}{%
 \RequirePackage[notablist,figlist,notabhead,nofighead,tablesfirst]{endfloat}[1995/10/11]}

\renewcommand{\figureplace}{%
   \par\begin{center}
   \parbox{\textwidth}
   {\begin{center}
   \rule{2.1in}{0.005in}\\
   Insert \figurename~\thepostfig\ about here\\
   \rule{2.1in}{0.005in}\\
   \end{center}}
   \end{center}\par}
\renewcommand{\tableplace}{%
   \par\begin{center}
   \parbox{\textwidth}
   {\begin{center}
   \rule{2.1in}{0.005in}\\
   Insert \tablename~\theposttbl\ about here\\
   \rule{2.1in}{0.005in}\\
   \end{center}}
   \end{center}\par}

\def\@gobbleuntilnext[#1]{}
\let\eatarg\@gobbleuntilnext
\let\ifnextchar\@ifnextchar

\def\figure{%
     \efloat@condopen{fff}
     \efloat@iwrite{fff}{\string\begin{figure*}[ht]}%
     \global\def\@figure@written{\relax}% Set a flag that there is at least one figure -- thp 20010705 
%% should be a global declaration to be "visible" at end document
     \ifnextchar[{\gobbleuntilnext[}{}
     \efloat@iwrite{fff}{\string\ifnextchar[{\string\eatarg}{}}
    \if@domarkers%
       \addtocounter{postfig}{1}% % bj
       \figureplace%              % bj
    \fi%
    \def\@currenvir{efloat@float}%
    \begingroup%
    \let\do\ef@makeinnocent \dospecials%
    \ef@makeinnocent\^^L% and whatever other special cases
    \endlinechar`\^^M \catcode`\^^M=12 \ef@xfigure}%

\def\table{%
    \efloat@condopen{ttt}
    \efloat@iwrite{ttt}{\string\begin{table*}[ht]}%
    \ifnextchar[{\gobbleuntilnext[}{}
    \@ifundefined{hrm}{}{%
    \efloat@iwrite{ttt}{\string\sf}}%
    \efloat@iwrite{ttt}{\string\ifnextchar[{\string\eatarg}{}} % bj
    \if@domarkers
       \addtocounter{posttbl}{1} % bj
       \tableplace               % bj
    \fi
    \def\@currenvir{efloat@float}%
    \begingroup
    \let\do\ef@makeinnocent \dospecials
    \ef@makeinnocent\^^L% and whatever other special cases
    \endlinechar`\^^M \catcode`\^^M=12 \ef@xtable}

\long\def\@@contentsline#1#2#3{ #2 }
\long\def\@@numberline#1#2{\noindent{\em\figurename\ #1.\/} #2\vspace{0.5\baselineskip}\par}
\long\def\@@caption{\refstepcounter\@captype \@dblarg{\@@@caption\@captype}}
\long\def\@@@caption#1[#2]#3{\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}}
\def\listoffigures{\section*{\figurecaptionsname}\@starttoc{lof}}% changed from 'Figure Captions'

\long\def\figurecaptionsformat{
  \let\contentsline=\@@contentsline
  \let\numberline=\@@numberline
  \def\baselinestretch{\@@spacing}
}

\def\processfigures{%
 \expandafter\ifnum \csname @ef@fffopen\endcsname>0
  \immediate\closeout\efloat@postfff \ef@setct{fff}{0}
  \clearpage                                                       
  \if@figlist
   \@ifundefined{@figure@written}{}{%
    \figurecaptionsformat
    {\normalsize\@ifundefined{hrm}{}{\sf}\listoffigures}          
    \clearpage
   }                             
  \fi
  \if@fighead
     \section*{\figuresection}                                  
     \suppressfloats[t]                                         
  \fi
  \@ifundefined{fig@num}{%
  \markboth{}{}
  \pagestyle{empty}}{%
%  \setcounter{page}{1}
%  \markright{\rm\hfill \s@title, Figure}
   \def\@oddhead{\rightmark}                                    % changed by Michael Erickson
   \markright{\hfill \s@title, \figurename\ \protect\thefigure} % to include appendix numbering
                                                                % remove rm - thp 020227
  }
  \let\caption=\@@caption
  \def\baselinestretch{\@@spacing}\normalsize\@ifundefined{hrm}{}{\sf}
  \processfigures@hook \@input{\jobname.fff}
 \fi}

\def\processtables{%
  \expandafter\ifnum \csname @ef@tttopen\endcsname>0
  \immediate\closeout\efloat@postttt \ef@setct{ttt}{0}
  \clearpage                                                    
  \if@tabhead
      \section*{\tablesection}                                 
      \suppressfloats[t]                                       
  \fi
% \markboth{\MakeUppercase{\tablesection}}{\MakeUppercase{\tablesection}}% bj
  \def\baselinestretch{\@@spacing}
  \processtables@hook \@ifundefined{hrm}{}{\sf}\tiny\normalsize\@input{\jobname.ttt}
 \fi}

%========= Maketitle, margins, lengths, etc. ==========

\def\maketitle{
\@ifundefined{hrm}{}{\hrm}
 \check@author
 \@ifundefined{s@title}{\ClassWarningNoLine{apa}{Using title for short title}
                        \def\s@title{\@title}
                        \markright{\hfill\@title}}%\protect\thepage}}  %% removed rm
                       {\markright{\hfill\s@title}}%\protect\thepage}} %% thp 020227
 \@ifundefined{r@headr}{\ClassWarningNoLine{apa}{Using short title for running head}
                        \def\r@headr{\protect\MakeUppercase{\s@title}}}{}
  \begin{center}
  \vspace*{0.5in}
  \makebox[\linewidth][l]{\rheadname\hspace{0.1in}\MakeUppercase{\r@headr}}\\ %thp090298

  \vspace*{1in}
  \@title\vspace{0.5in}\\

  \@ifundefined{@authorTwo}{
  \@author \\

  \@affil \vspace{0.25in} \\ }{
  \@ifundefined{@authorThree}{
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.25in} \\ }{
  \@ifundefined{@authorFour}{
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.25in} \\ }{
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.2in} \\ 
  \@authorFour \\

  \@affilFour \vspace{0.25in} \\ }}}

  \@ifundefined{@note}
   {\vspace*{\baselineskip} }
   {\@note}

  \end{center}
  \newpage
  \raggedright
  \hyphenpenalty 10000
  \fussy
  \@ifundefined{@abstract}{}{%
   \section{\abstractname}% changed from 'Abstract' 10/00

   \@abstract

   \newpage
  }
  \setlength{\parindent}{0.4in}
  \@ifundefined{DoNotRepeatTitle}{\section{\protect\@title}}{}

  \indent
}

\ThreeLevelHeading
\def\baselinestretch{\@@spacing}
%\def\refname{References}
\setlength{\footnotesep}{0.5cm}
\setlength{\topmargin}{0in}
\setlength{\oddsidemargin}{0.25in}
\setlength{\evensidemargin}{0.25in}
\setlength{\textwidth}{6in}
\setlength{\textheight}{8.5in}
\setcounter{secnumdepth}{0}

\def\ps@myheadings{
 \let\@mkboth\@gobbletwo
 \def\@oddhead{\hbox{}\rightmark\hfil\hspace{0.1in}\thepage} %% removed rm - thp 020227
 \def\@oddfoot{}
 \def\@evenhead{}
 \def\@evenfoot{}
 \def\sectionmark##1{}
 \def\subsectionmark##1{}}

\pagestyle{myheadings}
\raggedright
\hyphenpenalty 10000
\newcommand{\footmark}[1]{${}^{\mbox{\normalsize #1}}$}

\long\def\@makecaption#1#2{%
 \vskip10pt%
 \setbox\@tempboxa\hbox{\parbox{\columnwidth}{#1\cap@line{\cap@style #2}}}%
 \ifdim\wd\@tempboxa>\hsize\parbox{\columnwidth}{#1\cap@line{\cap@style #2}}\par%
 \else\hbox to\hsize{\box\@tempboxa\hfil}\par%
 \fi%
 \vskip\baselineskip}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize\@ifundefined{hrm}{}{\hrm}
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3 } \par
  \endgroup}

\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}

\def\centeredcaption#1{\caption}

\def\fnum@figure{\def\cap@style{}\def\cap@line{}{\em\figurename\ {\thefigure}}. }
% added second set of braces around \em  to get citations in man mode -- tp 17/7/2000
% then removed them again because they were cancelling application of em to the caption
\long\def\fnum@table{\def\cap@style{\em}\def\cap@line{\\ }\tablename\ \thetable }

\setcounter{topnumber}{1}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.6}
\setcounter{totalnumber}{1}
\def\textfraction{0}
\def\floatpagefraction{.7}
\setcounter{dbltopnumber}{1}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.7}
\def\dbltextfloatsep{\textfloatsep}

\fussy
\setlength{\parindent}{0.4in}
\let\oldfootnote=\footnote % 3/10/00 
\let\footnote=\endnote
\def\footnotesize{\normalsize\rm}

\@ifundefined{def@nosf}{%
\def\helvetica{%
\ClassWarning{apa}{ignored \string\helvetica\space (use helv option)}
}}{\def\helvetica{\relax}}

\def\timesroman{%
 \RequirePackage{times}
 \InputIfFileExists{mathptm.sty}{}{}
 \doublehyphendemerits5000
 \hfuzz0pt
 \tolerance=9999
 \pretolerance=-1 % Always look for hyphens
 \emergencystretch=25pt
 \hbadness=30000
 \hyphenpenalty=100 % since average badness will be high!
}

\bibleftmargin=\parindent
\def\bibnewpage{\newpage}
\def\bibsize{}
\def\bib@indent{\labelsep=0em
		\itemsep=0em 
%                \parsep=0em %% thp 21-Aug-2002 -- some editor complained!!
                \leftmargin=\bibleftmargin
                \itemindent=-\bibleftmargin}
                \def\newblock{\hskip .11em plus .33em minus .07em}\fussy

%==== Appendix definitions added by Michael Erickson 2000/07/11
\efloat@condopen{fff}
\efloat@iwrite{fff}{\string\apaappfig}
\efloat@iwrite{fff}{\string\setcounter{appendix}{0}}
\efloat@condopen{ttt}
\efloat@iwrite{ttt}{\string\apaapptab}
\efloat@iwrite{ttt}{\string\setcounter{appendix}{0}}

}

%%%%%%%%%%%%%%%%%%
%                %
% JOURNAL FORMAT %
%                %
%%%%%%%%%%%%%%%%%%

\@ifundefined{def@jou}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase\expandafter{\large #1}}}    % <- \bf
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     {\large #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\large{\em #1}}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{\large{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}.}\hskip .5em plus 1pt minus .5pt}

%========== End of code from theapa.sty ===============

%========== balance last-page columns ================= 

\IfFileExists{flushend.sty}{\RequirePackage{flushend}}{}

%========== ftnright and alterations ==================

\IfFileExists{ftnright.sty}{
 \let\savefootnoterule\footnoterule
 \let\save@makefntext\@makefntext
 \RequirePackage{ftnright}
 \let\footnoterule\savefootnoterule
 \let\@makefntext\save@makefntext
}{}

%======================================================

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{\protect\scriptsize #1}}}
\def\leftheader#1{\def\r@headl{\protect\MakeUppercase{\protect\scriptsize #1}}}
\def\shorttitle#1{}

\def\put@one@authaffil#1#2{%
  \parbox[t]{\textwidth}{\begin{center}{\large #1\vspace{0in}}%
                        {\\ #2\vspace{0.05in}\\}\end{center}}}

\newsavebox\auone@box
\newsavebox\autwo@box
\newsavebox\autot@box
\newlength\auone@boxwidth
\newlength\autwo@boxwidth
\newlength\autot@boxwidth

\def\default@d@authaffil#1#2#3#4{%
        \parbox[t]{\columnwidth}{\begin{center}{\large #1\vspace{0in}}%
                                {\\ #2\vspace{0.05in}\\}\end{center}}%
        \parbox[t]{\columnwidth}{\begin{center}{\large #3\vspace{0in}}%
                                {\\ #4\vspace{0.05in}\\}\end{center}}}

\def\uneven@d@authaffil#1#2#3#4{%
     \hfill\parbox[t]{\auone@boxwidth}{\begin{center}{\large #1\vspace{0in}}%
                                      {\\ #2\vspace{0.05in}\\}\end{center}}\hfill\hfill%
           \parbox[t]{\autwo@boxwidth}{\begin{center}{\large #3\vspace{0in}}%
                                      {\\ #4\vspace{0.05in}\\}\end{center}}\hfill}

\def\put@two@authaffil#1#2#3#4{%
     \let\disp@authaffil\default@d@authaffil
     \sbox\auone@box{\begin{tabular}{c}\large #1\\ #2\end{tabular}}
     \settowidth{\auone@boxwidth}{\usebox\auone@box}
     \sbox\autwo@box{\begin{tabular}{c}\large #3\\ #4\end{tabular}}
     \settowidth{\autwo@boxwidth}{\usebox\autwo@box}
     \ifdim\auone@boxwidth<1.25\columnwidth
      \ifdim\autwo@boxwidth<1.25\columnwidth
       \sbox\autot@box{\usebox\auone@box\hspace{0.4in}\usebox\autwo@box}
       \settowidth{\autot@boxwidth}{\usebox\autot@box}
       \ifdim\autot@boxwidth<\textwidth
        \let\disp@authaffil\uneven@d@authaffil
       \fi
      \fi
     \fi
     \ifdim\auone@boxwidth<\columnwidth
      \ifdim\autwo@boxwidth<\columnwidth
       \let\disp@authaffil\default@d@authaffil
      \fi
     \fi
     \disp@authaffil{#1}{#2}{#3}{#4}
}

\def\maketitle{
 \check@author
 \@ifundefined{r@headr}{\def\r@headr{\protect\MakeUppercase{\protect\scriptsize\@title}}}{}
 \@ifundefined{r@headl}{\def\r@headl{\protect\MakeUppercase{\protect\scriptsize\@author}}}{}
 \twocolumn[
  \vspace{0.03in}
  \begin{center}
% title
  {\LARGE \@title}\\
  \vspace{-0.05in}
  \@ifundefined{@authorTwo}{
% one author-affiliation
  \put@one@authaffil{\@author}{\@affil}}{
  \@ifundefined{@authorThree}{
% two authors-affiliations
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}}{
  \@ifundefined{@authorFour}{
% three authors-affiliations
  \@ifundefined{@twofirst}{
% first one, then two
  \put@one@authaffil{\@authorOne}{\@affilOne}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorTwo}{\@affilTwo}{\@authorThree}{\@affilThree}
  }{
% first two, then one
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@one@authaffil{\@authorThree}{\@affilThree}
  }}{
% four authors-affiliations
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorThree}{\@affilThree}{\@authorFour}{\@affilFour}
  }}}
  \@ifundefined{@note}
   {\vspace{0.07in}}
   {\vspace{0.07in}\\ {\large\@note\vspace{0.07in}}}
  \@ifundefined{@abstract}
  {\par }
  {\par \parbox{4.6875in}
   {\small \noindent \@abstract
   }\vspace{0.24in}
  }
  \end{center}
 ]
 \pagenumbering{arabic}
 \@ifundefined{@journal}{\thispagestyle{empty}}{%
  \@ifundefined{@vvolume}{\def\@vvolume{\strut}}{}%
  \@ifundefined{@copnum}{\def\@copnum{\strut}}{}%
  \@ifundefined{@ccoppy}{\def\@ccoppy{\strut}}{}%
  \fancyhead{}
  \fancyhead[LO]{\stiny{\@journal}\vspace{-0.15\baselineskip}\\
                 \stiny{\@vvolume}}
  \fancyhead[RO]{\stiny{\@ccoppy}\vspace{-0.15\baselineskip}\\
                 \stiny{\@copnum}}
  \fancyfoot[CO]{\small\rm\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \thispagestyle{fancy}
 }
 \@ifundefined{@acks}
  {}
  {\begin{figure}[b]
   \parbox{\columnwidth}{\setlength{\parindent}{0.18in}
   \noindent \makebox[\columnwidth]{\vrule height0.125pt width\columnwidth}\vspace*{0.05in}\par
   {\footnotesize\hspace{-0.04in}\@acks\par}}
   \end{figure}}
 \markboth{\hfill\r@headl\hfill}{\hfill\r@headr\hfill}
 \@ifundefined{no@tab}{\let\tabular\apatabular}{}
 \noindent
}

\newcommand\stiny{\@setfontsize\stiny\@vipt\@viipt}

\ThreeLevelHeading
\def\baselinestretch{0.923}
%\def\refname{References}
\setlength{\footnotesep}{0.2813in}
\setlength{\topmargin}{-0.275in}
\addtolength{\headheight}{0.02in}
\addtolength{\headsep}{-0.156in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\textwidth}{6.94in}
\setlength{\textheight}{8.9in}
\setlength{\columnwidth}{8.5cm}
\setlength{\columnsep}{0.25in}
\setlength{\parindent}{0.15625in}
%\setlength{\parskip}{0in}
\setlength{\textfloatsep}{0.35in}
%\flushbottom

\setcounter{secnumdepth}{0}

\def\ps@myheadings{\let\@mkboth\@gobbletwo
\def\@oddhead{\hbox{}\rightmark \hfil
\large\rm\thepage}\def\@oddfoot{}\def\@evenhead{\large\rm \thepage\hfil\leftmark\hbox
{}}\def\@evenfoot{}\def\sectionmark##1{}\def\subsectionmark##1{}}
\pagestyle{myheadings}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1 #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1 #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\long\def\@makeccaption#1#2#3{
 \vskip\abovecaptionskip
 \setbox\@tempboxa\hbox{#1 #2}
 \ifdim \wd\@tempboxa > \hsize 
    \hbox to\hsize{\hfil\parbox[t]{#3}{#1 #2}\hfil} 
  \else 
    \ifdim \wd\@tempboxa > #3
      \hbox to\hsize{\hfil\parbox[t]{#3}{#1 #2}\hfil}
    \else
      \hbox to\hsize{\hfil\mbox{#1 #2}\hfil} 
    \fi
 \fi 
 \vskip\belowcaptionskip}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \csname setcskip@#1\endcsname
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\long\def\@ccaption#1[#2]#3#4{\def\@ccwidth{#3} \par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makeccaption{\csname fnum@#1\endcsname}{\ignorespaces #4}{\@ccwidth}\par
  \endgroup}

\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}

\long\def\centeredcaption{\refstepcounter\@captype \@dblarg{\@ccaption\@captype}}

\def\setcskip@table{\setlength{\abovecaptionskip}{3.2pt}\setlength{\belowcaptionskip}{2pt}}
\def\setcskip@figure{\setlength{\abovecaptionskip}{-0.04in}\setlength{\belowcaptionskip}{-1.9pt}}

\def\fnum@figure{\small{\em\figurename\ {\thefigure}}.\hspace{0.07in}}
\long\def\fnum@table{\makebox[\linewidth][l]{\tablename\ \thetable} \\ \em }

\def\@makefnmark{\hbox{\@textsuperscript{\normalfont{\scriptsize\@thefnmark}}}}%
\long\def\@makefntext#1{\parindent 1em\noindent
           \hb@xt@1.8em{%
           \hss\@textsuperscript{\normalfont{\tiny\@thefnmark}\hspace{1.5pt}}}#1}%

\setcounter{topnumber}{2}
\def\topfraction{.85}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.75}
\setcounter{totalnumber}{3}
\def\textfraction{.10}
\def\floatpagefraction{.85}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.85}
\def\dblfloatpagefraction{.85}
\def\dbltextfloatsep{0.8\textfloatsep}
\let\footnotesize=\small

\def\helvetica{\relax}
\def\timesroman{\relax}

\doublehyphendemerits5000
\hfuzz0pt
\tolerance=9999
\pretolerance=-1
\emergencystretch=25pt
\hbadness=30000
\hyphenpenalty=100
\bibleftmargin=1.2em
\def\bibnewpage{}
\def\bibsize{\footnotesize}
\def\bib@indent{\labelsep=0em
                \itemsep=0em
                \leftmargin=\bibleftmargin
                \itemindent=-\bibleftmargin}
                \def\newblock{\hskip .11em plus .33em minus .07em}\sloppy

}

%%%%%%%%%%%%%%%%%%
%                %
% REGULAR FORMAT %
%                %
%%%%%%%%%%%%%%%%%%

\@ifundefined{def@doc}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase\expandafter{\large #1}}}    % <- \bf
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     {\large #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\large\em #1}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}.}\hskip .5em plus 1pt minus .5pt}

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{\protect\small #1}}}
\def\leftheader#1{\def\r@headl{\protect\MakeUppercase{\protect\small #1}}}
\def\shorttitle#1{\def\s@title{#1}}
\pagestyle{myheadings}

%========== End of code from theapa.sty ===============

\def\maketitle{
 \check@author
 \@ifundefined{r@headr}{\typeout{Using title for running head} 
                        \def\r@headr{\protect\MakeUppercase{\@title}}
                        \markright{\rm \@title \protect\\ \thepage}} {}
 \@ifundefined{r@headl}{\let\r@headl\r@headr}{}
 \@ifundefined{s@title}{\let\s@title\r@headr}{}
  \sloppy 
  \setlength{\parindent}{0.4in}
  \begin{center}
   \@ifundefined{@journal}{}{%
    \@ifundefined{@vvolume}{\def\@vvolume{}}{}%
    \@ifundefined{@copnum}{\def\@copnum{}}{}%
    \@ifundefined{@ccoppy}{\def\@ccoppy{}}{}%
    {\scriptsize{\@journal}}\hspace{\fill}{\scriptsize{\@ccoppy}}\vspace{-0.3\baselineskip}\\
    {\scriptsize{\@vvolume}}\hspace{\fill}{\scriptsize{\@copnum}}\vspace{0.1in}\\
   }
  \vspace*{0.3in}

  {\LARGE \@title}\\
  
  \vspace{0.3in}

  \@ifundefined{@authorTwo}{
% one author-affiliation
  {\Large \@author} \\

  \@affil \vspace{0.1in} \\ }{
  \@ifundefined{@authorThree}{
% two authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ }{
  \@ifundefined{@authorFour}{
% three authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ }{
% four authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ 
  {\Large \@authorFour}\\

  \@affilFour \vspace{0.1in} \\ }}}
  \@ifundefined{@note}
   {\vspace*{\baselineskip} }
   {\@note\vspace{0.2in}}

  \@ifundefined{@abstract}{}{%
   {\bf\abstractname}\vspace{0.1in}% changed from 'Abstract' 10/00

   \parbox{5in}{\@abstract}\vspace{0.25in}
  }
  \end{center}
 \pagenumbering{arabic}
 \thispagestyle{empty}
 \@ifundefined{@acks}
  {}
  {\begin{figure}[b]
   \parbox{\textwidth}{ \setlength{\parindent}{0.2in}
   \noindent \makebox[\linewidth]{\vrule height0.125pt width\linewidth}

   \vspace*{0.05in}
   {\footnotesize
   \indent \@acks

   }}
   \end{figure}}
 \markboth{\hfill \r@headl \hfill}{\hfill \r@headr \hfill}
 \noindent
}

\ThreeLevelHeading
%\def\refname{References}
\setlength{\topmargin}{-0.25in}
\setlength{\oddsidemargin}{0.25in}
\setlength{\evensidemargin}{0.25in}
\setlength{\textwidth}{6in}
\setlength{\textheight}{8.5in}
\setcounter{secnumdepth}{0}
\flushbottom

\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.6}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.7}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.8}
\def\dblfloatpagefraction{.8}
\def\dbltextfloatsep{0.8\textfloatsep}

\def\helvetica{\relax}
\def\timesroman{\relax}
\def\centeredcaption#1{\caption}

\long\def\@makecaption#1#2{
 \vskip 10pt 
 \setbox\@tempboxa\hbox{#1 #2}
 \ifdim \wd\@tempboxa >\hsize #1 #2\par \else \hbox
to\hsize{\hfil\box\@tempboxa\hfil} 
 \fi 
 \vskip 4pt}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\def\fnum@figure{\small {\em\figurename\ {\thefigure}}.\hspace{0.07in}}
\long\def\fnum@table{\small\tablename\ {\thetable}:}

\bibleftmargin=2em
\def\bibnewpage{}
\def\bibsize{\small}
\def\bib@indent{\labelsep=0em
                \leftmargin=\bibleftmargin
                \itemindent=-\bibleftmargin}
                \def\newblock{\hskip .11em plus .33em minus .07em}\sloppy

}

%---------- end of mode specific definitions -----------

%=======================================================
%       Some final definitions for all modes
%=======================================================

%\long\def\ignore#1{\relax}
\let\ignore\@gobble
\let\oneLevelHeading=\OneLevelHeading
\let\twoLevelHeading=\TwoLevelHeading
\let\threeLevelHeading=\ThreeLevelHeading
\let\fourLevelHeading=\FourLevelHeading
\let\fiveLevelHeading=\FiveLevelHeading
\def\HeadingLevels#1{\csname #1LevelHeading\endcsname} % fixed Jan 5 99
\def\headinglevels#1{\csname #1LevelHeading\endcsname} % fixed Jan 5 99
\bibliographystyle{apacite}
%\def\bibliographystyle#1{\relax}
%
% Thanks to Donald Arsenau for the right way to ignore \bibliographystyle
%
\def\bibliographystyle#1{\ClassWarning{apa}{\string\bibliographystyle
 \space command ignored}}
