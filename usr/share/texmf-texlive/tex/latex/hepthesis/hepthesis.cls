%% hepthesis
%%   LaTeX class for writing PhD theses, particularly those for
%%   high energy physics (HEP)
%% Author: Andy Buckley <andy@insectnation.org>
%%
%% This material is subject to the LaTeX Project Public License.
%% See http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
%% or the details of that license.
%%
%% Please let me know if you use hepthesis and what you think of it.
%% I'll try to implement any suggested options or geometry changes,
%% provided I think they're a good idea!


%% ========================================================================
%% Admin
%% ========================================================================
\def\fileversion{1.3}
\def\filedate{2006/09/28}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hepthesis}[\filedate\space HEP thesis class by Andy Buckley (v\fileversion)]

%% ========================================================================
%% Option parsing
%% ========================================================================
%% Conditional packages (can be disabled)
\def\@empty{}
\def\@yes{yes}
\def\@requireamsmath{yes}
\def\@requirebooktabs{yes}
\def\@requiresfheaders{}
\def\@requiremakeidx{}
\def\@requiretitling{}
\def\@requirehep{}
\def\@requirehyper{}
\def\@requiredraft{}
\def\@useAFour{yes}
\def\@requireAFourWide{}
\def\@oneside{}
\def\@bindmargins{yes}
\def\@hidefrontmatter{}
\def\@hidebackmatter{}


%% One-sided or two-sided (bound copies may have to be single-sided)
\DeclareOption{oneside}{%
  \def\@oneside{yes}
  \PassOptionsToClass{oneside}{book}}
\DeclareOption{twoside}{%
  \def\@oneside{}
  \PassOptionsToClass{twoside}{book}}

%% Sans serif titles?
\DeclareOption{sftitles}{%
  \def\@sftitles{yes}}

%% Pad inner margins for binding
\DeclareOption{bind}{%
  \def\@bindmargins{yes}}
\DeclareOption{nobind}{%
  \def\@bindmargins{}}
%% Use binding margins if output is not PDF
\DeclareOption{bindnopdf}{
  \ifx\pdfoutput\undefined%
  \def\@bindmargins{yes}%
  \else%  
  \def\@bindmargins{}%
  \fi%
}

%% Use AMS math packages
\DeclareOption{noams}{%
  \def\@requireamsmath{}}
\DeclareOption{ams}{%
  \def\@requireamsmath{yes}}

%% Change footnote markers to alphabetic
\DeclareOption{alphafoot}{%
  \DeclareRobustCommand{\thefootnote}{\alph{footnote}}%
}

%% Draft mode with line numbers and draft over-print
\DeclareOption{draft}{%
  \def\@requiredraft{yes}
  \AtEndOfPackage{%
    \let\@oldermainmatter\mainmatter%
    \DeclareRobustCommand{\mainmatter}{\@oldermainmatter\linenumbers}%
  }
}

%% Disable the frontmatter
\DeclareOption{hidefront}{%
  \def\@hidefrontmatter{yes}
}
\DeclareOption{hideback}{%
  \def\@hidebackmatter{yes}
}
\DeclareOption{hidefrontback}{%
  \def\@hidefrontmatter{yes}
  \def\@hidebackmatter{yes}
}

% Use hyperref package (with decent options)
\DeclareOption{hyper}{
  \def\@requirehyper{yes}}

% Use hyperref package (with decent options) only if output is PDF
\DeclareOption{hyperpdf}{
  \ifx\pdfoutput\undefined\else%  
  \def\@requirehyper{yes}%
  \fi%
}

%% Use nice-looking tables
\DeclareOption{booktabs}{%
  \def\@requirebooktabs{yes}}
\DeclareOption{nobooktabs}{%
  \def\@requirebooktabs{}}


%% Allows us to make an index
\DeclareOption{index}{%
  \def\@requiremakeidx{yes}
}

%% Allows us to make an index
\DeclareOption{titling}{%
  \def\@requiretitling{yes}
}

%% Particle physics options
\DeclareOption{hep}{%
  \def\@requirehep{yes}
}

