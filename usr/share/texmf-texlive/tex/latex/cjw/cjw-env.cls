%%-*- LaTeX -*-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cjwenv.cls
%
%
% Class file for typesetting envelopes.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        cjwenv.cls
% Author:       Colin J. Wynne <cwynne@brutus.mts.jhu.edu>
% Date:         Tue Dec 31 13:10:56 1996
% Last Rev.:
%
% Usage:
%
% Here is an example:
%
% \documentclass[business,11pt]{cjwenv}
% \address{%
%   My Home Address	\\
%   Street Name		\\
%   City, ST  ZIP}
%
% \begin{document}
% \begin{envelope}[c]{%
%   Prof. Peter Schickele	\\
%   USND Hoopole		\\
%   Hoopole, ND  12345}
% \end{envelope}
% 
% \begin{envelope}{%
%   Dr. Seuss			\\
%   Whoville, ??  67890}
% \address[c]{%
%   Horton		\\
%   Lost		\\
%   Hoboken, NJ  13579}
% \end{envelope}
% 
% \end{document}

% Declare the file version and date.
\def\fileversion{1.1}
\def\filedate{1998/10/5}

% Identify the class.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cjw-env}%
  [\filedate\space v\fileversion\space Envelope Class---CJW]

% My printer puts the top of the landscape page on the opposite side
% of the printer from the envelope feed.  Therefore, we offer the
% option of putting the output at the bottom of a standard page.
\newif \if@atbottom	\@atbottomfalse

% We set an envelope type with the following macro.
\newcommand{\envtype}[1]{%
  \renewcommand{\do@envelope}{\csname env@#1\endcsname}}
\newcommand{\do@envelope}{}

% Class options:
%
%   For business envelopes.  Other types should be handled thusly.
\DeclareOption{business}{\envtype{business}}
%   For 6.5" business envelopes.
\DeclareOption{narrow}{\envtype{narrow}}
%   For bottom printing.
\DeclareOption{bottom}  {\@atbottomtrue}
% Default: pass to article.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Pick a default envelope type.
\ExecuteOptions{business}
\ProcessOptions

% Load primary class.
\LoadClass[12pt]{article}

% All we care about is hieght, width, and offsets.  Zero out
% everything else.
\newcommand{\reset@page}{%
  \setlength{\oddsidemargin}	{0.0pt}
  \setlength{\topmargin}		{0.0pt}
  \setlength{\headheight}		{0.0pt}
  \setlength{\headsep}			{0.0pt}
  \setlength{\marginparsep}		{0.0pt}
  \setlength{\marginparwidth}	{0.0pt}
  \setlength{\footskip}			{0.0pt}
    %
  \setlength{\parskip}			{0.0pt}
  \setlength{\parindent}		{0.0pt}
    %
  \setlength{\textwidth}		{\paperwidth}
    \addtolength{\textwidth}	{-1.0in}
  \setlength{\textheight}		{\paperheight}
    \addtolength{\textheight}	{-1.0in}
  }

% This is the business envelope code.
\newcommand{\env@business}{%
  % Introduce a postscript special for landscape printing.
  \special{landscape}
  % Swap the height and width in TeX to match the landscape orientation.
  \setlength{\@tempdima}	{\paperheight}
  \setlength{\paperheight}	{\paperwidth}
  \setlength{\paperwidth}	{\@tempdima}
  %
  % Our business envelope has physical height of 4.125", and we will
  % leave a half inch on either side as a margin.
  \setlength{\textheight}   { 3.125in}
    \setlength{\voffset}    {-0.500in}
  % For bottom printing:
  \if@atbottom
    % This calculates the \voffset necessary to put the *physical*
    % bottom off the envelope (half inch below printable area) flush
    % bottom on the physical (landscap) page.
    \setlength{\@tempdima}  {\paperheight}
    \addtolength{\@tempdima}{-1.0in}
    \setlength{\@tempdimb}  {\textheight}
    \addtolength{\@tempdimb}{-\voffset}
    \addtolength{\@tempdima}{-\@tempdimb}
      %
    \setlength{\voffset}    {\@tempdima}
  \fi
  % We leave 0.75" horizontal margin on either side of a 9.5"
  % envelope. 
  \setlength{\textwidth}    { 8.000in}
    \setlength{\hoffset}    {-0.250in}
  }

% For a narrow (3.625" x 6.5") business envelope. 
\newcommand{\env@narrow}{%
  % Introduce a postscript special for landscape printing.
  \special{landscape}
  % Swap the height and width in TeX to match the landscape orientation.
  \setlength{\@tempdima}	{\paperheight}
  \setlength{\paperheight}	{\paperwidth}
  \setlength{\paperwidth}	{\@tempdima}
  %
  % Our envelope has physical height of 3.625", and we will
  % leave a quarter inch on either side as a margin.
  \setlength{\textheight}   { 3.125in}
    \setlength{\voffset}    {-0.250in}
  % For bottom printing:
  \if@atbottom
    % This calculates the \voffset necessary to put the *physical*
    % bottom off the envelope (quarter inch below printable area)
    % flush bottom on the physical (landscap) page.
    \setlength	{\@tempdima}{\paperheight}
    \addtolength{\@tempdima}{-1.000in}
    \setlength	{\@tempdimb}{\textheight}
    \addtolength{\@tempdimb}{-\voffset}
    \addtolength{\@tempdima}{-\@tempdimb}
      %
    \setlength{\voffset}    {\@tempdima}
  \fi
  % We leave 0.5" horizontal margin on either side of a 6.5"
  % envelope. 
  \setlength{\textwidth}    { 5.50in}
    \setlength{\hoffset}    {-0.50in}
  }
 
% How the sender's address is input.  By default, it will be flush
% left/ragged right.  An appropriate optional argument may be given.
\newcommand{\address}[2][l]{%
  \gdef\@address{#2}\gdef\from@align{#1}}
\address{}

% This does the actual page setup at the end of the preamble.  It must
% be done here and not after the \begin{document} in order for all the
% page parameters to work out, it seems.
\AtBeginDocument{%
  \reset@page\do@envelope}

% The envelope environment sets the actual envelope.  Mandatory
% argument is the recipient's address.  Optional argument changes the
% alignment of that adress.  There should probably be nothing in the
% actual environemnt, though in printing numerous envelopes one could
% put different return addresses in, or perhaps additional typesetting
% commands.
\newenvironment{envelope}[2][l]%
  {\gdef\@recipient{#2}\gdef\recip@align{#1}}
  {\do@envelope\clearpage
   \thispagestyle{empty}
   \vtop to \textheight{
     \hbox{%
       \begin{tabular}{\from@align}
         \@address
       \end{tabular}}
     \vfill
     \hbox to \textwidth{\hss
       \begin{tabular}{\recip@align}
         \@recipient
       \end{tabular}\hss}
     \vfill}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
