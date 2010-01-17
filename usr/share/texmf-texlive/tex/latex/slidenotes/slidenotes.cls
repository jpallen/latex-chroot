%%
%% This is file `slidenotes.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% slidenotes.dtx  (with options: `cls')
%% Copyright (C) 1993-1996 Hans van der Meer. All rights reserved.
%% File: slidenotes.dtx Copyright (C) 1993-1996 Hans van der Meer
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{slidenotes}[1998/04/23 3.27  Slides and notes]
\DeclareOption{help}{\ClassWarningNoLine{slidenotes}{%
    Options (first one is default):
      \MessageBreak
    notes,slides,minis:\space type of production;
      \MessageBreak
    portrait,landscape:\space slide orientation;
      \MessageBreak
    mixed,unmixed,anti:\space both, chosen, anti orientation;
      \MessageBreak
    center,nocenter,squeeze:\space vertical slide position;
      \MessageBreak
    rect,oval,rules,drules,noframe:\space type of slideframe;
      \MessageBreak
    newpage,nonewpage:\space yes/no start slide on new page;
      \MessageBreak
    smallnotes:\space notes one notch smaller}}
\newif\ifnotes
\newif\ifslides
\newif\ifminis
\DeclareOption{notes}{\notestrue\minisfalse\slidesfalse}
\DeclareOption{slides}{\notesfalse\minisfalse\slidestrue}
\DeclareOption{minis}{\notesfalse\ministrue\slidesfalse}
\newif\iflandscape
\DeclareOption{landscape}{\landscapetrue}
\DeclareOption{portrait}{\landscapefalse}
\newif\ifmixed
\newif\ifanti
\DeclareOption{mixed}{\mixedtrue\antifalse}
\DeclareOption{unmixed}{\mixedfalse}
\DeclareOption{anti}{\mixedfalse\antitrue}
\newif\ifcenter
\newif\ifsqueeze
\DeclareOption{center}{\squeezefalse\centertrue}
\DeclareOption{nocenter}{\squeezefalse\centerfalse}
\DeclareOption{squeeze}{\squeezetrue\centerfalse}
\newif\ifnewpage
\DeclareOption{newpage}{\newpagetrue}
\DeclareOption{nonewpage}{\newpagefalse}
\newif\ifsmallnotes
\smallnotesfalse
\DeclareOption{smallnotes}{\smallnotestrue}
\newcommand*\framevariant{}
\DeclareOption{noframe}{\renewcommand*\framevariant{n}}
\DeclareOption{rules}{\renewcommand*\framevariant{r}}
\DeclareOption{drules}{\renewcommand*\framevariant{d}}
\DeclareOption{rect}{\renewcommand*\framevariant{f}}
\DeclareOption{oval}{\renewcommand*\framevariant{o}}
\AtBeginDocument{\@ifundefined{obox}%
  {\IfFileExists{obox.sty}{\RequirePackage{obox}}%
    {\if\framevariant o
    \ClassWarningNoLine{slidenotes}{oval option disabled}%
    \renewcommand*\framevariant{f}\fi}}%
  {}}
\newcommand*\ovalslideframerule{\thicklines}
\providecommand\parentclass{report}
\ExecuteOptions{notes,portrait,mixed,rect,center,newpage}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\parentclass}}
\PassOptionsToClass{titlepage,a4paper}{\parentclass}
\ProcessOptions
\iflandscape\ifnotes\else
  \PassOptionsToClass{landscape}{\parentclass}%
\fi\fi
\LoadClass{\parentclass}
\ClassWarningNoLine{slidenotes}{%
  \iflandscape LANDSCAPE\else PORTRAIT\fi
  \space SLIDES\space
  \ifminis COLLECTION \fi \ifnotes + NOTES \fi
  PRODUCTION}
