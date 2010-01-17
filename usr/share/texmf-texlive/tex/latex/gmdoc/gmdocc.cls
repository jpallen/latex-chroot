%
% \GetFileInfo{gmdocc.cls}
% \title{The \pk{gmdocc} Class For \pk{gmdoc} Driver Files\thfileinfo}
% \author{Grzegorz `Natror' Murzynowski}
% \maketitle
%
% \begin{copyrnote}
%
%%Written by Grzegorz `Natror' Murzynowski,
%% natror at o2 dot pl
%%
%% \copyright\,2006 by Grzegorz `Natror' Murzynowski.
%%
%% This program is subject to the \LaTeX\ Project Public License.
%% See ^^A
%% \url{http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html} ^^A
%% for the details of that license.
%%
%% LPPL status: "author-maintained".\par
%%
%
%\end{copyrnote}
%
% \RecordChanges
% \ChangesStart{v0.677}{1000/00/00}
%
% \chschange{v0.69}{06/10/1}{81}
% \chschange{v0.70}{06/10/10}{98}
% \chschange{v0.71}{06/10/21}{114}
% \chschange{v0.72}{06/11/14}{122}
% \chschange{v0.73}{06/12/1}{128}
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gmdocc}
            [2006/12/01 v0.73 a class for gmdoc driver files (GM)]

%
% \division{Intro}
%%
%% This file is a~part of \pk{gmdoc} bundle and provides a~document
%% class for the driver files documenting \LaTeXpar\ packages \&a.\
%% with my \pk{gmdoc.sty} package. It's not necessary, of course: most
%% probably you may use another document class you like.
%%
%% By default this class loads \pk{mwart} class with a4paper (default)
%% option and \pk{lmodern} package with QX fontencoding. It loads also
%% my \pk{gmdoc} documenting package which loads some auxiliary
%% packages of mine and the standard ones.
%% 
%% If the \pk{mwart} class is not found, the standard \pk{article}
%% class is loaded instead. Similarly, if the \pk{lmodern} is not
%% found, the standard Computer Modern font family is used in the
%% default font encoding.
%% 
%
% \division{Usage}
%
% For the ideas and details of \pk{gmdoc}ing of the \LaTeXpar\ files
% see the \pk{gmdoc.sty} file's documentation (chapter \ref{gmd}). The
% r\^ole of the \pk{gmdocc} document class is rather auxiliary and
% exemplary.  Most probably, you may use your favourite document class
% with the settings you wish. This class I~wrote to meet my needs of
% fine formatting, such as not numbered sections and sans serif demi
% bold headings.
%
% However, with the users other than myself in mind, I~added some
% conditional clauses that make this class works also if an \pk{mwcls}
% class or the \pk{lmodern} package are unknown.  \dekmedskip
%
% Of rather many options supported by \pk{gmdoc.sty}, this class
% chooses my favourite, i.e., the default. An exception is made for
% the \TextUsage*{noindex} option, which is provided by this class and
% passed to \pk{gmdoc.sty}. This is intended for the case you don't
% want to make an index.
%
% Simili modo, the \TextUsage*{nochanges} option is provided to turn
% creating the change history off. 
%
% Both of the above options turn the \emph{writing out to the files}
% off. They don't turn off |\PrintIndex| nor |\PrintChanges|. (Those
% two commands are no-ops by themselves if there's no \file{.ind}
% (n)or \file{.gls} file respectively.)
% \dekmedskip
%
% One more option is \TextUsage*{outeroff}. It's intended for
% compiling the documentation of macros defined with the |\outer|
% prefix. It |\relax|es this prefix so the `|\outer|' macros' names can
% appear in the arguments of other macros, which is necessary to
% pretty mark and index them. 
%
% I~decided not to make discarding |\outer| the default because
% it seems that \LaTeX\ writers don't use it in general and
% \pk{gmdoc.sty} \emph{does} make some use of it.
% \dekmedskip
% 
% This class provides also the \TextUsage*{debug} option. It turns the
% |\if@debug| Boolean switch True and loads the \pk{trace} package that
% was a~great help to me while debugging \pk{gmdoc.sty}.
% \dekmedskip
%
% The default base document class loaded by \pk{gmdocc.cls} is Marcin
% Woli\'nski's \pk{mwart}. If you have not installed it on your
% computer, the standard \pk{article} will be used. 
%
% Moreover, if you like MW's classes (as I~do) and need |\chapter|
% (for multiple files' input e.g.), you may declare another \pk{mwcls}
% with the option homonimic with the class'es name: \TextUsage*{mwrep}
% for \pk{mwrep} and \TextUsage*{mwbk} for \pk{mwbk}. For the symmetry
% there's also \TextUsage*{mwart} option (equivalent to the default
% setting).
%
% The existence test is done for any MW class option as it is in the
% default case.
%
% \stanza
% The \TextUsage\EOFMark\ is in this class typesets like this (of
% course, you can redefine it as you wish):\par\EOFMark
%
% \StopEventually\NoEOF
%
% \division{The Code}

% \CodeDefIndex\gmcc@baseclass
\def\gmcc@baseclass{mwart}% the default is Marcin Woli\'nski's class (\pk{mwcls})
% analogous to \pk{article}.

% Since you can choose the standard \pk{article} class, we'd better
% provide a~Boolean switch to keep the score of what was chosen. It's
% to avoid unused options if \pk{article} is chosen.
%\CodeDefIndex*{gmcc@mwcls}
\newif\ifgmcc@mwcls
\gmcc@mwclstrue
% \CodeDefine*{mwart}
\DeclareOption{mwart}{\def\gmcc@baseclass{mwart}}% The \pk{mwart} class may also
% be declared explicitly.
% \CodeDefine*{mwrep}
\DeclareOption{mwrep}{\def\gmcc@baseclass{mwrep}}% If you need
% chapters, this option chooses an MW's class that corresponds to
% \pk{report},
% \CodeDefine*{mwbk}
\DeclareOption{mwbk}{\def\gmcc@baseclass{mwbk}}% and this MW's class
% corresponds to \pk{book}.
% \CodeDefine*{article}
\DeclareOption{article}{\gmcc@mwclsfalse}% you can also
% \emph{choose} \pk{article}.


% \CodeDefine*{outeroff}
\DeclareOption{outeroff}{\let\outer\relax}% This option allows
% |\outer|-prefixed macros to be \pk{gmdoc}-processed with all the
% bells and whistles.

% \CodeDefine\if@debug
\newif\if@debug
% \CodeDefine*{debug}
\DeclareOption{debug}{\@debugtrue}% This option causes \pk{trace} to
% be loaded and the Boolean switch of this option may be used to hide
% some things needed only while debugging.

% \CodeDefine*{noindex}
\DeclareOption{noindex}{%
  \PassOptionsToPackage{\CurrentOption}{gmdoc}}% This
% option turns the writing outto \file{.idx} file off.

% \CodeDefIndex\if@gmccnochanges
% \CodeDefIndex*\@gmccnochangestrue
% \CodeDefIndex*\@gmccnochangesfalse
\newif\if@gmccnochanges
% \CodeDefine*{nochanges}
\DeclareOption{nochanges}{\@gmccnochangestrue}% This option turns the
% writing outto \file{.glo} file off.

% \CodeDefine*{gmeometric}
\def\gmTheGeometry{geometry}
\DeclareOption{gmeometric}{%
  \IfFileExists{gmeometric.sty}{%
    \def\gmTheGeometry{gmeometric}}{}}% It's an experimental option
% that causes the |\geometry| macro provided by \pk{geometry} package
% is not restricted to the preamble. This option causes the
% \pk{gmeometric} package is loaded (if available) that works the
% limitation around.


\ProcessOptions

% \newif\ifSecondClass^^A~to assure \TeX knows ifSecondClass
% ^^A switch and therefore it counts the fis properly.
% \iffalse It's for cooperation with my another class. (Feature under
% construction.)
\@ifundefined{ifSecondClass}{%
  \newif\ifSecondClass}{}
