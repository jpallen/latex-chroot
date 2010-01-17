% hssvita.cls
% Author: Kim Border, kcb@hss.caltech.edu
%
%	This file may be freely copied, modified,
%	and distributed.  But if you change anything
%	but the DEFAULT BUSINESS ADDRESS below,
%	please rename the file if you redistribute it.
%
%       NOTE: documentation suitable for latex-ing
%	appears at end of this file (after\endinput)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Identifiers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hssvita}[1995/04/27 Caltech Humanities and Social Science Vita]
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Declaration of Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}[1994/06/01]
\newboolean{fancy}
\newboolean{block}
\newboolean{justify}
\newboolean{cv}

\DeclareOption{fancy}{\setboolean{fancy}{true}}
\DeclareOption{block}{\setboolean{block}{true}}
\DeclareOption{justify}{\setboolean{justify}{true}}
\DeclareOption{cv}{\setboolean{cv}{true}}

\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{fleqn}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{openbib}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\typeout{^^J The \CurrentOption\ option is ignored by vita.}}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	Load classes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Revision History
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1-91			vita.sty written by kcb
% rev. 27-Jan-92	major change, incompatible with earlier version
% rev. 25-Apr-95	Converted to vita.cls, included linevita.sty as options
% rev. 26-Apr-95	Fixed references environment
% rev. 27-Apr-95	Fixed blockpar environment, reorganized parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	USER PARAMETERS (You may \renewcommand these)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Put the DEFAULT BUSINESS ADDRESS here!!!!
\newcommand{\@businessaddress}{Division of the Humanities and Social Sciences\\
California Institute of Technology\\
Pasadena, CA 91125}  

% This is used to label the home address
\newcommand{\homelabel}{{\small Home:}\\}% Default

% This is used to label the office address
\newcommand{\officelabel}{}% Blank by default

% This is used to label the vita, if option cv is invoked.
% van Leunen argues that nothing else looks like a vita
% so it neeed not announce what it is.
\newcommand{\cvlabel}{Curriculum Vitae}

% This is the section heading produced by the
% references environment
\newcommand{\referencelabel}{References}
% This is the default width of the reference entries
\newlength{\referencewidth}
\setlength{\referencewidth}{.3\textwidth}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	STYLE PARAMETERS
% Not to be changed in the Division of the Humanities
% and Social Sciences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H&SS margin specs
\setlength{\textheight}{9in}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\setlength{\topmargin}{0pt}
\ifcase \@ptsize %	 	margins for 10 pt
    \setlength{\oddsidemargin}{.375in}
    \setlength{\evensidemargin}{.375in}
    \setlength{\textwidth}{6.00in}
    \setlength{\marginparwidth}{.75in}
\or % 				margins for 11 pt
    \setlength{\oddsidemargin}{.150in}
    \setlength{\evensidemargin}{.150in}
    \setlength{\textwidth}{6.375in}
    \setlength{\marginparwidth}{1in}
\or % 				margins for 12 pt
    \setlength{\oddsidemargin}{.150in}
    \setlength{\evensidemargin}{.150in}
    \setlength{\textwidth}{6.375in}
    \setlength{\marginparwidth}{1in}
\fi

\setlength{\parindent}{0pt}
\setlength{\parskip}{.5\baselineskip}

% This is the space between cvlabel and name
\newlength{\cvskipamount}
\setlength{\cvskipamount}{2\medskipamount}

% This is the size of the hanging indent for entries
\newlength{\entryhang}
\setlength{\entryhang}{2em}

% This the size command for setting the main name 
% It depends on the pointsize: 12pt \Large is tacky
\newcommand{\namesize}{\ifcase\@ptsize\Large\or\Large\or\large\fi}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		DECORATIVE RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the decorative rule for headers
\newcommand{\decorativerule}{
\vbox{\hbox to \textwidth{\protect\rule{\textwidth}{0.02in}}
\vskip -\baselineskip\vskip 2pt
\hbox to \textwidth{\protect\rule{\textwidth}{0.01in}}
}}

