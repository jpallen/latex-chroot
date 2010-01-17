%% K_FriBri.CLS  -- Version vom 2. Jul. 1997
%% fuer LaTeX2e und KOMA-Script
%% von Alex Fries
%%
%% Kontaktadressen:
%%   Alex Fries:  Alex.Fries@Lauer-EDV.com
%%                bp016@smail.fh-koeln.de
%%
%% Optionen, abweichend von scrlettr-class:
%%    Calli                 Name in Calligraphie (genoetigt Font callig15)
%%    SmallC                Name in Smallcapital, ueber- und unterstrichen
%%    DIN                   Briefkopf nach DIN 5008 (Regeln fÅr
%%                          Maschinenschreiben)
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{k_fribri}
              [1997/07/02 ... der mit der persoenliche Note]

% **************
%   neue Fonts
% **************
\newfont{\alex}{cmcsc10 scaled 2988}
\newfont{\smallalex}{cmcsc10 scaled 800}
\newfont{\calligraphie}{callig15 scaled 2988}
\newfont{\smallcalli}{callig15 scaled 1000}

% **************************************
%   spezielle Befehle und Definitionen
% **************************************
\newcommand{\NLine}[1]{\vbox{\rule{\wd16}{#1}}}
\newcommand{\BKopf}{}
\newcommand{\nBKopf}{%
   \nexthead{\parbox[b]{\textwidth}{{%
      \sc\ignorespaces\fromname}{%
      \hfill\sf\footnotesize\headtoname\ \ignorespaces\toname
      \hfill\datename:\ \@date\hfill\pagename\
      \thepage\\[-8pt]\rule{\textwidth}{.4pt}}}}}

% *****************
%   DeclareOption
% *****************
\DeclareOption{Calli}{%
   \renewcommand{\BKopf}{%
   \firsthead{%
      \put(0,30){\parbox{\textwidth}{{%
      \calligraphie\ignorespaces\fromname}\hfill\raisebox{8mm}[15.7mm]{%
      \parbox[t]{4.5cm}{%
      \baselineskip2.5ex\raggedleft\ignorespaces\fromaddress\\
      \telephonenum}}}}}}
   \renewcommand{\nBKopf}{%
   \nexthead{\parbox[b]{\textwidth}{{%
      \smallcalli\ignorespaces\fromname}{%
      \hfill\footnotesize\headtoname\ \ignorespaces\toname
      \hfill\datename:\ \@date\hfill\pagename\
      \thepage\\[-6pt]\rule{\textwidth}{.4pt}}}}}}
\DeclareOption{DIN}{%
   \renewcommand{\BKopf}{%
   \firsthead{%
      \put(0,23){\parbox[t]{\textwidth}{%
      \normalsize\ignorespaces\fromname\\\ignorespases\fromaddress\\
      \telephonenum}}}}
   \renewcommand{\nBKopf}{%
   \nexthead{\parbox[b]{\textwidth}{{%
      \sfb\ignorespaces\fromname}
      \hfill\sf\headtoname\ \ignorespaces\toname
      \hfill\datename:\ \@date\hfill\pagename\
      \thepage\\[-8pt]\rule{\textwidth}{.4pt}}}}}
\DeclareOption{SmallC}{%
   \renewcommand{\BKopf}{%
   \firsthead{%
      \put(0,32){\parbox[t]{\textwidth}{{%
      \setbox16=\hbox{\alex\ignorespaces\fromname}\parbox[t]{\wd16}{%
      \offinterlineskip\NLine{0.5mm}\vglue1.5mm\hbox to \wd16{%
      \alex\ignorespaces\fromname}%
      \vglue1.5mm\NLine{0.5mm}}}\hfill\raisebox{-2.25mm}[15.7mm]{%
      \parbox[t]{4.5cm}{\baselineskip2.5ex\raggedleft\ignorespaces
      \fromaddress\\\telephonenum\\[2.5ex]}}}}}}
   \renewcommand{\nBKopf}{%
   \nexthead{\parbox[b]{\textwidth}{{%
      \setbox16=\hbox{\smallalex\ignorespaces\fromname}\parbox[b]{\wd16}{%
      \offinterlineskip\NLine{0.2mm}\vglue0.35mm\hbox to \wd16{%
      \smallalex\ignorespaces\fromname}\vglue0.5mm\NLine{0.2mm}}}
%      \sfb\ignorespaces\fromname}
      \hfill\rm\headtoname\ \ignorespaces\toname
      \hfill\datename:\ \@date\hfill\pagename\
      \thepage\\[-8pt]\rule{\textwidth}{.4pt}}}}}
\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{scrlettr}}
\ProcessOptions
\LoadClass{scrlettr}[1997/05/31]

% *********************************
%   scrlettr-Befehle undefinieren
% *********************************

\pagestyle{headings}
\BKopf
\nBKopf