%\fi\fi

%\iffalse
\ifSecondClass\else
%\fi\fi
\ifgmcc@mwcls
  \IfFileExists{\gmcc@baseclass.cls}{}{\gmcc@mwclsfalse}% As
  % announced, we do the ontological test to any \pk{mwcls}.
\fi 
\ifgmcc@mwcls
  \LoadClass[fleqn, oneside, noindentfirst, 11pt, withmarginpar,
  sfheadings]{\gmcc@baseclass}% 
\else
  \LoadClass[fleqn, 11pt]{article}% Otherwise the standard \pk{article} is
  % loaded. 
\fi

\AtBeginDocument{\mathindent=\CodeIndent}
% The |fleqn| option makes displayed formuals be flushed left and
% |\mathindent| is their indentation. Therefore we ensure it is always
% equal |\CodeIndent| just like |\leftskip| in \env{verbatim}. Thanks
% to that you may display single verbatim lines with |\[...\]|:
% \[\hbox{\verb+\[\hbox{|\verbatim\stuff|}\]+\,.}\]

\IfFileExists{lmodern.sty}{% We also examine the ontological status of
  % this package
  \RequirePackage{lmodern}% and if it shows to be satisfactory (the
  % package shows \emph{to be}), we load it and set the proper
  % font encoding.
  \RequirePackage[QX]{fontenc}%
}{}
%\iffalse\iffalse
\fi
% of ifSecondClass (a~feature under construction).\fi

