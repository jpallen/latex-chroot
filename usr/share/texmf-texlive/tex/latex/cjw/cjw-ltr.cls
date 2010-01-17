%%
%% This is file `cjw-ltr.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cjw-ltr.dtx  (with options: `class')
%% 
%% Copyright (C) 1995 by Colin J. Wynne
%% 
%% This file is part of cjw-ltr, a class for creating modified standard
%% letters as well as German style letters under LaTeX2e.
%% 
\def\fileversion{0.9}
\def\filedate{1997/01/01}
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
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cjw-ltr}
    [\filedate\space v\fileversion\space
 Modified Letter Class for LaTeX2e---CJW]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions

\LoadClass{letter}
\setlength\headsep   {25\p@}
\newlength{\letterskip}
  \setlength{\letterskip}{0.7em}
\let\addresswidth\indentedwidth
\newlength\lblwd
{\setbox0=\hbox{Fax:\enskip}\global\setlength{\lblwd}{\wd0}}
\newcommand*{\faxlabel}{\hbox to\lblwd{Fax:\enskip\hfil}}
\newcommand*{\tellabel}{\hbox to\lblwd{Tel:\enskip\hfil}}

\newcommand*{\fax}[1]{\def\faxnum{#1}}
  \fax{}
\def\check@iffax{%
  \ifx\@empty\faxnum\else
    \edef\faxnum{\protect\faxlabel\faxnum}
    \ifx\@empty\telephonenum\else
      \edef\telephonenum{\protect\tellabel\telephonenum}
  \fi\fi}
\def\opening#1{%
 \check@iffax
  \def\from@address{%
    \ifx\@empty\fromaddress%
      \@date%
    \else% home address
      \fromaddress%
      \ifx\@empty\telephonenum\else%
        \\ \telephonenum%
      \fi%
      \ifx\@empty\faxnum\else%
        \\ \faxnum%
      \fi%
      \\*[\letterskip]\@date%
    \fi}
  \setbox0=\hbox{%
    \begin{tabular}{l}\from@address\end{tabular}}
  \global\setlength{\addresswidth}{\wd0}
  \ifx\@empty\fromaddress
    \thispagestyle{firstpage}%
  \else
    \thispagestyle{empty}
  \fi
  \noindent\hfill\box0
  \par
  \vspace{2\letterskip}%
  {\raggedright\toname\\ \toaddress\par}%
  \vspace{2\letterskip}%
  \noindent#1%
  \setlength{\parindent}{20\p@}
  \setlength{\parskip}{0\p@ \@plus\@ne\p@\relax}
  \par\nobreak}
\long\def\closing#1{\par\nobreak\vspace{2\letterskip}%
  \stopbreaks
  \noindent\hfill
  \parbox{\addresswidth}{\raggedright%
       #1\\[6\letterskip]%
       \ifx\@empty\fromsig
           \fromname
       \else
   \fromsig
       \fi\strut}
   \par}
\let\unterschrift \signature
\let\absender     \address
\let\ort          \location
\let\telefon      \telephone
\let\datum        \date
\newcommand{\theday}{\number\day\relax}
\newcommand{\themonth}{%
  \ifcase\month\or January\or February\or%
  March\or April\or May\or June\or July\or August\or%
  September\or October\or November\or December\fi}
\newcommand{\themonat}{%
  \ifcase\month\or Januar\or Februar\or%
  M\"arz\or April\or Mai\or Juni\or Juli\or August\or%
  September\or Oktober\or November\or Dezember\fi}
