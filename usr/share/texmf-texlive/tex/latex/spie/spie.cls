%% spie.cls - Version 2.8
%% LaTeX2e class file to format manuscript for SPIE Proceedings

% History
% Prepared by Rick Zaccone <zaccone@bucknell.edu> on 6/3/91.
% Modified by Adrian F Clark <alien@uk.ac.essex> 11-Jan-1992.
% Modified by Ken Hanson <kmh@lanl.gov>  April, 1995
% Modified by Ken Hanson <kmh@lanl.gov>  June 23, 1997
% Modified by Ken Hanson <kmh@lanl.gov>  Nov. 3, 1997
% Modified by Ken Hanson <kmh@lanl.gov>  Dec. 10, 1997
% Modified by Ken Hanson <kmh@lanl.gov>  Mar. 8, 1998
% Modified by Ken Hanson <kmh@lanl.gov>  July 18, 2001
% Modified by Guenter Milde <G.Milde@physik.tu-dresden.de>  
%   August 1, 2001
%  Convert to LaTex2e class and added option a4paper
% Modified by Ken Hanson <kmh@lanl.gov>  August 29, 2001
%  Update SPIE format, including new text field: 6.75 in by 8.75 in
%  citesort.sty embedded to facilitate concatenation of citations.
%  However, citesort may lead to problems when used with babel, 
%   in which case it should be removed from this file.
% 2.70 Modified by Ken Hanson <kmh@lanl.gov>  August 29, 2002
%  Remove tabular in maketitle to properly handle long author list.
%  Use of \and in \author{} will start new line after inserting a
%    blank line.
%  Remove a4 option, leaving standard a4paper option in place.
%  Remove \hoffset and \voffset commands.  Defaults are again zero.
% 2.71 Modified by Ken Hanson <kmh@lanl.gov>  Sept. 18, 2002
%  Correct short figure caption format, replacing : with .  Thanks Mats.
% 2.8 Modified by Ken Hanson <kmh2@lanl.gov>  July 16, 2003
%  Margins changed to match SPIE's new specs.
%
%%%%%%%%%%%%%%%%%%%%%%%%
% Usage:
% \documentclass[]{spie}
% \documentclass[a4paper]{spie}  %% use this for A4 paper
%
% This style file does not automatically implement all the formatting
%  required for an SPIE manuscript.  The user must make a few 
%  manual adjustments For proper formatting, such as:
% 1. Title and subsubsection should be in lower case 
%    except for the first letter and proper nouns or acronyms
% 2. Subsection headings should be capitalized as for book titles
% 3. Format authors as follows
%    \author{author1\supit{a}, author2\supit{b}, and author3\supit{c} \skiplinehalf
%            \supit{a}affiliation1\\
%            \supit{b}affiliation2\\
%            \supit{c}affiliation3
%           }
%
%%%  Note: \skiplinehalf and \supit{} are defined in this class
% ------------------------------------------------------------
%% based on standard LaTeX article class --
%% need to define font Size Option inside spie.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{spie}[2003/07/16 v2.80 SPIE Proceedings class]

\LoadClassWithOptions{article}  % build on standard article class

\DeclareOption{a4paper}{%
   \AtEndOfClass{%
       \oddsidemargin -0.61cm     % for side margins of 2cm
       \evensidemargin -0.61cm    % for side margins of 2cm
       \typeout{a4paper used}
       }
   }
%\DeclareOption{a4}{%    %% non-standard option
%   \AtEndOfClass{%
%       \oddsidemargin -0.61cm    % for side margins of 2cm
%       \evensidemargin -0.61cm   % for side margins of 2cm
%       \typeout{a4 used}
%       }
%   }
\ProcessOptions\relax      % set margins for a4paper if specified

%% type out specified font size
\if0\@ptsize\typeout{ten-point font}\fi
\if1\@ptsize\typeout{eleven-point font}\fi
\if2\@ptsize\typeout{twelve-point font}\fi

%% page format (see "Sample manuscript showing specifications and style")
%% following based on default top and left offset of 1 inch = 25.4mm
\topmargin 0.0in                % for top margin of 1.00in
%% the next two side margins are for US letter paper 
%% and are overridden by the a4paper option
\oddsidemargin -0.125in           % for side margin of 0.875 in
\evensidemargin -0.125in          % for side margin of 0.875 in
%
\textheight 8.74in                % approx 22.2 cm
\textwidth 6.75in                 % approx 17.1 cm
\headheight 0in \headsep 0in      % avoid extra space for header
\pagestyle{empty}                 % no page numbers is default
\parskip 1ex plus 1ex minus 0.3ex % spacing between paragraphs
\date{}                           % avoid date

