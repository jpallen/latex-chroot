%% FriBrief.CLS  -- Version vom 2. Jul. 1997
%% fuer LaTeX2e
%% von Alex Fries
%%
%% Kontaktadressen:
%%   Alex Fries:  Alex.Fries@Lauer-EDV.com
%%                bp016@smail.fh-koeln.de
%%
%% Optionen, abweichend von letter-class:
%%    Calli                 Name in Calligraphie (genoetigt Font callig15)
%%    SmallC                Name in Smallcapital, ueber- und unterstrichen
%%    Referenz              fuegt Referenzzeile ein
%%    a4paper               Anpassung fuer DIN A4-Papier (Anwendung empfohlen)
%%    nomark                keine Faltmarkierungen
%%    english               Anpassung fuer englischsprachige Laender
%%
%% Befehle, abweichend von letter-class:
%%    \retouraddress        ...
%%    \Anlagen              \Anlagen{2 Grafiken}
%%    \Verteiler            \Verteiler{Hr. Mueller\\Fr. Maier}
%%    \Betreff              \Betreff{Kuendigung}
%%    \Behandlungsvermerk   \Behandlungsvermerk{EILT}
%%    \Datum                \Datum{Rostingen, den \today}
%%    \IhrZeichen           ...   \
%%    \MeinZeichen          ...    > nur in Verbindung mit Option <Referenz>
%%    \IhrSchreiben         ...   /
%%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{fribrief}
              [1997/07/02 ... der mit der persoenliche Note]

% **************
%   neue Fonts
% **************
\newfont{\Retschrift}{cmss6}
\newfont{\alex}{cmcsc10 scaled 2988}
\newfont{\calligraphie}{callig15 scaled 2988}

% *********************
%   spezielle Befehle
% *********************
\newcommand{\BKopf}[1]{\put(0,23){\parbox[t]{\textwidth}{\@PlainName\hfill #1\\
   \fromaddress}}} % wenn nichts anderes gesagt: DIN-Kopf