%% Paper size (wide A4 is default)
\DeclareOption{a4paper}{%
  \def\@useAFour{yes}%
  \def\@requireAFourWide{yes}%
}
\DeclareOption{a4narrow}{%
  \def\@useAFour{yes}%
  \def\@requireAFourWide{}%
}
\DeclareOption{a5paper}{%
  \def\@useAFour{}%
  \PassOptionsToClass{a5paper}{book}%
}
\DeclareOption{b5paper}{%
  \def\@useAFour{}%
  \PassOptionsToClass{b5paper}{book}%
}
\DeclareOption{letterpaper}{%
  \def\@useAFour{}%
  \PassOptionsToClass{letterpaper}{book}%
}
\DeclareOption{legalpaper}{%
  \def\@useAFour{}%
  \PassOptionsToClass{legalpaper}{book}%
}
\DeclareOption{executivepaper}{%
  \def\@useAFour{}%
  \PassOptionsToClass{executivepaper}{book}%
}
%% Handle the A4 default paper size
\ifx\@useAFour\@empty\else%
  \PassOptionsToClass{a4paper}{book}%
\fi


%% Options to be passed to the hep package
\DeclareOption{hepfd}{\def\@requirehep{yes}\PassOptionsToPackage{fd}{hep}}
\DeclareOption{heplayout}{\def\@requirehep{yes}\PassOptionsToPackage{layout}{hep}}
\DeclareOption{hephyper}{\def\@requirehep{yes}\PassOptionsToPackage{hyper}{hep}}
\DeclareOption{hepfloat}{\def\@requirehep{yes}\PassOptionsToPackage{float}{hep}}
\DeclareOption{hepall}{\def\@requirehep{yes}\PassOptionsToPackage{all}{hep}}

%% Process the options (no package requirement allowed above here)
\ProcessOptions

%% ========================================================================
%% Base class and packages
%% ========================================================================

%% Base class
\LoadClass[12pt]{book}

%% Use wide format if using A4 paper
\ifx\@requireAFourWide\@empty\else\RequirePackage{a4wide}\fi

%% Hyperlinks (optional, has to come early in the package list)
\ifx\@requirehyper\@empty\else\RequirePackage[colorlinks=true,bookmarks=true]{hyperref}\fi
%pdfpagemode=None, FullScreen, UseThumbs, UseOutlines

%% AMS math package (optional)
\ifx\@requireamsmath\@empty\else%
  \RequirePackage{amsmath}
  \AtEndOfPackage{%
    %% Displayed maths environments re-defined to be the same as AMS' align
    \renewenvironment{displaymath}{\align}{\endalign\ignorespacesafterend}
    \newenvironment{displaymath*}%
      {\expandafter\let\expandafter\@oldoldalignstar \csname align*\endcsname \@oldoldalignstar}%
      {\expandafter\let\expandafter\@oldoldendalignstar \csname endalign*\endcsname \@oldoldendalignstar \ignorespacesafterend}
    \renewenvironment{equation}{\align}{\endalign\ignorespacesafterend}
    \renewenvironment{equation*}%
      {\expandafter\let\expandafter\@oldoldalignstar \csname align*\endcsname \@oldoldalignstar}%
      {\expandafter\let\expandafter\@oldoldendalignstar \csname endalign*\endcsname \@oldoldendalignstar \ignorespacesafterend}
  }%
\fi

%% Index building (optional)
\ifx\@requiremakeidx\@empty\else\RequirePackage{makeidx}\fi