% This is the simple rule used for sections
\newcommand{\simplerule}{\hbox to \textwidth{\protect\rule[0.0in]{\textwidth}{0.01in}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		DATE Format: Month, Year
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\today}{\ifcase\month\or
 January\or February\or March\or April\or May\or June\or
 July\or August\or September\or October\or November\or December\fi,
 \space\number\year}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		HEADERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{headings}
\ifthenelse{\boolean{fancy}}%
% For fancy option:
{\addtolength{\headheight}{\baselineskip}
%
\renewcommand{\@oddhead}{\vbox{\hbox to \textwidth{\reset@font\small\@name\hfill\thepage}
\vskip 1pt
\decorativerule}}
\renewcommand{\@evenhead}{\vbox{\hbox to \textwidth{\reset@font\small\thepage\hfill\@name}
\vskip 1pt
\decorativerule}}}
% For plain default:
{\renewcommand{\@oddhead}{\reset@font\small\rm\@name\hfill\thepage}
\renewcommand{\@evenhead}{\reset@font\small\rm\thepage\hfill\@name}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		REDEFINE \section command:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{fancy}}%
% If fancy option is selected, redefine \section this way:
{\renewcommand{\section}[1]{\bigskip\pagebreak[2] 
\vbox{{\bfseries #1}\vskip -\baselineskip\vskip 2pt\simplerule}{\nopagebreak\par}}}%
% Otherwise, default \section:
{\renewcommand{\section}[1]{\bigskip\pagebreak[2]
{\bfseries #1}\nopagebreak\par}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		REDEFINE PARAGRAPHS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Hanging indentation and no pagebreaks in a paragraph.
%	Unless block option is used.
\ifthenelse{\boolean{block}}%
{\@setpar{\@@par\samepage}}%
{\@setpar{\hangindent\entryhang \hangafter=1\@@par\samepage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		NEW COMMANDS for vita.cls:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\@name}{}
\newboolean{n@me}
\newcommand{\name}[1]{\renewcommand{\@name}{#1}
	\setboolean{n@me}{true}}

\newcommand{\@homeaddress}{}
\newboolean{home@ddress}
\newcommand{\homeaddress}[1]{\renewcommand{\@homeaddress}{#1}
	\setboolean{home@ddress}{true}}

\newboolean{business@ddress}
\newcommand{\businessaddress}[1]{\renewcommand{\@businessaddress}{#1}
	\setboolean{business@ddress}{true}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		VITA environment: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The \begin{vita} formats the above information
% The \end{vita} puts the date at the end
\newenvironment{vita}{\thispagestyle{empty}%
% Warn if missing name
\ifthenelse{\boolean{n@me}}{}{\@@warning{Missing name command}}
% Warn if \businessaddress omitted:
\ifthenelse{\boolean{business@ddress}}{}{\@@warning{Using default business address}}
%
% Start at the very top
\vspace*{-2\headsep}
%
% If cv option is invoked, then use cvlabel and skip \cvskipamount
\ifthenelse{\boolean{cv}}{\centerline{\large\bfseries \cvlabel}\vspace{\cvskipamount}}{\relax}
%
\centerline{\namesize\bfseries\@name}
%
% fancy option puts a rule
\ifthenelse{\boolean{fancy}}{\vskip -\baselineskip\vskip 6pt\decorativerule}{}
%
\vspace{3\bigskipamount}
%
% Now format the adresses side by side
\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll@{}}
%
\begin{tabular}[t]{@{}l@{}}
\officelabel
\@businessaddress
\end{tabular}
&
\ifthenelse{\boolean{home@ddress}{}}%
%% Format the home address
{\begin{tabular}[t]{@{}l@{}}
\homelabel
\@homeaddress
\end{tabular}}
%% WARNING if missing \homeaddress
{\@@warning{Missing homeaddress}}
\end{tabular*}
\bigskip\par}%
%% PUT date at bottom of last page
{\par\samepage\vfill%
\ifthenelse{\boolean{block}}{}{\hfill}
\today}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		REFERENCES evironment:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{references}{\section{\referencelabel}%
\setlength{\lineskip}{\baselineskip}
\@setpar{\@@par}
\begin{minipage}[t]{\referencewidth}\flushleft}%
{\end{minipage}\par}
\renewcommand{\and}{\end{minipage}\hfil
\begin{minipage}[t]{\referencewidth}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		BLOCK PARAGRAPH environment:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{blockpar}{\par\begin{minipage}{\textwidth}
\setlength{\parskip}{.5\baselineskip}}{\end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		INITIAL DECLARATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unless justify option is set, use ragged right edge 
% N.B.  Don't use \raggedright it redefines \\ !
%
\ifthenelse{\boolean{justify}}{\relax}%
	{\@rightskip\@flushglue \rightskip\@rightskip}
%
\nofiles
%
\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%		DOCUMENTATION & USAGE
%%		suitable for latexing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\documentclass{article}
\begin{document}
\title{Caltech HSS Vita Document Class}
\author{Kim Border}
\date{26-Apr-95}
\maketitle

This class extends the {\tt article} class and is
used to produce a curriculum vitae for the Chairman
of the Division of the Humanities and Social Sciences
and his henchmen.  

The format is very plain.  Use it with no options
and you will not embarrass yourself with a tacky
vita.  I recommend the appendix on vitae from \emph{A
Handbook for Scholars} by Mary-Claire van Leunen
for advice on how to prepare a cv.  It recommends
the following sections in the following order (blank
sections should be omitted):  Degrees, Additional
education, Experience, Honors, Grants, Memberships
(optional, depends on field), Personal information,
Publications.

Good taste suggests typesetting your vita in the
following point sizes:  {\tt 12pt} for Assistant
Professors and graduate students, {\tt 11pt} for
Associate Professors, {\tt 10pt} for Professors
(only half joking).

The \mbox{\ttfamily hssvita.cls} class defines three
new commands---\verb#\name{}#, \verb#\businessaddress{}#,
and \verb#\homeaddress{}#, which are used to insert
the appropriate information.  Lines in the addresses
should, as usual, be separated by \verb#\\#

Each entry on the vita is simply typed as a separate
paragraph with no special commands.

The class defines three new environments. 
\begin{itemize}
\item
The most important is {\tt vita}, which encloses
the vita itself. \emph{The entire content of the
vita should be enclosed} in \verb#\begin{vita}# and
\verb#\end{vita}#. This environment formats your
name and addresses and places the date at the end.
Note that the \verb#\name{}#, \verb#\businessaddress{}#,
and \verb#\homeaddress{}# commands must come
\emph{before} the \verb#\begin{vita}# command.

\end{itemize}

There is also the \verb#blockpar# environment, which
uses a {\tt minipage} environment to produce block
paragraphs instead of hanging indentation; and the
\verb#references# environment, which is used if you
want to include the names and addresses of personal
references. It works much like the \verb#\author#
command.

The best way to explain its use is by example:
\begin{verbatim}
\documentclass[11pt]{hssvita}

\begin{document}

\name{Kim C. Border}

\businessaddress{Associate Professor of Economics\\
Division of the Humanities and Social Sciences\\
California Institute of Technology\\
Pasadena, CA 91125\\
818--356--4062\\
kcb@hss.caltech.edu}

\homeaddress{
517 N.\ Cahuenga Blvd.\\
Los Angeles, CA 90004\\
}

\begin{vita}

\section{Degrees}

BS 1974, California Institute of Technology.

PhD 1979, University of Minnesota.


\section{Experience}
California Institute of Technology. Assistant
Professor of Economics, 1979--1983.\\
Associate Professor of Economics, since 1983.

\section{Publications}

Samurai accountant: a theory of auditing and plunder,
with J.~Sobel.  \textsl{Review of Economic
Studies}~5:\,525--540, 1987.

\textsl{Infinite Dimensional Analysis: A Hitchhiker's
Guide}, with C.~D.~Aliprantis. Springer--Verlag,
Berlin, 1994.


\section{Notes on the vita style}
\begin{blockpar}
This is a sample abridged vita. It is only here to
illustrate how to use the style sheet. Note that
you can produce block paragraphs if you wish.
Following this paragraph are some personal references.
\end{blockpar}

\begin{references}
James S. Jordan\\
University of Minnesota
\and
Donald J. Brown\\
Yale University
\end{references}

\end{vita}
\end{document}
\end{verbatim}

Since a vita is a personal matter, after you have
prepared a vita for the Chairman, there are several
customization options.  They include
\begin{description}
\item[fancy] which uses decorative rules to give a
B-school sort of look.
\item[justify] which right justifies the lines for
the anal retentive. By default, lines are set ragged
right, since most vita entries do not break nicely.
\item[block] which makes block paragraphs 
instead of hanging.
\item[cv] which adds the rubric Curriculum Vitae at
the top.  van Leunen argues that this is unnecessary,
since it is obvious what a cv is.
\end{description}

You may also \verb#\renewcommand# various commands
in the preamble to customize behavior.
\begin{itemize}
\item
By default, the home address is prefaced by a line
that says {\small Home:} It is defined by
\verb#\newcommand{\homelabel}{{\small Home:}\\}#
You can eliminate it by \verb#\renewcommand{\homelabel}{}#
\item
Similarly, there is a (blank by default) label for
the office address:
\begin{verbatim}
\newcommand{\officelabel}{}
\end{verbatim}
\item
The \verb#\referencelabel# is used as the section
header for the {\tt references} environment.
\begin{verbatim}
\newcommand{\referencelabel}{References}
\end{verbatim}
The length \verb#\referencewidth# is the width
reserved for a personal reference entry. By default
it is
\begin{verbatim}
\setlength{\referencewidth}{.3\textwidth}
\end{verbatim}
This allows three references across.  Change it to
\begin{verbatim}
\setlength{\referencewidth}{.45\textwidth}
\end{verbatim}
in the preamble if you list two or four references.
\item
If you use the {\tt cv} class option, it prints
\verb#\cvlabel# at the top, which is by default:
\begin{verbatim}
\newcommand{\cvlabel}{Curriculum Vitae}
\end{verbatim}
\end{itemize}

\end{document}