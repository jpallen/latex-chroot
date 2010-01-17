% exam.cls
%
% A LaTeX2e document class for preparing exams.

%% exam.cls
%% Copyright (c) 1994, 1997, 2000, 2004 Philip S. Hirschhorn
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "author-maintained".
% 
% This work consists of the files exam.cls and examdoc.tex.


% The user documentation for exam.cls is in the file examdoc.tex.


%%% Philip Hirschhorn
%%% Department of Mathematics
%%% Wellesley College
%%% Wellesley, MA 02481
%%% psh@math.mit.edu

% The newest version of this documentclass should always be available
% from my web page: http://www-math.mit.edu/~psh/


\def\fileversion{2.2}
\def\filedate{2004/08/14}
%---------------------------------------------------------------------
%---------------------------------------------------------------------
% PLEASE DO NOT MAKE ANY CHANGES TO THIS FILE!
% 
% If you wish to make changes to this file, rename this file
% to something other than exam.cls BEFORE YOU MAKE THE CHANGES!
% 
% If there's some feature that you'd like that this file doesn't
% provide, tell me about it.
% 
%
%
%
%
% Thanks to:
%
% Piet van Oostrum, from whose excellent ``fancyheadings.sty'' we
% shamelessly stole most of the code for setting the headers and
% footers.
%
% Mate Wierdl <mw@wierdlmpc.msci.memphis.edu>, who contributed the
% code so that if the number of points is ``1'', then the default
% value of \pointname will print ``1 point'' instead of ``1 points''.
%
% Tom Brikowski <brikowi@utdallas.edu>, who contributed the code for
% making the number of points and number of questions available as
% macros (as well as the idea of putting the number of points in a 
% box, instead of in parentheses).  (I changed his code to make this
% all optional, so if there are errors there, it's my fault and not
% his.)
%
% Ottmar Beucher <beucher@fh-karlsruhe.de>, Dan Drake
% <drake@math.umn.edu>, and Justus Piater <Justus.Piater@ULg.ac.be> who
% contributed ideas and code for the \pointsofquestion and \gradetable
% commands for printing a Grading Table.  (I changed all the code to
% make this compatible with hyperref.sty, so if there are errors there,
% it's my fault and not theirs.)
%
% Justus Piater <Justus.Piater@ULg.ac.be>, who contributed the code for
% the solution environment.  (I changed his code to allow page breaks
% inside solutions so, once again, if it's buggy, it's my fault.) 
%
% Donald Arseneau <asnd@triumf.ca>, who created the excellent
% ``framed.sty'' and generously allowed me to include basically the
% whole thing in exam.cls, making the few changes needed for it to
% work well with question environments:
% framed.sty   v 0.8a   21-Jul-2003
% Copyright (C) 1992-2003 by Donald Arseneau
% These macros may be freely transmitted, reproduced, or modified
% provided that this notice is left intact.
%
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%                             Changelog:


% Version 2.2:
%
% Enough already with betatest.
%
%--------------------------------------------------------------------
%
% Version 2.116$\beta$:
%
% We futzed with the oneparchoices environment so that a bit more
% space will be left before the first choice when the list of choices
% continues the paragraph of the question.
%
%--------------------------------------------------------------------
%
% Version 2.115$\beta$:
%
% New environment: oneparchoices
%
% Intended for multiple choice questions (just like the choices
% environment), except that the oneparchoices prints all the choices in
% a single paragraph.  This environment does *not* create a paragraph
% break at its beginning, so if you begin the environment without
% skipping a line before it, the choices will be printed as a
% continuation of the paragraph preceding the environment.
%
%--------------------------------------------------------------------
%
% Version 2.114$\beta$:
%
% We fixed up the code for \uplevel and \fullwidth so that they work
% correctly if a solution environment is inside the argument.
%
%--------------------------------------------------------------------
%
% Version 2.113$\beta$:
%
% Added code to warn if point totals have changed since the last run of
% LaTeX (which requires running LaTeX again to make sure that
% gradetables, pointsofquestion, and pointsonpage values are correct).
%
%
% We also added code to create a label for every question, part,
% subpart, and subsubpart.  We make no use of these labels, but we put
% them there so that if a question (or part, etc.) is, e.g., moved from
% one page to another, LaTeX will notice this and warn the user that
% LaTeX must be run one more time to be sure everything is correct.
%
% We need to do this even though we've already included code to check
% when point totals change because questions (and parts, etc.) know what
% page they're on from reading the info written to the .aux file on the
% previous run.  Thus, if a question (or part, etc.) is moved to a
% different page, then the pointsonpage totals won't notice until the
% *second* subsequent run of LaTeX, and so there'll be no warning to the
% user on the *first* run.  Including these labels gives the user a
% warning on that first run.
%
%--------------------------------------------------------------------
%
% Version 2.112$\beta$:
%
% New environment: coverpages
%
% This is for use only *before* any questions (or parts, or subparts, or
% subsubparts).  It allows you to print one or more cover pages,
% numbered in a different sequence of page numbers from the main pages.
% That is, the page number is reset to 1 at the end of a coverpages
% environment.
%
% The default is that headers and footers are empty on the coverpages,
% but if you print the page number (using \thepage in the header or
% footer) then the page number will be printed in roman numerals.  When
% the coverpages environment ends, the page number is reset to 1 and the
% page numbers revert to the (standard) arabic numbers.
%
% Headers and footers on coverpages are determined by commands
% completely analogous to the relevant commands for the main pages,
% except that the names of the commands begin with the word ``cover''.
% That is, the following commands are available to define headers and
% footers, and to leave additional space for the headers and footers as
% needed: 
%
%
% New commands:
%
% \coverheader
% \coverrunningheader
% \coverfirstpageheader
%
% \coverlhead
% \coverchead
% \coverrhead
%
% \coverfooter
% \coverrunningfooter
% \coverfirstpagefooter
%
% \coverlfoot
% \covercfoot
% \coverrfoot
%
% \coverextraheadheight
% \coverextrafootheight
%
%--------------------------------------------------------------------
%
% Version 2.111$\beta$:
%
% Bugfix: There was an incompatibility with spanish.ldf (loaded when the
% user loads the babel package with the spanish option) (and possibly
% with other language packages as well).  That file redefines \@roman,
% which is used by \roman, which I had used to define some internally
% used command names.  I replaced
%
%   \roman{countername}
%
% with
%
%   \romannumeral \csname c@countername\endcsname
%
% for all of those command names, and now all at least seems to be
% well.
%
%
% The following stuff isn't really complete yet:
% New environment: coverpages
%
% New commands:
%
% \coverheader
% \coverrunningheader
% \coverfirstpageheader
%
% \coverlhead
% \coverchead
% \coverrhead
%
% \coverfooter
% \coverrunningfooter
% \coverfirstpagefooter
%
% \coverlfoot
% \covercfoot
% \coverrfoot
%
% \coverextraheadheight
% \coverextrafootheight
%
%--------------------------------------------------------------------
%
% Version 2.110$\beta$:
%
% We change the definition of \half to print a fraction one half that
% uses a slanted fraction bar.  We also created two new commands:
%
%   \newcommand*\usehorizontalhalf
%   \newcommand*\useslantedhalf
%
% The first one changes the definition of \half so that it produces a
% fraction with a horizontal fraction bar (via $\frac{1}{2}$), and the
% second one returns the definition of \half to its default.
%
%--------------------------------------------------------------------
%
% Version 2.109$\beta$:
%
% Point values for questions (and parts, etc.) can now include half
% points.  To specify a half point, you include ``\half'' immediately
% following the integer part (or just with ``\half'' if the integer part
% is zero).  For example, the following are all valid point values:
%
% 0
% \half
% 1
% 1\half
% 2
% 2\half
% Etc.
%
%--------------------------------------------------------------------
%
% Version 2.108$\beta$:
%
% New environment: solutionorlines
%
% This is almost identical to the solution environment, except that when
% solutions are not being printed and an optional argument appears
% specifying an amount of space to be left for answers, that space is
% filled with ruled lines (created by \fillwithlines), rather than being
% left blank (as it is by the solution environment).
%
% Also: Changed the shade of gray used as the default color for
%       \shadedsolutions.
%
%       Changed the default thickness of lines used by \fillwithlines.
%
%--------------------------------------------------------------------
%
% Version 2.107$\beta$:
%
% We added an option to have solution environments use a \colorbox (from
% the color package) instead of an \fbox.  Instead of surrounding the
% solution with a printed box, it prints the solution on a colored
% background.  The default color is a light gray (so that it can be
% printed on any printer that can do grayscale), but the color can be
% changed.
%
% To use this option, the user must load the color package with the
% command
%
%   \usepackage{color}
%
% in the preamble.  (If appropriate, optional arguments can be used in
% that command.)  The user can then give the command
%
%   \shadedsolutions
%
% to have all solutions printed using a \colorbox.  After giving that
% command, the user can change the color of the backgrounds of solutions
% by defining the color ``SolutionColor''.  The default SolutionColor is
% set via the command
%
%   \definecolor{SolutionColor}{gray}{0.9}
%
% and the user can change that by giving a \definecolor command *after*
% giving the command \shadedsolutions.  For example, the command
%
%   \definecolor{SolutionColor}{rgb}{0.8,0.9,1}
%
% sets the background color to a light blue.
%
% You can return to the default situation of having solutions printed
% inside an \fbox by giving the command
%
%   \framedsolutions
%
% Note added later: The default shade of gray was changed in version
% 2.108$\beta$.
%
%--------------------------------------------------------------------
%
% Version 2.106$\beta$:
%
%
% We redid the solution environment to use Donald Arseneau's framed.sty
% macros, so that the solution can be broken across pages with each
% piece enclosed in a frame.
%
% We also changed the default definition of \solutiontitle; it's now
% defined by:
%
%  \newcommand{\solutiontitle}{\noindent\textbf{Solution:}\enspace}
%
%
%--------------------------------------------------------------------
%
% Version 2.105$\beta$:
%
% We're making the thickness of the lines used by \fillwithlines
% changeable, and changing the default thickness.
%
% We're doing this by defining a new command:
%
%   \linefill,
%
% which is similar to \hrulefill, except that \linefill uses a line of
% height \linefillthickness, whose default value is 0.2pt.
% (\fillwithlines used to use \hrulefill, which uses a line of height
% 0.4pt.)
%
% The default value of \linefillthickness is set by the command
%
%   \setlength\linefillthickness{0.2pt}
%
% and this can be changed by giving a new \setlength command.
%
% Note added later: The default thickness was changed in version
% 2.108$\beta$.
%
%--------------------------------------------------------------------
%
% Version 2.104$\beta$:
%
% We added a new command: \fillwithlines
%
% \fillwithlines takes one argument, which is either a length or \fill,
% and it fills that much vertical space with horizontal lines that run
% the length of the current line.  That is, they extend from the current
% left margin (which depends on whether we're in a question, part,
% subpart, or subsubpart) to the right margin.
%
% The distance between the lines is \linefillheight, whose default value
% is set with the command
%
%   \setlength\linefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.
%
%--------------------------------------------------------------------
%
% Version 2.103$\beta$:
%
% We added a new command: \answerline
%
% This is intended for short answer questions.  It inserts a \vskip of
% length \answerskip and then inserts a horizontal line of length
% \answerlinelength at the right margin, preceded by the number of the
% current question, part, subpart, or subsubpart.
%
% The default values are set by the commands
%
%   \setlength\answerlinelength{1in}
%   \setlength\answerskip{2ex}
%
% and these can be changed by giving new \setlength commands.
%
%--------------------------------------------------------------------
%
% Version 2.101$\beta$:
%
% We eliminated the command \marks, since it conflicts with a definition
% of that name in some package or other.  We changed the definition of
% \marksnotpoints so that it still accomplishes the same thing, but now
% it works through the \pointpoints command.
%
% We changed the default format for the \droptotalpoints command, so
% that it now prints
%
%   Total for Question 1: 25
%
% where the ``25'' is followed by \marginpointname, whose default value
% is empty.
%
%--------------------------------------------------------------------
%
% Version 2.098$\beta$:
%
% We moved the definitions of \thepartno, \thesubpart, and
% \thesubsubpart outside of the associated list environments, so that
% the user can redefine them once at the beginning of the LaTeX file and
% not have their redefinition overridden in every such list.
%
% We also replaced most occurrences of \thequestion with
% \arabic{question}, so that the user can safely redefine \thequestion
% to something like \Alph{question}, etc.
%
% We rewrote the components of the \gradetable[v][questions] and
% \gradetable[h][questions] to use the question counter in place of
% @iterator, and to insert \thequestion instead of \the@iterator as the
% question number in the table (so that if the user redefines
% \thequestion, then the table will print the question ``numbers'' (or
% letters, etc.) in whatever format \thequestion prints the question
% numbers on the exam).
%
% We also created a new command:
%
%   \totalpoints
%
% for use in the argument of a \totalformat command.  \totalpoints is
% just an abbreviation for \pointsofquestion{\arabic{question}}.  That
% is, it's a macro that prints the total number of points for the
% current question.
%
% We changed the longsolution environment to make it easy to change the
% amount by which the left and right margins are increased.  The default
% amount is set by the command
%
%   \setlength{\longsolutionindent}{2em}
%
% and the user can change this by giving a new \setlength command.
%
% Note added later: longsolution was eliminated in version
% 2.106$\beta$.
%
%--------------------------------------------------------------------
%
% Version 2.097$\beta$:
%
% We've changed the default format for the total points for a question
% printed by the \droptotalpoints command.  This command still prints
% the total points for the question right justified a distance of
% \rightpointsmargin from the right edge of the paper, but now the
% number of points will, by default, be surrounded by either
%
%   a double box, if \boxedpoints is in effect,
%   double brackets, if \bracketedpoints is in effect, or
%   double parentheses, otherwise.
%
% It's still true that if you use a \totalformat command, then the
% format of the printed total points is completely controlled by the
% argument of the \totalformat command and the default doesn't matter at
% all.
%
%
% Note added later: We changed the default format again in version
% 2.101$\beta$; see the notes above.
%
%--------------------------------------------------------------------
%
% Version 2.096$\beta$:
%
% The labels for questions, parts, subparts, and subsubparts can now be
% customized.  The format now depends on the commands
%
%   \questionlabel
%   \partlabel
%   \subpartlabel
%   \subsubpartlabel
%
% the default definitions of which are:
%
%   \newcommand\questionlabel{\thequestion.}
%   \newcommand\partlabel{(\thepartno)}
%   \newcommand\subpartlabel{\thesubpart.}
%   \newcommand\subsubpartlabel{\thesubsubpart)}
%
% These definions can be changed by using a \renewcommand command.
% Note that the definition of \partlabel used `\thepartno', and *not*
% `\thepart'.  This is because `\thepart' refers to the counter for the
% standard sectioning command \part, and not the counter used in the
% parts environment.  The counter used by the parts environment is
% inserted with the command `\thepartno'.
%
%--------------------------------------------------------------------
%
% Version 2.095$\beta$:
%
% Added solution and longsolution environments.
%
% The command \printanswers causes both of these environments print the
% solution, and the command \noprintanswers causes both of these
% environments not to print the solution.  The default is
% \noprintanswers.
%
% The commands \printanswers and \noprintanswers can be given as many
% times as desired to switch back and forth between the two.
%
% The documentclass option ``answers'' is equivalent to giving a
% \printanswers command at the beginning of the file.
%
%
% Both of these environments take an optional argument which is an
% amount of blank vertical space to be left when \noprintanswers is in
% effect.  (The default value of this blank vertical space is 0pt.)
%
%
% The solution environment prints the solution inside of a box, which
% cannot be broken across pages.  Thus, it is only appropriate for
% solutions that are short enough to fit on a page.
%
% The longsolution environment prints the solution with left and right
% margins slightly increased, and it can be broken across pages.
%
% When printing the solution, both environments begin with
% \solutiontitle, the default value of which is created by the command
%
% \newcommand{\solutiontitle}{\textbf{Solution:}\enspace}
%
% This can be changed with the \renewcommand command.
%
% Note added later: solution was changed and longsolution was
% eliminated in version 2.106$\beta$.
%
%--------------------------------------------------------------------
%
% Version 2.094$\beta$:
%
% We've expanded the options of the \gradetable command, so that you
% can now get a grading table indexed by either question numbers or by
% page numbers, and in either case you can have either a horizontally
% oriented table or a vertically oriented table.
%
% \gradetable now takes two optional arguments: The first can be either
% `[v]' or `[h]', and the second can be either `[questions]' or
% `[pages]'.  The defaults are `[v]' and `[questions]', and you must
% specify a first option if you want to specify a second option.
%
% Thus: \gradetable is equivalent to \gradetable[v][questions]
%
% `[v]' and `[h]' are as before: Vertically oriented or horizontally
% oriented.
%
% `[questions]' is the same as the earlier version: A table that lists
% the question numbers, the possible total points for each question the
% total for the entire exam, and spaces are left for the score on each
% question.
%
% `[pages]' prints a table indexed by page numbers instead of by
% question numbers.  It lists only the numbers of pages that have points
% on them, and for each such page it lists the number of points possible
% on that page.  It also lists the total possible points on the exam,
% and spaces are left for the score on each page.
%
% For both tables indexed by questions and tables indexed by points,
% there are commands that allow you to change the column and row
% headings (the following are shown setting the default values:)
%
%    \hpword{Points:}
%    \hsword{Score:}
%    \htword{Total}
%    \vpword{Points}
%    \vsword{Score}
%    \vtword{Total:}
%
% For tables indexed by questions, the appropriate row and column titles
% are set by the following commands:
%
%    \hqword{Question:}
%    \vqword{Question}
%
% For tables indexed by pages, the appropriate row and column titles are
% set by the following commands:
%
%    \hpgword{Page:}
%    \vpgword{Page}
%
%
% For both \gradetable[h] and \gradetable [v], the width of the blank
% cells created for filling in the grades can be changed with the
% command \cellwidth, and the arraystretch applied to the table can be
% changed with the command \gradetablestretch.  The default values are
% created by the commands:
%
%   \cellwidth{2em}
%   \gradetablestretch{1.5}
%
%--------------------------------------------------------------------
%
% Version 2.093$\beta$:
%
% If the user gives the comman \addpoints, then
% \pointsonpage{n} expands to the number of points on page n.
%
%--------------------------------------------------------------------
%
% Version 2.092$\beta$:
%
% Increased the \leftmargin in the choices environment.
%
%--------------------------------------------------------------------
%
% Version 2.091$\beta$:
%
% New commands:
% \pointsdroppedatright
% \droppoints
% \droptotalpoints
% \totalformat
%
% \pointsdroppedatright: The command \pointsdroppedatright causes points
% not to be printed until you give the command \droppoints, except that
% a \qformat command still works as expected (i.e., if you include
% ``\thepoints'' in the argument of the \qformat, it will print the
% points as usual).
%
%
% \droppoints: The command \droppoints should be given only at the end
% of a paragraph or between paragraphs; if you give it within a
% paragraph, it causes the paragraph to end.  \droppoints prints the
% most recent point value in the right margin, formatted as it is when
% you give the command \pointsinrightmargin, except that the points
% appear opposite the last line of the paragraph (or, if the command
% \droppoints is given between paragraphs, then additional vertical
% space is left between the paragraphs and the points are printed
% opposite the blank space).  Thus, the formatting can be changed by
% using giving the commands \bracketedpoints, \boxedpoints, or
% \marginpointname.
%
% The command \droppoints actually works this way even if one of the
% commands \pointsdroppedatright, \pointsinmargin, or
% \pointsinrightmargin, is in effect, but if you use it that way the
% points will appear twice on the page.
%
%
% \droptotalpoints: To use the command \droptotalpoints, you must first
% give the command \addpoints.  The command \droptotalpoints should be
% given only at the end of a paragraph or between paragraphs; if you
% give it within a paragraph, it causes the paragraph to end.
% \droptotalpoints prints the total points for the current question
% (i.e., the sum of the points assigned to the question and to all of
% its parts, subparts, and subsubparts) in the right margin, formatted
% formatted by default inside either double brackets, double box, or
% double parentheses, depending on whether \bracketedpoints,
% \boxedpoints, or neither is in effect.
%
% \totalformat: The \totalformat command allows you to change the format
% used by the \droptotalpoints command.  It takes one argument, and that
% argument becomes the command to print the total points, right
% justified a distance of \rightpointsmargin from the right edge of the
% paper.  The argument should contain the expression
% ``\pointsofquestion{\arabic{question}}'' at the point at which the number
% of points should appear.  For example, the command
%
%   \totalformat{[\pointsofquestion{\arabic{question}}]}
%
% will produce the same appearance as the default does when the command
% \bracketedpoints is in effect and \marginpointname is empty, and the
% command
%
%   \totalformat{\fbox{Total: \pointsofquestion{\arabic{question}}}}
%
% produces a box surrounding ``Total: 25''.
%
%--------------------------------------------------------------------
%
% Version 2.087$\beta$:
%
% We changed ``\point@toks={}'' into ``\global \point@toks={}'' when
% \point@toks is set, so that if the user somehow arranges for us to be
% inside of a group when we enter horizontal mode, the \point@toks will
% be properly set equal to null, and so the points won't accidentally be
% placed a second time at the second paragraph of the question.
%
% Similarly, we changed ``\pageinfo@commands={}'' to 
% ``\global \pageinfo@commands={}''.
%
%--------------------------------------------------------------------
%
% Version 2.080$\beta$:
%
% We added a new command \gradetable that produces a grading table,
% oriented either vertically or horizontally, that lists the questions,
% their point values, and the total points, and leaves spaces for
% entering the grade for each question and the total grade.  We also
% added a new command \pointsofquestion that takes one argument that is
% assumed to be the number of a question and returns the total number of
% points for that question.  \pointsofquestion is used by the
% \gradetable command, but the user can choose to use it separately.

