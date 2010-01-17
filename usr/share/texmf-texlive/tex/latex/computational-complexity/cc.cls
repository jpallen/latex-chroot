%%
%% This is file `cc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cc.dtx  (with options: `cccls,chartab')
%% 
%% This is a generated file.
%% 
%% Copyright 2000-2003
%% Michael N"usken, Joachim von zur Gathen, computational complexity
%% 
%% IMPORTANT NOTICE:
%% 
%% You are *not* allowed to modify this file.
%% 
%% You are *not* allowed to distribute this file.
%% For distribution of the original source see the terms
%% for copying and modification in the file cc.dtx.
%% 
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
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\providecommand\ignorespacesafterend{\@ignoretrue}
\newif\ifclass
\ifx\@currext\@clsextension\classtrue\else\classfalse\fi
\ifclass\expandafter\ProvidesClass\else\expandafter\ProvidesPackage\fi
{\ifclass cc\else cc-cls\fi}[2006/10/13 v2.06
   computational complexity
   \ifclass document class\else package\fi]
\RequirePackage{ccaux}
\DeclareOption{localnumbering}{\@longarticletrue}
\DeclareOption{globalnumbering}{\@longarticlefalse}
\DeclareOption{longarticle}{\@longarticletrue}
\DeclareOption{shortarticle}{\@longarticlefalse}
\DeclareOption{cclayout}{\@cclayouttrue}
\DeclareOption{nocclayout}{\@cclayoutfalse}
\DeclareOption{prefixes}{%
  \PassOptionsToPackage{\CurrentOption}{relabel}}
\DeclareOption{noprefixes}{%
  \ExecuteOptions{notheoremitemprefixes}%
  \PassOptionsToPackage{\CurrentOption,nobare}{relabel}}
\DeclareOption{bare}{\PassOptionsToPackage{\CurrentOption}{relabel}}
\DeclareOption{nobare}{\PassOptionsToPackage{\CurrentOption}{relabel}}
\DeclareOption{multilingual}{\ExecuteOptions{T1,latin1,babel}}
\DeclareOption{nomultilingual}{\ExecuteOptions{OT1,nolatin1,nobabel}}
\DeclareOption{T1}{\@Tonetrue}
\DeclareOption{OT1}{\@Tonefalse}
\DeclareOption{latin1}{\@latintrue}
\DeclareOption{nolatin1}{\@latinfalse}
\DeclareOption{babel}{\@babeltrue}
\DeclareOption{nobabel}{\@babelfalse}
\DeclareOption{ams}{\@amstrue}
\DeclareOption{noams}{\@amsfalse}
\DeclareOption{autotitle}{\@autotitletrue}
\DeclareOption{noautotitle}{\@autotitlefalse}
\DeclareOption{ccsectioning}{\@ccsectioningtrue}
\DeclareOption{noccsectioning}{\@ccsectioningfalse}
\DeclareOption{natbib}{\@natbibtrue\@cccitefalse}
\DeclareOption{nonatbib}{\@natbibfalse\@cccitefalse}
\DeclareOption{cccite}{\@natbibfalse\@cccitetrue}
\DeclareOption{nocccite}{\@natbibfalse\@cccitefalse}
\DeclareOption{manualbibliography}{\@manualbibliographytrue}
\DeclareOption{twocolumnbibliography}{\@twocolumnbibliographytrue}
\DeclareOption{onecolumnbibliography}{\@twocolumnbibliographyfalse}
\DeclareOption{nosort}{%
  \def\@natbibsort{}}
\DeclareOption{sort}{%
  \def\@natbibsort{\PassOptionsToPackage{sort}{natbib}}}
\DeclareOption{sort&compress}{%
  \def\@natbibsort{\PassOptionsToPackage{sort&compress}{natbib}}}
\DeclareOption{cctheorems}{\@cctheoremstrue\@standardtheoremstrue}
\DeclareOption{cctheorems+separatelycounted}{%
  \@cctheoremstrue\@standardtheoremsfalse}
\DeclareOption{nocctheorems}{\@cctheoremsfalse}
\DeclareOption{separateequationcounting}{\@ccnosepeqncntfalse}
\DeclareOption{noseparateequationcounting}{\@ccnosepeqncnttrue}
\DeclareOption{ccalgorithms}{\@ccalgotrue}
\DeclareOption{noccalgorithms}{\@ccalgofalse}
\DeclareOption{theoremitemprefixes}{%
  \PassOptionsToPackage{\CurrentOption}{ccthm}}
