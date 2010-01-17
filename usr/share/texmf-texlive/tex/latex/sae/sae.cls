%%
%% LaTeX document style `sae', for use with LaTeX2e
%% This is a style for typesetting an SAE technical paper.
%%
%% COPYRIGHT 1999,2000 by Axel Franke, axel.franke@forbrf.lth.se
%%
%% Copying of part or all of any file in the sae.cls style
%% is allowed under the following conditions only:
%% (1) You may freely distribute unchanged copies of the files. Please
%%     include the documentation when you do so.
%% (2) You may modify a renamed copy of any file, but only for personal
%%     use or use within an organization.
%% (3) You may copy fragments from the files, for personal use or for use
%%     in a macro package for distribution, as long as credit is given
%%     where credit is due.
%%
%% You are NOT ALLOWED to take money for the distribution or use of
%% these files or modified versions or fragments thereof, except for
%% a nominal charge for copying etc.
%%

% Identification
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sae}[2000/06/28 SAE Technical paper format^^J
Copyright 1999,2000 Axel Franke (axel.franke@forbrf.lth.se)^^J]


\DeclareOption{times}{%
  \renewcommand{\familydefault}{ptm}%
  \typeout{^^JSetting document font to Times^^J}%
  }
\DeclareOption{helvetica}{%
  \renewcommand{\familydefault}{phv}%
  \typeout{^^JSetting document font to Helvetica^^J}%
  }
\DeclareOption{a4paper}{%
  \PassOptionsToPackage{a4paper,nohead,left=15mm,top=15mm,right=15mm,textheight=240mm}{geometry}%
  \typeout{^^JPaper size: A4^^J}%
  \AtBeginDocument{ \columnsep 15mm }
  }
\DeclareOption{letterpaper}{%
  \PassOptionsToPackage{letterpaper,nohead,left=.5in,top=.5in,right=.5in,textheight=10in}{geometry}%
  \typeout{^^JPaper size: Letter^^J}%
  \AtBeginDocument{ \columnsep .5in }
  }

\DeclareOption{pdftex}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}
  }

\DeclareOption{nonumber}{%
  \pagestyle{empty}%
  }

%% What we do not understand: 
\DeclareOption*{\typeout{^^JOption [\CurrentOption] not %
    supported by this style.^^J}}

%% default otions
\ExecuteOptions{helvetica,a4paper}
\ProcessOptions

% Using classes and packages
\LoadClass[twocolumn]{article}
\RequirePackage{geometry}

%% Declarations

% sections etc. not numbered
\setcounter{secnumdepth}{-2}

% LaTeX uses rubber length for \parskip
% SAE style seems to use fixed length
\setlength{\parskip}{\baselineskip}

% distance between the preceding text and a list item (description
% list, enumerated list, etc.) was too large
\setlength{\topsep}{-\parskip}

%  This places floats where they should go (suggested by Ross Pursifull,
%  "Pursifull, Ross (R.)" <rpursifu@visteon.com>, 19991207)
\renewcommand{\bottomfraction}{1}
\renewcommand{\textfraction}{0}
\setcounter{topnumber}{10}
\setcounter{bottomnumber}{10}
\setlength{\parindent}{0pt}

%% Heading formats
\renewcommand{\section}{\@startsection
  {section}%
  {1}%
  {0mm}%
  {-.1\baselineskip}%
  {.1\baselineskip}%
  {\normalsize\bfseries\uppercase}%
}

\renewcommand{\subsection}{\@startsection
  {subsection}%
  {2}%
  {0mm}%
  {-\baselineskip}%
  {-\baselineskip}%
  {\flushleft\normalsize\uppercase}%
}

\renewcommand{\subsubsection}{\@startsection
  {subsubsection}%
  {3}%
  {0mm}%
  {-\baselineskip}%
  {-\baselineskip}%
  {\flushleft\normalsize\underline}%
}

\renewcommand{\paragraph}{\@startsection
  {paragraph}%
  {4}%
  {0mm}%
  {-\baselineskip}%
  {-\baselineskip}%
  {\flushleft\normalsize}%
}


\renewcommand{\refname}{\flushleft\normalsize\bfseries REFERENCES}


%% Build title page
\def\@maketitle{%
  \null
  \parbox[t][90mm][t]{\textwidth}{%
    \begin{flushright}%
      \fontsize{14}{18}\selectfont%
      \usebox{\numberbox}\\
      \usebox{\titlebox}
      \usebox{\authorbox}\\[2ex]%
    \end{flushright}%
\vfill
    \begin{flushleft}%
        \raisebox{1cm}{\usebox{\saecopyrightbox}}\\%
    \end{flushleft}}%b
}

% Boxes for the title
\newsavebox{\authorbox}
\savebox{\authorbox}{}
\newsavebox{\titlebox}
\newsavebox{\numberbox}
\newsavebox{\saecopyrightbox}

\newcommand{\AddAuthor}[2]{%
  \savebox{\authorbox}{%
    \parbox[t]{\textwidth}{%
      \flushright%
      \usebox{\authorbox}\\%
      \fontfamily{\familydefault}\fontsize{12}{14}%
        \fontseries{b}\fontshape{n}\selectfont%
        #1\\%
      {\fontfamily{\familydefault}\fontsize{10}{11}%
        \fontseries{m}\fontshape{n}\selectfont%
        #2}\fontsize{12}{12}\selectfont\\[2ex]%
      }%
    }
  }
\newcommand{\PaperTitle}[1]{%
  \savebox{\titlebox}{%
    \parbox[t]{\textwidth}%
    {\flushright%
      \fontfamily{\familydefault}\fontsize{18}{22}%
      \fontseries{b}\fontshape{n}\selectfont%
      #1}%
    }%
  }
\newcommand{\PaperNumber}[1]{%
  \savebox{\numberbox}{
    \fontfamily{\familydefault}\fontsize{14}{18}%
    \fontseries{b}\fontshape{n}\selectfont%
    #1}%
  }

\newcommand{\SAECopyright}[1]{%
  \savebox{\saecopyrightbox}{%
    {\fontfamily{\familydefault}\fontsize{8}{10}%
      \fontseries{m}\fontshape{n}\selectfont%
      Copyright {\copyright} #1 Society of %
      Automotive Engineers, Inc.}%
    }%
  }





















