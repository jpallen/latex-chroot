% This file can be used instead of psslurs.pro, it is only commented
% and indented.
%
% VERSION: 1.0
%
% WARNING! This is a heavy magic! If you want something more understandable,
%   you will have to write it yourself (if it is possible in a stack-oriented
%   language that PostScript is). There are some constants you can
%   change and see what happens, but I think the slurs should be almost
%   always satisfiable. When not, let me know at:
%   standa@hiero.cz
%   Also any bug reports and comments are welcomed.
%
%         Stanislav Kneifl.

/slur@Dict 200 dict def 

% this dictionary is for \setslurtext, overriding some dvips's definitions
/temp@xx@dict 4 dict def temp@xx@dict begin
	/a { moveto ax1 ay1 rmoveto } def
	/V {gsave newpath transform round exch round exch itransform
		exch ax1 add exch ay1 add moveto rulex 0 rlineto 0 ruley neg
		rlineto rulex neg 0 rlineto fill grestore} def
end

TeXDict begin
% get dimen from TeX's string ("125pt" -> 125 PS points)
/GD { dup length 2 sub 0 exch getinterval cvr 1.045 mul} def
% get dimen adjusted to Resolution
/GDAR { dup length 2 sub 0 exch getinterval cvr 4 AR mul 1.045 mul} def
% Adjust to Resolution
/AR { Resolution mul 300 div } def
%  the distances in dvips's PostScript are resolution dependant!
end

slur@Dict begin
/CP /currentpoint load def
/ED { exch def } bind def
/AR { Resolution mul 300 div } def  % stands for Adjust to Resolution,
/VS { dup /ay1 exch ay1 exch linew mul 4 mul add def /ay2 exch ay2 exch linew mul 4 mul add def } def
/y { 3 2 roll ax1 ay1 rmoveto show moveto } def
/M { mul } def
/A { add } def
/SB { sub } def
/P { pop } def
/DP { dup } def
/R { roll } def

/drawseg { 0 0 moveto
	ax1 ay1
		ax1 0.6 mul ax2 0.4 mul add ay1 0.6 mul ay2 0.4 mul add 
		ax1 ax2 add 2 div ay1 ay2 add 2 div curveto
	ax1 0.4 mul ax2 0.6 mul add ay1 0.4 mul ay2 0.6 mul add 
		ax2 ay2
		x2 0 curveto } def