% To use either \gradetable or \pointsofquestion, the user must give the
% command \addpoints.  \pointsofquestion{n} will then return the total
% number of points for question n and all of its parts, subparts, and
% subsubparts.  Since all this information is stored in the .aux file
% and then read back on the next run of LaTeX, the user must run LaTeX
% twice after any changes to the questions or points.

% \gradetable[h] produces a horizonatlly oriented grade table, and
% \gradetable[v] produces a vertically oriented grade table.  The
% command \gradetable is equivalent to \gradetable[v].

% \gradetable[h] produces a table with three rows, titled (by default)
% ``Question:'', ``Points:'', and ``Score:'' (the titles are in the
% first column of the table).  There is then one column for each
% question (with the question number and point value in the first two
% rows), plus a final column labelled ``Total'' with the total points in
% the second row.

% \gradetable[v] produces a table with three columns, titled (by
% default) ``Question'', ``Points'', and ``Score'' (the titles are in
% the first row of the table).  There is then one row for each question
% (with the question number and point value in the first two columns),
% plus a final row labelled ``Total:'' with the total points in the
% second column.

% Note that \gradetable[h] produces row titles whose default values
% contains colons, while \gradetable[v] produces column titles whose
% default values do not contain colons.

% The row and column titles and the word ``Total'' can be changed using
% the commands \hqword, \hpword, \hsword, \htword, \vqword,
% \vpword, \vsword, and \vtword, where the first four affect
% \gradetable[h] and the second four affect \gradetable[v].  The default
% values are created by the commands:

%   \hqword{Question:}
%   \hpword{Points:}
%   \hsword{Score:}
%   \htword{Total}
%   \vqword{Question}
%   \vpword{Points}
%   \vsword{Score}
%   \vtword{Total:}

% For both \gradetable[h] and \gradetable [v], the width of the blank
% cells created for filling in the grades can be changed with the
% command \cellwidth, and the arraystretch applied to the table can be
% changed with the command \gradetablestretch.  The default values are
% created by the commands:

%   \cellwidth{2em}
%   \gradetablestretch{1.5}



% Changing the definition of \points:

% The default definition of \points is that it expands to ``point'' if
% the number of points is 1 and to ``points'' otherwise.  There is now a
% command ``\pointpoints'' that takes two arguments, after which
% \points will expand to the first argument when the number of points is
% 1 and to the second argument otherwise.  For example, the default is
% the result of the command \pointpoints{point}{points}.
%
%--------------------------------------------------------------------
%
% Version 2.070$\beta$:
%
% We made this compatible with hyperref.sty.
% We did this by eliminating all use of LaTeX's 
% \label, \newlabel, \ref, and \pageref commands.
% We now put information into the .aux file using the
% \PgInfo@write command, and get that info out of the aux file
% using \PgInfo and \PgInfo@get, along with a few \gdef commands
% written straight to the .aux file.
%
%--------------------------------------------------------------------
%
% Version 2.067$\beta$:
%
% We're adding code to enable headers and footers
% to know whether the current page continues a question started on an
% earlier page, and whether the page ends with a question still
% incomplete.

%--------------------------------------------------------------------
% For use in headers and footers:
%
% \ifcontinuation{Text 1}{Text 2}
% Expands to ``Text 1'' if this page begins with a part or subpart or
% subsubpart that continues a question begun on an earlier page, and
% expands to ``Text 2'' if this page begins with a new question.
%
% \ContinuedQuestion expands to the number of the question that is
% being continued from an earlier page.
%
% \ifincomplete{Text 1}{Text 2}
% Expands to ``Text 1'' if the last question begun on or before this
% page has a part, subpart, or subsubpart that begins on a later page,
% and if we have not yet encountered a \nomorequestions command.
%
% \IncompleteQuestion expands to the number of the question that is
% continued on the next page.
%
% \nomorequestions is a command that you can give after the last
% question if you intend to include extra material (e.g., tables for
% use on the exam) but you don't want the pages containing the extra
% material to be labelled as continuing the last question on the exam.
%
%--------------------------------------------------------------------
%
%
% Also: 
% Changed the code for headers and footers to
% use the command \normalfont instead of \rm so that the main
% document font will appear in headers and footers even when the
% main document font is *not* a roman font.
%
% \def\marksnotpoints
%
% Changes \pointname so that it is identical to the default \pointname
% except that the work ``mark'' is used instead of the word
% ``point''.  That is, if the number of points is 1, then you'll get
% ``1 mark'', and if the number of points is other than 1 then you'll
% get ``n marks'' (where n is the number of points).
%
%
% \bracketedpoints
% \nobracketedpoints
%
% The default remains to put the points inside of parentheses.
% \bracketedpoints switches to points inside of square brackets and
% \boxedpoints switches to points in side of a box.  Both
% \nobracketedpoints and \noboxedpoints return to the default of
% points inside of parentheses no matter how many \boxedpoints and
% \bracketedpoints commands have been given in any order.
%
%
% \pointsinrightmargin
% \nopointsinrightmargin
%
% The default remains to put the points right after the question
% number, before the text of the question. \pointsinrightmargin
% switches to points in the right margin and \pointsinleftmargin
% switches to points in the left margin.  Both \nopointsinrightmargin
% and \nopointsinleftmargin return to the default of points right
% after the question number, before the text of the question, no
% matter how many \pointsinrightmargin and \pointsinleftmargin
% commands have been given in any order. 
%
% if \pointsinrightmargin is used, then the points are printed
% right justified in the right margin, with the right edge a distance
% of \rightpointsmargin from the right edge of the paper.
% The default value of \rightpointsmargin is 1 cm, but it can be set
% to any other length with the usual \setlength command
% (as in \setlength{\rightpointsmargin}{0.5cm}).
%
%
% subsubparts environment
% Numbered using lower case greek letters.
%
%
% choices environment, for multiple choice answers
%
%
% \qformat{Format line}
% 
% Format line must have some stretch (e.g., at least one \hfil or
% \dotfill or something similar).
% \thequestion inserts the question number,
% \thepoints inserts the number of points followed by pointname if
%   a number of points has been specified for this question, and it
%   inserts nothing at all if no points have been specified.
%
% \noqformat returns to the standard question number formatting.
%
%
%
% The standard options
%   a4paper
%   a5paper
%   b5paper
%   letterpaper
%   legalpaper
%   executivepaper
%   landscape
% now all work.
%
%
%
% Two new commands for use in \pointname, \marginpointname, and
% \qformat: 
%
% \points expands to either ``point'' or ``points'', depending on
% whether the number of points is 1 or other than 1.
%
% \marks expands to either ``mark'' or ``marks'', depending on
% whether the number of points is 1 or other than 1.
%
%
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
% The only change from version 2.0 to version 2.01 is that this
% documentclass (and its accompanying documentation) is now
% explicitly distributed under the LaTeX Project Public License.
%
%--------------------------------------------------------------------
%--------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{exam}[\filedate\space Version \fileversion\space by
  Philip Hirschhorn]

\RequirePackage{ifthen}

\newif\if@printanswers
\@printanswersfalse
\DeclareOption{answers}{\@printanswerstrue}
\DeclareOption{noanswers}{\@printanswersfalse}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}




%                         *****************
%                         ** PAGE LAYOUT **
%                         *****************


% We set the parameters in terms of \paperwidth and \paperheight
% so that the options

% a4paper
% a5paper
% b5paper
% letterpaper
% legalpaper
% executivepaper
% landscape

% will all work:

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}

\setlength{\headheight}{15pt}
\setlength{\headsep}{15pt}
\setlength{\topmargin}{0in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength{\footskip}{29pt}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2.2in}

\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{5pt}





%--------------------------------------------------------------------

%                          ****************
%                          ** EXTRAWIDTH **
%                          ****************

\newlength\@extrawidth

% \@rightmargin is needed for \pointsinrightmargin and
% \pointsdroppedatright, so that we can right justify the points:
\newlength\@rightmargin
\setlength{\@rightmargin}{1in}

% We put the argument of \extrawidth into a length so that it will
% work correctly even if it's negative:

\def\extrawidth#1{%
  \@extrawidth=#1
  \advance \textwidth by \@extrawidth
  \divide\@extrawidth by 2
  \advance\oddsidemargin by -\@extrawidth
  \advance\evensidemargin by -\@extrawidth
  % Bug fix, 13 April 2004: 
  %\advance\@rightmargin by \@extrawidth
  \advance\@rightmargin by -\@extrawidth
}




%--------------------------------------------------------------------
%--------------------------------------------------------------------
%             Making room for large headers and footers

% The following are used to save the effect of any changes to 
% \topmargin and \textheight caused by \extraheadheight or
% \extrafootheight commands.  They hold the values currently in effect.
% We put them into lengths so that it will work correctly even if the
% argument is negative:

\newlength\@extrahead
\newlength\@extrafoot
\setlength{\@extrahead}{0in}
\setlength{\@extrafoot}{0in}

% The following are used to hold the requested values for extrahead and
% extrafoot, first page and all pages after the first, and then the
% similar things requested for the cover pages:
\newlength\run@exhd
\newlength\fp@exhd
\newlength\run@exft
\newlength\fp@exft
\newlength\covrun@exhd
\newlength\covfp@exhd
\newlength\covrun@exft
\newlength\covfp@exft

\setlength{\run@exhd}{0in}
\setlength{\fp@exhd}{0in}
\setlength{\run@exft}{0in}
\setlength{\fp@exft}{0in}
\setlength{\covrun@exhd}{0in}
\setlength{\covfp@exhd}{0in}
\setlength{\covrun@exft}{0in}
\setlength{\covfp@exft}{0in}


\newcommand*\adj@hdht@ftht{%
  \if@coverpages
    \ifnum\value{page}=1
      \@setheadheight{\covfp@exhd}%
      \@setfootheight{\covfp@exft}%
    \else
      \@setheadheight{\covrun@exhd}%
      \@setfootheight{\covrun@exft}%
    \fi
  \else
    \ifnum\value{page}=1
      \@setheadheight{\fp@exhd}%
      \@setfootheight{\fp@exft}%
    \else
      \@setheadheight{\run@exhd}%
      \@setfootheight{\run@exft}%
    \fi
  \fi
}


\newcommand*\extraheadheight{%
  \@ifnextchar[{\@xtrahd}{\@ytrahd}%
}

\def\@xtrahd[#1]#2{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#2}%
  \adj@hdht@ftht
}

\def\@ytrahd#1{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\extrafootheight{%
  \@ifnextchar[{\@xtraft}{\@ytraft}%
}

\def\@xtraft[#1]#2{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#2}%
  \adj@hdht@ftht
}

\def\@ytraft#1{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#1}%
  \adj@hdht@ftht
}


\newcommand*\coverextraheadheight{%
  \@ifnextchar[{\cov@xtrahd}{\cov@ytrahd}%
}

\def\cov@xtrahd[#1]#2{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytrahd#1{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextrafootheight{%
  \@ifnextchar[{\cov@xtraft}{\cov@ytraft}%
}

\def\cov@xtraft[#1]#2{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytraft#1{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#1}%
  \adj@hdht@ftht
}

\def\@appendoutput#1{%
  \output=\expandafter{\the\output #1}%
}

\@appendoutput{\adj@hdht@ftht}

%--------------------------------------------------------------------
%                 \setheadheight and \setfootheight:

\def\@setheadheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\topmargin by -\@extrahead
    \global\advance\textheight by \@extrahead
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrahead=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrahead=0in
      \else
        \global\@extrahead=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\topmargin by \@extrahead
    \global\advance\textheight by -\@extrahead
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setheadheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page). 
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
    \global\pagegoal=\textheight
  \endgroup
}

\def\@setfootheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\textheight by \@extrafoot
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrafoot=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrafoot=0in
      \else
        \global\@extrafoot=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\textheight by -\@extrafoot
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setfootheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page). 
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
    \global\pagegoal=\textheight
  \endgroup
}




%---------------------------------------------------------------------
%
%                      *************************
%                      ** HEADERS AND FOOTERS **
%                      *************************
% 
% The pagestyles available are head, foot, headandfoot, and empty.
% \pagestyle{head} prints the head, and gives an empty foot.
% \pagestyle{foot} prints the foot, and gives an empty head.
% \pagestyle{headandfoot} prints both the head and the foot.
% \pagestyle{empty} gives an empty head and an empty foot.
% 

