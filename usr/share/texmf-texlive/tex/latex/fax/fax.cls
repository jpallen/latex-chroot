% (c) Copyright on FAX.CLS written by J.B.Rhebergen and J.H.M. de Jonge.
%
% You are allowed to make modification to this FAX.CLS and redistribute it
% under the following conditions:
%   1) You leave this top message intact.
%   2) You send me an updated version with your changes and an
%      explanation/motivation.
%   3) You ask no money for it.
%
% This document class comes with no waranty whatsoever! Comments and
% suggestion are most welcome.
%
% Mail me at: J.B.Rhebergen@ET.TUDelft.NL
%         or: rheberg@morra.et.tudelft.nl
%
% Happy Texing!
%
% Jan Rhebergen
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fax}[1995/07/18 v1.0 by: J.B. Rhebergen & J.H.M. de Jonge]
\IfFileExists{lastpage.sty}{\RequirePackage{lastpage}}{%
  \typeout{Warning: I did not find lastpage.sty,
  use \string\setcounter{\string\faxpages}{..} instead!}}

\newif\if@note\@notefalse
\newif\if@topsep\@topseptrue

\newcommand*{\slsf}{\sffamily\slshape}
\newcommand*{\bsf}{\sffamily\bfseries}

\newcommand*{\@lstpgno}{%
  \@ifundefined{r@LastPage}{0}{%
    \expandafter\expandafter\expandafter
    \@cdr\csname r@LastPage\endcsname
    \@nil}%
}

\newcommand*{\@to}{\typeout{Warning: The \string{\to} command is not defined!}}
\newcommand*{\@from}{\IfFileExists{from.fax}{\input{from.fax}}{%
  \typeout{Warning: I did not find from.fax, use \string\from{..} in your document!}}}
\newcommand*{\@note}{\IfFileExists{note.fax}{\input{note.fax}}{%
  \typeout{Warning: I did not find note.fax, use \string\note{..} in your document!}}}
\newcommand*{\@fxtxt}{{\Large\sc Tele-Fax Message}}
\newcommand*{\@dtxt}{Date:}
\newcommand*{\@ntxt}{Note:}
\newcommand*{\@ptxt}{page}
\newcommand*{\@pptxt}{pages}

\newcommand*{\@nothing}{}
\newcommand*{\mymsg}[1]{\renewcommand*{\@fxtxt}{#1}}
\renewcommand*{\to}[1]{\renewcommand*{\@to}{#1}}
\newcommand*{\from}[1]{\renewcommand*{\@from}{#1}}
\newcommand*{\note}[1]{\renewcommand*{\@note}{#1}}

\DeclareOption{dutch}{
  \renewcommand*{\@from}{\IfFileExists{van.fax}{\input{van.fax}}{%
    \typeout{Warning: I did not find van.fax, use \string\from{..} in your document!}}}
  \renewcommand*{\@note}{\IfFileExists{nb.fax}{\input{nb.fax}}{%
    \typeout{Warning: I did not find nb.fax, use \string\note{..} in your document!}}}
  \renewcommand*{\@fxtxt}{{\Large\sc Fax Boodschap}}
  \renewcommand*{\@dtxt}{Datum:}
  \renewcommand*{\@ntxt}{NB:}
  \renewcommand*{\@ptxt}{pagina}
  \renewcommand*{\@pptxt}{paginas}}

\DeclareOption{note}{\@notetrue}
\DeclareOption{nosep}{\@topsepfalse}

\DeclareOption*{\IfFileExists{artikel3.cls}
                 {\PassOptionsToClass{\CurrentOption}{artikel3}}
                 {\PassOptionsToClass{\CurrentOption}{article}}}

\ProcessOptions

\IfFileExists{artikel3.cls}{\LoadClass{artikel3}}{%
\typeout{Warning: I did not find artikel3.cls, I loaded article.cls instead!}
\LoadClass{article}}

\newlength{\faxtopsep}
\setlength{\faxtopsep}{3ex}
\newcounter{faxpages}

\AtBeginDocument{
\sf
\newlength{\@framewd}
\setlength{\@framewd}{\textwidth}
\newlength{\@sep}
\setlength{\@sep}{0.5em}
\addtolength{\@framewd}{-0.5\@sep}
\newbox\@thin
\newbox\@frombx
\newbox\@tobx
\setbox\@frombx=\hbox{\@from}
\setbox\@tobx=\hbox{\@to}
\newdimen\@thinht
\newdimen\@thindp
\@thinht=\ht\@frombx
\@thindp=\dp\@frombx
\newdimen\@tmpdim
\@tmpdim=\ht\@tobx
\ifdim\@tmpdim>\@thinht
  \@thinht=\@tmpdim
\fi
\@tmpdim=\dp\@tobx
\ifdim\@tmpdim>\@thindp
  \@thindp=\@tmpdim
\fi
\setbox\@thin=\hbox{\vrule width 0mm height \@thinht depth \@thindp}
\begin{center}
\ifx\@fxtxt\@nothing\relax\else\@fxtxt\strut\\\fi
\framebox[0.5\@framewd][t]{\copy\@thin\copy\@tobx}\hfill%
\framebox[0.5\@framewd][t]{\copy\@thin\copy\@frombx}\\
\nointerlineskip
\vspace{0.5\@sep}
\framebox[0.5\@framewd]{{\bsf \@dtxt} \today\strut}\hfill
\ifcase\@lstpgno
    \framebox[0.5\@framewd]{{\bsf Fax:} \thefaxpages\ page(s)\strut}\\
  \or
    \framebox[0.5\@framewd]{{\bsf Fax:} \pageref{LastPage} \@ptxt\strut}\\
  \else
    \framebox[0.5\@framewd]{{\bsf Fax:} \pageref{LastPage} \@pptxt\strut}\\
  \fi
\if@note
    \nointerlineskip
    \vspace{0.5\@sep}
    \addtolength{\@framewd}{-1em}
    \framebox[\textwidth][c]{\hfill
    \begin{minipage}{\@framewd}\fbox{\small\bsf \@ntxt} \@note\strut\hfill
    \end{minipage}\hfill}
  \fi
\end{center}
\if@topsep\vspace{\faxtopsep}\fi
}