\newcommand{\theyear}{\number\year\relax}
\newcommand{\heute}{den~\theday.\ \themonat\ \theyear}
\newcommand{\betreff}[2][Betreff]{%
  \def\betreffname{#1}\long\def\@betreff{#2}}
\newcommand{\bezug}[2][Bezug]{%
  \def\bezugname{#1}\long\def\@bezug{#2}}
\betreff[]{}
\bezug[]{}
\long\def\brief#1{%
  \newpage
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{0.7em}
    \if@twoside \ifodd\c@page
                \else\thispagestyle{empty} \hbox{}\newpage\fi
    \fi
    \c@page\@ne
    \interlinepenalty=200 % Smaller than the TeXbook value
    \@prozessan{\leavevmode\ignorespaces #1}
    \date{\heute}}
\long\def\@prozessan#1{%
  \@xproz #1!!@@@%
  \ifx\@empty\toPLZ\else\@xproz #1@@@\fi%
  \expandafter\@yproz \@tempa\\@@@%
  \ifx\@empty\@tempc
    \let\@tempd\@empty
  \else
    \expandafter\@zproz \@tempa\\@@@%
    \ifx\@empty\@tempd
      \else
      \expandafter\@zproz \@tempa{}@@@%
    \fi
  \fi
  \ifx\@empty\@tempb
    \let\totitle\@empty \let\toname\@empty \let\toaddress\@empty
  \else
    \ifx\@empty\@tempc
      \let\totitle\@empty
      \ifx\@empty\toPLZ
        \let\toname\@tempb \let\toaddress\@empty
      \else
        \let\toname\@empty \let\toaddress\@tempb
      \fi
    \else
      \ifx\@empty\@tempd
        \let\totitle\@empty \let\toname\@tempb \let\toaddress\@tempc
      \else
        \let\totitle\@tempb \let\toname\@tempc \let\toaddress\@tempd
      \fi
    \fi
    \fi}
\long\def\@xproz #1!!#2@@@{\def\@tempa{#1}\def\toPLZ{#2}}
\long\def\@yproz #1\\#2@@@{\def\@tempb{#1}\def\@tempc{#2}\def\@tempd{}}
\long\def\@zproz #1\\#2\\#3@@@{\def\@tempc{#2}\def\@tempd{#3}}
\let\endbrief\endletter
\def\anrede#1{%
  \check@iffax
  \ifx\@empty\fromlocation
    \def\@dateline{\@date}
  \else
    \def\@dateline{\fromlocation,\space\@date}
  \fi
  \null\vspace{1.2\letterskip}
  \noindent\ignorespaces
  \ifx\@empty\fromaddress%
    \pagestyle{firstpage}%
    {\raggedleft \@dateline}%
  \else % Home address
    \pagestyle{empty}%
    {\raggedright%
       \fromname \hfill \@dateline\\
       \fromaddress}
        \ifx\@empty\telephonenum
        \else
          \\ \telephonenum
        \fi
        \ifx\@empty\faxnum
        \else
          \\ \faxnum
        \fi
  \fi
  \par
  \vspace{2.2\letterskip}
  {\raggedright
     \ifx\@empty\totitle
     \else
       \totitle \\
     \fi
     \toname
     \ifx\@empty\toaddress
     \else
       \\ \toaddress
     \fi
     \ifx\@empty\toPLZ
     \else
       \\*[0.6\letterskip]\toPLZ
     \fi
   \par}
  \@checkbetreffbezug
    \ifx\@empty\@betreff
    \else
      \vspace{\letterskip}
      \ifx\@empty\betreffname
      \else
        \betreffname:\quad
      \fi
      \@betreff\par
    \fi
    \ifx\@empty\@bezug
    \else
      \vspace{1\letterskip}
      \ifx\@empty\bezugname
      \else
        \bezugname:\quad
      \fi
      \@bezug\par
    \fi
  \vspace{1.4\letterskip}%
  #1\par\nobreak}
\def\@checkbetreffbezug{%
  \ifx\@empty\@betreff
    \ifx\@empty\@bezug
    \else
      \ClassWarningNoLine{cjw-ltr}{%
        Die \protect\betreff und \protect\bezug Befehlen sollen nur
                                                    \MessageBreak
        zusammen verwendet werden.  Ihnen fehlt die  \MessageBreak
        Betreff-Zeile.}
    \fi
  \else
    \ifx\@empty\@bezug
      \ClassWarningNoLine{cjw-ltr}{%
        Die \protect\betreff und \protect\bezug Befehlen sollen nur
                                                    \MessageBreak
        zusammen verwendet werden.  Ihnen fehlt die  \MessageBreak
        Bezug-Zeile.}
    \fi
  \fi}
\long\def\gruss#1{\par\nobreak\vspace{2\letterskip}%
  \stopbreaks
  \noindent%
  {\raggedright #1 \\[5\letterskip]
     \ifx\@empty\fromsig
       \fromname
     \else
       \fromsig
     \fi}
  \par
  \vspace{\letterskip}}
\newcommand{\anlage}[1][Anlage]{%
  \def\@tempa{n} \def\@tempb{#1}
  \ifx\@tempa\@tempb
    \renewcommand{\enclname}{Anlagen}
  \else
    \renewcommand{\enclname}{\@tempb}
  \fi\encl}
\endinput
%%
%% End of file `cjw-ltr.cls'.
