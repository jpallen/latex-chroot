% LaTeX style file for the Maple Technical Newsletter
% Copyright 1994, by Waterloo Maple Software. 
\NeedsTeXFormat{LaTeX2e}
\typeout{}
\typeout{mtn.cls:  A Document Class for the Maple Technical Newsletter}
\typeout{}
\typeout{This style is based on the macros used by Maple's Export to LaTeX.}
\typeout{Maple input and output are specified by:}
\typeout{}
\typeout{Input:}
\typeout{}
\typeout{        \protect\begin{mapleinput}}
\typeout{        x + y;}
\typeout{        \protect\end{mapleinput}}
\typeout{}
\typeout{Output:}
\typeout{}
\typeout{        \protect\begin{maplelatex}}
\typeout{        \protect\[}
\typeout{        x + y}
\typeout{        \protect\]}
\typeout{        \protect\end{maplelatex}}
\typeout{}
\typeout{Plots:}
\typeout{}
\typeout{To include postscript graphics from a file use the macro}
\typeout{}
\typeout{        \protect\mapleplot{filename.ps}}
\typeout{}
\typeout{}
%
\def\fileversion{1.8}
\def\filedate{1994/10/25}
\ProvidesClass{mtn}[\filedate\space\fileversion]
%
\edef\PtSize{11pt}   %% default
\DeclareOption{10pt}{
	\edef\PtSize{10pt}
	}
\DeclareOption{11pt}{
	\edef\PtSize{11pt}
	}
\DeclareOption{12pt}{
	\edef\PtSize{12pt}
	}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{mapleenv}}
\ExecuteOptions{dvips}
\ProcessOptions
%
\LoadClass[\PtSize,twoside]{article}
\RequirePackage{mapleenv,fancyheadings}
%%
%% DEFINE PAGE LAYOUT 
%% including fancy headers and footers
%% 
\setlength{\marginparwidth}{30pt}
\setlength{\marginparsep}{5pt}
\setlength{\oddsidemargin}{0.5 in}
\setlength{\evensidemargin}{-0.5 in}
\setlength{\textheight}{21.5 cm}
\setlength{\textwidth}{6.25 in}
\setlength{\headheight}{\baselineskip}
\setlength{\footskip}{1.36 cm}
\setlength{\topmargin}{-0.125 in}
%%
%% USE FANCY PAGESTYLE TO ALLOW PROPER HEADERS AND FOOTERS
%% (see man fancyheadings for details)
%%
\pagestyle{fancyplain}
\setlength{\footrulewidth}{0.6pt}
\setlength{\headrulewidth}{0.6pt}
\setlength{\plainheadrulewidth}{0.6pt}
\setlength{\plainfootrulewidth}{0.6pt}
\lfoot[\rm\thepage]{}
\cfoot{}
\rfoot[]{\rm\thepage}
%%
%%% Define the section behavior, etc.
\setcounter{secnumdepth}{0}
\renewcommand\section{\@startsection{section}{1}{-0.09em}%
                                   {-2ex \@plus -1ex \@minus -.2ex}%
                                   {1ex \@plus.2ex}%
                                   {\reset@font\Large\bfseries\rmfamily}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-1ex\@plus -1ex \@minus -.2ex}%
                                     {1ex \@plus .2ex}%
                                     {\reset@font\large\bfseries\scshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\reset@font\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\reset@font\normalsize\bfseries}}
%%%
\def\title#1{\gdef\@title{#1}}
\def\shorttitle#1{\gdef\@shorttitle{#1}}
\def\author#1{\gdef\@author{#1}}
\def\thanks#1{\footnotemark\begingroup
\def\protect{\noexpand\protect\noexpand}\xdef\@thanks{\@thanks
  \protect\footnotetext[\the\c@footnote]{#1}}\endgroup}

\def\@thanks{}
\def\@shorttitle{}
\def\and{%%                             % \begin{tabular}
\end{tabular}\hskip 1em plus .17fil\begin{tabular}[t]{c}%% \end{tabular}
}
%
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
%
% \noindent \hspace{-0.09 em}{\Huge\rmfamily\bfseries{#1}}\par 
% \noindent {\Large\rmfamily\bfseries\em{#2}}\par 
\def\@shorttitle{\@title}
\def\@maketitle{%
  \headsep=0pt
  \newpage
  \thispagestyle{plain}
  \null
  \noindent
  \vbox{\vskip-2.5ex\noindent\Huge\rmfamily\mdseries \@title \par}%
  \vskip 0.5ex%
  \lineskip .5ex%
  \noindent%
  {\Large\rmfamily\bfseries\itshape%
  \begin{tabular}[t]{c}%
    \hspace*{-1ex}\@author
  \end{tabular}\par}%
  \vskip 1.5ex
  \hrule
  \par
  \thispagestyle{plain}
  \rhead[]{\fancyplain{}{\@shorttitle}}
  \lhead[\fancyplain{}{\@shorttitle}]{}
  \vskip 3ex}

%
% aliases for old style usage
%
\let\heading\section
\let\subheading\subsection
\newcommand{\HEADING}[3]{%
	\let\footnote\thanks%
	\title{#1}
	\author{#2}
	\shorttitle{#3}
	\maketitle
}%

\raggedbottom
\endinput   % mtn.cls