/DS {
	AR /maxe ED
	/ifadjust ED
	/ifdash ED
	AR /m ED         % max height of the slur
	/e ED            % "angularity" of the slur; 0.1 = very angular,
                          %   0.3 = very round
	/aa exch neg def       % what to multiply the height with
                          %   AFTER the max height checking
	/y2 ED           % y coordinate of the end of the slur
	/x2 ED           % x coordinate of the end of the slur
	/y1 ED           % y coordinate of the beginning of the slur
	/x1 ED           % x coordinate of the beginning of the slur
	/yr2 ED
	/yr1 ED
	/internote ED
	/x2 x2 x1 sub def						% x2=x2-x1
	/y2 y2 y1 sub def						% y2=y2-y1
	/sx y2 x2 div def
	/b x2 300 mul Resolution div abs sqrt AR 2 mul def	% b=2*sqrt(x2)
	b 3 AR lt {/b 3 AR def} if			% b=max(b,3)
	b m gt {/b m def} if					% b=min(b,m)
	/aa b aa mul def						% aa=aa*b
	/s 90 x2 y2 atan sub def			% s=90-arctan(x2,y2)   slope of the slur
	/aa aa s cos div def					% aa=aa/cos(s)   height of the slur
	/x2 s neg cos x2 mul s neg sin y2 mul sub def	% x2 = x2*cos(-s) - y2*sin(-s)
																	%  is the length of the slur
	e x2 mul maxe gt { /e maxe x2 div def } if
	/beta e x2 mul aa neg atan def
	beta 90 gt {/beta 180 beta sub def} if
	/ax1 e x2 mul def				% control points
	/ay1 aa def
	/ax2 1 e sub x2 mul def
	/ay2 aa def

% check if the starting and endin vector stay in desired quadrants
% => beta < abs(s)
	beta s abs lt {
		/b aa abs s abs 2 add sin mul s abs 2 add cos div def
		s aa mul 0 lt {
			s cos 0.75 lt { /ax1 ax1 b 1 s cos sub mul 0.5 mul sub def /ay1 ay1 s cos mul 0.8 mul def } if
%              ^^^^                                 ^^^                                ^^^
% (values to play with)
			/ax2 x2 b sub def
		}
		{
			/ax1 b def
			s cos 0.75 lt { /ax2 b 1 s cos sub mul 0.5 mul ax2 add def /ay2 ay2 s cos mul 0.8 mul def } if
%              ^^^^                             ^^^                                    ^^^
		} ifelse
	} if

% align the slur to the staff lines

	gsave
	x1 y1 translate
	s rotate
%	[1 0 sx 1 0 0] concat
	drawseg
	gsave
	initmatrix
	flattenpath
	pathbbox
	exch pop
	sub
	/slh ED            % in slh we have the height of the whole slur
	pop
	grestore

	/yr s aa mul 0 ge { yr1 } { yr2 } ifelse internote div def
	/slh yr slh internote div aa 0 gt { add } { sub } ifelse 2 div def
%	check if the slur gets too close to staff line
	/shift 0 def
	slh 4.45 lt slh -0.5 gt and {
		/slh slh dup truncate sub def
		slh 0 lt { /slh 1 slh add def } if
		aa 0 gt { /slh 1 slh sub def } if

			% slh now contains the position ot the slur top/bottom in the space
			% between the nearest staff lines (from <0,1>), regardless direction

			% slur is too low:
		slh 0.45 lt { /shift 0.45 slh sub def } if
			% slur is too high, but we can be shift it down:
		slh 0.7 gt slh 0.85 lt and { /shift 0.7 slh sub def } if
			% slur is too high, must be shifted up:
		slh 0.85 ge { /shift 1.45 slh sub def } if
	} if

	aa 0 gt { /shift shift neg def } if

	ifadjust 0 eq {
		/shift 0 def
	} if


% and finally draw it...

	grestore
	gsave
	/linew internote 0.06 mul AR def
	linew 4 mul setlinewidth
	1 setlinecap
	0 setlinejoin
	ifdash 1 eq
		{ [internote 8 mul AR internote 5 mul AR] 0 setdash } if
	x1 y1 shift neg 2 mul internote mul 4 AR mul add translate
	s rotate
%	[1 sx 0 1 0 0] concat

% uncomment this to see the control points
%  5 AR setlinewidth ax1 ay1 moveto	0.1 0 rlineto stroke
%  ax2 ay2 moveto 0.1 0 rlineto stroke linew setlinewidth

	drawseg
	1 VS
	drawseg
	-2 VS
	drawseg
	x2 20 AR gt {
		3 VS
		drawseg
	} if
	x2 50 AR gt {
		-4 VS
		drawseg
	} if
	x2 80 AR gt {
		5 VS
		drawseg
	} if
	stroke

	grestore

	% now some \slurtext code...

	/x1 ax1 ax2 add 2 div def          % middle of the slur
	/y1 ay1 ay2 add 2 div def
	x1 s cos mul y1 s sin mul add neg
	y1 s cos mul x1 s sin mul sub
	aa 0 lt {1} {0} ifelse
	end

	% this is a hack to place the slurtext in the middle of the slur.
	% From unknown reasons simple 'ax1 ay1 translate' did not work,
	% so we have to overlay some definitions with our own, namely
	% 'a', which is originally 'moveto' and 'V' for drawing rules.
	% maybe there are some other operations that should be redefined,
	% but for almost all cases this will be sufficient. If you find
	% anything that won't be typeset at the correct position, let me know...

	temp@xx@dict begin
	/dir exch def
	/ay1 exch def
	/ax1 exch def
} def

% crescendos
/DC {
	/y2 ED
	/x2 ED
	/y1 ED
	/x1 ED
	gsave
	1 AR ceiling setlinewidth         % line thickness: this results
	1 setlinecap                      % to exactly 2 pixels in 300 dpi
	1 setlinejoin
	x2 y2 10 AR add moveto            % the 10's specify wideness of the
	x1 y1 lineto                      % open end of the crescendo,
	x2 y2 10 AR sub lineto            % similarly the 11's below
	stroke
	grestore
} def

% half crescendos
/DHC {
	/y2 ED
	/x2 ED
	/y1 ED
	/x1 ED
	gsave
	1 AR ceiling setlinewidth
	1 setlinecap
	1 setlinejoin
	x2 y2 11 AR add moveto
	x1 y1 4 AR add lineto stroke
	x1 y1 4 AR sub moveto
	x2 y2 11 AR sub lineto
	stroke
	grestore
} def

% differenced line

/DLN {
	gsave
	GDAR ceiling setlinewidth
	GDAR exch GDAR neg rlineto
	stroke
	grestore
} def

% sloped line

/DSLN {
	gsave
	GDAR ceiling setlinewidth
	GDAR exch 1.125 mul neg rotate 0 rlineto
	stroke
	grestore
} def

% free line (init & terminate)

/DFLN {
	gsave
	GDAR ceiling setlinewidth
	CP moveto
	lineto
	stroke
	grestore
} def

end