%                            Pagestyles:

\newcommand*\ps@head{%
  \@dohead
  \@nofoot
}

\newcommand*\ps@headandfoot{%
  \@dohead
  \@dofoot
}

\newcommand*\ps@foot{%
  \@nohead
  \@dofoot
}

% \ps@empty is already defined by article.cls, so we'll
% say \def instead of \newcommand*:
\def\ps@empty{%
  \@nohead
  \@nofoot
}

\newif\if@coverpages
\@coverpagesfalse

\newenvironment{coverpages}{%
    \ifnum \value{numquestions}>0
      \ClassError{exam}{%
        Coverpages cannot be used after questions have begun.\MessageBreak
      }{%
        All question, part, subpart, and subsubpart environments
        \MessageBreak
        must begin after the cover pages are complete.\MessageBreak
      }%
    \fi
    \@coverpagestrue
    \pagenumbering{roman}%
    \adj@hdht@ftht
  }{%
    \clearpage
    \pagenumbering{arabic}%
    \adj@hdht@ftht
}

\newcommand*\cover@question@error{%
  \ClassError{exam}{%
    No questions are allowed in the cover pages.\MessageBreak
  }{%
    All question, part, subpart, and subsubpart environments
    \MessageBreak
    must begin after the cover pages are complete.\MessageBreak
  }%
}



\newcommand*\@dohead{%
  \def\@oddhead{%
    \if@coverpages
      \ifnum\value{page}=1
        \cov@fullhead
      \else
        \covrun@fullhead
      \fi
    \else
      \ifnum\value{page}=1
        \@fullhead
      \else
        \run@fullhead
      \fi
    \fi
  }% @oddhead
  \let\@evenhead=\@oddhead
}

\newcommand*\@dofoot{%
  \def\@oddfoot{%
    \if@coverpages
      \ifnum\value{page}=1
        \cov@fullfoot
      \else
        \covrun@fullfoot
      \fi
    \else
      \ifnum\value{page}=1
        \@fullfoot
      \else
        \run@fullfoot
      \fi
    \fi
  }% @oddfoot
  \let\@evenfoot=\@oddfoot
}

\newcommand*\@nohead{%
  \def\@oddhead{}%
  \let\@evenhead=\@oddhead
}

\newcommand*\@nofoot{%
  \def\@oddfoot{}%
  \let\@evenfoot=\@oddfoot
}




%--------------------------------------------------------------------
%       \@fullhead, \run@fullhead, \@fullfoot, and \run@fullfoot:

\newcommand*\@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
    }% hbox
    \if@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}


\newcommand*\run@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\run@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\run@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\run@rhead\strut}}%
    }% hbox
    \ifrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}



% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\@fullfoot{%
  \vbox to 0pt{%
    \if@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\@rfoot}}%
    }% hbox
    \vss
  }% vbox
}


\newcommand*\run@fullfoot{%
  \vbox to 0pt{%
    \ifrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\run@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\run@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\run@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%       \cov@fullhead, \covrun@fullhead, \cov@fullfoot, and
%       \covrun@fullfoot: 

\newcommand*\cov@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\cov@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\cov@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\cov@rhead\strut}}%
    }% hbox
    \ifcov@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}


\newcommand*\covrun@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\covrun@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\covrun@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\covrun@rhead\strut}}%
    }% hbox
    \ifcovrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}



% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\cov@fullfoot{%
  \vbox to 0pt{%
    \ifcov@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\cov@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\cov@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\cov@rfoot}}%
    }% hbox
    \vss
  }% vbox
}


