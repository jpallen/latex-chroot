\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{filoaddr}
          [1998/01/17 18:15:06 3.1.1.1 Filofax address pages (Frank Bennett)]
\DeclareOption{fourcolumn}%
              {\PassOptionsToPackage{\CurrentOption}{autofilo}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}
\RequirePackage{rotating}
\RequirePackage{url}
\def\mygobble#1{}
\newlength\templen
\newlength\mytemplength
\newlength\descheight
\newlength\myparwidth
\newlength\descwidth
\newlength\biggerwidth
\newlength\myentryheight
\newlength\myparheight
\newlength\mylinewidth
\def\entry#1{%
\vbox{%
\vskip2pt
\topline
\vskip 2pt
\parbox{\linewidth}{%
\raggedright%
\small#1}
\vskip 1pt
\bottomline}}
\def\topline{%
  \vbox to0pt{%
    \hbox to\linewidth{%
      \hskip-2.4pt%
      \vrule width0.4pt height0pt depth7pt%
      \vrule width\mylinewidth depth0.4pt height0pt%
      \vrule width0.4pt height0pt depth7pt\hskip-2.4pt}%
    \vskip-7pt}}
\def\bottomline{%
  \vbox to0pt{%
    \vskip-7pt
    \hbox to\linewidth{%
      \hskip-2.4pt%
      \vrule width0.4pt height7pt depth0pt%
      \vrule width\mylinewidth depth0.4pt height0pt%
      \vrule width0.4pt height7pt depth0pt%
      \hskip-2.4pt}}}
\def\address#1#2{%
  \settoheight\myparheight{\vbox{%
                             \boxmaxdepth0pt%
                             \parbox{\myparwidth}{\raggedright #2}}}%
  \settowidth\descwidth{\small\textbf{#1}}%
  \ifnum\descwidth>\myparheight\biggerwidth\descwidth\else%
      \biggerwidth\myparheight\fi%
  \vbox{\vskip3pt%
  \hbox to\linewidth{%
    \hskip3pt%
    \vbox to\biggerwidth{%
      \vfil%
        \hbox to\descheight{%
          \begin{sideways}{\small\textbf{#1}}\end{sideways}%
          \hfil}%
      \vfil}%
    \hskip2pt%
    \vbox to\biggerwidth{%
      \vfil%
        \hbox to\myparwidth{%
          \parbox{\myparwidth}{\raggedright #2}}%
      \vfil}}}}
\def\addresses#1{%
  \autofilo{#1}
  \settoheight\descheight{\vbox{\boxmaxdepth0pt{\small\textbf{Yy}}}}
  \myparwidth\linewidth%
  \advance\myparwidth by-\descheight\relax%
  \advance\myparwidth by-5pt\relax%
  \mylinewidth\linewidth
  \advance\mylinewidth by4pt\relax}
\def\endaddresses{\endautofilo}