\DeclareOption{notheoremitemprefixes}{%
  \PassOptionsToPackage{\CurrentOption}{ccthm}}
\DeclareOption{enhancedprefixes}{% old
  \PassOptionsToPackage{theoremitemprefixes}{ccthm}}
\DeclareOption{standardprefixes}{% old
  \PassOptionsToPackage{notheoremitemprefixes}{ccthm}}
\DeclareOption{ccpublish}{\@ccpublishtrue}
\DeclareOption{noccpublish}{\@ccpublishfalse}
\DeclareOption{cctextarea}{\@cctextareatrue}
\DeclareOption{nocctextarea}{\@cctextareafalse}
\DeclareOption{noothermargins}{\@marginmode\m@ne}
\DeclareOption{classicalmargins}{\@marginmode\z@}
\DeclareOption{printmargins}{\@marginmode\@ne}
\DeclareOption{balancedmargins}{\@marginmode\tw@}
\DeclareOption{10pt}{\def\@ccptsize{10}}
\DeclareOption{11pt}{\def\@ccptsize{11}}
\DeclareOption{12pt}{\def\@ccptsize{12}}
\DeclareOption{a4paper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{a5paper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{b5paper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{letterpaper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{legalpaper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{executivepaper}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{landscape}{\@cctextareafalse%
  \PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{leqno}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{amsmath}%
  }
\DeclareOption{reqno}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{amsmath}%
  }
\DeclareOption*{\OptionNotUsed
  \PassOptionsToClass{\CurrentOption}{article}}
\ifclass
\ExecuteOptions{a4paper,12pt,cctextarea,balancedmargins,twoside,%
  OT1,nolatin1,nobabel,%
  localnumbering,bare,%
  leqno,ams,ccpublish,cclayout,autotitle,ccsectioning,%
  onecolumnbibliography,natbib,sort&compress,%
  cctheorems,theoremitemprefixes,noseparateequationcounting,%
  ccalgorithms}
\else
\ExecuteOptions{a4paper,12pt,nocctextarea,balancedmargins,twoside,%
  OT1,nolatin1,nobabel,%
  localnumbering,bare,%
  leqno,ams,noccpublish,nocclayout,noautotitle,ccsectioning,%
  onecolumnbibliography,natbib,sort&compress,%
  cctheorems,theoremitemprefixes,noseparateequationcounting,%
  ccalgorithms}
\fi
\ProcessOptions\relax
\PassOptionsToClass{\@ccptsize pt}{article}
\if@twoside
\PassOptionsToClass{twoside}{article}
\else
\PassOptionsToClass{oneside}{article}
\fi
\let\@ccptsize\@undefined
\@natbibsort
\let\@natbibsort\@undefined
\if@standardtheorems\else
    \ClassWarning{cc}{You are using the non documented
      feature\MessageBreak
      cctheorems+separatelycounted.\MessageBreak
      It is recommended not to use this.}
\fi
\newcommand{\cc}{\textsf{computational complexity}}
\ifclass
\LoadClass{article}[1999/01/07 v1.4a]
\fi
\if@Tone
\RequirePackage[T1]{fontenc}
\fi
%%german.sty is not allowed. Use global options:
%%multilingual,german.
\@pass@ptions\@pkgextension{}{german}
\global\expandafter\let\csname ver@german.\@pkgextension\endcsname\@empty
\if@babel
\RequirePackage{babel}
\fi
\if@latin
\RequirePackage[latin1]{inputenc}[1998/03/05 v0.97]
\fi
\if@ams
\RequirePackage{amsmath}[2000/01/15 v2.05]% 1997/03/20 v1.2d
\RequirePackage{amsfonts}[1997/09/17 v2.2e]
\RequirePackage{amssymb}[1996/11/03 v2.2b]
\else
\newcommand{\numberwithin}[3][\arabic]{%
  \@ifundefined{c@#2}{\@nocounterr{#2}}{%
    \@ifundefined{c@#3}{\@nocnterr{#3}}{%
      \@addtoreset{#2}{#3}%
      \expandafter\xdef\csname the#2\endcsname{%
        \expandafter\noexpand\csname the#3\endcsname%
        .\noexpand#1{#2}}}}%
}
%% \def\numberwithin#1#2{\@ifundefined{c@#1}{\@nocounterr{#1}}{%
%%   \@ifundefined{c@#2}{\@nocnterr{#2}}{%
%%   \@addtoreset{#1}{#2}%
%%   \toks@\expandafter\expandafter\expandafter{\csname the#1\endcsname}%
%%   \expandafter\xdef\csname the#1\endcsname
%%     {\expandafter\noexpand\csname the#2\endcsname
%%      .\the\toks@}}}}
\let\@ifempty\cc@ifempty
\let\@ifnotempty\cc@ifnotempty
\let\bigstar\bullet
\let\lozenge\circ
\def\square{{\fboxsep.3em{\vbox{\hbox{\fbox{}}\vskip0pt}}}}
\let\text\mbox% This is a poor man's version!
\fi
\RequirePackage{url}[1999/03/02 ver 1.4]
\expandafter\def\expandafter\UrlSpecials\expandafter{%
  \UrlSpecials\do\%{}}
\providecommand{\email}{\begingroup\urlstyle{tt}\Url}
\providecommand{\homepage}{\begingroup\scriptsize\urlstyle{tt}\Url}
\providecommand{\ixpt}{\@setfontsize\ixpt\@ixpt{11}}
\newcommand{\xptsfbx}{%
  \@setfontsize\xpt\@xpt{12}\usefont{OT1}{cmss}{bx}{n}}
\DeclareTextFontCommand{\textsfbx}{\usefont{OT1}{cmss}{bx}{n}}
\if@cclayout
\RequirePackage{cclayout}
\else
\newskip\headerindent \headerindent=10mm
\newdimen\headrulewidth \headrulewidth.4pt
\def\cctitlehead{}
\def\ccauthorhead{}
\def\ps@cc{\let\@mkboth\markboth
     \def\@oddhead{\vbox{\hbox to\textwidth{\reset@font\strut
         \null
         \hfil
         {\small\cctitlehead}%
         \hbox to\headerindent{\hfil\thepage}%
         }%
       \if@ccpublish\else
       \kern2.6\p@
       \hrule\@height\headrulewidth\kern-\headrulewidth
       \kern-2.6\p@
       \fi
       \vskip\z@
       }%
     }%
     \def\@oddfoot{}
     \def\@evenhead{\vbox{\hbox to\textwidth{\reset@font\strut
         \hbox to\headerindent{\thepage\hfil}%
         {\small\ccauthorhead}%
         \hfil
         \null
         }%
       \if@ccpublish\else
       \kern2.6\p@
       \hrule\@height\headrulewidth\kern-\headrulewidth
       \kern-2.6\p@
       \fi
       \vskip\z@
       }%
     }%
     \let\@evenfoot\@oddfoot
     }
\fi%@cclayout
\if@ccsectioning
\def\@seccntformat#1{\csname the#1\endcsname.\enskip}
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-2.9ex\@plus-.5ex\@minus-.2ex}%
  {1.5ex\@plus.5ex\@minus.2ex}%
  {\normalfont\large\bfseries\centering}}
\def\opt@fullstop#1{#1{\has@fullstop#1.\@@@
\if@tempswa\else
\has@exlamationmark#1!\@@@
\if@tempswa\else
\has@questionmark#1?\@@@
\if@tempswa\else
.\fi
\fi
\fi}}
\def\has@fullstop#1.#2\@@@{\@ifempty{#2}{\@tempswafalse}{\@tempswatrue}}
\def\has@exlamationmark#1!#2\@@@{\@ifempty{#2}{\@tempswafalse}{\@tempswatrue}}
\def\has@questionmark#1?#2\@@@{\@ifempty{#2}{\@tempswafalse}{\@tempswatrue}}
\def\dot@sect#1#2#3#4#5#6[#7]#8{%
  \let\@sect\ccorg@sect\let\@ssect\ccorg@ssect
  \@sect{#1}{#2}{#3}{#4}{#5}{#6}[#7]{\opt@fullstop{#8}}}
\def\dot@ssect#1#2#3#4#5{%
  \let\@sect\ccorg@sect\let\@ssect\ccorg@ssect
  \@ssect{#1}{#2}{#3}{#4}{\opt@fullstop{#5}}}
\def\add@dot{%
  \let\ccorg@sect\@sect\let\ccorg@ssect\@ssect
  \let\@sect\dot@sect\let\@ssect\dot@ssect}
\renewcommand{\subsection}{%
  \add@dot
  \@startsection{subsection}{2}{\z@}%
  {2.33ex\@plus.5ex\@minus.2ex}% was 12pt +-
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\renewcommand{\subsubsection}{%
  \add@dot
  \@startsection{subsubsection}{3}{\z@}%
  {1.55ex\@plus.5ex\@minus.2ex}% was 8pt +-
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\fi%@ccsectioning
\if@natbib
\RequirePackage{cc2cite}
\if@manualbibliography
\bibpunct{[}{]}{;}{n}{}{,}
\fi
\else%@natbib
\if@cccite
\RequirePackage{cccite}
\renewcommand{\thebibliography}[1]{%
  \condbreak{8ex}%
  \section*{\refname
    \addcontentsline{toc}{section}{\refname}%
    \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
  \vskip-\lastskip
  \list{[\@arabic\c@enumiv] }%
  {%
    \labelwidth\z@
    \labelsep\z@
    \leftmargin\z@
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
    }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000
  \sfcode`\.\@m
  \bibfont}
\let\bibfont\small
\CheckCommand*\@bibitem[1]{\item\if@filesw \immediate\write\@auxout
  {\string\bibcite{#1}{\the\value{\@listctr}}}\fi\ignorespaces}
\def\@bibitem#1{\item\if@filesw \immediate\write\@auxout
  {\string\bibcite{#1}{[\the\value{\@listctr}]}}\fi\ignorespaces}
\else
  \relax
\fi%@cccite
\fi%@natbib
\if@twocolumnbibliography
\RequirePackage{multicol}
\newenvironment{nthebibliography}{%
  \footnotesize
  \let\bibfont\footnotesize
  \let\section\subsubsection
  \begin{multicols}2
    \othebibliography}
  {%
    \vfill\vfill\vfill\vfill
    \endothebibliography
  \end{multicols}}
\AtBeginDocument{%
  \let\othebibliography\thebibliography
  \let\endothebibliography\endthebibliography
  \let\thebibliography\nthebibliography
  \let\endthebibliography\endnthebibliography}
\fi
\RequirePackage{relabel}[1998/09/07 v1.01]
\let\nref\ref
\babel\def\partname{Part}[german=Teil,french=\protect\@Fpt partie]
\defprefix{part}{\partname~}
\babel\def\chaptername{Chapter}[german=Kapitel,french=Chapitre]
\defprefix{chapter}{\chaptername~}
\babel\def\sectionname{Section}[german=Abschnitt,french=Section]
\defprefix{section}{\sectionname~}
\babel\def\subsectionname{Section}[german=Abschnitt,french=Section]
\defprefix{subsection}{\subsectionname~}
\babel\def\subsubsectionname{Section}[german=Abschnitt,french=Section]
\defprefix{subsubsection}{\subsubsectionname~}
\let\ccorg@appendix\appendix
\babel\def\appendixname{Appendix}[german=Anhang,french=Annexe]
\def\appendix{%
  \defprefix{section}{\appendixname~}%
  \defprefix{subsection}{\appendixname~}%
  \defprefix{subsubsection}{\appendixname~}%
  \ccorg@appendix}
\defprefix{equation}#1{(#1)}
\babel\def\figurename{Figure}[german=Figur,french={\scshape Figure}]
\defprefix{figure}{\figurename~}
\babel\def\tablename{Table}[german=Tafel,french={\scshape Table}]
\defprefix{table}{\tablename~}
\numberallwithin{section}
\AtBeginDocument{\@adjustnumbering}
\if@cctheorems
\RequirePackage{ccthm}
\RequirePackage{ccproof}
\fi
\if@ccalgo
\RequirePackage{ccalgo}
\fi
\babel\def\ccacknowledgementsname{Acknowledgements}[%
  german=Danksagung,french=Remerciements]
\newenvironment{acknowledge}{\section*{\ccacknowledgementsname}}{}
\def\labelitemi{$\circ$}
\def\footnoterule{\kern-3\p@\hrule\@width18mm\kern 2.6\p@}
\let\ccorg@include\include
\newwarning{warn@include}{Note that \protect\include\space is equivalent
  to \protect\input\space.}
\renewcommand{\include}{%
  \if@ccpublish
    \ccClassWarning{warn@include}%
    \let\next\input
  \else
    \let\next\ccorg@include
  \fi
  \next}
\endinput
%%
%% End of file `cc.cls'.