%%  space for floats - figures and tables
\floatsep 0.9ex plus 0.3ex minus 0.6ex 
\textfloatsep 4ex plus 3ex minus 1.5ex
\renewcommand{\textfraction}{0.10} 
\renewcommand{\floatpagefraction}{0.60} 
\renewcommand{\topfraction}{0.90} 
\renewcommand{\bottomfraction}{0.90}
\setcounter{totalnumber}{3} 
\setcounter{topnumber}{2} 
\setcounter{bottomnumber}{2} 


%%%% useful definitions %%%%
\def\skiplinehalf{\medskip\\}
\def\skipline{\\}
\def\exspace{\vspace{1ex}}
% superscript in italics, 
% to cross reference author and affiliations
\def\supit#1{\raisebox{0.8ex}{\small\it #1}\hspace{0.05em}}  


%%%%  define \ample font size %%%%
%% 10% larger than \normalsize for 10 pt, 
%% but smaller than \large
\if0\@ptsize
   \def\ample{\@setsize\large{12pt}\xipt\@xipt}
\else
   \def\ample{\large}
\fi  

%%%% define title aspects %%%%
\def\titlefont{\normalfont\LARGE\bfseries}  %% insurance
\if0\@ptsize
   \font\titlefont = cmbx12 at 16truept  % 10pt
\else
   \def\titlefont{\LARGE\bf}             % other
\fi

\def\title#1{\gdef\@title{\titlefont #1}}

\def\authorinfo#1{\gdef\@authorinfo{#1}}
\authorinfo{}     %% default is empty

\def\maketitle{\par 
 \begingroup
   \def\thefootnote{\fnsymbol{footnote}}%
   \def\@makefnmark{\hbox
       to\z@{$\m@th^{\@thefnmark}$\hss}}%
   \if@twocolumn
     \twocolumn[\@maketitle]%
     \else \newpage
     \global\@topnum\z@
     \@maketitle \fi     
     \@thanks
 \endgroup
 \let\maketitle\relax
 \let\@maketitle\relax
 \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax

%%%%  define footnote attributes %%%%
\renewcommand{\footnotesize}{\small}  % enlarge footnote font to small
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\ifx\@authorinfo\empty \else\footnotetext[0]{\@authorinfo}\fi      
%% use zero to avoid footnote mark
\renewcommand{\thefootnote}{\fnsymbol{footnote}}  
%% use footnote symbols, not numbers
}

% redefine \and for author list because \tabular was removed
\def\and{\bigskip\\}    
 
\def\@maketitle{\newpage
 \null
% move title to top of page 
\if0\@ptsize\vspace{-10mm}\else\vspace{-12mm}\fi
 \begin{center}%
  {\setlength{\baselineskip}{4.3ex} \@title \par}
  \vskip 3.5mm 
  {\large        % author and organization font size 
   \@author \par}   % remove tabular used in article.cls
  \vskip 1.5ex	
  {\large \@date}%
 \end{center}%
 \par
}


%%%% section aspects %%%%
% all headings bold
% center section headings, ample size
\def\sectfont{\centering\ample\bf}
% sub- and subsubsection headings flush left
\def\subsectfont{\raggedright\ample\bf}
\def\subsubsectfont{\raggedright\normalsize\bf}
\def\append{0}

\def\section{\@startsection{section}{1}{\z@}
   {-2.5ex plus -1ex minus -0.5ex}{0.2ex plus 0.5ex minus 0ex}{\sectfont}} 
\def\subsection{\@startsection{subsection}{2}{\z@}
   {-1.5ex plus -1ex minus -0.5ex}{0.1ex plus 0.1ex minus 0.1ex}{\subsectfont}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
   {-1ex plus -1ex minus -0.5ex}{0.1ex plus 0.1ex}{\subsubsectfont}}