\newcommand{\Ref}{}
\newcommand{\Betreff}[1]{\def\betreff{\ignorespaces #1}}
\newcommand{\Anlagen}[1]{\def\anlagen{\ignorespaces #1}}
\newcommand{\Verteiler}[1]{\def\verteiler{\ignorespaces #1}}
\newcommand{\NLine}[1]{\vbox{\rule{\wd16}{#1}}}
\newcommand{\retouraddress}[1]{\def\retaddress{\ignorespaces #1}}
\newcommand{\Behandlungsvermerk}[1]{\def\Behver{#1}}
\newcommand{\Datum}[1]{\def\date{#1}}
\newcommand{\IhrZeichen}[1]{\def\yref{#1}}
\newcommand{\MeinZeichen}[1]{\def\myref{#1}}
\newcommand{\IhrSchreiben}[1]{\def\ymail{#1}}
\newcommand{\Faltmarken}{\put(-19,-65){\line(1,0){3}}
                         \put(-19,-164){\line(1,0){3}}
                         \put(-19,-114){\line(1,0){3}}}
\def\yrefname{{\tiny\sl Ihr Zeichen:\quad}}
\def\myrefname{{\tiny\sl Mein Zeichen:\quad}}
\def\ymailname{{\tiny\sl Ihr Schreiben vom:\quad}}
\def\date{\today}
\def\yref{}
\def\myref{}
\def\ymail{}
\def\anlagen{}
\def\betreff{}
\def\verteiler{}
\def\retaddress{}
\def\@SmallCName{}
\def\@CalliName{}
\def\Behver{}
\def\PageLayout{}

% *****************
%   DeclareOption
% *****************
\DeclareOption{Calli}{%
   \renewcommand{\BKopf}[1]{%
   \put(0,21){%
   \parbox{\textwidth}{{\@CalliName}\hfill\raisebox{8mm}[15.7mm]{%
   \parbox[t]{4.5cm}{\baselineskip2.5ex\raggedleft\fromaddress}}}}
   \put(0,6){\parbox{\textwidth}{\hfill #1}}}}
\DeclareOption{SmallC}{%
   \renewcommand{\BKopf}[1]{%
   \put(0,25){%
   \parbox[t]{\textwidth}{{\setbox16=\hbox{\@SmallCName}\parbox[t]{\wd16}{%
   \offinterlineskip\NLine{0.5mm}\vglue1.5mm\hbox to \wd16{\@SmallCName}%
   \vglue1.5mm\NLine{0.5mm}}}\hfill\raisebox{-2.25mm}[15.7mm]{%
   \parbox[t]{4.5cm}{\baselineskip2.5ex\raggedleft\fromaddress\\[2.5ex]}}}}
   \put(0,6){\parbox{\textwidth}{\hfill #1}}}}
\DeclareOption{a4paper}{%
   \PassOptionsToClass{11pt,\CurrentOption}{letter}
   \def\PageLayout{%
      \oddsidemargin 0mm
      \evensidemargin 0mm
      \marginparwidth 90pt
      \marginparsep 11pt
      \marginparpush 5pt
      \topmargin -8.5mm
      \headheight 4.25mm
      \headsep 8.5mm
      \topskip 4.25mm
      \footskip 5mm
      \footnotesep 12pt
      \skip\footins 10pt plus 2pt minus 4pt
      \textheight 23cm
      \textwidth 160mm}}
\DeclareOption{Referenz}{%
   \renewcommand{\Ref}{%
   \put(0,-55.15){\parbox[t]{\textwidth}{\rule{\textwidth}{0.1mm}\\
   \yrefname \yref\hfill\ymailname \ymail\hfill\myrefname \myref\par}}}}
\DeclareOption{nomark}{\renewcommand{\Faltmarken}{}}
\DeclareOption{english}{\def\yrefname{{\tiny\sl your reference:\quad}}
                        \def\myrefname{{\tiny\sl my reference:\quad}}
                        \def\ymailname{{\tiny\sl your letter:\quad}}}
\DeclareOption{a5paper}{%
   \ClassError{fribrief}{Sorry, A5-Papier wird nicht unterstuetzt.}}
\DeclareOption{b5paper}{%
   \ClassError{fribrief}{Sorry, B5-Papier wird nicht unterstuetzt.}}
\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass{letter}
\PageLayout  % siehe \DeclareOption{a4paper}

% *******************************
%   letter-Befehle undefinieren
% *******************************
\def\@texttop{}
\renewcommand{\name}[1]{%
   \def\@SmallCName{\alex#1\normalsize}%
   \def\@CalliName{\calligraphie#1\normalsize}
   \def\@PlainName{\normalsize #1}}

\renewcommand*{\opening}[1]{\thispagestyle{empty}%
   \pagestyle{headings}
   \unitlength 1mm%
   \begin{picture}(0,0)
   \BKopf{\date}
   \Faltmarken
   \put(0,-22){\makebox(85,4)[l]{\underline{\Retschrift\retaddress}}}
   \put(0,-27){\parbox[t]{\textwidth}{%
      \parbox[t]{7cm}{\toname\\\toaddress}\hfill\Behver}}
   \Ref
   \end{picture}%
   \strut\par\vspace*{64mm}
   \ifx\@empty\betreff\relax \else\betreff\strut\par\vspace{6mm}\fi%
   \def\Anrede{#1}%
   \ifx\Anrede\@empty\relax \else #1\par\fi\nobreak}

\renewcommand{\closing}[1]{\par\nobreak%
 \stopbreaks%
 \noindent%
 \ignorespaces#1
 \vspace{6cm minus 3cm}
 \ifx\@empty\fromsig\relax \else\vspace{3cm}\fromsig\fi
 \ifx\@empty\anlagen\relax \else\encl{\anlagen}\fi
 \ifx\@empty\verteiler\relax \else\cc{\verteiler}\fi}