\RequirePackage[margin=2.7cm, left=4cm,
   right=2.2cm]{\gmTheGeometry}% Now we set the
% page layout.

\def\gmdoccMargins{%
  \geometry{margin=2.7cm, left=4cm, right=2.2cm}}

\if@debug%  For debugging we load also the \pk{trace} package that was
% very helpful to me.
  \RequirePackage{trace}%
  \errorcontextlines=100 % And we set an error info parameter.
\fi

%\CodeDefine\ifdtraceon
%\CodeDefine\ifdtraceoff
\newcommand*\ifdtraceon{\if@debug\afterfi\traceon\fi}
\newcommand*\ifdtraceoff{\if@debug\traceoff\fi}

%  We load the core package:
\RequirePackage{gmdoc}

\@ifpackageloaded{lmodern}{% The Latin Modern font family provides
  % a~light condensed typewriter font that seems to be the most
  % suitable for the marginpar CS marking.
  \def\marginpartt{\normalfont\fontseries{lc}\ttfamily}}%


% ^^A\setcounter{IndexColumns}{2} narrow columns do spare space and
% ^^A~look better
\raggedbottom

\setcounter{secnumdepth}{0}% We wish only the parts and chapters to be
% numbered. 

\renewcommand*\thesection{\arabic{section}}% isn't it redundant at the
% above setting?

\@ifnotmw{}{%
  \@ifclassloaded{mwart}{% We set the indentation of Contents:
    \SetTOCIndents{{}{\quad}{\quad}{\quad}{\quad}{\quad}{\quad}}}{% for \pk{mwart}
    \SetTOCIndents{{}{\bf9.\enspace}{\quad}{\quad}{\quad}{\quad}{\quad}}}% and for the two other \pk{mwcls}s.
  \pagestyle{outer}}% We set the page numbers to be printed in the
    % outer and bottom corner of the page.

\def\titlesetup{\bfseries\sffamily}% We set the title(s) to be
% boldface and sans serif.

\if@gmccnochanges\let\RecordChanges\relax\fi% If the |nochanges|
% option is on, we discard writing outto the \file{.glo} file.

\RecordChanges% We turn the writing the |\changes| outto the
% \file{.glo} file if not the above.

% \CodeUsgIndex\dekclubs \CodeUsgIndex\smartunder
\dekclubs% We declare the club sign \verb+|+ to be a~shorthand for |\verb*|
\smartunder% and we declare the |_| char to behave as usual in the
% math mode and outside math to be just an uderscore.

\exhyphenpenalty\hyphenpenalty% 'cause \pk{mwcls} set it |=10000| due
% to Polish customs.

\RequirePackage{amssymb}
\def\EOFMark{\rightline{\ensuremath{\square}}}


\endinput
% \changes{v0.677}{06/9/23}{Added checkings if \pk{mwart.cls} and
% \pk{lmodern.sty} are available and more standard behaviour if they
% are not}
%
% \changes{v0.70}{06/10/10}{Added some options and Latin Modern Light
% Condensed to the marginpar CSs.}
%
% \Finale

% (For my GNU Emacs:)
%%% Local Variables: 
%%% mode: latex
%%% TeX-master: "e:/LaTeX/TeXGuru/gmdoc/gmdocDoc"
%%% End: 