%% Use the \title and \author arguments to build the front page etc.
\ifx\@requiretitling\@empty%
%% Re-define \title and \author to store their args in \thetitle, \theauthor variables
  \renewcommand*\title[1]{\gdef\@title{#1}\global\let\thetitle\@title}%
  \renewcommand*\author[1]{\gdef\@author{#1}\global\let\theauthor\@author}%
\else%
  \RequirePackage{titling}%
\fi

%% Sans serif titles
\ifx\@sftitles\@empty\else%
  \RequirePackage{sfheaders}
\fi

%% Nice tables (optional)
\ifx\@requirebooktabs\@empty\else%
  \RequirePackage{booktabs}
  \AtEndOfClass{%
    %% Tabular environment, defined to use the booktabs facilities
    \let\@oldtabular\tabular
    \let\@oldendtabular\endtabular
    \renewenvironment{tabular}[1]{%
      \@oldtabular{@{}#1@{}}%
      \toprule%
    }{%
      \bottomrule%
      \@oldendtabular%
      \ignorespacesafterend%
    }
    %%
  }%
\fi

%% Convenience-included HEP packages (optional)
\ifx\@requirehep\@empty\else\RequirePackage{hep}\fi

%% ``DRAFT'' underprint and line numbering in draft mode (optional)
\ifx\@requiredraft\@empty\else%
  \RequirePackage[pagewise, mathlines, displaymath]{lineno}
  \RequirePackage{draftcopy}
\fi

%% The right way to do custom spacing
\RequirePackage{setspace}

%% Funky headers
\RequirePackage{fancyhdr}

%% Make sure bibliography (but not ToC) appears in the ToC
\RequirePackage[nottoc]{tocbibind}

%% Verbatim things
\RequirePackage{verbatim,comment}

%% Subfigures
\RequirePackage[loose]{subfigure}
\subfiglabelskip=0pt

%% Nice captions (with continuation option)
\RequirePackage[subfigure]{ccaption} % this one must come first...
\RequirePackage[margin=20pt,labelfont=bf]{caption}

%% Rotated figures
\RequirePackage{rotating}

%% Make maths in titles go automatically bold
\AtEndOfClass{%
  \g@addto@macro\bfseries{\boldmath}
}

%% ========================================================================
%% Length definitions
%% ========================================================================

\setlength{\parindent}{0.6cm}          % tweak the initial indent in paras
\setlength{\parskip}{0.3cm}            % tweak the intra-para gap size
\setlength{\topmargin}{0in}
\setlength{\textheight}{9in}
\setlength{\footskip}{0.5in}
\setlength{\textwidth}{6.2in}
%% Increase inner margins for binding
\newlength{\@bindextramargin}
\AtEndOfClass{%

  \ifx\@bindmargins\@empty%
    \setlength{\@bindextramargin}{0.0in}
  \else%
    \setlength{\@bindextramargin}{0.2in}
  \fi
  \setlength{\oddsidemargin}{\@bindextramargin}
  \setlength{\evensidemargin}{-\@bindextramargin}
}
%%
%% Redefine bits of document shape
\renewcommand{\topfraction}{0.95}%
\renewcommand{\bottomfraction}{0.95}%
\renewcommand{\textfraction}{0.05}%
\renewcommand{\arraystretch}{1.25}%
%%
%% Reset rule widths and the header width
\renewcommand{\headwidth}{\textwidth}%
\renewcommand{\headrulewidth}{0.5pt}%
\renewcommand{\footrulewidth}{0pt}%
\addtolength{\headheight}{2.5pt}%
\addtolength{\headsep}{20pt}%
\newlength{\@maintextwidth}%
\setlength{\@maintextwidth}{\textwidth}%
\newlength{\@frontmattertextwidth}%
\setlength{\@frontmattertextwidth}{\@maintextwidth}%
\newlength{\@abstractextramargin}%
\setlength{\@abstractextramargin}{1.5cm}%
%%
%% Top vertical spacing in the front matter
\newlength{\@frontmattertopskip}%
\newlength{\@frontmattertitletopskip}%
\newlength{\frontmattertitleskip}%
\addtolength{\frontmattertitleskip}{3cm}%
\addtolength{\@frontmattertitletopskip}{0cm}%
\setlength{\@frontmattertopskip}{\frontmattertitleskip}%
\addtolength{\@frontmattertopskip}{\@frontmattertitletopskip}%
%%
%% Figure widths
\newlength{\smallfigwidth}
\newlength{\mediumfigwidth}
\newlength{\largefigwidth}
\newlength{\hugefigwidth}
\setlength{\smallfigwidth}{0.45\textwidth}
\setlength{\mediumfigwidth}{0.6\textwidth}
\setlength{\largefigwidth}{0.75\textwidth}
\setlength{\hugefigwidth}{0.9\textwidth}
%% Figure width aliases
\newlength{\littlefigwidth}
\newlength{\bigfigwidth}
\setlength{\littlefigwidth}{\smallfigwidth}
\setlength{\bigfigwidth}{\largefigwidth}


%% ========================================================================
%% Headers and footers
%% ========================================================================
%% No header or footer on the title page
\AtBeginDocument{\thispagestyle{plain}}
%% Use funky headers and footers
\pagestyle{fancy}

%% Normal headers and footers (headers are all like RH pages for oneside)
\ifx\@oneside\@empty%
  \fancyhead[RO,LE]{\bfseries\thepage}%
  \fancyhead[LO,RE]{\bfseries\leftmark}%
\else%
  \fancyhead[RO,RE]{\bfseries\thepage}%
  \fancyhead[LO,LE]{\bfseries\leftmark}%
\fi%
\fancyfoot{}%
%% Lower case header content
\renewcommand{\chaptermark}[1]{%
  \markboth{#1}{}%
}

%% Headers and footers for plain (blank) pages
\fancypagestyle{plain}{%
  \fancyhf{}%
  %\fancyhead[RO,LE]{\bfseries \thepage}%
  \fancyfoot[C]{\bfseries \thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

%% Treat forced blank pages in the same way as chapter title pages
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else%
  \hbox{}%
  %\thispagestyle{empty}%
  \thispagestyle{plain}%
  \newpage%
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}%

%% Provide mixed-case versions of the Table of contents,
%% List of tables, List of figures, Bibliography etc. header names 
\DeclareRobustCommand{\contentsname}{Contents}
\DeclareRobustCommand{\bibname}{Bibliography}
\DeclareRobustCommand{\listfigurename}{List of Figures}
\DeclareRobustCommand{\listtablename}{List of Tables}

%% Commenting out front and back matter
\ifx\@hidefrontmatter\@yes\AtBeginDocument{\excludecomment{frontmatter}}\fi
\ifx\@hidebackmatter\@yes\AtBeginDocument{\excludecomment{backmatter}}\fi


%% ========================================================================
%% Internal environments and commands
%% ========================================================================

%% Narrow environment (doesn't work)
\DeclareRobustCommand{\@narrowbegin}[1]{% 
  \begin{list}
  %\begingroup
  \setlength{\topsep}{0pt}% 
  \setlength{\leftmargin}{#1}% 
  \setlength{\rightmargin}{#1}% 
  \setlength{\listparindent}{\parindent}% 
  \setlength{\itemindent}{\parindent}% 
  \setlength{\parsep}{\parskip}% 
  \item[]%
}
\DeclareRobustCommand{\@narrowend}{%
  %\endgroup
  \end{list}%
} 
\newenvironment{@narrow}[1]{\@narrowbegin{#1}}{\@narrowend}



%% ========================================================================
%% Public environments and commands
%% ========================================================================


%% Re-define the sectioning commands with optional 1st arg now being the label
%% Oops, actually a bad idea since it clashes with the existing 1st option arg!
%\let\@oldchapter\chapter
%\DeclareRobustCommand{\chapter}[2][]{\def\@argone{#1}\def\@empty{}\chapter{#2}\ifx\@argone\@empty\else\label{#1}\fi}
%\let\@oldsection\section
%\DeclareRobustCommand{\chapter}[2][]{\def\@argone{#1}\def\@empty{}\section{#2}\ifx\@argone\@empty\else\label{#1}\fi}
%\let\@oldsubsection\subsection
%\DeclareRobustCommand{\chapter}[2][]{\def\@argone{#1}\def\@empty{}\subsection{#2}\ifx\@argone\@empty\else\label{#1}\fi}
%\let\@old\


%% An environment for the rubbish at the front of a typical thesis
\let\@oldfrontmatter\frontmatter
%\renewenvironment{frontmatter}{%
\specialcomment{frontmatter}{%
  \setcounter{tocdepth}{2}% show down to subsections in contents
  \setcounter{secnumdepth}{2}% number down to subsections
  \newcounter{iterlist}%
  \@oldfrontmatter%
  \begin{onehalfspace}%
}{%
  \end{onehalfspace}%
  \ignorespacesafterend%
}

%% Environment for the thesis main body
\let\@oldmainmatter\mainmatter
\specialcomment{mainmatter}{%
  \@oldmainmatter%
  \pagenumbering{arabic}%
  \begin{onehalfspace}%
}{%
  \end{onehalfspace}%
  \ignorespacesafterend%
}

%% Environment for appendices
\specialcomment{appendices}{%
  \begin{onehalfspace}%
  \appendix%
}{%
  \end{onehalfspace}%
  \ignorespacesafterend%
}

%% Environment for all the junk at the end of the thesis
\let\@oldbackmatter\backmatter
\specialcomment{backmatter}{%
  \@oldbackmatter%
  \begin{onehalfspace}%
  \appendix%
}{%
  \end{onehalfspace}%
  \ignorespacesafterend%
}

%% Environment for acknowledgements page in frontmatter
\newenvironment{acknowledgements}{%
  \setlength{\textwidth}{\@frontmattertextwidth}%
  \cleardoublepage%
  \vspace*{\@frontmattertopskip}%
  \begin{center}%
    \begingroup
    \ifx\@sftitles\@empty\else\sf\fi
    {\LARGE{\textbf{Acknowledgements}}}%
    \endgroup
  \end{center}%
  \vspace*{1cm}%
}{%
  \setlength{\textwidth}{\@maintextwidth}%
  \ignorespacesafterend%
}

%% Environment for preface page in frontmatter
\newenvironment{preface}{%
  \setlength{\textwidth}{\@frontmattertextwidth}%
  \cleardoublepage%
  \vspace*{\@frontmattertopskip}%
  \begin{center}%
    \begingroup
    \ifx\@sftitles\@empty\else\sf\fi
    {\LARGE{\textbf{Preface}}}%
    \endgroup
  \end{center}%
  \vspace*{1cm}%
}{%
  \setlength{\textwidth}{\@maintextwidth}%
  \ignorespacesafterend %
}

%% Environment for declaration rubrik page in frontmatter
%% (flushright doesn't work in this macro for some reason,
%% so you'll have to do that bit yourself like in the 
%% example file)
\newenvironment{declaration}{%
  \setlength{\textwidth}{\@frontmattertextwidth}%
  \cleardoublepage%
  \vspace*{\@frontmattertopskip}%
  \begin{center}%
    \begingroup
    \ifx\@sftitles\@empty\else\sf\fi
    {\LARGE\textbf{Declaration}}%
    \endgroup
  \end{center}%
  \vspace*{1cm}%
}{%
  %\newline \newline \newline%
  %\begin{flushright}
  %  \thesisauthor\newline
  %  \today\newline
  %\end{flushright}
  %\setlength{\textwidth}{\@maintextwidth}%
  \ignorespacesafterend%
}

%% Environment for thesis abstract in frontmatter
%% (argument is the thesis title)
\newenvironment{abstract}[1][Abstract]{%
  %\setlength{\textwidth}{\@frontmattertextwidth}%
  %\begin{@narrow}{\@abstractextramargin}
  \cleardoublepage%
  \vspace*{\@frontmattertopskip}%
  \begin{center}%
    \begingroup
    \ifx\@sftitles\@empty\else\sf\fi
    {\LARGE\textbf{#1}}%
    \endgroup
  \end{center}%
  \vspace*{1cm}%
  %\larger{%
}{%
  %}%
  %\setlength{\textwidth}{\@maintextwidth}%
  %\end{@narrow}
  \ignorespacesafterend%
}

%% Deprecated: combined command for defining the title and author in the preamble
\DeclareRobustCommand{\definethesis}[2]{%
  \typeout{hepthesis: definethesis macro is deprecated. Use author and title macros instead.}
  \author{#1}%
  \title{#2}%
}

%% Makes a thesis title page
\let\@oldtitlepage\titlepage
\let\@oldendtitlepage\endtitlepage
\DeclareRobustCommand{\titlepage}[2][]{%
  \@oldtitlepage%
  \begingroup
  \ifx\@sftitles\@empty\else\sf\fi
  \begin{center}%
    \vspace*{\frontmattertitleskip}%
    \begin{doublespace}%
      {\Huge\textbf{\thetitle}}\\%
    \end{doublespace}%
    \vspace*{3cm}%
    {\Large{{\theauthor} \\ {#1}}}\\%
    \vspace*{8cm}%
    {#2}%
  \end{center}%
  \endgroup
  \@oldendtitlepage
  \cleardoublepage%
}
\renewcommand{\maketitle}[1]{\titlepage{}}

%% A main quote page
\DeclareRobustCommand{\frontquote}[2]{%
  \cleardoublepage%
  \vspace*{6.5cm}%
  \thispagestyle{plain}
  \pagestyle{plain}
  \begin{center}%
    \noindent\emph{``#1''}%
    \newline%
    \indent --- #2%
  \end{center}%
  \cleardoublepage%
}

%% A dedication page
\DeclareRobustCommand{\dedication}[1]{%
  \cleardoublepage%
  \vspace*{7cm}%
  \thispagestyle{plain}
  \pagestyle{plain}
  \begin{center}%
    \noindent\emph{#1}%
  \end{center}%
  \cleardoublepage%
}

%% Environment for colophon in backmatter
\newenvironment{colophon}{%
  \chapter{Colophon}
}{%
  \ignorespacesafterend %
}


%% Typesets a chapter quote
\DeclareRobustCommand{\chapterquote}[2]{%
  \noindent\emph{``#1''}%
  \newline%
  \indent --- #2%
  \vspace{1cm}%
}

%% Typesets the first para of a chapter slightly differently
%% (I don't use it, so maybe it needs some work)
\newenvironment{chapterintro}[1][blah]{%
  %\begingroup
  \def\thearg{#1}%
  \def\sans{sf}%
  \def\italic{it}%
  \def\sansit{sfit}%
  \ifx\thearg\sans%
    \sffamily%
  \else%
  \ifx\thearg\italic%
    \it%
  \else%
  \ifx\thearg\sansit%
    \sffamily%
    \it%
  \fi\fi\fi%
}{%
  \ignorespacesafterend%
  %\endgroup
}

%% Bold inline section heading with a finishing colon
\DeclareRobustCommand{\verysubsection}[1]{{\noindent\textbf{#1:}}}

%% Table environment
\let\@oldtable\table
\let\@oldendtable\endtable
\renewenvironment{table}[1][tbp]{%
  \vspace{0.4cm}%
  \@oldtable[#1]%
  \begin{center}%
}{%
  \end{center}%
  \@oldendtable%
  \ignorespacesafterend%
}

%% Figure environment
\let\@oldfigure\figure
\let\@oldendfigure\endfigure
\renewenvironment{figure}[1][tbp]{
  \@oldfigure[#1]%
  \begin{center}%
}{%
  \end{center}%
  \@oldendfigure%
  \ignorespacesafterend%
}

%% Figure* environment (lots of \expandafter and \csname gubbins reqd... *sigh*)
\expandafter\let\expandafter\@oldfigurestar \csname figure*\endcsname
\expandafter\let\expandafter\@oldendfigurestar \csname endfigure*\endcsname
\renewenvironment{figure*}[1][tbp]{
  \@oldfigurestar[#1]%
  \begin{center}%
}{%
  \end{center}%
  \@oldendfigurestar%
  \ignorespacesafterend%
}

%% Sideways figure environment
\let\@oldsidewaysfigure\sidewaysfigure
\let\@oldendsidewaysfigure\endsidewaysfigure
\renewenvironment{sidewaysfigure}[1][tbp]{
  \@oldsidewaysfigure[#1]%
  \begin{center}%
}{%
  \end{center}%
  \@oldendsidewaysfigure%
  \ignorespacesafterend%
}


%% ``Thesis''-prefixed duplicate commands and environments (deprecated)
\newcommand{\thesistypeout}{\typeout{hepthesis: thesis- prefix commands are deprecated and will soon be removed}}
\newenvironment{thesistable}{\thesistypeout\table}{\endtable\ignorespacesafterend}
\newenvironment{thesistabular}{\thesistypeout\tabular}{\endtabular\ignorespacesafterend}
\newenvironment{thesisfigure}{\thesistypeout\expandafter\let\expandafter\@oldoldfigurestar \csname figure*\endcsname \@oldoldfigurestar}%
  {\expandafter\let\expandafter\@oldoldendfigurestar \csname endfigure*\endcsname \@oldoldendfigurestar \ignorespacesafterend}
\newenvironment{thesissidewaysfigure}{\thesistypeout\sidewaysfigure}{\endsidewaysfigure\ignorespacesafterend}
\newenvironment{thesisdisplaymath}{\thesistypeout\displaymath}{\enddisplaymath\ignorespacesafterend}
\newenvironment{thesisdisplaymath*}{\thesistypeout\expandafter\let\expandafter\@oldolddisplaymathstar \csname displaymath*\endcsname \@oldolddisplaymathstar}%
  {\expandafter\let\expandafter\@oldoldenddisplaymathstar \csname enddisplaymath*\endcsname \@oldoldenddisplaymathstar \ignorespacesafterend}
\newenvironment{thesisequation}{\thesistypeout\equation}{\endequation\ignorespacesafterend}
\newenvironment{thesisequation*}{\thesistypeout\expandafter\let\expandafter\@oldoldequationstar \csname equation*\endcsname \@oldoldequationstar}%
  {\expandafter\let\expandafter\@oldoldendequationstar \csname endequation*\endcsname \@oldoldendequationstar \ignorespacesafterend}
\newenvironment{thesisdeclaration}{\thesistypeout\declaration}{\enddeclaration\ignorespacesafterend}
\newenvironment{thesisabstract}[1][Abstract]{\thesistypeout\abstract[#1]}{\endabstract\ignorespacesafterend}
\newenvironment{thesischapterintro}[1]{\thesistypeout\chapterintro{#1}}{\endchapterintro\ignorespacesafterend}
\newenvironment{thesispreface}{\thesistypeout\preface}{\endpreface\ignorespacesafterend}
\newenvironment{thesisacknowledgements}[1]{\thesistypeout\acknowledgements}{\endacknowledgements\ignorespacesafterend}
\newenvironment{thesisfrontmatter}{\thesistypeout\frontmatter}{\ignorespacesafterend}
\newenvironment{thesismainmatter}{\thesistypeout\mainmatter}{\ignorespacesafterend}
\newenvironment{thesisbackmatter}{\thesistypeout\backmatter}{\ignorespacesafterend}
\DeclareRobustCommand{\thesistitlepage}[2][]{\thesistypeout\titlepage{#1}{#2}}
\DeclareRobustCommand{\thesisfrontquote}[2]{\thesistypeout\frontquote{#1}{#2}}
\DeclareRobustCommand{\thesischapterquote}[2]{\thesistypeout\chapterquote{#1}{#2}}
\DeclareRobustCommand{\thesisverysubsection}[1]{\thesistypeout\verysubsection{#1}}

%% In-document references
\DeclareRobustCommand{\Chapter}{Chapter\xspace}
\DeclareRobustCommand{\Section}{Section\xspace}
\DeclareRobustCommand{\Appendix}{Appendix\xspace}
\DeclareRobustCommand{\Figure}{Figure\xspace}
\DeclareRobustCommand{\Table}{Table\xspace}
\DeclareRobustCommand{\Equation}{equation\xspace}
\DeclareRobustCommand{\Reference}{reference\xspace}
%% Standard way to refer to a page number
\DeclareRobustCommand{\Page}{page\xspace}

%% Reference terms with built-in reference
\DeclareRobustCommand{\ChapterRef}[1]{\Chapter~\ref{#1}}
\DeclareRobustCommand{\SectionRef}[1]{\Section~\ref{#1}}
\DeclareRobustCommand{\AppendixRef}[1]{\Appendix~\ref{#1}}
\DeclareRobustCommand{\FigureRef}[1]{\Figure~\ref{#1}}
\DeclareRobustCommand{\TableRef}[1]{\Table~\ref{#1}}
\DeclareRobustCommand{\EquationRef}[1]{\Equation~\eqref{#1}}
\DeclareRobustCommand{\ReferenceRef}[1]{\Reference~\cite{#1}}
\DeclareRobustCommand{\PageRef}[1]{\Page~\pageref{#1}}