%% from latex.sty 
%% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}
%% {STYLE}[ARG1]{ARG2}
\def\@sect#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
     \let\@svsec\@empty\else
     \refstepcounter{#1}\edef\@svsec{\csname the#1\endcsname.\hskip 0.3em plus 0.3em}\fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@
       \begingroup #6\relax
          \ifnum #2=1
%%(kmh) in appendix, add word appendix in front of section number  
             \ifnum \append=1 {\interlinepenalty \@M 
	        APPENDIX \@svsec\uppercase{#8}\par}
	     \else {\interlinepenalty \@M \@svsec\uppercase{#8}\par}
	     \fi
	  \else\ifnum #2=2
             \noindent{\interlinepenalty \@M \@svsec #8\par}
	  \else
             \noindent{\interlinepenalty \@M \@svsec #8\par}
	       \fi
	  \fi
       \endgroup
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                    #7}\else
        \def\@svsechd{#6\hskip #3\relax  %% \relax added 2 May 90
                   \@svsec #8\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                             \protect\numberline{\csname the#1\endcsname}\fi
                       #7}}\fi
     \@xsect{#5}}

%%%%% Special sections %%%%%
\def\abstract{\section*{ABSTRACT}}
\def\endabstract{}

% Keywords
\def\keywords#1{
\par\vspace{0.5ex}{\noindent\normalsize\bf Keywords:} #1
\vspace{0.5ex}   %% provide extra space before first section
}

\def\acknowledgments{\section*{ACKNOWLEDGMENTS}}
\def\endacknowledgments{}
% Old spelling - acceptable, but not preferred
\def\acknowledgements{\section*{ACKNOWLEDGMENTS}}
\def\endacknowledgements{}

%%%% references %%%%
% Give the references section a section number
\def\thebibliography#1{\section*{REFERENCES\@mkboth
 {REFERENCES}{REFERENCES}}\list
 {\arabic{enumi}.}
 {\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
 \advance\leftmargin\labelsep \usecounter{enumi}}
 \def\newblock{\hskip .11em plus .33em minus .07em}
  %% reduce vspace between items
  \parskip -0.7ex plus 0.5ex minus 0ex   
\if0\@ptsize\else\small\fi      %% smaller fonts
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist


%%%% Add theorem, lemma, and definition environments %%%%
% kmh - noindent
\def\@begintheorem#1#2{
   \par\noindent\bgroup{\sc #1\ #2. }\it\ignorespaces}
\def\@opargbegintheorem#1#2#3{
   \par\bgroup{\sc #1\ #2\ (#3). }\it\ignorespaces}
\def\@endtheorem{\egroup}
\def\proof{\par{\it Proof}. \ignorespaces}
\def\endproof{{\ \vbox{\hrule\hbox{%
   \vrule height1.3ex\hskip0.8ex\vrule}\hrule
  }}\par}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}

%%%% Figure and table captions %%%
\long\def\@makecaption#1#2{%     % from article.cls
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\footnotesize\bf #1.\ }{\footnotesize #2}}%
  \ifdim \wd\@tempboxa >\hsize   % bold with period
    {\footnotesize\bf #1.\ }{\footnotesize #2 \par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%%%% appendix aspects %%%% 
% use \appendix to start an appendix
% use \section{} for each appendix section
\def\appendix{\def\append{1}
  \par
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \setcounter{subsubsection}{0}
  \def\thesection{\Alph{section}}  
  \def\thesubsection{\Alph{section}.\arabic{subsection}}
\def\thesubsubsection{
\Alph{section}.\arabic{subsection}.\arabic{subsubsection}}
}


%%%% Citations are superscripts (from aip.sty) %%%%
\def\@cite#1#2{\unskip\nobreak\relax
    \def\@tempa{$\m@th^{\hbox{\the\scriptfont0 #1}}$}%
    \futurelet\@tempc\@citexx}
\def\@citexx{\ifx.\@tempc\let\@tempd=\@citepunct\else
    \ifx,\@tempc\let\@tempd=\@citepunct\else
    \let\@tempd=\@tempa\fi\fi\@tempd}
\def\@citepunct{\@tempc\edef\@sf{
    \spacefactor=\the\spacefactor\relax}\@tempa
    \@sf\@gobble}

% \citenum emits the plain citation number without ornament
% \citea puts its argument into the ornamentation for citations
% thus \cite{foo} is equivalent to \citea{\citenum{foo}}
\def\citenum#1{{\def\@cite##1##2{##1}\cite{#1}}}
\def\citea#1{\@cite{#1}{}}

% Collapse citation numbers to ranges.  Non-numeric and undefined labels
% are handled.  No sorting is done.  E.g., 1,3,2,3,4,5,foo,1,2,3,?,4,5
% gives 1,3,2-5,foo,1-3,?,4,5
\newcount\@tempcntc
\def\@citexzzz[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \@tempcnta\z@\@tempcntb\m@ne\def\@citea{}\@cite{\@for\@citeb:=#2\do
    {\@ifundefined
       {b@\@citeb}{\@citeo\@tempcntb\m@ne\@citea\def\@citea{,}{\bf ?}\@warning
       {Citation `\@citeb' on page \thepage \space undefined}}%
    {\setbox\z@\hbox{\global\@tempcntc0\csname b@\@citeb\endcsname\relax}%
     \ifnum\@tempcntc=\z@ \@citeo\@tempcntb\m@ne
       \@citea\def\@citea{,}\hbox{\csname b@\@citeb\endcsname}%
     \else
      \advance\@tempcntb\@ne
      \ifnum\@tempcntb=\@tempcntc
      \else\advance\@tempcntb\m@ne\@citeo
      \@tempcnta\@tempcntc\@tempcntb\@tempcntc\fi\fi}}\@citeo}{#1}}
\def\@citeozzz{\ifnum\@tempcnta>\@tempcntb\else\@citea\def\@citea{,}%
  \ifnum\@tempcnta=\@tempcntb\the\@tempcnta\else
   {\advance\@tempcnta\@ne\ifnum\@tempcnta=\@tempcntb \else \def\@citea{--}\fi
    \advance\@tempcnta\m@ne\the\@tempcnta\@citea\the\@tempcntb}\fi\fi}


% begin citesort.sty
% A replacement for \@citex which sorts citation numbers as well as
% compressing and allowing breaks.  Based on cite.sty by Donald
% Arseneau.
%
% for use in LaTeX say, \documentstyle[...,citesort,...]{...}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Allow, but strongly discourage, line breaks within a long
%     series of citations.  Compress lists of successive numbers
%     to one number range, e.g., 5,6,7,8,9 --> 5--9.  Compatible
%     with versions of \@cite that use exponents.
%              -- Donald Arseneau  1989
%
% Modified to sort the numbers so they come out in increasing order,
% regardless of the way they appear in the source. O(N^2) sort!
% Ian Green, CUED, 10-Dec-1991.  Improvements to img@eng.cam.ac.uk
% please. Version 1

\newcount\@minsofar
\newcount\@min
\newcount\@cite@temp
\def\@citex[#1]#2{%
\if@filesw \immediate \write \@auxout {\string \citation {#2}}\fi
\@tempcntb\m@ne \let\@h@ld\relax \def\@citea{}%
\@min\m@ne%
\@cite{%
  \@for \@citeb:=#2\do {\@ifundefined {b@\@citeb}%
    {\@h@ld\@citea\@tempcntb\m@ne{\bf ?}%
    \@warning {Citation `\@citeb ' on page \thepage \space undefined}}%
{\@minsofar\z@ \@for \@scan@cites:=#2\do {%
  \@ifundefined{b@\@scan@cites}%
    {\@cite@temp\m@ne}
    {\@cite@temp\number\csname b@\@scan@cites \endcsname \relax}%
\ifnum\@cite@temp > \@min% select the next one to list
    \ifnum\@minsofar = \z@
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\else
    \ifnum\@cite@temp < \@minsofar
      \@minsofar\number\@cite@temp
      \edef\@scan@copy{\@scan@cites}\fi\fi\fi}\@tempcnta\@min
  \ifnum\@minsofar > \z@ % some more
    \advance\@tempcnta\@ne
    \@min\@minsofar
    \ifnum\@tempcnta=\@minsofar %   Number follows previous--hold on to it
      \ifx\@h@ld\relax
        \edef \@h@ld{\@citea\csname b@\@scan@copy\endcsname}%
      \else \edef\@h@ld{\ifmmode{-}\else--\fi\csname b@\@scan@copy\endcsname}%
      \fi
    \else \@h@ld\@citea\csname b@\@scan@copy\endcsname
          \let\@h@ld\relax
  \fi % no more
\fi}%
\def\@citea{,\penalty\@highpenalty\,}}\@h@ld}{#1}}
% end of citesort.sty

%% end of spie.cls