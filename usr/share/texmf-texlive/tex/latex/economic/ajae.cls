%%% LaTeX class for manuscripts submitted to the
%%% American Journal of Agricultural Economics (AJAE)
%%%
%%% author: Arne Henningsen
%%% version: 1.1 (6 October 2006)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the AJAE Formatting Instructions in every detail.
%%% Please report any problems to <ahenningsen@email.uni-kiel.de>.
%%% Further information is available at
%%% http://www.uni-kiel.de/agrarpol/ahenningsen/latex-bibtex.html
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.
%%% Following additional packages are required:
%%% amsmath, babel, bm, courier, endfloat, endnotes, geometry,
%%% helvet, mathptmx, natbib, setspace, titlesec, url
%%%
%%% The class provides following options:
%%% noendnotes - don't use endnotes (use footnotes)
%%% noendfloat - don't move floats to the end of the paper
%%% author - show name(s) of authors(s)
%%% date - show date
%%% preprint - print the 'preprint notice'
%%%
%%%
%%% The corresponding BibTeX style file "ajae.bst" should be used
%%% for the bibliography: \bibliographystyle{ajae}
%%%
%%% This document class provides following new commands:
%%% \keywords can be use to show keywors below the abstract
%%% \jelclass can be use to show JEL classifications below the abstract
%%% \leadingfootnote can be used to add a leading unnumbered footnote
%%% \affiliation can be used to add affiliation information
%%% \veclatin should be used for latin symbols that denote vectors
%%% \matlatin should be used for latin symbols that denote matrices
%%% \vecgreek should be used for greek symbols that denote vectors
%%% \matgreek should be used for greek symbols that denote matrices
%%%
%%% If you use footnotes, add following lines before the reference section:
%%%    \clearpage
%%%    \listofendnotes


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ajae}[2006/08/22 LaTeX class for the American Journal of Agricultural Economics]

\RequirePackage{ifthen}

% option to use footnotes in place of endnotes
\newcounter{UseEndnotes}
\setcounter{UseEndnotes}{1}
\DeclareOption{noendnotes}{\setcounter{UseEndnotes}{0}}

% option to NOT place floats at the end
\newcounter{UseEndfloat}
\setcounter{UseEndfloat}{1}
\DeclareOption{noendfloat}{\setcounter{UseEndfloat}{0}}

% option to show the authors' names
\newcounter{ShowAuthor}
\setcounter{ShowAuthor}{0}
\DeclareOption{author}{\setcounter{ShowAuthor}{1}}

% option to print the date
\newcounter{ShowDate}
\setcounter{ShowDate}{0}
\DeclareOption{date}{\setcounter{ShowDate}{1}}

% option to print the 'preprint notice'
\newcounter{ShowPreprintNote}
\setcounter{ShowPreprintNote}{0}
\DeclareOption{preprint}{\setcounter{ShowPreprintNote}{1}}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[12pt,english,tablecaptionabove]{scrartcl}
% tablecaptionabove = use \captionabove for tables

% page format, margins
\RequirePackage{geometry}
\geometry{letterpaper, tmargin=1.0in, bmargin=1.1in, lmargin=1.25in,
  rmargin=1.25in, headheight=0in, headsep=0in, footskip=0.5in }

% double spacing
\RequirePackage{setspace}
\doublespacing

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

% font for section headers
\setkomafont{section}{\normalfont\bfseries}

% font for subsection headers
\setkomafont{subsection}{\normalfont\itshape}

% fonts for math
\RequirePackage[leqno,fleqn]{amsmath}
\RequirePackage{bm}
% latin symbols for vectors and matrices
\newcommand{\veclatin}[1]{\bm{#1}}
\newcommand{\matlatin}[1]{\bm{#1}}
% greek symbols for vectors and matrices
\newcommand{\vecgreek}[1]{\pmb{#1}}
\newcommand{\matgreek}[1]{\pmb{#1}}

% font for URLs
\RequirePackage{url}
\def\UrlFont{\rmfamily}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\bibpunct{(}{)}{;}{a}{}{,}
\setlength{\bibsep}{0pt}

% captions of figures and tables
\setcapwidth[l]{\textwidth}
\setcapindent{0pt}
\setkomafont{captionlabel}{\normalfont\bfseries}
\setkomafont{caption}{\normalfont\bfseries}
\renewcommand{\captionformat}{.\ }

% section and subsections are not numbered
\setcounter{secnumdepth}{0}

% leading unnumbered footnote
\def\leadingfootnote{\xdef\@thefnmark{}\@footnotetext}

% titlepage without author and date
\newcommand{\affiliation}[1]{\newcommand{\@affiliation}{#1}}
\renewcommand{\maketitle}{
   \begin{center}
   \begin{LARGE}
   \begin{spacing}{1.25}
   \textbf{\@title}
   \end{spacing}
   \end{LARGE}
   \vspace*{10mm}
   \ifthenelse{\equal{\theShowAuthor}{1}}{
      \begin{large}
      \textbf{\@author}\\
      \end{large}
      \ifthenelse{ \isundefined\@affiliation }{}{
         \vspace*{3mm}
         \begin{small}
         \@affiliation\\
         \end{small}
      }
      \vspace*{5mm}
   }{}
   \ifthenelse{\equal{\theShowDate}{1}}{
      \@date\\
      \vspace*{5mm}
   }{}
   \ifthenelse{\equal{\theShowPreprintNote}{1}}{
      \begin{small}
      This is a preprint of an Article accepted for publication in
      American Journal of Agricultural Economics.
      \copyright{} \the\year ,
      American Agricultural Economics Association
      \end{small}
      \vspace*{5mm}
   }{}
   \end{center}
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
\ifthenelse{ \isundefined\@keywords }{
\ClassWarningNoLine{ajae}{No keywords specified.
   Please use the command \protect\keywords}
}{
\smallskip\\ \noindent
Key words: \@keywords
}
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{ajae}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{
\smallskip\\ \noindent
JEL classification: \@jelclass
}
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

% use endnotes in place of footnotes
\ifthenelse{\equal{\theUseEndnotes}{1}}{
\RequirePackage{endnotes}
\let\footnote=\endnote
\newcommand{\listofendnotes}{
   \begingroup
   \parindent 0pt
   \parskip 2ex
   \def\enotesize{\normalsize}
   \theendnotes
   \endgroup
}
}{}

% move floats to the end of the paper
\ifthenelse{\equal{\theUseEndfloat}{1}}{
\RequirePackage[tabhead,fighead,nomarkers,nolists]{endfloat}
}{}

% for compatibility with erae.cls
\newcommand{\citetPage}[2]{\citeauthor{#2} (\citeyear{#2}, p.~#1)}
\newcommand{\citepPage}[2]{\citetext{\citealp{#2}, p.~#1}}
