%%
%% This is file `usthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% usthesis.dtx  (with options: `cls')
%% 
%% -------------------------------------------------------------------
%%         University of Stellenbosch Thesis Class
%% -------------------------------------------------------------------
%% 
%% Author: Danie Els
%% 
%%         Copyright (C) 2003--2006 Danie Els
%%         All rights reserved.
%% 
%% This work may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3 of this
%% license or (at your option) any later version.  The latest version
%% of this license is in:  http://www.latex-project.org/lppl.txt  and
%% version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% This Current Maintainer of this work is Danie Els (dnjels@sun.ac.za)
%% -------------------------------------------------------------------
%% 
\newcommand{\USfiledate}{2006/08/26}
\newcommand{\USfileversion}{v2.2}
%%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\def\US@basetype{book}
\ProvidesClass{usthesis}[\USfiledate\space
                         \USfileversion\space
                         Stellenbosh Thesis class (DNJ ELS)]
\edef\US@AFRstr{\string afrikaans}
\newcommand{\AorE}[2]{%
   \ifx\US@AFRstr\languagename #1\else #2\fi}
\newenvironment{Afr}%
    {\ifx\languagename\US@AFRstr\relax\else
       \selectlanguage{afrikaans}%
     \fi}%
    {}
\newcommand*\US@ENGstr{}
\let\US@ENGstr=\relax
\newenvironment{Eng}%
    {\ifx\relax\US@ENGstr\relax\else
        \ifx\languagename\US@ENGstr\relax\else
           \edef\US@tempa{\noexpand\selectlanguage{\US@ENGstr}}%
           \US@tempa
        \fi
     \fi}%
    {}
\newcommand\US@degree{%
   \ClassWarning{usthesis}{No degree or subject supplied}%
   \textfb{[No degree!]}}
\newcommand\US@degreelong{%
   \ClassWarning{usthesis}{No degree or subject supplied}%
   \textfb{[No degree!]}}
\newcommand\USNameAFR{Universiteit van Stellenbosch}
\newcommand\USNameENG{University of Stellenbosch}
\newcommand\USName{}
\newcommand\PhDDescriptAFR{%
   \ThesisType\ ingelewer vir die graad \US@degreelong\ aan die \USName}
\newcommand\PhDFinalDescriptAFR{%
   \ThesisType\ goedgekeur vir die graad \US@degreelong\ aan die \USName}
\newcommand\MastersDescriptAFR{%
   \ThesisType\ ingelewer ter gedeeltelike voldoening aan die vereistes vir die
   graad \US@degreelong\ aan die \USName}
\newcommand\PhDDescriptENG{%
   \ThesisType\ presented for the degree of \US@degreelong\ at the \USName}
\newcommand\PhDFinalDescriptENG{%
   \ThesisType\ approved for the degree of \US@degreelong\ at the \USName{}}
\newcommand\MastersDescriptENG{%
   \ThesisType\ presented in partial fulfilment of the requirements for the degree
   of \US@degreelong\ at the \USName}
\newcommand\MastersDescript{}
\newcommand\PhDDescript{}
\newcommand\PhDFinalDescript{}
\newcommand\StudyLeaderAFR{Studieleier:}
\newcommand\StudyLeadersAFR{Studieleiers:}
\newcommand\PromotorAFR{Promotor:}
\newcommand\PromotorsAFR{Promotors:}
\newcommand\StudyLeaderENG{Supervisor:}
\newcommand\StudyLeadersENG{Supervisors:}
\newcommand\PromotorENG{Promoter:}
\newcommand\PromotorsENG{Promoters:}
\newcommand\StudyLeaderType{}
\newcommand\StudyLeadersType{}
\newcommand\PromotorType{}
\newcommand\PromotorsType{}
\newcommand\TypeReportAFR{Verslag}
\newcommand\TypeAssignmentAFR{Werkstuk}
\newcommand\TypeThesisAFR{Tesis}
\newcommand\TypePhDAFR{Proefskrif}
\newcommand\TypeReportENG{Report}
\newcommand\TypeAssignmentENG{Assignment}
\newcommand\TypeThesisENG{Thesis}
\newcommand\TypePhDENG{Dissertation}
\newcommand\TypeReport{}
\newcommand\TypeAssignment{}
\newcommand\TypeThesis{}
\newcommand\TypePhD{}
\newcommand\MonthAFR[1]{\ifcase#1\or
   Januarie\or Februarie\or Maart\or April\or Mei\or Junie\or
   Julie\or  Augustus\or September\or Oktober\or November\or
   Desember\fi}
\newcommand\MonthENG[1]{\ifcase#1\or
   January\or February\or March\or April\or May\or June\or
   July\or August\or September\or October\or November\or
   December\fi}
\newcommand\MonthName[1]{}
\newcommand\CopyrightHolderAFR{\USName}%
\newcommand\CopyrightTxtAFR{Kopiereg}
\newcommand\CopyrightAnotAFR{Alle regte voorbehou.}
\newcommand\CopyrightHolderENG{\USName}
\newcommand\CopyrightTxtENG{Copyright}
\newcommand\CopyrightAnotENG{All rights reserved.}
\newcommand\CopyrightHolder{}
\newcommand\CopyrightTxt{}
\newcommand\CopyrightAnot{}
\newcommand\ThesisDeclareAFR{%
   Ek, die ondergetekende, verklaar hiermee dat die werk in
   hierdie \MakeLowercase{\ThesisType}{} vervat, my eie
   oorspronklike werk is en dat ek dit nie van te vore in
   geheel of gedeeltelik by enige universiteit ter verkryging
   van 'n graad voorgel\^{e} het nie.}
\newcommand\SignatAFR{Handtekening}
\newcommand\DateAFR{Datum}
\newcommand\ThesisDeclareENG{%
   I, the undersigned, hereby declare that the work contained
   in this \MakeLowercase{\ThesisType}{} is my own original
   work and that I have not previously in its entirety or in
   part submitted it at any university for a degree.}
\newcommand\SignatENG{Signature}
\newcommand\DateENG{Date}
\newcommand\ThesisDeclare{}
\newcommand\Signat{}
\newcommand\Datetxt{}
\newcommand{\USextrasafrikaans}{%
   \let\USName          =\USNameAFR
   \let\MasterDescript  =\MastersDescriptAFR
   \let\PhDDescript     =\PhDDescriptAFR
   \let\PhDFinalDescript=\PhDFinalDescriptAFR
   \let\StudyLeaderType =\StudyLeaderAFR
   \let\StudyLeadersType=\StudyLeadersAFR
   \let\PromotorType    =\PromotorAFR
   \let\PromotorsType   =\PromotorsAFR
   \let\TypeReport      =\TypeReportAFR
   \let\TypeAssignment  =\TypeAssignmentAFR
   \let\TypeThesis      =\TypeThesisAFR
   \let\TypePhD         =\TypePhDAFR
   \let\MonthName       =\MonthAFR
   \let\CopyrightHolder =\CopyrightHolderAFR
   \let\CopyrightTxt    =\CopyrightTxtAFR
   \let\CopyrightAnot   =\CopyrightAnotAFR
   \let\ThesisDeclare   =\ThesisDeclareAFR
   \let\Signat          =\SignatAFR
   \let\Datetxt         =\DateAFR
   }
\newcommand{\UScaptionsafrikaans}{%
   \def\declarationname{Verklaring}%
   \def\abstractname{Uittreksel}%
     }
\newcommand{\USextrasenglish}{%
   \let\USName          =\USNameENG
   \let\MasterDescript  =\MastersDescriptENG
   \let\PhDDescript     =\PhDDescriptENG
   \let\PhDFinalDescript=\PhDFinalDescriptENG
   \let\StudyLeaderType =\StudyLeaderENG
   \let\StudyLeadersType=\StudyLeadersENG
   \let\PromotorType    =\PromotorENG
   \let\PromotorsType   =\PromotorsENG
   \let\TypeReport      =\TypeReportENG
   \let\TypeAssignment  =\TypeAssignmentENG
   \let\TypeThesis      =\TypeThesisENG
   \let\TypePhD         =\TypePhDENG
   \let\MonthName       =\MonthENG
   \let\CopyrightHolder =\CopyrightHolderENG
   \let\CopyrightTxt    =\CopyrightTxtENG
   \let\CopyrightAnot   =\CopyrightAnotENG
   \let\ThesisDeclare   =\ThesisDeclareENG
   \let\Signat          =\SignatENG
   \let\Datetxt         =\DateENG
   }
\newcommand{\UScaptionsenglish}{%
   \def\declarationname{Declaration}%
   \def\abstractname{Abstract}%
     }
\USextrasenglish
\UScaptionsenglish
\def\US@addto#1#2{%
  #2%
  \@temptokena{#2}%
  \ifx#1\relax
    \let#1\@empty
  \fi
  \ifx#1\undefined
     \edef#1{\the\@temptokena}%
  \else
     \toks@\expandafter{#1}%
     \edef#1{\the\toks@\the\@temptokena}%
  \fi
  \@temptokena{}\toks@\@temptokena}
\newcommand\US@addlangextras[2]{%
   \AtBeginDocument{%
      \expandafter\US@addto\csname extras#1\endcsname #2}}
\newcommand\US@addlangcaptions[2]{%
   \AtBeginDocument{%
      \expandafter\US@addto\csname captions#1\endcsname #2}}
\DeclareOption{english}{%
   \edef\US@ENGstr{\string english}%
   \US@addlangextras{english}{\USextrasenglish}%
   \US@addlangcaptions{english}{\UScaptionsenglish}}
\DeclareOption{UKenglish}{%
   \edef\US@ENGstr{\string UKenglish}%
   \US@addlangextras{UKenglish}{\USextrasenglish}%
   \US@addlangcaptions{UKenglish}{\UScaptionsenglish}}
\DeclareOption{USenglish}{%
   \edef\US@ENGstr{\string USenglish}%
   \US@addlangextras{USenglish}{\USextrasenglish}%
   \US@addlangcaptions{USenglish}{\UScaptionsenglish}}
\DeclareOption{british}{%
   \edef\US@ENGstr{\string british}%
   \US@addlangextras{british}{\USextrasenglish}%
   \US@addlangcaptions{british}{\UScaptionsenglish}}
\DeclareOption{afrikaans}{%
   \US@addlangextras{afrikaans}{\USextrasafrikaans}%
   \US@addlangcaptions{afrikaans}{\UScaptionsafrikaans}}
\newif\if@Report
\@Reporttrue
\newif\if@Masters
\@Mastersfalse
\newif\if@PhD
\@PhDfalse
\newif\if@Final
\@Finalfalse
\newcommand{\ThesisType}{}
\newcommand{\PromotorText}{}
\newcommand{\PromotorsText}{}
\DeclareOption{report}{%
   \renewcommand{\ThesisType}{\TypeReport}%
   \renewcommand{\PromotorText}{\StudyLeaderType}
   \renewcommand{\PromotorsText}{\StudyLeadersType}
   \@Reporttrue
   \@Mastersfalse
   \@PhDfalse}
\DeclareOption{masters-a}{%
   \renewcommand{\ThesisType}{\TypeAssignment}%
   \renewcommand{\PromotorText}{\StudyLeaderType}
   \renewcommand{\PromotorsText}{\StudyLeadersType}
   \@Reportfalse
   \@Masterstrue
   \@PhDfalse}
\DeclareOption{masters-t}{%
   \renewcommand{\ThesisType}{\TypeThesis}%
   \renewcommand{\PromotorText}{\StudyLeaderType}%
   \renewcommand{\PromotorsText}{\StudyLeadersType}%
   \@Reportfalse
   \@Masterstrue
   \@PhDfalse}
\DeclareOption{PhD}{%
   \renewcommand{\ThesisType}{\TypePhD}%
   \renewcommand{\PromotorText}{\PromotorType}%
   \renewcommand{\PromotorsText}{\PromotorsType}%
   \@Reportfalse
   \@Mastersfalse
   \@PhDtrue
   \@Finalfalse}
\DeclareOption{PhDfinal}{%
   \renewcommand{\ThesisType}{\TypePhD}%
   \renewcommand{\PromotorText}{\PromotorType}%
   \renewcommand{\PromotorsText}{\PromotorsType}%
   \@Reportfalse
   \@Mastersfalse
   \@PhDtrue
   \@Finaltrue}
\DeclareOption{twocolumn}{}
\newif\if@ABlock
\newif\if@GBlock
\@ABlockfalse
\@GBlockfalse
\DeclareOption{a5block}{%
   \PassOptionsToClass{a4paper}{\US@basetype}%
   \@ABlocktrue
   \@GBlockfalse}
\DeclareOption{goldenblock}{%
   \PassOptionsToClass{a4paper}{\US@basetype}%
   \@GBlocktrue
   \@ABlockfalse}
\DeclareOption{stdblock}{%
   \@GBlockfalse
   \@ABlockfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\US@basetype}}
\ExecuteOptions{report}
\ProcessOptions*\relax
\LoadClass[oneside,openany]{\US@basetype}
\RequirePackage{calc}
\providecommand{\phantomsection}{}
\newif\ifpdf
\ifx\pdfoutput\undefined
\else
  \ifx\pdfoutput\relax
  \else
    \ifcase\pdfoutput
    \else
      \pdftrue
    \fi
  \fi
\fi
\AtBeginDocument{%
   \@ifpackageloaded{graphicx}{}{%
      \ClassError{usthesis}{You must load the graphicx package}{}%
      }%
   }
\newlength{\US@tdima}
\newlength{\US@tdimb}
\newsavebox{\US@tboxa}
\newcounter{US@tcnta}
\newcounter{US@tcntb}
\newcommand\FixVertParams[1]{%
    \normalsize
    \setlength\US@tdima{\textheight-\topskip}%
    \setcounter{US@tcnta}{\US@tdima}
    \setcounter{US@tcntb}{\baselineskip}
    \setcounter{US@tcnta}{\value{US@tcnta}/\value{US@tcntb}}
    \setlength\textheight{\baselineskip*\value{US@tcnta}+\topskip}%
    \setlength\US@tdima{\paperheight-\textheight}%
    \setlength\topmargin{#1\US@tdima-\headheight-\headsep-1in}%
    \@settopoint\topmargin}
\newcommand\FixHorizParams[1]{%
    \@settopoint\textwidth
    \setlength\US@tdima{\paperwidth-\textwidth}%
    \if@twoside
        \setlength\oddsidemargin{#1\US@tdima-1in}%
    \else
        \setlength\oddsidemargin{.5\US@tdima-1in}%
    \fi
    \@settopoint\oddsidemargin
    \setlength\evensidemargin{\US@tdima-\oddsidemargin-2in}%
    \@settopoint\evensidemargin
    \setlength\marginparwidth{\evensidemargin+1in-\marginparsep-1cm}%
    \@settopoint\marginparwidth}
\if@ABlock
    \setlength\paperheight  {297.3mm}
    \setlength\paperwidth   {210.2mm} % A4 paper
    \setlength\textwidth    {.5\paperheight}
    \setlength\textheight   {\paperwidth}
    \setlength\marginparsep {7\p@}
    \setlength\marginparpush{7\p@}
    \FixVertParams{0.375}
    \FixHorizParams{0.375}
    \ifpdf
       \setlength\pdfpagewidth{\paperwidth}
       \setlength\pdfpageheight{\paperheight}
    \fi
\fi
\if@GBlock
    \setlength\paperheight  {297.3mm}
    \setlength\paperwidth   {210.2mm} % A4 paper
    \setlength\textheight   {0.747547\paperheight}
    \setlength\textwidth    {0.666667\paperwidth}
    \setlength\marginparsep {7\p@}
    \setlength\marginparpush{7\p@}
    \FixVertParams{0.375}
    \FixHorizParams{0.375}
    \ifpdf
       \setlength\pdfpagewidth{\paperwidth}
       \setlength\pdfpageheight{\paperheight}
    \fi
\fi
\begingroup
   \catcode`\Q=3
   \long\gdef\US@ifempt#1{\US@xifempt#1QQ\@secondoftwo\@firstoftwo\@nil}
   \long\gdef\US@xifempt#1#2Q#3#4#5\@nil{#4}
\endgroup
\newenvironment{US@adjustwidth}[2]{%
   \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\partopsep}{0pt}%
      \setlength{\leftmargin}{#1}%
      \setlength{\rightmargin}{#2}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
      }%
   \item[]}{\end{list}}
\newenvironment{SetMargins}[2]%
  {\setlength{\US@tdima}{-1in-\hoffset-\oddsidemargin}%
   \setlength{\US@tdimb}{-\US@tdima}%
   \addtolength{\US@tdima}{#1}%
   \addtolength{\US@tdimb}{-\paperwidth+\textwidth+#2}%
   \begin{US@adjustwidth}{\US@tdima}{\US@tdimb}%
  }%
  {\end{US@adjustwidth}}
\newenvironment{US@titlepage}[4]
  {\cleardoublepage
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse\newpage
   \fi
   \thispagestyle{empty}%
   \setcounter{page}\@ne
   \setlength{\US@tdima}{1in+\voffset+\topmargin+\headheight+\headsep+\topskip}%
   \setlength{\US@tdimb}{#1 -\US@tdima}%
   \vspace*{\US@tdimb}%
   \addtolength{\US@tdima}{\textheight-\paperheight-\topskip}%
   \addtolength{\US@tdima}{#2}%
   \enlargethispage{-\US@tdima}%
   \setlength{\US@tdima}{-1in-\hoffset-\oddsidemargin}%
   \setlength{\US@tdimb}{-\US@tdima}%
   \addtolength{\US@tdima}{#3}%
   \addtolength{\US@tdimb}{-\paperwidth+\textwidth+#4}%
   \begin{US@adjustwidth}{\US@tdima}{\US@tdimb}%
  }%
  {\end{US@adjustwidth}%
   \if@restonecol\twocolumn \else \newpage \fi
   \if@twoside\else
      \setcounter{page}\@ne
   \fi}
\let\maketitle\relax
\newcommand{\TitlePage}{%
   \begingroup
      \let\footnote\relax
      \begin{US@titlepage}{2cm}{2.5cm}{2.5cm}{2.5cm}%
         \centering
         \if@Report
            \includegraphics[width=100mm]{USlogo-top}\par
         \else
            %\includegraphics[width=88mm]{UScrest-top}\par
         \fi
         \vfill
        {\LARGE \@title \par}
         \vspace{2em}
         \if@Authorpresent
            {\large \AorE{deur}{by}\par}
             \vspace{2em}
            {\Large
             \lineskip .75em\relax%
             \begin{tabular}[t]{c}%
                \US@authorlong
             \end{tabular}\par}%
             \vfill
         \fi
        {\large\slshape
         \begin{US@adjustwidth}{1.5cm}{1.5cm}
            \centering\US@ThesisDescript
         \end{US@adjustwidth}\par}
         \vfill
        {\US@adress\par}
         \vfill
        {\normalsize \US@promotorset \par}
         \vfill
        {\large \US@date\par}%
      \end{US@titlepage}%
   \endgroup
   \global\let\TitlePage\relax
   \setcounter{footnote}{0}%
   \global\let\thanks\relax
   \global\let\@thanks\@empty
   }
\newif\if@Authorpresent
\@Authorpresentfalse
\renewcommand\author[2]{%
   \@Authorpresenttrue%
   \gdef\US@author{#1}%
   \gdef\US@authorlong{#2}}
\newcommand\US@author{%
   \ClassWarning{usthesis}{No author supplied}%
   }
\newcommand\US@authorlong{%
   \ClassWarning{usthesis}{No author supplied}%
   }
\newcommand{\US@ThesisDescript}{}
\newcommand\ThesisDescript[1]{%
   \long\gdef\US@ThesisDescript{#1}}
\let\ReportDescript=\ThesisDescript
\if@Masters
   \ThesisDescript{\MasterDescript}
\fi
\if@PhD
   \if@Final
      \ThesisDescript{\PhDFinalDescript}
   \else
      \ThesisDescript{\PhDDescript}%
   \fi
\fi
\newcommand\degree[2]{%
   \gdef\US@degree{#1}%
   \gdef\US@degreelong{#2}}
\let\subject=\degree
\newcommand\adress[1]{\gdef\US@adress{#1}}
\newcommand\US@adress{%
   \ClassWarning{usthesis}{No institutional address supplied}}
\newif\ifUS@multprm\US@multprmfalse
\newif\ifUS@prmstacked\US@prmstackedfalse
\newcommand\US@promotor{}
\newcommand*\US@prmalign{l}
\newcommand*\US@prmnewline{~}
\newcommand{\promotor}{%
   \@ifstar{\US@prmstackedtrue\@promotor}%
           {\US@prmstackedfalse\@promotor}}
\newcommand{\@promotor}[2][l]{%
   \renewcommand*\US@prmalign{#1}%
   \renewcommand\US@promotor{#2}}
\newcommand{\US@promotorset}{%
   \edef\US@beginTab{%
      \noexpand\begin{tabular}[t]{@{}\US@prmalign @{}}}%
   \edef\US@endTab{%
      \noexpand\end{tabular}}%
   \sbox{\US@tboxa}{%
      \let\and\US@prm@and%
      \US@beginTab%
         \US@promotor%
      \US@endTab}%
   \ifUS@prmstacked
      \makebox[\wd\US@tboxa][\US@prmalign]{%
         \ifUS@multprm\PromotorsText\else\PromotorText\fi}\\[1ex]%
      \usebox{\US@tboxa}%
   \else
      \ifUS@multprm\PromotorsText\else\PromotorText\fi
      \US@prmnewline%
      \usebox{\US@tboxa}%
   \fi
   }
\newcommand*{\US@prm@and}[1][2ex]{%
      \gdef\US@prmnewline{\\[2ex]}%
      \global\US@multprmtrue%
      \ifUS@prmstacked
         \\[#1]%
      \else
         \US@endTab
         \hskip 1em \@plus.17fil\relax
         \US@beginTab
      \fi
      \ignorespaces}
\let\studyleader\promotor
\let\supervisor\promotor
\newcount\US@month
\newcount\US@year
\US@month=0
\US@year=\number\year
\def\US@date{\MonthName{\US@month}\ \number\US@year}
\newcommand{\setdate}[2]{%
   \US@ifempt{#1}{\US@month=0}{\US@month=#1}%
   \US@year=#2
   \gdef\US@date{\MonthName{\US@month}\ \number\US@year}}
\newcommand\CopyrightPage[1][\CopyrightHolder]{%
   \clearpage
   \thispagestyle{empty}
   \mbox{}\par\vfill
   \begin{center}
      \CopyrightTxt\ \copyright\ \number\US@year\ #1\\
      \CopyrightAnot
   \end{center}
   \vfill\mbox{}\par
   \clearpage}
\newcommand{\DeclarationPage}[1][\ThesisDeclare]{%
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \par
   \thispagestyle{plain}%
   \chapter*{\declarationname}%
   \declaremark
   \phantomsection
   \addcontentsline{toc}{chapter}{\declarationname}%
   #1\par
   \vspace{3cm}
   \noindent
   \begin{minipage}{.5\textwidth}
      \Signat:~\dotfill\mbox{}\\
      \phantom{\Signat:}~%
         \hfill\makebox[0pt][c]{\US@author}\hfill\mbox{}\\[1cm]
      \Datetxt:~\dotfill\mbox{}
   \end{minipage}
   \if@restonecol\twocolumn\fi}
\newenvironment{abstract}[1][\languagename]%
   {\edef\@tempa{\expandafter\string #1}%
    \ifx\@tempa\languagename\relax\else
      \edef\@tempa{\noexpand\selectlanguage{#1}}\@tempa%
    \fi
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \par
   \chapter*{\abstractname}%
   \abstractmark
   \phantomsection
   \addcontentsline{toc}{chapter}{\abstractname}%
   \if@Report\else
       \begin{center}
          {\large\bfseries \@title \par}
           \medskip
          {\lineskip .75em\relax%
           \begin{tabular}[t]{@{}c@{}}%
              \US@author
           \end{tabular}\par}
           \smallskip
          {\small\itshape\US@adress\par}
           \smallskip
          {\ThesisType: \US@degree\par}
           \smallskip
          {\US@date\par}
       \end{center}
    \fi
    \if@restonecol\twocolumn\fi%
    }{}
\renewcommand\tableofcontents{%
   \if@twocolumn
      \@restonecoltrue\onecolumn
   \else
      \@restonecolfalse
   \fi
   \chapter*{\contentsname}%
   \tocmark
   \phantomsection
   \addcontentsline{toc}{chapter}{\contentsname}%
   \@starttoc{toc}%
   \if@restonecol\twocolumn\fi}
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \lofmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{3em}}
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \lotmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi}
\let\l@table\l@figure
\providecommand\bibsection{}%
\AtBeginDocument{%
   \renewcommand{\bibsection}{%
      \chapter*{\bibname}%
      \bibmark
      \phantomsection
      \addcontentsline{toc}{chapter}{\bibname}}%
   }
\renewenvironment{thebibliography}[1]{%
   \bibsection
   \parindent \z@
   \bibpreamble
   \bibfont
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty \clubpenalty
   \widowpenalty4000%
   \sfcode‘\.\@m}
  {\def\@noitemerr%
      {\@latex@warning{Empty ‘thebibliography’ environment}}%
   \endlist
   \vskip-\lastskip}
\let\bibfont\relax
\let\bibpreamble\relax
\newcommand*{\setbiblabel}[1]{%
   \renewcommand*{\@biblabel}[1]{#1}}
\setbiblabel{[#1]\hfill}
\renewenvironment{theindex}
   {\if@twocolumn
       \@restonecolfalse
    \else
       \@restonecoltrue
    \fi
    \columnseprule \z@
    \columnsep 35\p@
    \twocolumn[\@makeschapterhead{\indexname}]%
    \indexmark
    \phantomsection
    \addcontentsline{toc}{chapter}{\indexname}
    \thispagestyle{plain}
    \parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem}
   {\if@restonecol
       \onecolumn
    \else
       \clearpage
    \fi}
\newcommand*{\US@headfnt}[1]{{\slshape\small#1}}
\newcommand*{\US@numfnt}[1]{{\normalsize\bfseries#1}}
\if@twoside
   \def\ps@usthesis{%
      \def\@evenhead{\US@numfnt{\thepage}\hfil\US@headfnt{\leftmark}}%
      \def\@oddhead{\US@headfnt{\rightmark}\hfil\US@numfnt{\thepage}}%
      \let\@oddfoot\@empty
      \let\@evenfoot\@empty
      \let\@mkboth\markboth
      \def\chaptermark##1{%
         \markboth{\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
               \if@mainmatter
                  \@chapapp\ \thechapter. \ %
               \fi
            \fi
            ##1}}{}}%
      \def\sectionmark##1{%
         \markright{\MakeUppercase{%
            \ifnum \c@secnumdepth > \z@
               \thesection. \ %
            \fi
            ##1}}}%
      \def\declaremark{\markboth{\MakeUppercase{\declarationname}}{}}%
      \def\abstractmark{\markboth{\MakeUppercase{\abstractname}}{}}%
      \def\tocmark{\markboth{\MakeUppercase{\contentsname}}{}}%
      \def\lofmark{\markboth{\MakeUppercase{\listfigurename}}{}}%
      \def\lotmark{\markboth{\MakeUppercase{\listtablename}}{}}%
      \def\bibmark{\markboth{\MakeUppercase{\bibname}}{}}%
      \def\indexmark{\markboth{\MakeUppercase{\indexname}}{}}%
      }
\else
   \def\ps@usthesis{%
      \def\@oddhead{\US@headfnt{\rightmark}\hfil\US@numfnt{\thepage}}%
      \let\@oddfoot\@empty
      \let\@mkboth\markboth
      \def\chaptermark##1{%
         \markright{\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
               \if@mainmatter
                  \@chapapp\ \thechapter. \ %
               \fi
            \fi
            ##1}}}%
      \def\declaremark{\markright{\MakeUppercase{\declarationname}}}%
      \def\abstractmark{\markright{\MakeUppercase{\abstractname}}}%
      \def\tocmark{\markright{\MakeUppercase{\contentsname}}}%
      \def\lofmark{\markright{\MakeUppercase{\listfigurename}}}%
      \def\lotmark{\markright{\MakeUppercase{\listtablename}}}%
      \def\bibmark{\markright{\MakeUppercase{\bibname}}}%
      \def\indexmark{\markright{\MakeUppercase{\indexname}}}%
      }
\fi
\def\ps@plain{%
   \let\@mkboth\@gobbletwo
   \let\@oddhead\@empty
   \let\@evenhead\@empty
   \def\@oddfoot{\reset@font\hfil\US@numfnt{\thepage}\hfil}%
   \let\@evenfoot\@oddfoot
   }
\pagestyle{usthesis}
\newcommand{\US@headfamily}{\normalfont\rmfamily}
\def\section{%
   \@startsection{section}{1}%
                 {\z@}%
                 {-3.5ex plus -1ex minus -.2ex}%
                 {2.3ex plus .2ex}%
                 {\US@headfamily\Large\bfseries\raggedright}}
\def\subsection{%
   \@startsection{subsection}{2}%
                 {\z@}%
                 {-3.25ex plus -1ex minus -.2ex}%
                 {1.5ex plus .2ex}%
                 {\US@headfamily\large\bfseries\raggedright}}%
\def\subsubsection{%
   \@startsection{subsubsection}{3}%
                 {\z@}%
                 {-3.25ex plus -1ex minus -.2ex}%
                 {1.5ex plus .2ex}%
                 {\US@headfamily\normalsize\bfseries\raggedright}}
\def\paragraph{%
   \@startsection{paragraph}{4}%
                 {\z@}%
                 {3.25ex plus 1ex minus .2ex}%
                 {-1em}%
                 {\US@headfamily\normalsize\bfseries}}
\def\subparagraph{%
   \@startsection{subparagraph}{5}%
                 {\parindent}%
                 {3.25ex plus 1ex minus .2ex}%
                 {-1em}%
                 {\US@headfamily\normalsize\bfseries}}
\setcounter{topnumber}{3}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{3}
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.7}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\dblfloatpagefraction}{.7}
\setlength{\floatsep}{15pt plus 12pt}
\setlength{\textfloatsep}{\floatsep}
\setlength{\intextsep}{\floatsep}
\setlength{\dblfloatsep}{15pt plus 12pt}
\setlength{\dbltextfloatsep}{15pt plus 12pt}
\setlength{\@fptop}{0pt plus1fil}
\setlength{\@fpbot}{0pt plus1fil}
\setlength{\@fpsep}{8pt plus1fil}
\setlength{\@dblfptop}{0pt plus1fil}
\setlength{\@dblfpbot}{0pt plus1fil}
\setlength{\@dblfpsep}{8pt plus1fil}
\setlength{\abovecaptionskip}{0.5\baselineskip}
\setlength{\belowcaptionskip}{0.5\baselineskip}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small{\bfseries #1:} #2}%
  \ifdim \wd\@tempboxa >\hsize
    \unhbox\@tempboxa\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\endinput
%%
%% End of file `usthesis.cls'.