\providecommand*\@swapdimens[3]{#3=#1 #1=#2 #2=#3\relax}
\providecommand{\@ifemptyarg}[1]{% {absence}{presence}
  \ifx\@empty#1\@empty
  \expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi}
\ifminis\squeezefalse\fi
\ifslides\squeezefalse\fi
\ifnotes\mixedtrue\antifalse\fi
\ifanti
  \iflandscape\landscapefalse\else\landscapetrue\fi
  \ClassWarningNoLine{slidenotes}{ANTI OPTION => ORIENTATION CHANGED}
\fi
\RequirePackage{verbatim}
\ifmixed\ifnotes\else
  \AtBeginDocument{%
    \@ifundefined{rotatebox}%
      {\IfFileExists{graphics.sty}%
        {\RequirePackage{graphics}}%
        {\mixedfalse}%
      }{}}
\fi\fi
\newlength\slidewidth
\newlength\slideheight
\setlength\slidewidth{176mm}
\setlength\slideheight{248mm}
\newcommand*\slidemagnification{\magstep4}
\newlength\slideboxrule
\newlength\slideboxsep
\newlength\slidenotesep
\newlength\slidetitlesep
\setlength\slideboxrule{.2mm}
\setlength\slideboxsep{3mm}
\setlength\slidenotesep{8mm}
\setlength\slidetitlesep{\z@}
\@ifundefined{c@chapter}%
  {\newcounter{slidecounter}}%
  {\newcounter{slidecounter}[chapter]}
\newcount\missedslidecounter
\newcounter{minicounter}
\newsavebox\slidebox
\newtoks\slidemarker
\AtBeginDocument{%
  \@ifundefined{@title}{\def\@title{\Collection}}{}%
  \slidemarker={\@title}}
\newtoks\everyslide
\newtoks\everynote
\ifnotes
\newenvironment{note}[1][]{%
  \notesfont
  \ifsmallnotes\smallersizes\fi
  \normalsize
  \the\everynote
  \addvspace{\slidenotesep}%
  \list{}{\leftmargin=\z@
   \rightmargin=\marginwidth
   \parsep=\parskip}\item[]
  \ignorespaces}{\endlist\ifnewpage\vfill\fi}
\else
  \let\note=\comment
  \let\endnote=\endcomment
\fi
\newcommand*\smallersizes{%
  \let\Huge\huge
  \let\huge\LARGE
  \let\LARGE\Large
  \let\Large\large
  \let\large\normalsize
  \let\normalsize\small
  \let\small\footnootsize
  \let\footnotesize\scriptsize
  \let\scriptsize\tiny
  }
\ifmixed
\newenvironment{portraitslide}{%
  \landscapeslidefalse
  \iflandscape\@swapdimens\slideheight\slidewidth\@tempdima
  \fi
  \@slide}{\@endslide
  \iflandscape\putslide{90}\else\putslide{0}\fi}
\newenvironment{landscapeslide}{%
  \landscapeslidetrue
  \iflandscape\else\@swapdimens\slideheight\slidewidth\@tempdima
  \fi
  \@slide}{\@endslide
  \iflandscape\putslide{0}\else\putslide{90}\fi}
\newenvironment{slide}{\@slide}{\@endslide\putslide{0}}
\else\ifanti
\newenvironment{portraitslide}{%
  \landscapeslidefalse
  \iflandscape
    \refstepcounter{slidecounter}%
    \let\@slide=\comment\let\@endslide=\endcomment
  \fi
  \@slide}{\@endslide
  \iflandscape\else\putslide{0}\fi}
\newenvironment{landscapeslide}{%
  \landscapeslidetrue
  \iflandscape\else
    \refstepcounter{slidecounter}%
    \let\@slide=\comment\let\@endslide=\endcomment
  \fi
  \@slide}{\@endslide
  \iflandscape\putslide{0}\fi}
\newenvironment{slide}{%
  \refstepcounter{slidecounter}%
  \let\@slide=\comment\let\@endslide=\endcomment
  \@slide}{\@endslide}
\else
\newenvironment{portraitslide}{%
  \landscapeslidefalse
  \iflandscape
    \refstepcounter{slidecounter}%
    \global\advance\missedslidecounter\@ne
    \let\@slide=\comment\let\@endslide=\endcomment
  \fi
  \@slide}{\@endslide
  \iflandscape\else\putslide{0}\fi}
\newenvironment{landscapeslide}{%
  \landscapeslidetrue
  \iflandscape\else
    \refstepcounter{slidecounter}%
    \global\advance\missedslidecounter\@ne
    \let\@slide=\comment\let\@endslide=\endcomment
  \fi
  \@slide}{\@endslide
  \iflandscape\putslide{}\fi}
\newenvironment{slide}{\@slide}{\@endslide\putslide{0}}
\fi\fi
\ifmixed\else\ifanti\else
\AtEndDocument{\ifnum\missedslidecounter>\z@
  \ClassWarningNoLine{slidenotes}{Rerun with `anti'
  for \the\missedslidecounter\space slide(s) skipped}%
  \fi}
\fi\fi
\ifnotes
  \newcommand*\putslide[1]{\noindent\rputslide{#1}\par}
\fi
\ifslides
  \newcommand*\putslide[1]{\begin{center}\rputslide{#1}\end{center}}
\fi
\ifminis
  \newcommand*\putslide[1]{\noindent
    \rputslide{#1}%
    \stepcounter{minicounter}%
      \ifnum\value{minicounter}=2
        \par
      \else\ifnum\value{minicounter}=4
        \newpage\setcounter{minicounter}{0}%
      \else\hfil\fi\fi}
\fi
\newcommand*\rputslide[1]{\usebox{\slidebox}}
\ifmixed\ifnotes\else
  \renewcommand*\rputslide[1]{%
    \ifnum#1=\z@\usebox{\slidebox}%
    \else\rotatebox{#1}{\kern-.5\slidewidth\usebox{\slidebox}}%
    \fi}
\fi\fi
\newcommand*\@slide[1][]{%
\ifnotes
\ifnewpage\newpage\else\addvspace{\bigskipamount}\fi
\else
\ifminis\else\newpage\fi
\fi
  \refstepcounter{slidecounter}%
  \slidefont
  \normalsize
\ifnotes
  \@ifemptyarg{#1}%
    {\addcontentsline{toc}{section}{\Slide\,\theslidecounter}}%
    {\addcontentsline{toc}{section}{#1}}%
\fi
  \@tempdima\slidewidth
  \advance\@tempdima-\tw@\slideboxrule
  \advance\@tempdima-\tw@\slideboxsep
  \@tempdimb\slideheight
  \advance\@tempdimb-\tw@\slideboxrule
  \advance\@tempdimb-\tw@\slideboxsep
  \begin{lrbox}{\slidebox}%
    \the\everyslide
    \ifsqueeze
        \begin{minipage}{\@tempdima}%
    \else
        \begin{minipage}[][\@tempdimb][t]{\@tempdima}%
    \fi
     \setbox\@tempboxa=\vbox\bgroup\leavevmode
     \@ifemptyarg{#1}{}{\slidetitle{#1}}\ifcenter\vfil\fi
     \ignorespaces}
\newcommand*\@endslide{%
  \ifcenter\vfil\fi
    \egroup
    \chk@slideheight\@tempboxa
    \unvbox\@tempboxa
    \end{minipage}\end{lrbox}%
  \sbox\slidebox{\parbox{\slidewidth}{%
    \fboxsep\slideboxsep
    \fboxrule\slideboxrule
    \csname frame@\framevariant\endcsname
    \\*[\smallskipamount]
    \makebox[\slidewidth]{%
      \small\strut\the\slidemarker
      \hfil\Slidenumber~\theslidecounter}%
  }}}
\newcommand*\frame@f{%
  \fbox{\usebox\slidebox}%
  }
\newcommand*\frame@o{%
  \@tempdimb\dp\slidebox
  \advance\@tempdimb-\fboxsep
  \advance\@tempdimb-\fboxrule
  \obox[][\ovalslideframerule]{%
    \raisebox{\@tempdimb}{\usebox\slidebox}}%
  }
\newcommand*\frame@n{%
  \advance\fboxsep\fboxrule \fboxrule\z@
  \fbox{\usebox\slidebox}%
  }
\newcommand*\frame@r{%
  \rule{\slidewidth}{\fboxrule}\\*[\fboxsep]%
  \usebox{\slidebox}\\*[\fboxsep]%
  \rule{\slidewidth}{\fboxrule}%
  }
\newcommand*\frame@d{%
  \rule{\slidewidth}{\fboxrule}\\*[\tw@\fboxrule]%
  \rule[\baselineskip]{\slidewidth}{\fboxrule}%
    \vspace{-\baselineskip}\\*[\fboxsep]%
  \usebox{\slidebox}\\*[\fboxsep]%
  \rule{\slidewidth}{\fboxrule}\\*[\tw@\fboxrule]%
  \rule[\baselineskip]{\slidewidth}{\fboxrule}%
    \vspace{-\baselineskip}%
  }
\newcommand*\chk@slideheight[1]{{%
  \dimen@\ht#1
  \advance\dimen@\dp#1
  \ifnum\dimen@>\slideheight
    \ClassWarning{slidenotes}{slide too high by \the\dimen@}%
  \fi}}
\newcommand*\slidetitle{\@slidetitle{\slidetitlefont}}
\newcommand*\slidesubtitle{\@slidetitle{\slidesubtitlefont}}
\newcommand*\@slidetitle[2]{%
    \@ifemptyarg{#2}{}%
        {\begin{center}#1#2\end{center}\vspace{\slidetitlesep}}}
\newif\iflandscapeslide
\iflandscape\landscapeslidetrue\else\landscapeslidefalse\fi
\newcommand\landscapeonly[1]{\iflandscapeslide#1\fi}
\newcommand\portraitonly[1]{\iflandscapeslide\else#1\fi}
\newlength\marginwidth
\setlength\marginwidth{3cm}
\newcommand*\cue[2][\cuefont]{%
  \marginpar{\hspace*{-\marginwidth}%
  \parbox{\marginparwidth}{\raggedright\sloppy#1#2}}}
\@mparswitchfalse
\@ifundefined{c@chapter}{}{%
  \let\old@makechapterhead=\@makechapterhead
  \let\old@makeschapterhead=\@makeschapterhead
  \renewcommand*\@makechapterhead[1]{%
    \global\slidemarker={#1}\old@makechapterhead{#1}%
    \thispagestyle{empty}\newpage}%
  \renewcommand*\@makeschapterhead[1]{%
    \global\slidemarker={#1}\old@makeschapterhead{#1}%
    \thispagestyle{empty}\newpage}%
  }
\ifnotes\else\pagestyle{empty}\fi
\newcommand*\headerfont{\rmfamily}
\newcommand*\slidefont{\sffamily}
\newcommand*\notesfont{\rmfamily}
\newcommand*\footnotefont{\sffamily\mdseries\upshape}
\newcommand*\slidetitlefont{\Large\bfseries\boldmath}
\newcommand*\slidesubtitlefont{\normalsize\bfseries\boldmath}
\newcommand*\cuefont{\sffamily\bfseries\boldmath}
\newcommand*\Collection{LECTURE NOTES}
\newcommand*\Slidenumber{\#}
\newcommand*\Slide{Slide}
\let\CurrentDirectory=\@currdir
\def\DirectorySeparator#1#2`\^^M{\@ifemptyarg{#2}{#1}{#2}}
\edef\DirectorySeparator{%
\expandafter\DirectorySeparator\CurrentDirectory`\^^M}
\providecommand*{\LastChar}[1]{%
  \@ifemptyarg{#1}{}{\expandafter\@lastchar#1`\^^M}}
\def\@lastchar#1#2`\^^M{\@ifemptyarg{#2}{#1}{\@lastchar#2`\^^M}}
\providecommand*{\DirectoryName}[1]{\@ifemptyarg{#1}{}%
  {\if\LastChar{#1}\DirectorySeparator\relax#1\else
    #1\DirectorySeparator\fi}}
\newcommand*\Setfolder[2]{\edef#1{\DirectoryName{#2}}}
\InputIfFileExists{slidenotes.cfg}{}{}
\ifnotes
  \iflandscape\@swapdimens\paperheight\paperwidth\@tempdima\fi
\else
  \ifanti\@swapdimens\paperheight\paperwidth\@tempdima\fi
\fi
\divide\slidewidth by\slidemagnification
\multiply\slidewidth by\@m
\divide\slideheight by\slidemagnification
\multiply\slideheight by\@m
\iflandscape\@swapdimens\slideheight\slidewidth\@tempdima\fi
\ifslides
  \renewcommand\maketitle{}
  \@ifundefined{c@chapter}{}{%
    \renewcommand*\@makechapterhead[1]{\global\slidemarker={#1}%
      \thispagestyle{empty}}%
    \renewcommand*\@makeschapterhead[1]{\global\slidemarker={#1}%
      \thispagestyle{empty}}%
  }
\fi
\ifnotes\else\AtBeginDocument{\let\tableofcontents=\relax}\fi
\ifslides
  \mag\slidemagnification\relax
  \setlength\hoffset{-1in}
    \divide\hoffset by\slidemagnification
    \multiply\hoffset by\@m
  \setlength\textwidth{\paperwidth}
    \divide\textwidth by\slidemagnification
    \multiply\textwidth by\@m
  \setlength\oddsidemargin{0pt}
  \setlength\evensidemargin{0pt}
  \setlength\voffset{-1in}
    \divide\voffset by\slidemagnification
    \multiply\voffset by\@m
  \setlength\headheight{0pt}
  \setlength\headsep{0pt}
  \setlength\textheight{\paperheight}
    \addtolength\textheight{-2\topmargin}
    \divide\textheight by\slidemagnification
    \multiply\textheight by\@m
\fi
\ifminis
  \setlength\headheight{0pt}
  \setlength\headsep{0pt}
  \setlength\footskip{0pt}
  \setbox\@tempboxa\vbox{\hbox{\slidefont\small\strut}\smallskip\null}
  \@tempdima=2\slidewidth
  \ifmixed
    \advance\@tempdima by 2\ht\@tempboxa
  \else
    \advance\@tempdima by 8mm
  \fi
  \ifdim\@tempdima>\textwidth \setlength\textwidth{\@tempdima}\fi
  \@tempdimb=2\slideheight
    \advance\@tempdimb by 2\ht\@tempboxa
  \ifdim\@tempdimb>\textheight
    \setlength\textheight{\@tempdimb}
    \@tempdimb\paperheight
    \advance\@tempdimb-\textheight
    \addtolength\topmargin{-\@tempdimb}
  \fi
  \setlength\oddsidemargin{0pt}
  \setlength\evensidemargin{0pt}
\fi
\ifnotes
  \setlength\marginparsep{5mm}
  \addtolength\marginparwidth{\marginwidth}
\fi
\notesfont
\endinput
%%
%% End of file `slidenotes.cls'.
