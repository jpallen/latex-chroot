%%% LaTeX class for manuscripts submitted to the
%%% European Review of Agricultural Economics (ERAE)
%%%
%%% author: Arne Henningsen
%%% version: 1.0.1 (28 August 2006)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the ERAE Formatting Instructions in every detail.
%%% Please report any problems to <ahenningsen@email.uni-kiel.de>.
%%% Further information is available at
%%% http://www.uni-kiel.de/agrarpol/ahenningsen/latex-bibtex.html
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, courier, endfloat, geometry,
%%% helvet, mathptmx, natbib, setspace, titlesec, url
%%%
%%% The corresponding BibTeX style file "erae.bst" should be used
%%% for the bibliography: \bibliographystyle{erae}
%%%
%%% This document class provides 4 new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \jelclass can be use to show JEL classifications below the abstract
%%% \citetPage{page}{key} for citations like Author (Year: page)
%%% \citepPage{page}{key} for citations like (Author, year: page)
%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{erae}[2006/08/22 LaTeX class for the European Review of Agricultural Economics]

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,pointednumbers,tablecaptionabove]{scrartcl}
% pointednumbers = add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for tables

% page format, margins
\RequirePackage{geometry}
\geometry{a4paper, tmargin=2.5cm, bmargin=2.8cm, lmargin=2.5cm,
  rmargin=2.5cm, headheight=0cm, headsep=0cm, footskip=1.2cm }

% one half spacing
\RequirePackage{setspace}
\onehalfspacing

% spacing around (sub)section headers
\RequirePackage{titlesec}
\titlespacing*{\section}{0pt}{1em}{0.25em}
\titlespacing*{\subsection}{0pt}{0.85em}{0.15em}

% spacing around formulas
\AtBeginDocument{
\setlength{\abovedisplayshortskip}{6pt}
\setlength{\belowdisplayshortskip}{6pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\allowdisplaybreaks
}

% spacing around captions and floats
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{3pt}
\setlength{\floatsep}{0pt}
\setlength{\textfloatsep}{20pt}
\setlength{\intextsep}{5pt}

% font families: times/helvetica/courier
\RequirePackage{mathptmx}
\RequirePackage[scaled=.90]{helvet}
\RequirePackage{courier}

% amsmath
\RequirePackage{amsmath}
% for compatibility with ajae.cls
\newcommand{\veclatin}[1]{#1}
\newcommand{\matlatin}[1]{#1}
\newcommand{\vecgreek}[1]{#1}
\newcommand{\matgreek}[1]{#1}

% font for URLs
\RequirePackage{url}
\def\UrlFont{\rmfamily}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\setlength{\bibsep}{0pt}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% titlepage without author and date
\renewcommand{\maketitle}{
   \begin{spacing}{1.5}
   \centering
   \LARGE{\textbf{\@title}}%
   \end{spacing}
}

% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\renewenvironment{abstract}{%
\begin{center}
\begin{minipage}{0.9 \textwidth}
\small
\begin{center}
\textbf{Abstract}
\end{center}
}{%
\smallskip\\ \noindent
Key words: \@keywords
\smallskip\\ \noindent
JEL classification: \@jelclass
\end{minipage}
\end{center}%
\noindent%
}

% use babel package and set language to english
\RequirePackage[english]{babel}

% avoid clubs and widows
\clubpenalty=10000
\widowpenalty=10000
% \displaywidowpenalty=10000

% increase stretchability of the spaces (avoid overful hboxes)
\setlength{\emergencystretch}{3em}

% move floats to the end of the paper
\RequirePackage[heads,tablesfirst,nolists]{endfloat}

% use single quotes
\RequirePackage{csquotes}
\MakeInnerQuote{°}

% cite page numbers after colon
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}: #1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}: #1}}