\newcommand*\covrun@fullfoot{%
  \vbox to 0pt{%
    \ifcovrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\covrun@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\covrun@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\covrun@rfoot}}%
    }% hbox
    \vss
  }% vbox
}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%            ********************************************
%            ** COMMANDS TO DEFINE HEADERS AND FOOTERS **
%            ********************************************
%
% \lhead[#1]{#2} sets the first page left head to #1, and the
%   running left head to #2
% 
% \lhead{#1} sets both the first page left head and the running
%   left head to #1
% 
% \chead, \rhead, \lfoot, \cfoot, and \rfoot work similarly.
% 
% 
% \@lhead is the left head for Page 1
% \run@lhead is the running left head
% (i.e., for all pages other than the first)
% 
% \@chead is the center head for Page 1
% \run@chead is the running center head
% (i.e., for all pages other than the first)
% 
% etc.
% 
% Alternative commands are:
% \firstpageheader{LEFT}{CENTER}{RIGHT}
% \runningheader{LEFT}{CENTER}{RIGHT}
% or
% \header{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpageheader{LEFT}{CENTER}{RIGHT}
%          \runningheader{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \firstpagefooter{LEFT}{CENTER}{RIGHT}
% \runningfoother{LEFT}{CENTER}{RIGHT}
% or
% \footer{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpagefooter{LEFT}{CENTER}{RIGHT}
%          \runningfoother{LEFT}{CENTER}{RIGHT}

\def\firstpageheader#1#2#3{%
  \def\@lhead{#1}%
  \def\@chead{#2}%
  \def\@rhead{#3}%
}

\def\runningheader#1#2#3{%
  \def\run@lhead{#1}%
  \def\run@chead{#2}%
  \def\run@rhead{#3}%
}

\def\header#1#2#3{%
  \firstpageheader{#1}{#2}{#3}%
  \runningheader{#1}{#2}{#3}%
}


\def\firstpagefooter#1#2#3{%
  \def\@lfoot{#1}%
  \def\@cfoot{#2}%
  \def\@rfoot{#3}%
}

\def\runningfooter#1#2#3{%
  \def\run@lfoot{#1}%
  \def\run@cfoot{#2}%
  \def\run@rfoot{#3}%
}

\def\footer#1#2#3{%
  \firstpagefooter{#1}{#2}{#3}%
  \runningfooter{#1}{#2}{#3}%
}



\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\def\@lhead{#1}\def\run@lhead{#2}}
\def\@ylhead#1{\def\run@lhead{#1}\def\@lhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\def\@chead{#1}\def\run@chead{#2}}
\def\@ychead#1{\def\run@chead{#1}\def\@chead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\def\@rhead{#1}\def\run@rhead{#2}}
\def\@yrhead#1{\def\run@rhead{#1}\def\@rhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\def\@lfoot{#1}\def\run@lfoot{#2}}
\def\@ylfoot#1{\def\run@lfoot{#1}\def\@lfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\def\@cfoot{#1}\def\run@cfoot{#2}}
\def\@ycfoot#1{\def\run@cfoot{#1}\def\@cfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\def\@rfoot{#1}\def\run@rfoot{#2}}
\def\@yrfoot#1{\def\run@rfoot{#1}\def\@rfoot{#1}}


%                    Initialize head and foot:



\pagestyle{headandfoot}

\lhead{}
\chead{}
\rhead{}
\lfoot{}
\cfoot[]{Page \thepage}
\rfoot{}

%--------------------------------------------------------------------
%                    Coverpage headers and footers
%
% \coverlhead[#1]{#2} sets the first cover page left head to #1, and the
%   running cover left head to #2
% 
% \coverlhead{#1} sets both the first cover page left head and the running
%   cover left head to #1
% 
% \coverchead, \coverrhead, \coverlfoot, \covercfoot, and \coverrfoot
% work similarly.
% 
% 
% \cov@lhead is the left head for Page 1
% \covrun@lhead is the running left head
% (i.e., for all pages other than the first)
% 
% \cov@chead is the center head for Page 1
% \covrun@chead is the running center head
% (i.e., for all pages other than the first)
% 
% etc.
% 
% Alternative commands are:
% \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
% \coverrunningheader{LEFT}{CENTER}{RIGHT}
% or
% \coverheader{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
%          \coverrunningheader{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
% \coverrunningfoother{LEFT}{CENTER}{RIGHT}
% or
% \coverfooter{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
%          \coverrunningfoother{LEFT}{CENTER}{RIGHT}

\def\coverfirstpageheader#1#2#3{%
  \def\cov@lhead{#1}%
  \def\cov@chead{#2}%
  \def\cov@rhead{#3}%
}

\def\coverrunningheader#1#2#3{%
  \def\covrun@lhead{#1}%
  \def\covrun@chead{#2}%
  \def\covrun@rhead{#3}%
}

\def\coverheader#1#2#3{%
  \coverfirstpageheader{#1}{#2}{#3}%
  \coverrunningheader{#1}{#2}{#3}%
}


\def\coverfirstpagefooter#1#2#3{%
  \def\cov@lfoot{#1}%
  \def\cov@cfoot{#2}%
  \def\cov@rfoot{#3}%
}

\def\coverrunningfooter#1#2#3{%
  \def\covrun@lfoot{#1}%
  \def\covrun@cfoot{#2}%
  \def\covrun@rfoot{#3}%
}

\def\coverfooter#1#2#3{%
  \coverfirstpagefooter{#1}{#2}{#3}%
  \coverrunningfooter{#1}{#2}{#3}%
}



\def\coverlhead{\@ifnextchar[{\cov@xlhead}{\cov@ylhead}}
\def\cov@xlhead[#1]#2{\def\cov@lhead{#1}\def\covrun@lhead{#2}}
\def\cov@ylhead#1{\def\covrun@lhead{#1}\def\cov@lhead{#1}}

\def\coverchead{\@ifnextchar[{\cov@xchead}{\cov@ychead}}
\def\cov@xchead[#1]#2{\def\cov@chead{#1}\def\covrun@chead{#2}}
\def\cov@ychead#1{\def\covrun@chead{#1}\def\cov@chead{#1}}

\def\coverrhead{\@ifnextchar[{\cov@xrhead}{\cov@yrhead}}
\def\cov@xrhead[#1]#2{\def\cov@rhead{#1}\def\covrun@rhead{#2}}
\def\cov@yrhead#1{\def\covrun@rhead{#1}\def\cov@rhead{#1}}

\def\coverlfoot{\@ifnextchar[{\cov@xlfoot}{\cov@ylfoot}}
\def\cov@xlfoot[#1]#2{\def\cov@lfoot{#1}\def\covrun@lfoot{#2}}
\def\cov@ylfoot#1{\def\covrun@lfoot{#1}\def\cov@lfoot{#1}}

\def\covercfoot{\@ifnextchar[{\cov@xcfoot}{\cov@ycfoot}}
\def\cov@xcfoot[#1]#2{\def\cov@cfoot{#1}\def\covrun@cfoot{#2}}
\def\cov@ycfoot#1{\def\covrun@cfoot{#1}\def\cov@cfoot{#1}}

\def\coverrfoot{\@ifnextchar[{\cov@xrfoot}{\cov@yrfoot}}
\def\cov@xrfoot[#1]#2{\def\cov@rfoot{#1}\def\covrun@rfoot{#2}}
\def\cov@yrfoot#1{\def\covrun@rfoot{#1}\def\cov@rfoot{#1}}


%                 Initialize coverpage head and foot:


\coverlhead{}
\coverchead{}
\coverrhead{}
\coverlfoot{}
\covercfoot{}
\coverrfoot{}




%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                      Headrules and footrules:

\newif\if@headrule
\newif\ifrun@headrule

\def\firstpageheadrule{\@headruletrue}
\def\nofirstpageheadrule{\@headrulefalse}

\def\runningheadrule{\run@headruletrue}
\def\norunningheadrule{\run@headrulefalse}

\def\headrule{\@headruletrue\run@headruletrue}
\def\noheadrule{\@headrulefalse\run@headrulefalse}



\newif\if@footrule
\newif\ifrun@footrule

\def\firstpagefootrule{\@footruletrue}
\def\nofirstpagefootrule{\@footrulefalse}

\def\runningfootrule{\run@footruletrue}
\def\norunningfootrule{\run@footrulefalse}

\def\footrule{\@footruletrue\run@footruletrue}
\def\nofootrule{\@footrulefalse\run@footrulefalse}



%                             Initialize:

\noheadrule
\nofootrule


%                 Cover page headrules and footrules:

\newif\ifcov@headrule
\newif\ifcovrun@headrule

\def\coverfirstpageheadrule{\cov@headruletrue}
\def\nocoverfirstpageheadrule{\cov@headrulefalse}

\def\coverrunningheadrule{\covrun@headruletrue}
\def\nocoverrunningheadrule{\covrun@headrulefalse}

\def\coverheadrule{\cov@headruletrue\covrun@headruletrue}
\def\nocoverheadrule{\cov@headrulefalse\covrun@headrulefalse}



\newif\ifcov@footrule
\newif\ifcovrun@footrule

\def\coverfirstpagefootrule{\cov@footruletrue}
\def\nocoverfirstpagefootrule{\cov@footrulefalse}

\def\coverrunningfootrule{\covrun@footruletrue}
\def\nocoverrunningfootrule{\covrun@footrulefalse}

\def\coverfootrule{\cov@footruletrue\covrun@footruletrue}
\def\nocoverfootrule{\cov@footrulefalse\covrun@footrulefalse}



%                             Initialize:

\nocoverheadrule
\nocoverfootrule



%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                \numpages, \iflastpage, and \oddeven
%     Also: \numpoints, \numquestions, \numparts, and \numsubparts
%                    Also also: \pointsofquestion

% Make the number of pages available as the macro \numpages,
% the number of points as \numpoints,
% the number of questions as \numquestions,
% the number of parts as \numparts, and
% the number of subparts as \numsubparts
%\def\numpages{\pageref{@lastpage}}
%\def\numpoints{\pageref{@numpoints}}
%\def\numquestions{\pageref{@numquestions}}
%\def\numparts{\pageref{@numparts}}
%\def\numsubparts{\pageref{@numsubparts}}
%\def\numsubsubparts{\pageref{@numsubsubparts}}

% This was previously done with \pageref commands.  When I eliminated
% all \label, \ref, and \pageref commands in order to make this
% compatible with hyperref.sty, this stuff was created:

% \gdef commands for exam@lastpage, exam@numpoints, exam@numquestions,
% exam@numparts, exam@numsubparts and exam@numsubsubparts are written to
% the .aux file via \AtEndDocument.

% \gdef commands for pointsofq@i, pointsofq@ii, etc. are written to the
% .aux file as each question is completed (see the definition of the
% questions environment).

% \gdef commands for pointsonpage@i, pointsonpage@ii, etc. are written
% to the .aux file as we encounter points defined for a later page, and
% for the last such page with AtEndDocument.

\def\numpages{\@ifundefined{exam@lastpage}%
  {\mbox{\normalfont\bf ??}}%
  \exam@lastpage
}

\def\numpoints{\@ifundefined{exam@numpoints}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numpoints
}

\def\numquestions{\@ifundefined{exam@numquestions}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numquestions
}

\def\numparts{\@ifundefined{exam@numparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numparts
}

\def\numsubparts{\@ifundefined{exam@numsubparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numsubparts
}

\def\numsubsubparts{\@ifundefined{exam@numsubsubparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numsubsubparts
}

\def\pointsofquestion#1{\@ifundefined{pointsofq@\romannumeral #1}%
  {\mbox{\normalfont\bf ??}}%
  {\csname pointsofq@\romannumeral #1\endcsname}%
}

\def\pointsonpage#1{\@ifundefined{pointsonpage@\romannumeral #1}%
  {\mbox{\normalfont\bf ??}}%
  {\csname pointsonpage@\romannumeral #1\endcsname}%
}


\newif\if@pointschanged
\@pointschangedfalse



%%%\let\@realenddocument=\enddocument
%%%\def\enddocument{\clearpage
%%%   \if@filesw 
%%%     {\advance\c@page-1 \immediate\write\@mainaux
%%%       {\string\newlabel{@lastpage}{{}{\arabic{page}}}}%
%%%     }
%%%   \fi
%%%   \@realenddocument
%%%}


\AtEndDocument{%
  \clearpage
  \if@filesw
    \advance\c@page-1
    \immediate\write\@mainaux
      {\string\gdef\string\exam@lastpage{\arabic{page}}}%
    \advance\c@page+1 % In case some other package looks at \c@page
    \immediate\write\@mainaux
        {\string\gdef\string\exam@numpoints{\prtaux@hlfcntr{numpoints}}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{exam@numpoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\exam@numpoints}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \edef\pt@check{\prtaux@hlfcntr{numpoints}}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numquestions{\thenumquestions}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numparts{\thenumparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubparts{\thenumsubparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubsubparts{\thenumsubsubparts}}%
    \ifnum \thepageof@pagepoints > 0\relax
      \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
      % See if this has changed from the last run of LaTeX:
      \@ifundefined{pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname}%
        {\global\@pointschangedtrue}%
        {%
        % OK; it's defined.  See if it's changed:
        \begingroup
          \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral 
                    \csname c@pageof@pagepoints\endcsname\endcsname}%
          \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
          \edef\pt@check{\prtaux@hlfcntr{@pagepoints}}%
          \ifx \pt@check \othpt@check
            % Do nothing
          \else
            \global\@pointschangedtrue
          \fi
        \endgroup
        }%
    \fi
    \immediate\write\@mainaux
      {\string\gdef\string\lastpage@withpoints{\page@withpoints}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{lastpage@withpoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \edef\othpt@check{\page@withpoints}%
        \edef\pt@check{\lastpage@withpoints}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
  \fi
  % Echo numbers of questions, parts, and subparts:
  \typeout{This exam contains \thenumquestions\space questions
    with \thenumparts\space parts, \thenumsubparts\space subparts,
    and \thenumsubsubparts\space subsubparts.}
  % If counting points, echo total points:
  \if@printtotalpoints
    \begingroup
      \def\typ@expnd{%
        \thenumpoints
        \ifnumpoints@half
          \space and a half%
        \fi
      }
      \typeout{This exam has a total of \typ@expnd\space points.}
    \endgroup
  \fi
  \if@pointschanged
    \ClassWarningNoLine{exam}{Point totals have changed.
               Rerun to get point totals right}%
  \fi
}


% We define \iflastpage so that it can safely be used
% in headers and footers:
\def\iflastpage#1#2{%
  \@ifundefined{exam@lastpage}{\def\@@lastpage{-1}}%
          {\edef\@@lastpage{\exam@lastpage}}%
  \ifnum\value{page}=\@@lastpage
    #1%
  \else
    #2%
  \fi
}


% The macro \oddeven takes two arguments.  If the page number is odd,
% then you get the first argument; otherwise, you get the second
% argument.
\def\oddeven#1#2{%
  \ifodd\value{page}%
    #1
  \else
    #2
  \fi
}



%--------------------------------------------------------------------
%--------------------------------------------------------------------
%                 \ifcontinuation, \ContinuedQuestion,
%                \ifincomplete, and \IncompleteQuestion

% The commands \ifcontinuation, \ContinuedQuestion, \ifincomplete, and
% \IncompleteQuestion assume that there is only one questions
% environment in the entire document.  (Actually, \ContinuedQuestion
% should work even if there are multiple questions environments, but
% none of the other three will work in general.)



% \PgInfo@write, \PgInfo and \PgInfo@get are our replacements
% for \label, \newlabel, and \pageref.  (We're avoiding using
% \label, \newlabel, and \pageref so that we will be compatible
% with hyperref.sty, which redefines those commands.)

% We use \PgInfo, \PgInfo@write, and \PgInfo@get to know on which page
% each question, part, subpart, and subsubpart appears.

% We use \PgInfo@write to write \PgInfo commands to the .aux file.  The
% \PgInfo command takes two arguments: A question (or part, or subpart,
% or subsubpart) label, and the number of the page on which it appears.

% The label for a question is of the form `question@2' (if it's question
% 2).

% The label for a part is of the form `part@2@1' (if it's part a of
% question 2).

% The label for a subpart is of the form `subpart@2@1@3' (if it's
% subpart iii of part a of question 2).

% The label for a subsubpart is of the form `subsubpart@2@1@3@4' (if
% it's subsubpart $\delta$ of subpart iii of part a of question 2).

% The \PgInfo command defines a control sequence of the form `Pg@label'
% that expands to the page number for the corresponding question.  For
% example, \PgInfo{subsubpart@2@1@3@4}{7} defines 
%   \csname Pg@subsubpart@2@1@3@4\endcsname 
% to expand to 7.

% The \PgInfo@get{label} command returns the value of the macro Pg@label,
% but it *doesn't* check whether that macro is defined.  Thus, it's
% important to check that the macro Pg@label is defined before giving the
% command \PgInfo@get{label}.



% The token list to a \write command isn't expanded until
% it's shipped out.  Since the argument to PgInfo@write
% generally contains macros, we want to expand those macros
% now, rather than waiting until this is shipped out, at which
% point the macros may have different values.  Thus, we use
% \edef to force expansion of the argument, and we put
% a \noexpand in front of \thepage so that the \thepage
% will not be expanded now.  (This may not get shipped out
% until a later page, and so we want the \thepage to be expanded
% only when it's shipped out.)
% We use the \begingroup \endgroup pair so that our use
% of \reserved@a won't affect its use anywhere else.
\def\PgInfo@write#1{%
  \begingroup
    \edef\reserved@a{\write\@mainaux
      {\string\PgInfo{#1}{\noexpand\thepage}}}%
    \reserved@a
  \endgroup
}

%\PgInfo commands are written to the .aux file by the \PgInfo@write
%command; that's the only place that \PgInfo commands appear.
\def\PgInfo#1#2{\expandafter\gdef\csname Pg@#1\endcsname{#2}}

% Note: PgInfo@get assumes that the control sequence being
% constructed is already defined; you have to make sure of this
% *before* calling \Pginfo@get
\def\PgInfo@get#1{\csname Pg@#1\endcsname}

% \set@counter@to@pageof takes two arguments: The first is the name
% of a counter, and the second (expands to) the label of a question,
% part, subpart, or subsubpart.  If that label exists, then we set
% the counter equal to the page on which the question (or part, etc.)
% appears.  If that label doesn't exist, we set the counter equal
% to -1.  (No labels exist on the first run of LaTeX on the file,
% and if a new question (or part, etc.) was created by editing the
% file, then the label will not exist until the second run of LaTeX
% after that.
\def\set@counter@to@pageof#1#2{%
  \@ifundefined{Pg@#2}%
  {\setcounter{#1}{-1}}%
  {\setcounter{#1}{\csname Pg@#2\endcsname}}%
}


%--------------------------------------------------------------------

% \ifcontinuation#1#2 expands to #2 if either: (1) The current page is
% before the page containing question number 1, or (2) A question begins
% on this page before any part, subpart, or subsubpart begins, or (3)
% The current page is later than a page with the \nomorequestions
% command.  Otherwise, it expands to #1.


\def\ifcontinuation#1#2{%
  % We need to first check whether we're on a page *before* the page on
  % which the first question appears.  If we don't yet know which page
  % has question number 1, then we must be doing an early run of LaTeX,
  % and we'll assume we're not a continuation.
  \expandafter\ifx\csname Pg@question@1\endcsname\relax
    % No page info yet; assume not a continuation
    #2%
  \else
    % Note: The ``\relax'' at the end of the following \ifnum
    % serves an entirely different purpose from the one at the
    % end of the above \expandafter\ifx.  That one (above)
    % is one of the things being compared, whereas the
    % one we're about to use is just to clearly mark the
    % end of the second number being compared by the \ifnum
    % (since it's conceivable that the ``#2'' would begin
    % with a digit).
    \ifnum \thepage < \csname Pg@question@1\endcsname\relax
      % We're before the page with question 1:
      #2%
    \else
      % The current page begins a new question if Contin@\thepage
      % has been defined as a macro that expands to \relax
      % (Note that this is different from if Contin@\thepage
      % has never been defined at all, in which case it will
      % be let equal to \relax (temporarily) by the \csname command.)
      \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
        #2%
      \else
        % See if we're after a \nomorequestions command:
        \@ifundefined{Pg@@endquestions}%
        {#1}%
        {\ifnum \thepage > \PgInfo@get{@endquestions}\relax
          % We're after a \nomorequestions:
          #2
         \else
           % We actually are incomplete:
           #1
         \fi
        }%
      \fi
    \fi 
  \fi
}

\def\nomorequestions{
  \PgInfo@write{@endquestions}%
}



%--------------------------------------------------------------------
% \ContinuedQuestion is for use in headers and footers, where we can
% assume that \thepage is the number of the page on which we'll
% actually appear.

% \ContinuedQuestion expands to the number of the question that
% continues onto this page, or to -1 if this page begins with a new
% question.

% ACTUALLY: \ContinuedQuestion expands to a positive number if either
% (1) this page doesn't contain the beginning of any question, part,
% subpart, or subsubpart, or (2) this page has a part, subpart, or
% subsubpart that appears before any question.  That means that if the
% current page actually begins with space for a continuation of the
% previous question (but doesn't begin any part, subpart, or subsubpart
% of that question) and then has a question, then we'll be asserting
% that this page begins with a new question, but the actual top of the
% page will begin with some blank space that's intended for the previous
% question.

% \ContinuedQuestion works by examining the value of the macro
% Contin@\thepage.  If this page starts with a question (i.e., if no
% question continues onto this page), then the macro Contin@\thepage
% will be defined, and will expand to `\relax' (and so an \ifx between
% \csname Contin@\thepage\endcsname and \ref@relax will be true).

% If Contin@\thepage is undefined, then when it is used in an \ifx
% command it will be temporarily set equal to \relax (which is
% *different* from being a macro that expands to \relax); in this case,
% there is no question, part, subpart, or subsubpart that begins on this
% page, and so \ContinuedQuestion will be set equal to the last question
% that was begun on a page before this one.

% The last possibility is that this page begins with either a part,
% subpart, or subsubpart.  In this case, Contin@\thepage is defined, and
% it expands to the number of the question that is continues onto this
% page.


\def\ref@relax{\relax}

\def\ContinuedQuestion{%
  \expandafter\ifx\csname Contin@\thepage\endcsname\relax
    % We get here if there's no question, part, subpart, or
    % subsubpart on this page, and so Contin@\thepage has
    % never been defined at all.  In that case, this page
    % continues whichever question was last begun on or 
    % before this page.
    \find@latestques
    \thelatest@ques
  \else
    \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
      % We get here if this page begins with a new question,
      % which is why Contin@\thepage has been defined to be
      % a macro that expands to \relax.
      % ACTUALLY: We get here if this page has a question that
      % appears before any part, subpart, or subsubpart.  That
      % means that if the current page actually begins with space
      % for a continuation of the previous question but doesn't begin
      % any part, subpart, or subsubpart of that question, then
      % we'll be asserting that this page begins with a new question,
      % but the actual top of the page will begin with some space
      % that's intended for the previous question.
      -1\relax
    \else
      % We get here if we didn't get anywhere above.  This happens
      % if Contin@\thepage has been defined to be a macro that expands
      % to something other than \relax, in which case it has been
      % defined to be a macro that expands to the number of the
      % question that continues onto this page.
      \csname Contin@\thepage\endcsname
    \fi
  \fi
}

%--------------------------------------------------------------------
% \find@latestques is for use in headers and footers, where we can
% assume that \thepage actually equals the page on which we'll appear.
% We find the last question that was started on or before the current
% page.

\newcounter{latest@ques}

\newcommand\find@latestques{%
  % \find@latestques is for use in headers and footers.
  % \find@latestques will set the counter latest@ques
  % to the number of the last question
  % that was begun on the exam from page 1 through the current
  % page.  This may well be the value of the question counter,
  % but it may be less than that if the page following this one
  % begins a new question and that question beginning was
  % typeset before the present page was shipped out.
  % Note: This macro is called both by \ContinuedQuestion and by
  % \find@quesend, which is why it has to find the last question
  % begun on or before the current page, rather than just before
  % the current page.
  \ifnum 1 > \arabic{question}\relax
    % Oops; probably because we're before the first question
    % Just set latest@ques to -1:
    \setcounter{latest@ques}{-1}%
  \else
    % If question latest@ques actually begins on this page (rather
    % than on the next page, but early enough on the next page
    % that the counter was advanced before we ran off into the
    % output routine to output the page and set the header and 
    % footer), then that's the correct question number.
    \expandafter\ifx\csname Pg@question@\arabic{question}\endcsname\relax
      % We don't know what page that question is on;
      % this must be an early run, before the aux file
      % is helpful.  Just set it equal to -1 and wait until the next
      % run to get it right.
      \setcounter{latest@ques}{-1}%
    \else
      % We now know that \PgInfo@get can tell us the page number
      % of \arabic{question} and of all earlier questions.
      % Set latest@ques equal to the current question number, and
      % then call \decr@latest@ques to recursively decrement
      % latest@ques as needed to find a question that begins on
      % or before the current page:
      \setcounter{latest@ques}{\arabic{question}}%
      \decr@latest@ques
    \fi
  \fi
}

\def\decr@latest@ques{%
  % If we get here, then we've already checked that the reference
  % Pg@question@\thelatest@ques is defined at least for a value of
  % \thelatest@ques greater than or equal to it's present value,
  % so we assume it's defined for all lesser values as well:
  \ifnum \thepage < \PgInfo@get{question@\thelatest@ques}\relax
    % Nope; latest@ques starts on a later page
    % Decrement latest@ques and see if that one's right:
    \addtocounter{latest@ques}{-1}%
    \ifnum \thelatest@ques < 1\relax
      \setcounter{latest@ques}{-1}%
      \let\next@dlq=\relax
    \else
      \let\next@dlq=\decr@latest@ques
    \fi
  \else
    % latest@ques starts on this page or earlier, so
    % that's the correct question number!  Exit:
    \let\next@dlq=\relax
  \fi
  \next@dlq
}
         


%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
\newcounter{ques@end}
\def\find@quesend{%
  % We find the last question started on or before the current page
  % and then find the page containing the last part (or subpart, or
  % subsubpart) of that question, and set the counter ques@end to that
  % page number.
  % Set latest@ques equal to the correct question number:
  \find@latestques
  \ifnum \value{latest@ques} < 0\relax
    % This must be an early run of LaTeX, before we have
    % \PgInfo commands in the .aux file:
    \setcounter{ques@end}{-1}%
  \else
    % See if this question has any parts.  (It has one or more parts
    % if and only if it has a part number 1.)
    \@ifundefined{Pg@part@\thelatest@ques @1}%
      {%
        % Nope; no parts.
        \setcounter{ques@end}{\PgInfo@get{question@\thelatest@ques}}%
      }%
      {\find@part}%
  \fi
}

\newcounter{last@part}
\def\find@part{%
  % We now know that this question has at least one part.
  % We'll find its highest numbered part by setting last@part
  % equal to 2 and then calling \find@lastpart to recursively
  % test whether that part number exists and, if so, incrementing
  % last@part to test for a higher numbered one:
  \setcounter{last@part}{2}%
  \find@lastpart
  % Now: See if this part has any subparts.  (It has one or more
  % subparts if and only if it has a subpart numbered 1.)
  \@ifundefined{Pg@subpart@\thelatest@ques @\thelast@part @1}%
    {%
      % Nope; no subparts.
      \setcounter{ques@end}{\PgInfo@get{part@\thelatest@ques
                                          @\thelast@part}}%
    }%
    {\find@subpart}%
}

\def\find@lastpart{%
  % We check whether this question has a part numbered last@part
  % and recursively increment last@part to find the highest
  % numbered value for which the part exists:
  \@ifundefined{Pg@part@\thelatest@ques @\thelast@part}%
    {\addtocounter{last@part}{-1}%
      \let\nextfind@lastpart=\relax
    }%
    {\addtocounter{last@part}{1}%
      \let\nextfind@lastpart=\find@lastpart
    }%
  \nextfind@lastpart
}

\newcounter{last@subpart}
\def\find@subpart{%
  % We now know that this part has at least one subpart.
  % We'll find its highest numbered subpart by setting last@subpart
  % equal to 2 and then calling \find@lastsubpart to recursively
  % test whether that subpart number exists and, if so, incrementing
  % last@subpart to test for a higher numbered one:
  \setcounter{last@subpart}{2}%
  \find@lastsubpart
  % Now: See if this subpart has any subsubparts.  (It has one or more
  % subsubparts if and only if it has a subsubpart numbered 1.)
  \@ifundefined{Pg@subsubpart@\thelatest@ques 
                         @\thelast@part @\thelast@subpart @1}%
    {%
      % Nope; no subsubparts
      \setcounter{ques@end}{\PgInfo@get{subpart@\thelatest@ques
                                  @\thelast@part @\thelast@subpart}}%
    }%
    {\find@subsubpart}%
}

\def\find@lastsubpart{%
  % We check whether this part has a subpart numbered last@subpart
  % and recursively increment last@subpart to find the highest
  % numbered value for which the subpart exists:
  \@ifundefined{Pg@subpart@\thelatest@ques 
                         @\thelast@part @\thelast@subpart}%
    {\addtocounter{last@subpart}{-1}%
      \let\nextfind@lastsubpart=\relax
    }%
    {\addtocounter{last@subpart}{1}%
      \let\nextfind@lastsubpart=\find@lastsubpart
    }%
  \nextfind@lastsubpart
}

\newcounter{last@subsubpart}
\def\find@subsubpart{%
  % We now know that this subpart has at least one subsubpart.
  % We'll find its highest numbered subsubpart by setting last@subsubpart
  % equal to 2 and then calling \find@lastsubsubpart to recursively
  % test whether that subsubpart number exists and, if so, incrementing
  % last@subsubpart to test for a higher numbered one:
  \setcounter{last@subsubpart}{2}%
  \find@lastsubsubpart
  \setcounter{ques@end}{\PgInfo@get{subsubpart@\thelatest@ques
               @\thelast@part @\thelast@subpart @\thelast@subsubpart}}%
}

\def\find@lastsubsubpart{%
  % We check whether this subpart has a subsubpart numbered last@subsubpart
  % and recursively increment last@subsubpart to find the highest
  % numbered value for which the subsubpart exists:
  \@ifundefined{Pg@subsubpart@\thelatest@ques 
              @\thelast@part @\thelast@subpart @\thelast@subsubpart}%
    {\addtocounter{last@subsubpart}{-1}%
      \let\nextfind@lastsubsubpart=\relax
    }%
    {\addtocounter{last@subsubpart}{1}%
      \let\nextfind@lastsubsubpart=\find@lastsubsubpart
    }%
  \nextfind@lastsubsubpart
}


%--------------------------------------------------------------------
\newcounter{incmp@ques}

\def\IncompleteQuestion{%
  \Find@Incmp@ques
  \theincmp@ques
}

\def\Find@Incmp@ques{%
  \iflastpage{\setcounter{incmp@ques}{-1}}{\chk@incomp}%
}
\newcounter{next@ques}
\newcounter{nextq@page}
\def\chk@incomp{%
  \find@quesend
  \ifnum \theques@end > \thepage\relax
    % This question has a part (or sub...) starting on a later page
    \setcounter{incmp@ques}{\value{latest@ques}}%
  \else
    \setcounter{next@ques}{\thelatest@ques}%
    \addtocounter{next@ques}{1}%
    \expandafter\ifx\csname Pg@question@\thenext@ques \endcsname\relax
      % This isn't the last page but there is no next question:
      \setcounter{incmp@ques}{\thelatest@ques}%
    \else
      % This isn't the last page and there is a next question:
      \setcounter{nextq@page}{\PgInfo@get{question@\thenext@ques}}%
      \addtocounter{nextq@page}{-1}%
      \ifnum \thenextq@page > \thepage\relax
        \setcounter{incmp@ques}{\thelatest@ques}%
      \else
        \setcounter{incmp@ques}{-1}%
      \fi
    \fi
  \fi
}


\def\ifincomplete#1#2{%
  \def\incomp@first{#1}%
  \def\incomp@second{#2}%
  \Find@Incmp@ques
  \ifnum \theincmp@ques < 0\relax
    \incomp@second
  \else
        \@ifundefined{Pg@@endquestions}%
        {\incomp@first}%
        {\ifnum \thepage < \PgInfo@get{@endquestions}%
           \incomp@first
         \else
           \incomp@second
         \fi
        }%
  \fi
}




%---------------------------------------------------------------------
%
%                    ***************************
%                    ** QUESTION ENVIRONMENTS **
%                    ***************************
%
%
%

% We define the command \part only inside of a parts environment, so
% that we don't interfere with the meaning of the standard article
% documentclass command \part if that is used inside of a questions
% environment.  The commands \question, \subpart, and \subsubpart are
% defined everywhere inside of a questions environment.  If the user
% accidentally gives a \subpart command outside of a subparts
% environment, then an error will be created.


%--------------------------------------------------------------------
% These are the commands for dealing with hlfcntr's, i.e., the things
% used to count points.
%
% A point value is a nonnegative integer with an optional half integer.
% A hlfcntr consists of a regular counter together with an \if: If the
% regular counter is called ``counter'', then the \if is called
% ``\ifcounter@half''; it's set true by ``\counter@halftrue'' and set
% false by ``\counter@halffalse''.
%
% The commands:
%
% \set@hlfcntr{countername}{value}
% \copy@hlfcntr{tocounter}{fromcounter}
% \addto@hlfcntr{countername}{value}
% \add@hlfcntrtohlfcntr
% \ifhlfcntr@pos{countername}
% \prtaux@hlfcntr{countername}
%
% ``value'' can be either a (nonnegative) integer, an integer followed by
% ``\half'', or just plain ``\half''.  (Actually, ``value'' can be empty
% (although the braces must be present), in which case it's interpreted
% as ``0''.)
%
% Examples of valid values:
%   0
%   0\half
%   1
%   1\half
%   2
%   2\half
% etc.

% Note on using ``\global'': LaTeX's \setcounter and \addtocounter
% commands are already \global (i.e., you don't have to say
% ``\global''), but \somethingtrue and \somethingfalse (used to set
% \ifsomething) aren't.  Thus, we need to say ``\global'' when setting
% these things.

% A scratch hlfcntr:
\newcounter{tmp@hlfcntr}
\newif\iftmp@hlfcntr@half

\newcommand*\horiz@half{$\frac{1}{2}$}
\newcommand*\slanted@half{%
  $\raise0.6ex\hbox{$\scriptstyle 1$}\kern -.2em/\kern -.2em
     \raise-0.5ex\hbox{$\scriptstyle 2$}$%
}
\newcommand*\useslantedhalf{\let\half\slanted@half}
\newcommand*\usehorizontalhalf{\let\half\horiz@half}
\newcommand*\half{\slanted@half}


\newcommand*\set@hlfcntr[2]{%
  \begingroup
    \expandafter\global\csname #1@halffalse\endcsname
    % If there as a `\half' present, it will be executed
    % right after the assignment of the digit part of #2
    % to the counter #1.
    \def\half{%
      \expandafter\global\csname #1@halftrue\endcsname
    }%
    % We insert a `0' in case there are no digits present:
    \setcounter{#1}{0#2}\relax
  \endgroup
}

\newcommand*\copy@hlfcntr[2]{%
  % We set #1 to the value of #2
  \setcounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \expandafter\global\csname #1@halftrue\endcsname
  \else
    \expandafter\global\csname #1@halffalse\endcsname
  \fi
}

\newcommand*\addto@hlfcntr[2]{%
  % We add the valueandhalf #2 to hlfcntr #1
  \begingroup
    \def\half{\add@half{#1}}%
    % We insert a `0' in case there are no digits present:
    \addtocounter{#1}{0#2}\relax
  \endgroup
}

\newcommand*\add@hlfcntrtohlfcntr[2]{%
  % We add the hlfcntr #2 to the hlfcntr #1
  \addtocounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \add@half{#1}%
  \fi
}

\newcommand*\add@half[1]{%
  % We add one half to hlfcntr #1:
  \csname if#1@half\endcsname
    \addtocounter{#1}{1}%
    \expandafter\global\csname #1@halffalse\endcsname
  \else
    \expandafter\global\csname #1@halftrue\endcsname
  \fi
}

\newcounter{ifpos@cntr}
\def\ifhlfcntr@pos#1{%
  % The argument must be a hlfcntr (which, of course,
  % can never be negative); we'll be true if and only if
  % that halfcntr is positive:
  \setcounter{ifpos@cntr}{\value{#1}}%
  \csname if#1@half\endcsname
    \addtocounter{ifpos@cntr}{1}%
  \fi
  \ifnum \value{ifpos@cntr} > 0
}

% \prtaux@hlfcntr is used inside the argument of a \write command for
% writing to the .aux file:
\newcommand*\prtaux@hlfcntr[1]{%
  % We don't want a \relax after the 0 in the following
  % line, because it would sometimes appear in the aux file:
  \ifnum \value{#1} = 0 
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prtaux@halforzero{#1}%
  \else
    \arabic{#1}%
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prtaux@halforblank{#1}%
  \fi
}
\newcommand*\prtaux@halforzero[1]{%
  \csname if#1@half\endcsname
    \string\half
  \else
    0%
  \fi
}
\newcommand*\prtaux@halforblank[1]{%
  \csname if#1@half\endcsname
    \string\half
  \fi
}
%--------------------------------------------------------------------




% We use the counter name `partno' for the parts environment so that
% we will not interfere with the counter `part' used by the article
% document class.

\newcounter{question}
\newcounter{partno}
\newcounter{subpart}
\newcounter{subsubpart}
\newcounter{choice}
\newcounter{numpoints}
\newif\ifnumpoints@half
\set@hlfcntr{numpoints}{0}
\newcounter{pointsof@thisquestion}
\newif\ifpointsof@thisquestion@half
\set@hlfcntr{pointsof@thisquestion}{0}
\newcounter{numquestions}
\newcounter{numparts}
\newcounter{numsubparts}
\newcounter{numsubsubparts}
\newcounter{Curr@Page}

% @pagepoints accumulates the points on a single page:
\newcounter{@pagepoints}
\newif\if@pagepoints@half
%\setcounter{@pagepoints}{0}
\set@hlfcntr{@pagepoints}{0}
\newcounter{pageof@pagepoints}
\setcounter{pageof@pagepoints}{0}

% latest@points is a holding area for points until we know
% whether they'll land on the same page as the points
% currently counted in @pagepoints:
\newcounter{latest@points}
\newif\iflatest@points@half
\set@hlfcntr{latest@points}{0}

% Whenever we meet a new page on which points are defined, we'll
% redefine \page@withpoints to expand to that page.  At the end of the
% document, it will hold the last page that has points, and we'll write
% a \gdef\lastpage@withpoints command to the .aux file.
% We initialize \page@withpoints here:
\def\page@withpoints{0}%

% \pageinfo@commands is used by each question, part, subpart, and
% subsubpart to insert into everypar the \PgInfo@write command to put
% its page number inot the .aux file, the \PgInfo@get command to read
% the page number into the counter Curr@Page, and to test and set
% \Contin@\theCurr@Page.  \temp@toks is used by part, subpart, and
% subsubpart to append all that to \pageinfo@commands, rather than
% deleting whatever may have been put into \pageinfo@commands by the
% current question and/or part and/or subpart.
\newtoks\pageinfo@commands
\newtoks\temp@toks

% \pagepoint@commands holds the commands to manage the counting of the
% number of points defined on each page.
\newtoks\pagepoint@commands

% \point@toks holds the commands to print the points at the proper
% location on the page (except that it's not used by the \qformat
% option).
\newtoks\point@toks

% We'll use \greeknum to number subsubparts
\def\greeknum#1{\expandafter\lc@greek\csname c@#1\endcsname}
\def\lc@greek#1{%
  \ifcase #1\or $\alpha$\or $\beta$\or $\gamma$\or $\delta$\or
  $\epsilon$\or $\zeta$\or $\eta$\or $\theta$\or $\iota$\or
  $\kappa$\or $\lambda$\or $\mu$\or $\nu$\or $\xi$\or o\or $\pi$\or
  $\rho$\or $\sigma$\or $\tau$\or $\upsilon$\or $\phi$\or $\chi$\or
  $\psi$\or $\omega$\else \@ctrerr
  \fi
}%


% The following macros are a variation on a trick from Victor
% Eijkhout's ``TeX by Topic'', page 142:
% Both \prepend@toklist and \append@toklist take two arguments,
% both of which should be token lists.
% \prepend@toklist prepends #2 to #1
% \append@toklist appends #2 to #1

\def\prepend@toklist#1#2{%
  \edef\do@it{\noexpand#1={\the#2\the#1}}%
  \do@it
}%

\def\append@toklist#1#2{%
  \edef\do@it{\noexpand#1={\the#1\the#2}}%
  \do@it
}%


% The command \qformat is provided for the user who wants to
% design a nonstandard question line.  If this command is used,
% then the usual line containing the question numbers will be
% replaced by the line specified by the \qformat command.
% Within the argument of the \qformat command:
% \thequestion will be replaced by the question number, and
% \thepoints will be replaced by ``\@points \@pointname'' if the
% number of points has been specified for this question, and otherwise
% it inserts nothing at all.  (The conditional @placepoints is used to
% determine if the number of points is nonzero.)
% The argument to the \qformat command *must* contain some
% stretch, i.e., at least one \hfil or \dotfill or ...
\newif\if@qformat
\@qformatfalse

\def\qformat#1{%
  \global\@qformattrue
  \gdef\@questionformat{#1}%
}

\newcommand\noqformat{%
  \global\@qformatfalse
}

\newcommand\thepoints{%
  \if@placepoints
    \@points \@pointname
  \fi
}

% We define the \subpart and \subsubpart commands when we enter a
% questions environment (rather than waiting until we enter a subparts
% of subsubparts environment) so that we can signal an error if a
% \subpart or \subsubpart command appears outside of the corresponding
% environment.  (We don't do this for the \part command so that the user
% can use the standard sectioning \part command outside of a parts
% environment.)

\newenvironment{questions}{%
  % \@queslevel is used for two purposes:
  % (1) We check that every \question, \part, \subpart, and 
  % \subsubpart command appears inside the appropriate environment,
  % and generate an error if one appears in the wrong place.
  % (2) If a \qformat is being used and if \@queslevel tells us
  % that we're currently processing a question, then we set
  % \global \point@toks={} to avoid setting the points for a 
  % question other than via the qformat command.
  \def\@queslevel{question}%
  \def\question{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{question}%
    \addtocounter{numquestions}{1}%
    % Write the sum of points of the previous question (if any)
    % to the .aux file.  (At this point, the question counter
    % has not yet been incremented, so \arabic{question} has the
    % number of the question that was just completed.)
    \if@filesw
      \ifnum \arabic{question} > 0\relax
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@
            \romannumeral \csname c@question\endcsname
              {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \@ifundefined{pointsofq@\romannumeral
                            \csname c@question\endcsname}%
          {\global\@pointschangedtrue}%
          {%
          % OK; it's defined.  See if it's changed:
          \begingroup
            \set@hlfcntr{tmp@hlfcntr}{\csname pointsofq@\romannumeral 
                         \csname c@question\endcsname\endcsname}%
            \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
            \edef\pt@check{\prtaux@hlfcntr{pointsof@thisquestion}}%
            \ifx \pt@check \othpt@check
              % Do nothing
            \else
              \global\@pointschangedtrue
            \fi
          \endgroup
          }%
      \fi
    \fi
    \set@hlfcntr{pointsof@thisquestion}{0}%
    % If there was a question with points immediately preceding
    % this question (i.e., there were no parts in the previous
    % question), then @placepoints will still be true, and we need to
    % cancel it.  (We used to do this inside of the \thepoints macro,
    % but that allowed for an error if the user specified points for a
    % question but had a \qformat that didn't mention \thepoints.)  We
    % also set @placepoints to be false in the \part command.
    \global \@placepointsfalse
    % point@toks will normally be empty at this point, but it might be
    % nonempty if there were points somewhere in the previous question
    % that never made it onto the page because we never entered
    % horizontal mode (perhaps because the user was weird and let the
    % text of a question (or part, etc.) consist entirely of an
    % enumerate environment, or description environment, or etc.).
    \global \point@toks={}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \pageinfo@commands={%
      \edef\@queslabel{question@\arabic{question}}%
      \PgInfo@write{\@queslabel}%
      \set@counter@to@pageof{Curr@Page}{\@queslabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, or \subsubpart
        % on this page:
        \global\expandafter\edef
               \csname Contin@\theCurr@Page\endcsname{\relax}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% pageinfo@commands
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% question
  \def\subpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subpart}%
    \addtocounter{numsubparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@subpartlabel{subpart@\arabic{question}%
        @\arabic{partno}@\arabic{subpart}}%
      \PgInfo@write{\@subpartlabel}%
      \set@counter@to@pageof{Curr@Page}{\@subpartlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, or \subsubpart
        % on this page:
        \global\expandafter\edef\csname
                       Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% temp@toks
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% subpart
  \def\subsubpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subsubpart}%
    \addtocounter{numsubsubparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@subsubpartlabel{subsubpart@\arabic{question}%
        @\arabic{partno}@\arabic{subpart}@\arabic{subsubpart}}%
      \PgInfo@write{\@subsubpartlabel}%
      \set@counter@to@pageof{Curr@Page}{\@subsubpartlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, or \subsubpart
        % on this page:
        \global\expandafter\edef\csname
                       Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% temp@toks
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% subsubpart
  \list{\question@number}%
    {\usecounter{question}%
    % We use the default definition of \makelabel
    % so as not to interfere with \qformat commands.
    % \def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{10.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \partopsep=0pt
    }%
  }%
  {%
    \endlist
    % Write the number of points of the final question
    % to the .aux file:
    \if@filesw
      \ifnum \arabic{question} > 0\relax
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@\romannumeral
                                \csname c@question\endcsname
            {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \@ifundefined{pointsofq@\romannumeral
                            \csname c@question\endcsname}%
          {\global\@pointschangedtrue}%
          {%
          % OK; it's defined.  See if it's changed:
          \begingroup
            \set@hlfcntr{tmp@hlfcntr}{\csname pointsofq@\romannumeral 
                         \csname c@question\endcsname\endcsname}%
            \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
            \edef\pt@check{\prtaux@hlfcntr{pointsof@thisquestion}}%
            \ifx \pt@check \othpt@check
              % Do nothing
            \else
              \global\@pointschangedtrue
            \fi
          \endgroup
          }%
      \fi
    \fi
  }
  
% \question@number is used as the label in the question list (instead
% of \questionlabel) so that if the user uses a \qformat command,
% we'll use the \@questionformat specified by the \qformat command:
\def\question@number{%
  \if@qformat
    \makebox[\hsize][s]{\@questionformat}\hskip-\labelsep
  \else
    \questionlabel
  \fi
}
\newcommand\questionlabel{\thequestion.}
     
% We want the \part command to be defined *only* inside of a parts
% environment, so that the user can use the standard sectioning \part
% command inside of a questions environment (as long as it's outside of
% a parts environment).

\newenvironment{parts}{%
  \def\@queslevel{part}%
  % If the question numbers are being inserted via a \qformat,
  % and if a question is beginning with a parts environmnt, then
  % we need to enter horizonal mode to the the qformat printed
  % on the page, rather than saving up the question label (and
  % possible points) to be combined with the label of the first
  % part.  (\if@inlabel tells us if we are still waiting to enter
  % horizontal mode after seeing a \question command.)
  \if@qformat
    \if@inlabel
      \leavevmode
      \@inlabelfalse
    \fi
    % The following is just in case the question had points,
    % in which case @placepoints will still be true.
    % (We used to do this inside of the \thepoints macro,
    % but that allowed for an error if the user specified points for
    % a question but had a \qformat that didn't mention \thepoints.)
    % We also set @placepoints to be false in the \question command,
    % in case one queation follows a previous one that had no parts.
    \global \@placepointsfalse
  \fi
  \def\part{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{part}%
    \addtocounter{numparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@partlabel{part@\arabic{question}@\arabic{partno}}%
      \PgInfo@write{\@partlabel}%
      \set@counter@to@pageof{Curr@Page}{\@partlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        \global\expandafter\edef\csname
            Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }%
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% part
  \list{\partlabel}%
    {%
    \usecounter{partno}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{(m)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    }%
  }% newenvironment{parts}
  {\endlist}
\newcommand\partlabel{(\thepartno)}
\def\thepartno{\alph{partno}}

\newenvironment{subparts}{%
  \def\@queslevel{subpart}%
  \list{\subpartlabel}%
    {%
    \usecounter{subpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{vii.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    }%
  }%
  {\endlist}
\newcommand\subpartlabel{\thesubpart.}
\def\thesubpart{\roman{subpart}}

\newenvironment{subsubparts}{%
  \def\@queslevel{subsubpart}%
  \list{\subsubpartlabel}%
    {%
    \usecounter{subsubpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{($\psi$)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    }%
  }%
  {\endlist}
\newcommand\subsubpartlabel{\thesubsubpart)}
\def\thesubsubpart{\greeknum{subsubpart}}


\pagepoint@commands={%
  \ifhlfcntr@pos{latest@points}%
    % We're putting a question (or part, etc.)
    % with points onto this page: 
    \ifnum \theCurr@Page > \thepageof@pagepoints\relax
      % These points go on a later page than
      % the points currently counted in @pagepoints:
      \ifnum \thepageof@pagepoints = 0\relax
        % Do nothing...
      \else
        \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@
           \romannumeral \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
        % See if this has changed from the last run of LaTeX:
        \@ifundefined{pointsonpage@\romannumeral
                            \csname c@pageof@pagepoints\endcsname}%
          {\global\@pointschangedtrue}%
          {%
          % OK; it's defined.  See if it's changed:
          \begingroup
            \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral 
                      \csname c@pageof@pagepoints\endcsname\endcsname}%
            \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
            \edef\pt@check{\prtaux@hlfcntr{@pagepoints}}%
            \ifx \pt@check \othpt@check
              % Do nothing
            \else
              \global\@pointschangedtrue
            \fi
          \endgroup
          }%
      \fi
      % The following is a macro because \theCurr@Page and
      % \thepageof@pagepoints might differ by more than 1:
      \increment@pageof@pagepoints
    \else
      % These points go on the same page as the points
      % currently counted in @pagepoints:
      \add@hlfcntrtohlfcntr{@pagepoints}{latest@points}%
      \set@hlfcntr{latest@points}{0}%
    \fi
  \fi
}
\def\increment@pageof@pagepoints{%
  \addtocounter{pageof@pagepoints}{1}%
  \ifnum \theCurr@Page > \thepageof@pagepoints\relax
    \immediate\write\@mainaux
        {\string\gdef\string\pointsonpage@
         \romannumeral \csname c@pageof@pagepoints\endcsname{0}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{pointsonpage@\romannumeral
                        \csname c@pageof@pagepoints\endcsname}
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral 
                  \csname c@pageof@pagepoints\endcsname\endcsname}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \def\pt@check{0}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \let\next@incr@pageof = \increment@pageof@pagepoints
  \else
    \copy@hlfcntr{@pagepoints}{latest@points}%
    \set@hlfcntr{latest@points}{0}%
    % \page@withpoints will be used to find the last
    % page that has points, which will be written to
    % the .aux file vis \AtEndDocument:
    \global\edef\page@withpoints{\thepageof@pagepoints}%
    \let\next@incr@pageof = \relax
  \fi
  \next@incr@pageof
}







\def\@checkqueslevel#1{%
  \begingroup
    \def\@temp{#1}%
    \ifx\@temp\@queslevel
      % Everything's fine; do nothing.
    \else
      \ClassError{exam}{%
        I found a #1 where I expected to find a
        \@queslevel\MessageBreak
      }{%
        Both #1 and \@queslevel \space can be used only inside the
        correct \MessageBreak \space \space
        environment and outside of any smaller environment
        \MessageBreak
      }%
    \fi
  \endgroup
}

\def\@doitem{\@ifnextchar[{\@readpoints}%
                          {\item@points@pageinfo}%
}

\def\@readpoints[#1]{%
% We use \def for \@points instead of \edef because we don't want
% \half (if present) to be expanded yet, so that the command \points
% can figure out how to deal with it:
  \def\@points{#1}%
  \global \@placepointstrue
  \if@addpoints
    \addto@hlfcntr{numpoints}{\@points}%
    \addto@hlfcntr{pointsof@thisquestion}{\@points}%
    % latest@points is a holding area for points to be
    % added to @pagepoints after we check whether they're
    % on the same page as the points currently counted
    % by @pagepoints:
    \addto@hlfcntr{latest@points}{\@points}%
  \fi
  \item@points@pageinfo
}



% do@int@lbl is the command used to create a label for every question,
% part, subpart, and subsubpart.  We make no use of these labels, but we
% put them there so that if a question (or part, etc.) is, e.g., moved
% from one page to another, LaTeX will notice this and warn the user
% that LaTeX must be run one more time to be sure everything is correct.
%
% We need to do this even though we've already included code to check
% when point totals change because questions (and parts, etc.) know what
% page they're on from reading the info written to the .aux file on the
% previous run.  Thus, if a question (or part, etc.) is moved to a
% different page, then the pointsonpage totals won't notice until the
% *second* subsequent run of LaTeX, and so there'll be no warning to the
% user on the *first* run.  Including these labels gives the user a
% warning on that first run.

\newcounter{lbl@cntr}
\def\do@int@lbl{%
  \addtocounter{lbl@cntr}{1}%
  % Looking at latex.ltx reveals that the argument to \label is
  % expanded, so we don't really need the \expandafter's in the
  % following, but I haven't seen any statement anywhere in
  % documentation about it being expanded, so we'll be paranoid and
  % protect against future changes in latex.ltx by using
  % \expandafter's: 
  \expandafter\label\expandafter{\thelbl@cntr @@exam@lbl}%
}


% Bug fix, 5 April 2004: \item@points@pageinfo
% Appending \point@toks and \pageinfo@commands to \everypar:
% Instead of appending the contents of \point@toks and
% \pageinfo@commands to \everypar using \append@toklist,
% we instead want to append only the two tokens
%   \the\point@toks
% and the two tokens
%   \the\pageinfo@commands
% to \everypar.  We need to do this because if a questions environment
% immediately follows a \section command, then @nobreak will be true,
% and so the \if@nobreak inside of \everypar will *not* execute the
% \everypar={} that we had been counting on to keep the points from
% being inserted a second time in the second paragraph of a question.
% Since we've put the command \global \point@toks={} inside of 
% \point@toks and the command \pageinfo@commands={} inside of
% \pageinfo@commands, when the contents of \point@toks and of
% \pageinfo@commands are executed when we enter horizontal mode and
% \everypar is dumped in, the contents of \point@toks and
% \pageinfo@commands will be made empty, and so if
% the second paragraph also get \the\point@toks and
% \the\pageinfo@commands, it won't matter.

\def\item@points@pageinfo{%
  \item
  % If @qformat is true, and if we're currently doing a question
  % (rather than a part, subpart, or subsubpart), then we don't want
  % to set the points (if any), since the points of a question will
  % appear only if the user chooses to cause that by putting a
  % \thepoints in the argument of the \qformat command.
  % 
  % Also: We need to do this here, *after* the \item command, rather
  % than inside the macro \@readpoints, because the \item command
  % puts the result of the \qformat command into an \hbox (with the
  % command ``\sbox\@tempboxa{\makelabel{#1}}%''), expanding the
  % argument of \qformat as it does so.  Thus, @placepoints will be
  % true when the argument of \qformat is expanded, and so if the
  % user put a \thepoints command inside that argument it will
  % correctly expand to the number of points.  (When @placepoints is
  % false, \thepoints expands to nothing at all).
  \if@qformat
    \ifx\ques@ref\@queslevel
      \global \@placepointsfalse
    \fi
  \fi
  \if@placepoints
    % \setup@point@toks defines \point@block to be a macro that prints
    % the points with the correct choice of parentheses, brackets, or
    % box, and \@pointname or \@marginpointname and puts commands into
    % \point@toks to place \point@block at the correct spot.  It
    % doesn't append anything to \everypar (we do that in this macro,
    % below). 
    \if@pointsdropped
      % Do nothing!
    \else
      \setup@point@toks
    \fi
    \global \@placepointsfalse
  \fi
  % We *don't* use \append@toklist; see Bug fix note above
  % We can append the tokens ``\the\point@toks'' whether or not we're
  % setting any points because if we're not setting them, \point@toks
  % will be empty.
  % Also: It's important to do this *after* the \item command above,
  % since the \item command discards the previous contents of
  % \everypar.
  \edef\append@everypar{\noexpand\everypar={\the\everypar
                        \noexpand\the \noexpand\pageinfo@commands
                        \noexpand\the \noexpand\point@toks}}%
  \append@everypar
  \do@int@lbl
}







% Initialize \@points:
% (Now that I think of it, this seems totally unnecessary,
% but we're not deleting it because we're chicken.)
\def\@points{0}


\def\setup@point@toks{%
% We begin by defining \point@block so that it expands to the properly
% formatted points (including either \pointname or \marginpointname,
% enclosed in either parentheses, brackets, or a box).  We then set
% the token list \point@toks equal to the sequence of commands needed
% to put \point@block at the correct location, followed by the tokens
% ``\global \point@toks={}''.  The \question, \part, \subpart, or 
% \subsubpart command then adds the two tokens ``\the\point@toks'' to
% \everypar.
%
% Note: It is not the *contents* of \point@toks that is added to
% \everypar; just the two tokens ``\the\point@toks''.  This difference
% is the bug fix of 2 April 2004, described above (the bug was that in
% earlier versions, we used to append the contents).
%
% The result of this is that whenever we finally enter horizontal mode
% (because we finally encountered the text of a question, part,
% subpart, or subsubpart) the contents of \point@toks will be dumped
% into horizontal mode and executed, and so the points will be placed
% and the token list \point@toks will be set to empty.  Thus, in the
% occasional circumstances in which \everypar is *not* set to empty
% after being added to the first paragraph (which occurs when a
% questions environment immediately follows a \section command), and
% so \everypar will still contain ``\the\point@toks'' when it
% encounters a possible second paragraph of the first question, the
% tokens ``\the\point@toks'' will insert an *empty* token list, which
% will do no harm.
%
%
% \point@block consists of \point@string surrounded by either
% parentheses, brackets, or an fbox.
%
% \point@string is either \@points\@pointname or
% \@points\@marginpointname.
  \setup@point@block
  \if@pointsinleftmargin
    \def\point@string{\@points\@marginpointname}%
    \point@toks={%
          \llap{\point@block 
                \hskip\@totalleftmargin
                \hskip\marginpointssep
          }%
          \global \point@toks={}%
    }%
  \else
    \if@pointsinrightmargin
      \def\point@string{\@points\@marginpointname}%
      \point@toks={%
            \rlap{\hskip-\@totalleftmargin
                  \hskip\textwidth
                  \hskip\@rightmargin
                  \hskip-\rightpointsmargin
                  \llap{\point@block}%
            }%
            \global \point@toks={}%
      }%
    \else
      % The points just go after the question number:
      \def\point@string{\@points\@pointname}%
      \point@toks={%
            \point@block
            \enspace
            \global \point@toks={}%
      }%
    \fi
  \fi
}% setup@point@toks


\def\setup@point@block{%
  \if@boxedpoints
    \def\point@block{\fbox{\point@string}}%
  \else
    \if@bracketedpoints
      \def\point@block{[\point@string]}%
    \else
      % plain old parentheses:
      \def\point@block{(\point@string)}%
    \fi
  \fi
}

\def\droppoints{%
  \def\point@string{\@points\@marginpointname}%
  \setup@point@block
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\point@block}%
  }% rlap
  \par
}

% The following is the default definition.
% It will be redefined if the user givea a \totalformat command.
\def\setup@total@block{%
  \def\total@block{%
    Total for Question \thequestion: \totalpoints\@marginpointname
  }%
}

\def\totalformat#1{%
  \def\setup@total@block{\def\total@block{#1}}%
}
% The following is for use in the argument to a \totalformat command:
\def\totalpoints{\pointsofquestion{\arabic{question}}}

\def\droptotalpoints{%
  \setup@total@block
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\total@block}%
  }% rlap
  \par
}


% @placepoints is set true when we encounter a question (or part, etc.)
% that has points.  It is set to false (1) when we set \point@toks equal
% to the sequence of commands required to put the properly formatted
% points onto the page (this happens only if @qformat is false or if
% @qformat is true but we're not doing a question), or (2) by a
% \question or \part command (since if we're doing a question and
% @qformat is true, we need to leave @placepoints true so that the
% \thepoints command can tell if it should expand to points or to
% nothing, and encountering a \question or \part command tells us that
% we no longer have to deal with a possible \thepoints, since we won't
% be expanding a qformat).
\newif\if@placepoints
\@placepointsfalse


% \marginpointssep will be used if the user says
% \pointsinleftmargin.  It will be the distance from whatever encloses
% the points (parentheses, brackets, or a box) to the left margin:
\newlength\marginpointssep
\setlength{\marginpointssep}{5pt}

% \rightpointsmargin will be used if the user says \pointsinrightmargin.
% It will be the distance from whatever encloses the point (parentheses,
% brackets, or a box) to the right edge of the paper:
\newlength\rightpointsmargin
\setlength{\rightpointsmargin}{1cm}


\newif\if@pointsdropped
\newif\if@pointsinleftmargin
\newif\if@pointsinrightmargin
\def\pointsinleftmargin{\global\@pointsinleftmargintrue 
                    \global\@pointsinrightmarginfalse
                    \global\@pointsdroppedfalse}
\def\pointsinrightmargin{\global\@pointsinrightmargintrue
                         \global\@pointsinleftmarginfalse
                         \global\@pointsdroppedfalse}
\def\nopointsinmargin{\global\@pointsinleftmarginfalse
                      \global\@pointsinrightmarginfalse
                      \global\@pointsdroppedfalse}
\def\pointsdroppedatright{\global\@pointsdroppedtrue
                          \global\@pointsinleftmarginfalse
                          \global\@pointsinrightmarginfalse}
\let\pointsinmargin\pointsinleftmargin
\let\nopointsinrightmargin\nopointsinmargin
\let\nopointsinleftmargin\nopointsinmargin


\nopointsinmargin


% Will the points be displayed inside parentheses (the default), or
% will they be boxed or bracketed:
\newif\if@boxedpoints
\def\boxedpoints{\global\@boxedpointstrue \global\@bracketedpointsfalse}
\def\noboxedpoints{\global\@boxedpointsfalse \global\@bracketedpointsfalse}
\@boxedpointsfalse

\newif\if@bracketedpoints
\def\bracketedpoints{\global\@bracketedpointstrue \global\@boxedpointsfalse}
\def\nobracketedpoints{\global\@bracketedpointsfalse \global\@boxedpointsfalse}
\@bracketedpointsfalse



\def\pointname#1{\gdef\@pointname{#1}}
% Initialize to leave a space, and then the word `points':
%%\pointname{ points}
% The following improvement was contributed by 
% Mate Wierdl <mw@wierdlmpc.msci.memphis.edu> 
% If the number of points is ``1'', then the default value of
% \pointname will print `` point'' instead of `` points'' (and this
% version of the command doesn't generate an error message if the
% points entry is something other than a number):
% Note the space before the \points in the following; it's
% intentional!)
\pointname{ \points}

\newcommand\point@sing{point}
\newcommand\point@plur{points}
\newcommand\pointpoints[2]{%
  \renewcommand\point@sing{#1}%
  \renewcommand\point@plur{#2}%
}



% The command \points:
% We use \ifthenelse and \equal so that if the user types something
% other than a legit point value, there still won't be any error
% messages.  We rig it so that if the point value looks like it's
% intended to be One or one or ONE, or some strange way of attempting
% one half, then it will expand to the singular value.  Alas, this is
% only useful for English, but I'm hoping few or no users will try doing
% this anyway.

% 0 points, one half point, 1 point, 1 and a half points, etc.:
\newcommand\points{%
  \begingroup
    \let\half=\relax
    \edef\pt@string{\@points}%
    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half}}
          {\point@sing}{\point@plur}%
  \endgroup
}
%\newcommand\points{%
%  \begingroup
%    \let\half=\relax
%    \edef\pt@string{\@points}%
%    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half} \or
%      \equal{\pt@string}{0\half} \or \equal{\pt@string}{0 \half}
%      \equal{\pt@string}{one} \or \equal{\pt@string}{One} \or
%      \equal{\pt@string}{ONE}}
%        {\point@sing}{\point@plur}%
%  \endgroup
%}

%\newcommand\points{\ifthenelse{\equal{\@points}{1}}{\point@sing}{\point@plur}}
% If we used the following line instead, then you'd get an error
% message if the point value contained something other than a valid
% integer:
%\pointname{ \ifthenelse{\@points = 1}{point}{points}}

% We used to define a command named \marks that works like \points,
% except that it expands to either ``mark'' or ``marks'', but that
% conflicts with some package or other.  Thus, we'll implement
% \marksnotpoints using the \pointpoints command instead:
\newcommand\marksnotpoints{\pointpoints{mark}{marks}}


% \@marginpointname is used in place of \@pointname if any of
% \@pointsinmargin, \@pointsinrightmargin, and \@pointsdropped are
% true:
\def\marginpointname#1{\gdef\@marginpointname{#1}}
\marginpointname{}


% The following keeps track of whether the user has requested that we
% add up the points on the exam.  We make the default false so that
% users who put other than numbers into the points argument of a
% question (or part, or subpart) won't get error messages.
% We use \if@printtotalpoints as a flag to signal that we are counting
% points, so that we will know to print the total on the screen (and
% in the log file).  We use this separate flag so that the user can
% use both \addpoints and \noaddpoints to count some points and not
% others, but still have the total printed when we finish the file no
% matter what the state of \if@addpoints.
\newif\if@addpoints
\newif\if@printtotalpoints
\def\addpoints{\global\@addpointstrue\global\@printtotalpointstrue}
\def\noaddpoints{\global\@addpointsfalse}
\@addpointsfalse
\@printtotalpointsfalse

%--------------------------------------------------------------------
%                   choices (for multiple choice)


\renewcommand\thechoice{\Alph{choice}}
\newcommand\choicelabel{\thechoice.}

% Added 22 April 2004: Increased the \leftmargin by 2.5em,
% so the choices will be visibly indented.
\newenvironment{choices}%
  {\list{\choicelabel}%
     {\usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
       \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
       \let\choice=\item
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
     }%
  }%
  {\endlist}

\newenvironment{oneparchoices}%
  {%
    \setcounter{choice}{0}%
    \def\choice{%
                 \refstepcounter{choice}%
                 \ifnum\value{choice}>1
                   \penalty -50\hskip 1em plus 1em\relax
                 \fi
                 \choicelabel\nobreak\enskip
               }%
    \let\par\@empty
    % If we're continuing the paragraph containing the question,
    % then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
  }%
  {}


%--------------------------------------------------------------------
%             Answer Lines (for short answer questions)

% Note: \ques@ref is also used in \item@points@pageinfo

\def\ques@ref{question}
\def\part@ref{part}
\def\subpart@ref{subpart}
\def\subsubpart@ref{subsubpart}

\newlength\answerlinelength
\newlength\answerskip
\setlength\answerlinelength{1in}
\setlength\answerskip{2ex}

\def\answerline{%
  \ifx\@queslevel\ques@ref
    \let\ans@l=\questionlabel
  \else
    \ifx\@queslevel\part@ref
      \let\ans@l=\partlabel
    \else
      \ifx\@queslevel\subpart@ref
        \let\ans@l=\subpartlabel
      \else
        \ifx\@queslevel\subsubpart@ref
          \let\ans@l=\subsubpartlabel
        \else
          % Oops; no question level defined.
          % We must be outide of the questions environment.
          % Just leave out the label, I guess:
          \def\ans@l{}%
        \fi
      \fi
    \fi
  \fi
  \par \nobreak \vskip \answerskip
  \hfill \ans@l~\hbox to \answerlinelength{\hrulefill}%
  \par
}

%--------------------------------------------------------------------
%                            \fillwithlines


% \fillwithlines takes one argument, which is either a length or \fill,
% and it fills that much vertical space with horizontal lines that run
% the length of the current line.  That is, the extend from the current
% left margin (which depends on whether we're in a quesiton, parts,
% subpart, or subsubpart) to the right margin.
%
% The distance between the lines is \linefillheight, whose default value
% is set with the command
%
% \setlength\linefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.
%
% The thickness of the lines is \linefillthickness, whose default value
% is set with the command
%
% \setlength\linefillthickness{.2pt}
%
% This value can be changed by giving a new \setlength command.


\newlength\linefillheight
\newlength\linefillthickness
\setlength\linefillheight{.25in}
\setlength\linefillthickness{0.1pt}

\newcommand\linefill{\leavevmode
    \leaders\hrule height \linefillthickness \hfill\kern\z@}


\def\fillwithlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \linefillheight depth \z@ width \z@
          \linefill}%
  % We use \cleaders (rather than \leaders) so that a given
  % vertical space will always produce the same number of lines
  % no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}


%--------------------------------------------------------------------
%                      \uplevel and \fullwidth:

% \uplevel is used to print text at the indentation level of the 
% enclosing environment.  For example, to precede a question with
% directions about how that question should be answered, you would
% say \uplevel{Answer this question correctly.}
% 
% \fullwidth is similar, but uses the full page of text on the page.

\long\def\uplevel#1{%
  \par\bigskip
  \vbox{%
    % We set \leftskip to provide the correct left margin for whatever
    % text is in the argument of the \uplevel command:
    \leftskip=\@totalleftmargin
    \advance\leftskip-\leftmargin
    % We adjust \@totalleftmargin (and linewidth?) in case there's a
    % solution environment inside of the argument to the \uplevel:
    \advance\@totalleftmargin-\leftmargin
    \advance\linewidth\leftmargin
    #1%
  }% vbox
  \nobreak
}

\long\def\fullwidth#1{%
  \par\bigskip
  \vbox{%
    \leftskip=0pt \rightskip=0pt
    \advance\linewidth\@totalleftmargin
    \@totalleftmargin=0pt
    #1%
  }% vbox
  \nobreak
}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                        ********************
%                        ** GRADING TABLES **
%                        ********************



\newcounter{@iterator}
\newlength\@cellwidth

\def\cellwidth#1{\@cellwidth=#1}
\def\gradetablestretch#1{\def\@gtblstretch{#1}}

% All of the following that begin with `h' are for horizontal tables,
% and all of them that begin with `v' are for vertical tables:
\def\hqword#1{\def\@hqword{#1}}
\def\hpword#1{\def\@hpword{#1}}
\def\hsword#1{\def\@hsword{#1}}
\def\htword#1{\def\@htword{#1}}
\def\vqword#1{\def\@vqword{#1}}
\def\vpword#1{\def\@vpword{#1}}
\def\vsword#1{\def\@vsword{#1}}
\def\vtword#1{\def\@vtword{#1}}

\def\vpgword#1{\def\@vpgword{#1}}
\def\hpgword#1{\def\@hpgword{#1}}

% Initialize:
\cellwidth{2em}
\gradetablestretch{1.5}
\hpword{Points:}
\hsword{Score:}
\htword{Total}
\vpword{Points}
\vsword{Score}
\vtword{Total:}

% For tables indexed by question number:
\vqword{Question}
\hqword{Question:}

% For tables indexed by page number:
\vpgword{Page}
\hpgword{Page:}



% The only command here accessible to the user is \gradetable.
% The possibilities are

%   \gradetable[v][questions]
%   \gradetable[v][pages]
%   \gradetable[h][questions]
%   \gradetable[h][pages]

% If one or both optional arguments are omitted, the defaults are `[v]'
% and `[questions]'.

\def\gradetable{%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}
\def\i@gtable[#1]{%
  % If the user doesn't include the optional argument
  % choosing between questions and pages,
  % we give them questions:
  \@ifnextchar[{\ii@gtable{#1}}{\ii@gtable{#1}[questions]}%
}
\def\ii@gtable#1[#2]{%
  \if@addpoints
    \@ifundefined{exam@numpoints}%
      {\ClassWarning{exam}%
        {%
          You must run LaTeX again to produce the grade table.
            \MessageBreak
        }%
        \fbox{Run \LaTeX{} again to produce the table}%
      }%
      {\do@gtable{#1}{#2}}%
  \else
    \ClassError{exam}{%
      You must give the command \protect\addpoints\MessageBreak
      \space\space in order to use the command \protect\gradetable
      \MessageBreak
      }{%
      If you don't give the command \protect\addpoints\MessageBreak
      \space\space then we're not keeping track of point values.
      \MessageBreak
      }%
  \fi
}
\def\@questionsref{questions}
\def\@pagesref{pages}
\def\do@gtable#1#2{%
  \begingroup % avoid trouble from using \@temp
    \def\@temp{#2}%
    \ifx\@temp\@questionsref
      \@grdtblquestions{#1}%
    \else
      \ifx\@temp\@pagesref
        \@grdtblpages{#1}%
      \else
        \ClassError{exam}{%
          The second optional argument to \protect\gradetable \MessageBreak
          \space \space must be either `questions' or `pages'\MessageBreak
        }{%
          Grade tables can be indexed by questions or pages;\MessageBreak
          \space\space for others, you're on your own.\MessageBreak
        }%
        \fbox{Error: Grade table: Invalid second optional argument `#1'.}%
      \fi
    \fi
  \endgroup
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grading tables indexed by question numbers:

\def\@grdtblquestions#1{%
  \if v#1%
    \@vgrdtblquestions
  \else
    \if h#1%
      \@hgrdtblquestions
    \else
      \ClassError{exam}{%
        The first optional argument to \protect\gradetable \MessageBreak
        \space \space must be either `h' or `v'\MessageBreak
      }{%
        Grade tables can be either horizontal or vertical;\MessageBreak
        \space\space no diagonals allowed.\MessageBreak
      }%
      \fbox{Error: Grade table: Invalid first optional argument `#1'.}%
    \fi
  \fi
}

%--------------------------------------------------------------------
% Vertical, indexed by question numbers:

\def\@vgrdtblquestions{%
  \begingroup
    % Save the current value of question in @iterator, so that
    % we cna restore it after doing the table:
    \setcounter{@iterator}{\arabic{question}}%
    \renewcommand\arraystretch{\@gtblstretch}%
    \begin{tabular}{|c|c|c|}
      \hline
      {\@vqword}& {\@vpword}& {\@vsword}\\
      \hline
      \setcounter{question}{0}\do@vloop
      {\@vtword}& \numpoints&\hbox to \@cellwidth{\hfill}\\
      \hline
    \end{tabular}%
    % Restore the saved value of question:
    \setcounter{question}{\arabic{@iterator}}%
  \endgroup
}
\def\do@vloop{%
  \addtocounter{question}{1}%
  \thequestion & \pointsofquestion{\arabic{question}}&\\
  \hline
  \ifnum \arabic{question} < \numquestions\relax
    \let\next@vloop=\do@vloop
  \else
    \let\next@vloop=\relax
  \fi
  \next@vloop
}

%--------------------------------------------------------------------
% Horizontal, indexed by question numbers:

\def\@hgrdtblquestions{%
  \begingroup
    % Save the current value of question in @iterator, so that
    % we can restore it after doing the table:
    \setcounter{@iterator}{\arabic{question}}%
    \renewcommand\arraystretch{\@gtblstretch}%
    \begin{tabular}{|l|*{\numquestions}{c|}c|}
      \hline
      {\@hqword}& \setcounter{question}{0}\do@qnumloop
      {\@htword}\\
      \hline
      {\@hpword}& \setcounter{question}{0}\do@ptloop
      \numpoints\\
      \hline
      {\@hsword}& \setcounter{question}{0}\do@sloop
      \\
      \hline
    \end{tabular}%
    % Restore the saved value of question:
    \setcounter{question}{\arabic{@iterator}}%
  \endgroup
}
\def\do@qnumloop{%
  \addtocounter{question}{1}%
  \thequestion &
  \ifnum \arabic{question} < \numquestions\relax
    \let\next@qnloop=\do@qnumloop
  \else
    \let\next@qnloop=\relax
  \fi
  \next@qnloop
}
\def\do@ptloop{%
  \addtocounter{question}{1}%
  \pointsofquestion{\arabic{question}}&
  \ifnum \arabic{question} < \numquestions\relax
    \let\next@ptloop=\do@ptloop
  \else
    \let\next@ptloop=\relax
  \fi
  \next@ptloop
}
\def\do@sloop{%
  \addtocounter{question}{1}%
  \hbox to \@cellwidth{\hfill}&
  \ifnum \arabic{question} < \numquestions\relax
    \let\next@sloop=\do@sloop
  \else
    \let\next@sloop=\relax
  \fi
  \next@sloop
}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grading tables indexed by page numbers:
%
% The only pages listed are those on which there is a nonzero number
% of points.  We check pages 1 through \lastpage@withpoints; this way,
% once we've checked that \lastpage@withpoints and
% \pointsonpage@\romannumeral{\lastpage@withpoints} are defined, we
% can safely (we think) check \pointsonpage@\romannumeral{n} for all n
% between 1 and \lastpage@withpoints without generating errors.

% Check that there's enough info from the .aux file to do a page
% indexed grade table:
\def\@grdtblpages#1{%
  \@ifundefined{lastpage@withpoints}%
    {\ClassWarning{exam}{%
      You must run LaTeX twice more\MessageBreak
      \space\space to produce the grade table.\MessageBreak}%
     \fbox{Run \LaTeX{} twice more to produce the grade table}%
    }%
    {%
      \@ifundefined{pointsonpage@\romannumeral
               \csname lastpage@withpoints\endcsname}%
        {\ClassWarning{exam}{%
          You must run LaTeX again\MessageBreak
          \space\space to produce the grade table.\MessageBreak}%
         \fbox{Run \LaTeX{} again to produce the grade table}%
        }%
        {%
          \@whchtblpgs#1
        }%
    }%
}

\def\@whchtblpgs#1{%
  \if v#1%
    \@vgrdtblpages
  \else
    \if h#1%
      \@hgrdtblpages
    \else
      \ClassError{exam}{%
        The first optional argument to \protect\gradetable \MessageBreak
        \space \space must be either `h' or `v'\MessageBreak
      }{%
        Grade tables can be either horizontal or vertical;\MessageBreak
        \space\space no diagonals allowed.\MessageBreak
      }%
      \fbox{Error: Grade table: Invalid first optional argument `#1'.}%
    \fi
  \fi
}

%--------------------------------------------------------------------
% Vertical, indexed by pages:

\def\@vgrdtblpages{%
  \begingroup
    \renewcommand\arraystretch{\@gtblstretch}%
    \begin{tabular}{|c|c|c|}
      \hline
      {\@vpgword}& {\@vpword}& {\@vsword}\\
      \hline
      \setcounter{@iterator}{0}\pg@vloop
      {\@vtword}& \numpoints&\hbox to \@cellwidth{\hfill}\\
      \hline
    \end{tabular}%
  \endgroup
}
\def\pg@vloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
                              \csname c@@iterator\endcsname\endcsname}%
%  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\roman{@iterator}\endcsname}%
%  spanish.ldf redefines \@roman, so we'll avoid \roman
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@vloopline
  \fi
  \ifnum \the@iterator < \lastpage@withpoints\relax
    \let\next@pg@vloop=\pg@vloop
  \else
    \let\next@pg@vloop=\relax
  \fi
  \next@pg@vloop
}
\def\pg@vloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \the@iterator & \pointsonpage{\the@iterator}&\\
  \hline
}

%--------------------------------------------------------------------
% Horizontal, indexed by pages:

% For a horizontal table, we need to know how many pages there are
% with points on them:
\newcounter{numpgs@withpts}
\def\count@pgswpts{%
  \setcounter{numpgs@withpts}{0}%
  \setcounter{@iterator}{0}%
  \docount@pgswpts
}
\def\docount@pgswpts{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
                              \csname c@@iterator\endcsname\endcsname}%
%  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\roman{@iterator}\endcsname}%
%  spanish.ldf redefines \@roman, so we'll avoid \roman
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{numpgs@withpts}{1}%
  \fi
  \ifnum \the@iterator < \lastpage@withpoints\relax
    \let\next@docount=\docount@pgswpts
  \else
    \let\next@docount=\relax
  \fi
  \next@docount
}


\def\@hgrdtblpages{%
  \begingroup
    \renewcommand\arraystretch{\@gtblstretch}%
    \count@pgswpts
    \begin{tabular}{|l|*{\thenumpgs@withpts}{c|}c|}
      \hline
      {\@hpgword}& \setcounter{@iterator}{0}\do@pgnumloop
      {\@htword}\\
      \hline
      {\@hpword}& \setcounter{@iterator}{0}\do@pgptloop
      \numpoints\\
      \hline
      {\@hsword}& \setcounter{@iterator}{0}\do@pgsloop
      \\
      \hline
    \end{tabular}%
  \endgroup
}

\def\do@pgnumloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
                             \csname c@@iterator\endcsname\endcsname}%
%  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\roman{@iterator}\endcsname}%
%  spanish.ldf redefines \@roman, so we'll avoid \roman
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@line
  \fi
  \ifnum \the@iterator < \lastpage@withpoints\relax
    \let\next@pgnumloop=\do@pgnumloop
  \else
    \let\next@pgnumloop=\relax
  \fi
  \next@pgnumloop
}
\def\pg@line{%
  \the@iterator &
}

\def\do@pgptloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
                              \csname c@@iterator\endcsname\endcsname}%
%  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\roman{@iterator}\endcsname}%
%  spanish.ldf redefines \@roman, so we'll avoid \roman
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pgpt@line
  \fi
  \ifnum \the@iterator < \lastpage@withpoints\relax
    \let\next@pgptloop=\do@pgptloop
  \else
    \let\next@pgptloop=\relax
  \fi
  \next@pgptloop
}
\def\pgpt@line{%
  \csname pointsonpage@\romannumeral \csname c@@iterator\endcsname\endcsname &
%  \csname pointsonpage@\roman{@iterator}\endcsname &
%  spanish.ldf redefines \@roman, so we'll avoid \roman
}

\def\do@pgsloop{%
  \addtocounter{@iterator}{1}%
%  \ifnum \csname pointsonpage@\roman{@iterator}\endcsname > 0\relax
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
                              \csname c@@iterator\endcsname\endcsname}%
%  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\roman{@iterator}\endcsname}%
%  spanish.ldf redefines \@roman, so we'll avoid \roman
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@sline
  \fi
  \ifnum \the@iterator < \lastpage@withpoints\relax
    \let\next@pgsloop=\do@pgsloop
  \else
    \let\next@pgsloop=\relax
  \fi
  \next@pgsloop
}
\def\pg@sline{%
  \hbox to \@cellwidth{\hfill}&
}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                     ***************************
%                     ** SOLUTION ENVIRONMENTS **
%                     ***************************



% If the documentclass options include ``answers'', then the command
% \@printanswerstrue is given at the beginning of the run.

% If the documentclass options include ``noanswers'', then the command
% \@printanswersfalse is given at the beginning of the run.

\def\printanswers{\@printanswerstrue}
\def\noprintanswers{\@printanswersfalse}


% If @printanswers is true, we print the solution using a TheSolution
% environment.  If @printanswers is false, we insert blank vertical space
% equal to the optional argument (the default value of which is 0pt).
\newenvironment{solution}[1][0pt]%
  {%
    \if@printanswers
      \begin{TheSolution}%
    \else
      \par
      \vspace*{#1}%
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \if@printanswers
      \end{TheSolution}%
    \else
      \egroup
    \fi
  }%

% If @printanswers is true, we print the solution using a TheSolution
% environment.  If @printanswers is false, we insert lined vertical space
% equal to the optional argument (the default value of which is 0pt).
\newenvironment{solutionorlines}[1][0pt]%
  {%
    \if@printanswers
      \begin{TheSolution}%
    \else
      \par
      \fillwithlines{#1}%
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \if@printanswers
      \end{TheSolution}%
    \else
      \egroup
    \fi
  }%

  
% The environment TheSolution is called from the solution environment
% when @printanswers is true.  It uses Donald Arseneau's
% framed.sty macros (included at the end if this file) to allow the
% solution to be broken across pages and have each piece enclosed in
% an fbox (or a colorbox, if the user has given the command
% \shadedsolution).
%
% Of course, the user can change TheSolution with a \renewenvironment
% command.
\newcommand{\solutiontitle}{\noindent\textbf{Solution:}\enspace}
\newenvironment{TheSolution}%
  {%
    \vspace{\parskip}%
    % If we don't set \leftskip and \rightskip to 0pt, then if we
    % appear inside of an \uplevel command we'd have indentation
    % inside of the solution box:
    \leftskip=0pt
    \rightskip=0pt
    \if@framedsolutions
      % Do nothing; we'll use the default \FrameCommand
    \else
      \def\FrameCommand{\colorbox{SolutionColor}}%
    \fi
    \MakeFramed{\advance\hsize-\width}%
    \solutiontitle
    \ignorespaces
  }%
  {%
    \unskip
    \endMakeFramed
  }%

\newif\if@framedsolutions
\@framedsolutionstrue

\def\framedsolutions{\@framedsolutionstrue}
\def\shadedsolutions{%
  \@ifundefined{definecolor}
  {%
    \ClassError{exam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorsolutions
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{SolutionColor}{gray}{0.8}
    \@framedsolutionsfalse
  }%
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------

% The following stuff is lifted from:
%
% framed.sty   v 0.8a   21-Jul-2003
% Copyright (C) 1992-2003 by Donald Arseneau
% These macros may be freely transmitted, reproduced, or modified
% provided that this notice is left intact.
%
% The modifications I made are marked with ``psh'' in a comment:
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create framed or shaded regions that can break across pages using 
% \begin{framed} ... \end{framed}    -- ordinary frame box (box at margin)
% \begin{shaded} ... \end{shaded}    -- shaded background (into margin)
%    ... leftbar ...                 -- line on left side
% \begin{MakeFramed}{settings} ... \end{MakeFramed}
%                        -- generic frame (for new environments)
%
% The "framed" environment puts the text into "\fbox" with the
% settings "\fboxrule=\FrameRule" and "\fboxsep=\FrameSep".
% You can change these lengths (using "\setlength") and you
% can even change the definition of "\FrameCommand" to use
% much fancier boxes.
%
% In fact, the "shaded" environment just redefines "\FrameCommand"
% to use "\colorbox{shadecolor}" (and you have to define the
% color "shadecolor": \newcolor{shadecolor}...).
%
% A page break is allowed, and even encouraged, before the framed
% environment.  If you want to attach some text (a box title) to the
% frame, then the text should be inserted by \FrameCommand
%
% The contents of the framed regions are restricted: 
% Floats, footnotes, marginpars and head-line entries will be lost.
% (Some of these may be handled in a later version.)
% This package will not work with the page breaking of multicol.sty,
% or other systems that perform column-balancing.
%
% The MakeFramed environment does the work.  Its "settings" argument
% should contain any adjustments to the text width (applied to \hsize,
% and using the "\width" of the frame itself) as well as a `restore' 
% command -- \@parboxrestore or \FrameRestore or something similar.
% 
% Expert commands:
% \MakeFramed, \endMakeFramed: the "MakeFramed" environment
% \FrameCommand: command to draw the frame around its argument
% \FrameRestore: restore some text settings, but fewer than \@parboxrestore
% \FrameRule: length register; \fboxrule for default "framed".
% \FrameSep: length register; \fboxsep for default "framed".
% \FrameHeightAdjust: macro; height of frame above baseline at top of page
% 
% This is still a `pre-production' version because I can think of many
% features/improvements that should be made.  Nevertheless, starting 
% with version 0.5 it should be bug-free.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%psh: Commented out \ProvidesPackage:
%\ProvidesPackage{framed}[2003/07/21 v 0.8a: 
%   framed or shaded text with page breaks]

%psh: Created \saved@totalleftmargin and \@sollistdepth:
\newdimen\saved@totalleftmargin
\newcount\@sollistdepth

\newenvironment{framed}% using default \FrameCommand
  {\MakeFramed {\advance\hsize-\width \FrameRestore}}%
  {\endMakeFramed}

\newenvironment{shaded}{%
  \def\FrameCommand{\colorbox{shadecolor}}%
  \MakeFramed {\FrameRestore}}%
 {\endMakeFramed}

\newenvironment{leftbar}{%
  \def\FrameCommand{\vrule width 3pt \hspace{10pt}}%
  \MakeFramed {\advance\hsize-\width \FrameRestore}}%
 {\endMakeFramed}

\chardef\FrameRestore=\catcode`\| % for debug
\catcode`\|=\catcode`\% % (debug: insert space after backslash)

\def\MakeFramed#1{\par
 % measure added width and height; call result \width and \height
 \setbox\z@\vbox{\vskip-1in \hbox{\hskip-1in 
   \FrameCommand{\hbox{\vrule \@height .7in \@depth.3in \@width 1in}}}%
   \vskip\z@skip}%
 \def\width{\wd\z@}\def\height{\ht\z@}%
 \edef\fb@frw{\the\width}\edef\fb@frh{\the\height}%
 % insert pre-penalties and skips
 \begingroup
 \skip@\lastskip
 \if@nobreak\else 
    \penalty9999 % updates \page parameters
    \ifdim\pagefilstretch=\z@ \ifdim\pagefillstretch=\z@
       \edef\@tempa{\the\skip@}%
       \ifx\@tempa\zero@glue \penalty-30
       \else \vskip-\skip@ \penalty-30 \vskip\skip@
    \fi\fi\fi
    \penalty\z@
    % Give a stretchy breakpoint that will always be taken in preference
    % to the \penalty 9999 used to update page parameters.  The cube root
    % of 10000/100 indicates a multiplier of 0.21545, but the maximum 
    % calculated badness is really 8192, not 10000, so the multiplier
    % is 0.2301. 
    \advance\skip@ \z@ plus-.5\baselineskip
    \advance\skip@ \z@ plus-.231\height
    \advance\skip@ \z@ plus-.231\skip@
    \advance\skip@ \z@ plus-.231\topsep
    \vskip-\skip@ \penalty 1800 \vskip\skip@
 \fi
 \addvspace{\topsep}%
 \endgroup
 % clear out pending page break
 \penalty\@M \vskip 2\baselineskip \vskip\height
 \penalty9999 \vskip -2\baselineskip \vskip-\height
 \penalty9999 % updates \pagetotal
|\message{After clearout, \pagetotal=\the\pagetotal, \pagegoal=\the\pagegoal. }%
 \fb@adjheight 
%psh: Added commands:
  \advance\hsize-\@totalleftmargin
  \saved@totalleftmargin=\@totalleftmargin
  \@totalleftmargin=0pt
  \parshape 0
  \let\@listdepth=\@sollistdepth
  \@sollistdepth=0
  \leftmargin=0pt
%psh: end of added commands
 \setbox\@tempboxa\vbox\bgroup
   #1% Modifications to \hsize (can use \width and \height)
   \textwidth\hsize \columnwidth\hsize
%psh: added one line:
   \linewidth=\hsize
}

\def\endMakeFramed{\par
     \kern\z@ \penalty-100 % put depth into height
 \egroup
 \begingroup \put@frame \endgroup
%psh: Added one line:
 \@totalleftmargin=\saved@totalleftmargin
}

% \put@frame takes the contents of \@tempboxa and puts all, or a piece,
% of it on the page with a frame (\FrameCommand).  It recurses until
% all of \@tempboxa has been used up. (\@tempboxa must have zero depth.)

\def\put@frame{\relax
 \ifdim\pagegoal=\maxdimen \pagegoal\vsize \fi
|   \message{=============== Entering putframe ====================^^J
|     \pagegoal=\the\pagegoal,  \pagetotal=\the\pagetotal. }%
 \ifinner \else
    \dimen@\pagegoal \advance\dimen@-\pagetotal % natural space left on page
  \ifdim\dimen@<2\baselineskip 
|   \message{Page has only \the\dimen@\space room left; eject. }%
    \eject \fb@adjheight \put@frame
  \else % there's appreciable room left on the page
|    \message{\string\pagetotal=\the\pagetotal,
|        \string\pagegoal=\the\pagegoal, 
|        \string\pagestretch=\the\pagestretch,
|        \string\pageshrink=\the\pageshrink,
|        \string\fb@frh=\fb@frh. \space}
|    \message{Box of size \the\ht\@tempboxa\space + \fb@frh}%
     \begingroup % temporarily set \dimen@ to be...
     \advance\dimen@.8\pageshrink  % maximum space available on page
     \advance\dimen@-\fb@frh\relax % space available for frame's contents
     \expandafter\endgroup
     % restore \dimen@ to real room left on page
     \ifdim\dimen@>\ht\@tempboxa % whole box does fit
|       \message{fits in \the\dimen@. }%
     \else % box must be split
|       \message{must be split to fit in \the\dimen@. }%
        \setbox\@tempboxa\vbox{% simulate frame and flexiblity of the page:
           \vskip \fb@frh \@plus\pagestretch \@minus.8\pageshrink
           \kern137sp\kern-137sp\penalty-30
           \unvbox\@tempboxa}%
        \edef\fb@resto@set{\boxmaxdepth\the\boxmaxdepth \splittopskip\the\splittopskip}%
        \boxmaxdepth\z@ \splittopskip\z@
        \setbox\tw@\vsplit\@tempboxa to\dimen@
        \setbox\tw@\vbox{\unvbox\tw@}% natural-sized
|       \message{Box of size \the\ht\@tempboxa\space split to \the\dimen@. 
|          Natural height of split box is \the\ht\tw@. }%
        % If the split-to size > (\vsize-\topskip), then set box to full size
        \begingroup
          \advance\dimen@\topskip
          \expandafter\endgroup
        \ifdim\dimen@>\pagegoal
|         \message{Frame is big -- Use up the full column. }%
          \dimen@ii\pagegoal
          \advance\dimen@ii -\topskip
          \advance\dimen@ii \FrameHeightAdjust\relax
        \else  % suspect this is wrong:
          % If the split-to size > feasible room_on_page, rebox it smaller.
          \advance\dimen@.8\pageshrink
          \ifdim\ht\tw@>\dimen@
|           \message{Box too tall; rebox it to \the\dimen@. }%
            \dimen@ii\dimen@
          \else % use natural size
            \dimen@ii\ht\tw@
          \fi
        \fi
        % Re-box contents to desired size \dimen@ii
        \advance\dimen@ii -\fb@frh
        \setbox\tw@\vbox to\dimen@ii \bgroup
        % remove simulated frame and page flexibility:
        \vskip -\fb@frh \@plus-\pagestretch \@minus-.8\pageshrink
        \unvbox\tw@ \unpenalty\unpenalty
        \ifdim\lastkern=-137sp % whole box went to next page
|          \message{box split at beginning! }%
           \egroup \fb@resto@set \eject % (\vskip for frame size was discarded) 
           \fb@adjheight
        \else %
           \egroup \fb@resto@set
           \ifvoid\@tempboxa % it all fit after all
|             \message{box split at end! }%
              \setbox\@tempboxa\box\tw@
           \else % it really did split
|             \message{box split as expected. Its reboxed height is \the\ht\tw@. }%
              \ifdim\wd\tw@>\z@
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%              \centerline{\FrameCommand{\box\tw@}}%  ??? \centerline bad idea
       \hbox{\hskip \saved@totalleftmargin\FrameCommand{\box\tw@}}%
              \else
|               \message{Zero width means likely blank. Don't frame it (guess)}%
                \box\tw@
              \fi
              \hrule \@height\z@
              \eject
              \fb@adjheight
              \put@frame
  \fi\fi\fi\fi\fi
  \ifvoid\@tempboxa\else
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%    \centerline{\FrameCommand{\box\@tempboxa}}%
    \hbox{\hskip\saved@totalleftmargin\FrameCommand{\box\@tempboxa}}%
    \nointerlineskip \null %{\showoutput \showlists}
    \penalty-30 \vskip\topsep
  \fi}

\def\fb@adjheight{%
  \vbox to\FrameHeightAdjust{}% get proper baseline skip from above.
  \penalty\@M \nointerlineskip
  \vskip-\FrameHeightAdjust
  \penalty\@M} % useful for tops of pages

\edef\zero@glue{\the\z@skip}

\catcode`\|=\FrameRestore

% Provide configuration commands:
\providecommand\FrameCommand{\fboxrule=\FrameRule \fboxsep=\FrameSep \fbox}
\@ifundefined{FrameRule}{\newdimen\FrameRule \FrameRule=\fboxrule}{}
\@ifundefined{FrameSep} {\newdimen\FrameSep  \FrameSep =3\fboxsep}{}

% Height of frame above first baseline when frame starts a page:
\providecommand\FrameHeightAdjust{6pt}

% \FrameRestore has parts of \@parboxrestore.  See how it is used in the 
% "settings" argument of \MakeFrame.  Previous behavior can be restored by 
% using \@parboxrestore there, or redefining:
% \makeatletter \renewcommand\FrameRestore{\@parboxrestore} \makeatother
\def\FrameRestore{%
  \let\if@nobreak\iffalse
  \let\if@noskipsec\iffalse
%  \let\par\@@par  ??
  \let\-\@dischyph
  \let\'\@acci\let\`\@accii\let\=\@acciii
%  \parindent\z@ \parskip\z@skip    Definitely omit!
%  \everypar{}%  ??
  \linewidth\hsize
%  \@totalleftmargin\z@
%  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
%  \parfillskip\@flushglue \lineskip\normallineskip
%  \baselineskip\normalbaselineskip
  \sloppy
%  \let\\\@normalcr
}

%  Compatibility with previous versions (temporary!):
\let\fram@d=\MakeFramed  \let\endfram@d=\endMakeFramed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This ends the stuff that's lifted from:
% % framed.sty   v 0.8a   21-Jul-2003
% % Copyright (C) 1992-2003 by Donald Arseneau


%--------------------------------------------------------------------
%--------------------------------------------------------------------

\endinput
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
