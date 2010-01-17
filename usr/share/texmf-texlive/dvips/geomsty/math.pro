% This file is adapted from the PostScript code that gets
% included by the psfix filter, provided with Mathematica.
% The only differences are the addition of the first two lines
% (MyDict) and of the abbreviations at the end (starting with /Ma).

%$Revision: 1.3 $
%$Date: 95/06/27 12:16:53 $

/MyDict 200 dict def
MyDict begin

% The externally visible functions are:
%	MathPictureStart- start page.
%	MathPictureEnd	- finish off page.
%	MathSubStart	- start a sub-page.
%	MathSubEnd	- finish off a sub-page.
%	Mdot		- draw a dot.
%	Mtetra		- draw a filled tetragon.
%	Metetra		- draw a filled tetragon with black edges.
%	Mistroke	- intermediate stroke of multi-stroke line/curve.
%	Mfstroke	- final stroke of multi-stroke line/curve.
%	Msboxa		- compute coordinates of text bounding box.
%	Mshowa		- plot characters.
%	MathScale	- compute scaling info to contain array of points.


% The following are only for backwards compatibility with earlier versions
% of Mathematica:
%	Mpstart		- identical to MathPictureStart.
%	Mpend		- identical to MathPictureEnd.
%	Mscale		- like MathScale but without user coordinate info.

/Mpstart {		% - Mpstart -
	MathPictureStart
} bind def

/Mpend {		% - Mpend -
	MathPictureEnd
} bind def

/Mscale {		% [pnts] Mscale -
	0 1 0 1		% [pnts] xbias xscale ybias yscale
	5 -1 roll	% xbias xscale ybias yscale [pnts]
	MathScale	% -
} bind def

%start of ISOLatin1 stuff

/ISOLatin1Encoding dup where
{ pop pop }
{
[
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/space /exclam /quotedbl /numbersign /dollar /percent /ampersand /quoteright
/parenleft /parenright /asterisk /plus /comma /minus /period /slash
/zero /one /two /three /four /five /six /seven
/eight /nine /colon /semicolon /less /equal /greater /question
/at /A /B /C /D /E /F /G
/H /I /J /K /L /M /N /O
/P /Q /R /S /T /U /V /W
/X /Y /Z /bracketleft /backslash /bracketright /asciicircum /underscore
/quoteleft /a /b /c /d /e /f /g
/h /i /j /k /l /m /n /o
/p /q /r /s /t /u /v /w
/x /y /z /braceleft /bar /braceright /asciitilde /.notdef
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
/dotlessi /grave /acute /circumflex /tilde /macron /breve /dotaccent
/dieresis /.notdef /ring /cedilla /.notdef /hungarumlaut /ogonek /caron
/space /exclamdown /cent /sterling /currency /yen /brokenbar /section
/dieresis /copyright /ordfeminine /guillemotleft
/logicalnot /hyphen /registered /macron
/degree /plusminus /twosuperior /threesuperior
/acute /mu /paragraph /periodcentered
/cedilla /onesuperior /ordmasculine /guillemotright
/onequarter /onehalf /threequarters /questiondown
/Agrave /Aacute /Acircumflex /Atilde /Adieresis /Aring /AE /Ccedilla
/Egrave /Eacute /Ecircumflex /Edieresis /Igrave /Iacute /Icircumflex /Idieresis
/Eth /Ntilde /Ograve /Oacute /Ocircumflex /Otilde /Odieresis /multiply
/Oslash /Ugrave /Uacute /Ucircumflex /Udieresis /Yacute /Thorn /germandbls
/agrave /aacute /acircumflex /atilde /adieresis /aring /ae /ccedilla
/egrave /eacute /ecircumflex /edieresis /igrave /iacute /icircumflex /idieresis
/eth /ntilde /ograve /oacute /ocircumflex /otilde /odieresis /divide
/oslash /ugrave /uacute /ucircumflex /udieresis /yacute /thorn /ydieresis
] def
} ifelse

/MFontDict 50 dict def

/MStrCat	% string1 string2 MStrCat string
{
	exch			% s2 s1
	dup length 		% s2 s1 len
	2 index length add	% s2 s1 len
	string			% s2 s1 s
	dup 3 1 roll	 	% s2 s s1 s
	copy			% s2 s s1
	length			% s2 s where
	exch dup		% s2 where s s
	4 2 roll exch		% s s where s2
	putinterval
} def

/MCreateEncoding	% name encoding MCreateEncoding newname
{
	% get base name
	1 index		% name encoding name

	% concatenate (-) and encoding to the name
	255 string cvs
	(-) MStrCat
	1 index MStrCat
	cvn exch		% basename newname encoding

	% make encoding name
	
	(Encoding) MStrCat
	cvn dup where
	{
		exch get
	}
	{
		pop
		StandardEncoding
	} ifelse
	3 1 roll		% vector basename newname

	% make the font if we haven't before
	dup MFontDict exch known not
	{
		1 index findfont
		dup length dict
		begin
			{1 index /FID ne
				{def}
				{pop pop}
			 ifelse} forall
			/Encoding 3 index
			def
			currentdict
		end
		1 index exch definefont pop

		MFontDict 1 index
		null put
	}
	if

	exch pop			% vector newname
	exch pop			% newname
} def

/ISOLatin1 { (ISOLatin1) MCreateEncoding } def
/ISO8859 { (ISOLatin1) MCreateEncoding } def

%end of ISOLatin1 stuff

%
% Include old font names for backward compatibility
%
/Mcopyfont {		% procedure to copy font
	dup
	maxlength
	dict
	exch
	{
	1 index
	/FID
	eq
	{
	pop pop
	}
	{
	2 index
	3 1 roll
	put
	}
	ifelse
	}
	forall
} def

/Plain	/Courier findfont Mcopyfont definefont pop
/Bold	/Courier-Bold findfont Mcopyfont definefont pop
/Italic /Courier-Oblique findfont Mcopyfont definefont pop

% Set up for the start of a page.
/MathPictureStart {	% - MathPictureStart -
	gsave				% -
	Mtransform			% possibly rotate to landscape mode
	Mlmarg				% left_margin
	Mbmarg				% bottom_margin
	translate			% -
	Mwidth				% init_width
	Mlmarg Mrmarg add		% init_width lmarg+rmarg
	sub				% true_width
	/Mwidth exch def		%
	Mheight				% init_height
	Mbmarg Mtmarg add		% init_height tmarg+bmarg
	sub				% true_height
	/Mheight exch def
	/Mtmatrix			% /Mtmatrix
	matrix currentmatrix		% /Mtmatrix text_matrix
	def
	/Mgmatrix			% /Mgmatrix
	matrix currentmatrix		% /Mgmatrix graphics_matrix
	def				% -
} bind def


% Finish off a page.
/MathPictureEnd {
	grestore
} bind def

%MFill fills the drawing area with the current color.
/MFill {
	0 0 		moveto
	Mwidth 0 	lineto
	Mwidth Mheight 	lineto
	0 Mheight 	lineto
	fill
} bind def

% xmin xmax ymin ymax MPlotRegion alters the origin, Mwidth and Mheight 
% so that the picture fills the altered region
/MPlotRegion {		% xmin xmax ymin ymax MPlotRegion
	3 index		% xmin xmax ymin ymax xmin
	Mwidth mul	% xmin xmax ymin ymax xmin_pos
	2 index		% xmin xmax ymin ymax xmin_pos ymin
	Mheight mul	% xmin xmax ymin ymax xmin_pos ymin_pos
	translate	% xmin xmax ymin ymax
	exch sub	% xmin xmax ymax-ymin
	Mheight mul	% xmin xmax new_height
	/Mheight
	exch def	% xmin xmax
	exch sub	% xmax-xmin
	Mwidth mul	% new-width
	/Mwidth
	exch def
} bind def

% Given a rectangle, set it up as a sub-picture.
/MathSubStart {		% xmin ymin xmax ymax MathSubStart <saved state(8)>
	Momatrix
	Mgmatrix Mtmatrix
	Mwidth Mheight		% xmin ymin xmax ymax <ss(8)>
	7 -2 roll		% xmin ymin <ss(8)> xmax ymax
	moveto			% xmin ymin <ss(8)>
	Mtmatrix setmatrix	% xmin ymin <ss(8)>
	currentpoint		% xmin ymin <ss(8)> xmax(t) ymax(t)
	Mgmatrix setmatrix	% xmin ymin <ss(8)> xmax(t) ymax(t)
	9 -2 roll		% <ss(8)> xmax(t) ymax(t) xmin ymin
	moveto			% <ss(8)> xmax(t) ymax(t)
	Mtmatrix setmatrix	% <ss(8)> xmax(t) ymax(t)
	currentpoint		% <ss(8)> xmax(t) ymax(t) xmin(t) ymin(t)
	2 copy translate	% <ss(8)> xmax ymax xmin ymin
	/Mtmatrix matrix currentmatrix def
	3 -1 roll		% <ss(8)> xmax xmin ymin ymax
	exch sub		% <ss(8)> xmax xmin height
	/Mheight exch def	% <ss(8)> xmax xmin
	sub			% <ss(8)> width
	/Mwidth exch def	% <ss(8)>
} bind def


% Restore the saved state left by the matching MathSubStart.
% Note, we also leave with the new Mgmatrix as the current matrix.
/MathSubEnd {		% gmat tmat lm rm bm tm w h MathSubStart -
	/Mheight exch def	% gmat tmat lm rm bm tm w
	/Mwidth exch def	% gmat tmat lm rm bm tm
	/Mtmatrix exch def	% gmat
	dup setmatrix		% gmat
	/Mgmatrix exch def	% -
	/Momatrix exch def	% -
} bind def


% Given a point, draw a dot.
/Mdot {		% x y Mdot -
	moveto		% -
	0 0 rlineto	% -
	stroke		% -
} bind def


% Given 4 points, draw the corresponding filled tetragon.
/Mtetra {	% x0 y0 x1 y1 x2 y2 x3 y3 Mtetra -
	moveto		% x0 y0 x1 y1 x2 y2
	lineto		% x0 y0 x1 y1
	lineto		% x0 y0
	lineto		% -
	fill		% -
} bind def


% Given 4 points, draw the corresponding filled tetragon with black edges.
% Note, this leaves the gray level at 0 (for compatibility with the old
% C code.
/Metetra {	% x0 y0 x1 y1 x2 y2 x3 y3 Metetra -
	moveto		% x0 y0 x1 y1 x2 y2
	lineto		% x0 y0 x1 y1
	lineto		% x0 y0
	lineto		% -
	closepath	% -
	gsave		% -
	fill		% -
	grestore	% -
	0 setgray	% -
	stroke		% -
} bind def


% Mistroke is called to stroke intermediate parts of a path.  It makes
% sure to resynchronize the dashing pattern and to leave the current point
% as the final point of the path.
/Mistroke {	% - Mistroke -
	flattenpath	% -
	0 0 0		% length x y
	{		% length x y new_x new_y (for moves)
	4 2 roll	% length new_x new_y x y
	pop pop		% length new_x new_y
	}
	{		% length x y new_x new_y (for lines)
	4 -1 roll	% length y new_x new_y x
	2 index		% length y new_x new_y x new_x
	sub dup mul	% length y new_x new_y dx*dx
	4 -1 roll	% length new_x new_y dx*dx y
	2 index		% length new_x new_y dx*dx y new_y
	sub dup mul	% length new_x new_y dx*dx dy*dy
	add sqrt	% length new_x new_y dlen
	4 -1 roll	% new_x new_y dlen length
	add		% new_x new_y new_length
	3 1 roll	% new_length new_x new_y
	}
	{		% length x y x1 y1 x2 y2 x3 y3 (for curves)
	stop		% should never be called
	}
	{		% length x y (for closepaths)
	stop		% should never be called
	}
	pathforall	% length x y
	pop pop		% length
	currentpoint	% length final_x final_y
	stroke		% length final_x final_y
	moveto		% length
	currentdash	% length dash_array dash_offset
	3 -1 roll	% dash_array dash_offset length
	add		% dash_array new_offset
	setdash		% -
} bind def


% Mfstroke is called to stroke the final parts of a path.  It resets
% the dashing pattern to compensate for any adjustments made by Mistroke.
/Mfstroke {	% - Mfstroke -
	stroke		% -
	currentdash	% dash_array dash_offset
	pop 0		% dash_array 0
	setdash		% -
} bind def



% Mrotsboxa is the same as Msboxa except that it takes an angle 
% form the stack and the box is calculated for text rendered at this  angle.  
% It gsaves in case we are starting a MathSubStart
% save Mrot so that Msboxa can convert bouding box back to the non-rotated
% coordinate system
% call Mrotcheck to alter the offsets into the rotated system
% converts Mtmatrix to render in the rotated system
% the calls Msboxa which does all the work
% at the end  Mtmatrix is restored and Mrot is reset to 0 
/Mrotsboxa {		% [str..] gx gy sx sy ang Mrotsboxa ...  Msboxa
	gsave		% in case in MathSubStart
	dup		% [str..] gx gy sx sy ang ang
	/Mrot
	exch def	% [str..] gx gy sx sy ang
	Mrotcheck	% [str..] gx gy sx_new sy_new ang
	Mtmatrix	% [str..] gx gy sx sy ang Mtmatrix
	dup
	setmatrix
	7 1 roll	% Mtmatrix [str..] gx gy sx sy ang
	4 index		% Mtmatrix [str..] gx gy sx sy ang gx
	4 index		% Mtmatrix [str..] gx gy sx sy ang gx gy
	translate	% Mtmatrix [str..] gx gy sx sy ang
	rotate		% Mtmatrix [str..] gx gy sx sy
	3 index		% Mtmatrix [str..] gx gy sx sy gx
	-1 mul		% Mtmatrix [str..] gx gy sx sy -gx
	3 index		% Mtmatrix [str..] gx gy sx sy -gx gy
	-1 mul		% Mtmatrix [str..] gx gy sx sy -gx -gy
	translate	% Mtmatrix [str..] gx gy sx sy
	/Mtmatrix	% now change Mtmatrix to be this new currentmatrix
	matrix
	currentmatrix
	def
	grestore	% grestore to deal with MathSubStart
	Msboxa		% Mtmatrix [ x y x y] [ x y x y]
	3  -1 roll	% [x y x y ] [x y x y] Mtmatrix
	/Mtmatrix
	exch def	% restore Mtmatrix
	/Mrot
	0 def		% restore Mrot
} bind def


% Given an array of strings ([str...]), which represent consecutive lines
% of text, a position in graphics coordinates (gx,gy) and a position in
% the bounding box coordinates (sx,sy), compute the low and high coordinates
% of the resulting text, in the [gx gy tx ty] form, which corresponds to
% the point (gx,gy) (in graphics coordinates) plus the offset (tx,ty) (in
% text coordinates).
% Note, Msboxa assumes that the current matrix is the text matrix.
% Mboxout is called in case we are in Mouter to make the box bigger
% Mboxrot adjusts the box to account for a rotation to convert the box
% into a nonrotated coordinate system
%
/Msboxa {	% [str...] gx gy sx sy Msboxa [gx gy tlx tly] [gx gy thx thy]
	newpath			% [str...] gx gy sx sy (just in case)
	5 -1 roll		% gx gy sx sy [str...]
	Mvboxa			% gx gy sx sy blx bly bhx bhy [off...]
	pop			% gx gy sx sy blx bly bhx bhy
	Mboxout			% adjust box for Minner
	6 -1 roll		% gx gy sy blx bly bhx bhy sx
	5 -1 roll		% gx gy sy bly bhx bhy sx blx
	4 -1 roll		% gx gy sy bly bhy sx blx bhx
	Msboxa1			% gx gy sy bly bhy tlx thx
	5 -3 roll		% gx gy tlx thx sy bly bhy
	Msboxa1			% gx gy tlx thx tly thy
	Mboxrot			% adjust box for rotation
	[			% gx gy tlx thx tly thy mark
	7 -2 roll		% tlx thx tly thy mark gx gy
	2 copy			% tlx thx tly thy mark gx gy gx gy
	[			% tlx thx tly thy mark gx gy gx gy mark
	3 1 roll		% tlx thx tly thy mark gx gy mark gx gy
	10 -1 roll		% thx tly thy mark gx gy mark gx gy tlx
	9 -1 roll		% thx thy mark gx gy mark gx gy tlx tly
	]			% thx thy mark gx gy [gx gy tlx tly]
	6 1 roll		% [gx gy tlx tly] thx thy mark gx gy
	5 -2 roll		% [gx gy tlx tly] mark gx gy thx thy
	]			% [gx gy tlx tly] [gx gy thx thy]
} bind def
	
% Msboxa1 is an internal function which, given a bounding box coordinate
% (sz), and the bounding box limits (blz and bhz), computes the actual
% offsets (tlz = (blz-bhz)(sz+1)/2, thz = (blz-bhz)(sz-1)/2).
/Msboxa1 {	% sz blz bhz Msboxa1 tlz thz
	sub		% sz blz-bhz
	2 div		% sz (blz-bhz)/2
	dup		% sz (blz-bhz)/2 (blz-bhz)/2
	2 index		% sz (blz-bhz)/2 (blz-bhz)/2 sz
	1 add		% sz (blz-bhz)/2 (blz-bhz)/2 sz+1
	mul		% sz (blz-bhz)/2 tlz
	3 -1 roll	% (blz-bhz)/2 tlz sz
	-1 add		% (blz-bhz)/2 tlz sz-1
	3 -1 roll	% tlz sz-1 (blz-bhz)/2
	mul		% tlz thz
} bind def


% Given a (non-empty) array of strings ([str...]) calculate the 
% bounding box.  We do this for fixedwidth fonts or nonfixedwidth fonts
% depending upon the setting of Mfixwid.  Mvboxa1 actually does a lot
% of the work.  For nonfixedwidth fonts the length of the bounding
% box length is made to be the summation of [(str)..] Mwidthcal
% ie the maximum length of the strings and xlow
%
/Mvboxa	{ % [str...] Mvboxa xlow ylow xhigh yhigh [off...]
	Mfixwid
	{
	Mvboxa1
	}
	{
	dup		% [str...] [str...]
	Mwidthcal	% [str...] [ w1 w2...]
	0 exch		% [str...] 0 [ w1 w2...] 
	{
	add
	}
	forall		% [str...] length
	exch
	Mvboxa1		% length xlow ylow xhigh yhigh [off...]
	4 index		% length xlow ylow xhigh yhigh [off...] xlow
	7 -1 roll	% xlow ylow xhigh yhigh [off...] xlow length
	add		% xlow ylow xhigh yhigh [off...] new_xhigh
	4 -1 roll
	pop		% xlow ylow yhigh [off...] new_xhigh
	3 1 roll	% xlow ylow new_xhigh yhigh [off...]
	}
	ifelse
} bind def


% Given a (non-empty) array of strings ([str...]) which represent consecutive
% lines of text, compute the total bounding box assuming that we start at
% (0,0) and the array of y offsets to place the lines correctly.
% Note, Mvboxa assumes that the current matrix is the text matrix.
% Note, Mvboxa does not alter the current path.
% The vertical spacing is set so that the bounding boxes of adjacent lines
% are .3 times the width of an `m' apart.
/Mvboxa1 {	% [str...] Mvboxa xlow ylow xhigh yhigh [off...]
	gsave		% [str...]
	newpath		% [str...] (clear path fragments)
	[ true		% [str...] mark true
	3 -1 roll	% mark true [str...]
	{		% mark {true -or- off... Xl Yl Xh Yh false} str
	Mbbox		% mark {true -or- off... Xl Yl Xh Yh false} xl yl xh yh
	5 -1 roll	% mark { - -or- off... Xl Yl Xh Yh} xl yl xh yh first?
	{		% mark xl yl xh yh
	0		% mark xl yl xh yh off1
	5 1 roll	% mark off1 xl yl xh yh
	}		% mark off1 XL YL XH YH
	{		% mark off... Xl Yl Xh Yh xl yl xh yh
	7 -1 roll	% mark off... Xl Xh Yh xl yl xh yh Yl
	exch sub	% mark off... Xl Xh Yh xl yl xh yh-Yl
	(m) stringwidth pop	% mark off... Xl Xh Yh xl yl xh yh-Yl pntsize
	.3 mul		% mark off... Xl Xh Yh xl yl xh yh-Yl fudge
	sub		% mark off... Xl Xh Yh xl yl xh off
	7 1 roll	% mark off... off Xl Xh Yh xl yl xh
	6 -1 roll	% mark off... off Xh Yh xl yl xh Xl
	4 -1 roll	% mark off... off Xh Yh yl xh Xl xl
	Mmin		% mark off... off Xh Yh yl xh XL
	3 -1 roll	% mark off... off Xh Yh xh XL yl
	5 index		% mark off... off Xh Yh xh XL yl off
	add		% mark off... off Xh Yh xh XL YL
	5 -1 roll	% mark off... off Yh xh XL YL Xh
	4 -1 roll	% mark off... off Yh XL YL Xh xh
	Mmax		% mark off... off Yh XL YL XH
	4 -1 roll	% mark off... off XL YL XH YH
	}		% mark off... XL YL XH YH
	ifelse		% mark off... XL YL XH YH
	false		% mark off... XL YL XH YH false
	}		% mark off... XL YL XH YH false
	forall		% mark off... xlow ylow xhigh yhigh false
	{ stop } if	% mark off... xlow ylow xhigh yhigh
	counttomark	% mark off... xlow ylow xhigh yhigh (#off's+4)
	1 add		% mark off... xlow ylow xhigh yhigh (#off's+5)
	4 roll		% xlow ylow xhigh yhigh mark off...
	]		% xlow ylow xhigh yhigh [off...]
	grestore	% xlow ylow xhigh yhigh [off...]
} bind def


% Given a string, compute the bounding box assuming that we start at (0,0).
% Note, the path is assumed to be empty, and we are assumed to be in text
% coordinates.  Allows for long strings.
/Mbbox {	% str Mbbox xlow ylow xhigh yhigh
	1 dict begin
	0 0 moveto		% str
	/temp (T) def
	{	gsave
		currentpoint newpath moveto
		temp 0 3 -1 roll put temp
		false charpath flattenpath currentpoint
		pathbbox
		grestore moveto lineto moveto} forall
	pathbbox
	newpath
	end
} bind def


% Compute the minimum of two numbers.
/Mmin {		% p q Mmin min(p,q)
	2 copy		% p q p q
	gt		% p q p>q?
	{ exch } if	% min(p,q) max(p,q)
	pop		% min(p,q)
} bind def


% Compute the maximum of two numbers.
/Mmax {		% p q Mmax max(p,q)
	2 copy		% p q p q
	lt		% p q p<q?
	{ exch } if	% max(p,q) min(p,q)
	pop		% max(p,q)
} bind def

% Mrotshowa is the same as Mshowa except that it takes an angle
% from the stack and the text is rendered at this angle.
% It saves Mrot (not really needed but saved anyway)
% calls Mrotcheck to adjust the offsets into the rotated coordinate system
% converts Mtmatrix to render in the rotated system
% and calls Mshowa which does all the work
% at the end Mtmatrix is restored and Mrot is reset to zero.
%
/Mrotshowa {	 	%[str..] gx gy sx sy ang Mrotshowa
	dup
	/Mrot
	exch def
	Mrotcheck
	Mtmatrix	%[str..] gx gy sx sy ang Mtmatrix
	dup
	setmatrix
	7 1 roll	%Mtmatrix [str..] gx gy sx sy ang
	4 index		%Mtmatrix [str..] gx gy sx sy ang gx
	4 index		%Mtmatrix [str..] gx gy sx sy ang gx gy
	translate
	rotate		%Mtmatrix [str..] gx gy sx sy
	3 index
	-1 mul
	3 index
	-1 mul		%Mtmatrix [str..] gx gy sx sy -gx -gy
	translate
	/Mtmatrix
	matrix
	currentmatrix
	def		%Mtmatrix [str..] gx gy sx sy
	Mgmatrix setmatrix
	Mshowa		%Mtmatrix
	/Mtmatrix
	exch def
	/Mrot 0 def	% restore Mrot
} bind def
	
%
% Given an array of strings ([str...]), which represent consecutive lines
% of text, a position in graphics coordinates (gx,gy) and a position in
% the bounding box coordinates (sx,sy), display the strings.
% Mboxout is called in case we are in Mouter
%
/Mshowa {	% [str...] gx gy sx sy Mshowa -
	4 -2 roll	% [str...] sx sy gx gy
	moveto		% [str...] sx sy
	2 index		% [str...] sx sy [str...]
	Mtmatrix setmatrix	% [str...] sx sy [str...]
	Mvboxa		% [str...] sx sy tlx tly thx thy [off...]
	7 1 roll	% [str...] [off...] sx sy tlx tly thx thy
	Mboxout
	6 -1 roll	% [str...] [off...] sy tlx tly thx thy sx
	5 -1 roll	% [str...] [off...] sy tly thx thy sx tlx
	4 -1 roll	% [str...] [off...] sy tly thy sx tlx thx
	Mshowa1		% [str...] [off...] sy tly thy relx
	4 1 roll	% [str...] [off...] relx sy tly thy
	Mshowa1		% [str...] [off...] relx rely
	rmoveto		% [str...] [off...]
	currentpoint	% [str...] [off...] x y
	Mfixwid
	{
	Mshowax
	}
	{
	Mshoway
	}
	ifelse
	pop pop pop pop
	Mgmatrix setmatrix
} bind def


% This is used for fixedwidth fonts
% It simply shows each string and advances the y direction by the offset
%
/Mshowax {	
	0 1
        4 index length  % [str...] [off...] x y 0 1 (#strings)
        -1 add          % [str...] [off...] x y 0 1 (#strings-1)
        {               % [str...] [off...] x y strnum
        2 index         % [str...] [off...] x y strnum x
        4 index         % [str...] [off...] x y strnum x [off...]
        2 index         % [str...] [off...] x y strnum [off...] strnum
        get             % [str...] [off...] x y strnum x off
        3 index         % [str...] [off...] x y strnum x off y
        add             % [str...] [off...] x y strnum x Y
        moveto          % [str...] [off...] x y strnum
        4 index         % [str...] [off...] x y strnum [str...]
        exch get        % [str...] [off...] x y str
	Mfixdash
	{
	Mfixdashp		
	}
	if
        show            % [str...] [off...] x y
        } for           % [str...] [off...] x y
} bind def

% Fix if all dashes and length > 1
/Mfixdashp {		% str
	dup
	length		% str n
	1
	gt		% str bool
	1 index		% str bool str
	true exch	% str bool true str
	{
	45
	eq
	and
	} forall
	and		% str bool
	{
	gsave
	(--)		
	 stringwidth pop
	(-)
	stringwidth pop
	sub
	2 div		% str lenfix
	0 rmoveto	% str
	dup		% str str
	length
	1 sub		% str len-1
	{
	(-)
	show
	}
	repeat
	grestore
	}
	if		% x y str
} bind def	


% This is for non-fixedwidth fonts
% It shows each character individually advancing the x position by
% the maximum width of any character in that position
%
/Mshoway {
        3 index		% [str...] [off...] x y [str...]
        Mwidthcal	% [str...] [off...] x y [w1 w2 w3...]
        5 1 roll	% [w1 w2 w3..] [str...] [off...] x y
	0 1		% [w1 w2 w3..] [str...] [off...] x y 0 1
	4 index length	% [w1 w2 w3..] [str...] [off...] x y 0 1 (#strings)
	-1 add		% [w1 w2 w3..] [str...] [off...] x y 0 1 (#strings-1)
	{		% [w1 w2 w3..] [str...] [off...] x y strnum
	2 index		% [w1 w2 w3..] [str...] [off...] x y strnum x
	4 index		% [w1 w2 w3..] [str...] [off...] x y strnum x [off...]
	2 index		% [w1 w2 w3..] [str...] [off...] x y
			%			strnum [off...] strnum
	get		% [w1 w2 w3..] [str...] [off...] x y strnum x off
	3 index		% [w1 w2 w3..] [str...] [off...] x y strnum x off y
	add		% [w1 w2 w3..] [str...] [off...] x y strnum x Y
	moveto		% [w1 w2 w3..] [str...] [off...] x y strnum
	4 index		% [w1 w2 w3..] [str...] [off...] x y strnum [str...]
	exch get	% [w1 w2 w3..] [str...] [off...] x y str
	[
	6 index		% [w1 w2 w3..] [str...] [off...] x y str [ [w1 w2..]
	aload
	length		% [w1 w2 w3..] [str...] [off...] x y str [ w1 w2.. len
	2 add
	-1 roll		% [w1 w2 w3..] [str...] [off...] x y [ w1 w2.. str
	{
	pop		% [w1 w2 w3..] [str...] [off...] x y [ w1 c2.. str am
	Strform		% [w1 w2 w3..] [str...] [off...] x y [ w1 w2.. str 1str
	stringwidth
	pop
	neg 
	exch		% [w1 w2 w3..] [str...] [off...] x y [ w1 w2..
			%					str -cm cn
	add
	0 rmoveto	% [w1 w2 w3..] [str...] [off...] x y [ w1 w2.. str
	}
	exch
	kshow		% [w1 w2 w3..] [str...] [off...] x y [
	cleartomark
	} for		% [w1 w2 w3..] [str...] [off...] x y
	pop	
} bind def

%
% This is a central mechanism for dealing with non-fixedwidth fonts.
% Given an array of strings Mwidthcal returns an array of the lengths
% of the longest character in the corresponding positions in the arrays.
% Thus the 4th element of the result is the maximum character width of
% each strin at the 4th position.
%
/Mwidthcal {		% [(abc) (abc) ..] Mwidthcal [w1 w2 w3 ...]
	[
	exch		% [ [(abc) (abd) ..]
	{
	Mwidthcal1
	}
	forall
	]		% [[w w w] [w w w] ..]
	[		% call this [chr ..] now
	exch		% [ [chr ..]
	dup		% [ [chr ..] [chr ..]
	Maxlen		% [ [chr ..] maxlen 
	-1 add
	0 1
	3 -1 roll	% [chr ..] [ [chr ..] 0 1 maxlen-1
	{
	[		% [chr ..] [ [chr ..] n [
	exch		% [chr ..] [ [chr ..] [ n
	2 index		% [chr ..] [ [chr ..] [ n [chr ..] 
	{		 
	1 index	
	Mget		% [chr ..] [ [chr ..] [ n [w1 w2 ..] n
	exch		% [chr ..] [ [chr ..] [ wn n
	}
	forall		
	pop		% [chr ..] [ [chr ..] [ w1 w2 w3 
	Maxget		% [chr ..] [ [chr ..] wmax
	exch		% [chr ..] [ wmax [chr ..]
	}
	for
	pop
	]		% [ wmax1 wmax2 wmax3 ..]
	Mreva
} bind def

%Reverse an array
/Mreva	{		%[a b c ..] Mreva [.. c b a]
	[
	exch		%[ [a b c ..]
	aload
	length		%[a b c .. len
	-1 1		%[a b c .. len -1 1
	{1 roll}
	for
	]		%[.. c b a]
} bind def

% take an array and an index and return that element if index exits
% if array not long enougth return zero
/Mget	{		%[a b c d..] index
	1 index
	length		%[a b c d..] index len
	-1 add
	1 index		%[a b c d..] index (len-1) index
	ge
	{
	get		%if long enough return entry
	}
	{
	pop pop
	0		%if not long enough return zero
	}
	ifelse
} bind def

%Take an array of arrays and return the longest length
/Maxlen	{		%[ arr1 arr2 arr3 ] Maxlen maxlen
	[		%[ arr1 arr2 arr3 ] [
	exch		%[ [ arr1 arr2 arr3 ]
	{
	length
	}
	forall		%[ len1 len2 len3.. 
	Maxget
} bind def

%Take a series of numbers starting with [ and return the largest member
/Maxget	{		%[n1 n2 n3 .. Maxget nmax
	counttomark	%[n1 n2 n3 .. len
	-1 add		%[n1 n2 n3 .. len-1
	1 1		%[n1 n2 n3 .. len 1 1
	3 -1 roll	%[n1 n2 n3 .. 1 1 (len-1)
	{
	pop
	Mmax
	}
	for		%[ nmax
	exch		% nmax [
	pop		% nmax
} bind def

%Take a string and return an array of the lengths of the characters
/Mwidthcal1 { % str Mwidthcal1 [w1 w2 w3 ..]
	[
	exch		%[ (str)
	{
	Strform
	stringwidth
	pop
	}
	forall		%[w1 w2 w3 ..
	]		%[w1 w2 w3 ..]
} bind def

%put a string onto the stack
/Strform {		% num
	/tem (x) def
	tem 0
	3 -1 roll
	put
	tem
} bind def

%/Mwidmax {		% [str...]
%	dup		% [str...] [str...]	
%	[		% [str...] [str...] [
%	exch		% [str...] [ [str...]
%	{
%	stringwidth
%	pop
%	}
%	forall		% [str...] [ w1 w2 ... wm wn
%	0
%	counttomark	% [str...] [ w1 w2 ... wm wn 0 n
%	-2 add		% [str...] [ w1 w2 ... wm wn 0 (n-1)
%	1 exch		% [str...] [ w1 w2 ... wm wn 0 1 (n-1)
%	1 exch		% [str...] [ w1 w2 ... wm wn 0 1 1 (n-1)
%	{
%	3 index		% [str...] [ w1 w2 ... wm wn num pos wm
%	3 index		% [str...] [ w1 w2 ... wm wn num pos wm wn
%	ge
%	{		% wm >= wn
%	exch pop
%	exch pop	% [str...] [ w1 w2 ... wm num
%	}
%	{		% wm < wn
%	pop
%	3 -1 roll	
%	pop		% [str...] [ w1 w2 ... wn pos   < pos -> num >
%	}
%	ifelse		% [str...] [ w1 w2 ... wmax nmax
%	}
%	for		% [str...] [ wmax nmax
%	4 1 roll
%	pop pop		% nmax [str...]
%	length		% nmax len
%	-1 add		% nmax (len - 1)
%	exch
%	sub		% max_pos
%} bind def


% Mshowa1 is an internal routine which, given a bounding box coordinate
% (sz), and the bounding box limits if we started drawing at 0 (tlz and thz),
% computes the offset at which to start drawing
% (relz = (sz-1)tlz/2 - (sz+1)thz/2 = sz(tlz-thz)/2-(tlz+thz)/2).
/Mshowa1 {	% sz tlz thz Mshowa1 relz
	2 copy		% sz tlz thz tlz thz
	add		% sz tlz thz tlz+thz
	4 1 roll	% tlz+thz sz tlz thz
	sub		% tlz+thz sz tlz-thz
	mul		% tlz+thz sz(tlz-thz)
	sub		% tlz+thz-sz(tlz-thz)
	-2 div		% sz(tlz-thz)/2-(tlz+thz)/2
} bind def


% Given the x and y scaling to user coordinates and an array of points to
% fit (xbias xscale ybias yscale [pnts]), set up the scaling.  The array
% must contain atleast two points, and the last two must be of the form
% [gxlow gylow 0 0] and [gxhigh gyhigh 0 0].
% Note, MathScale assumes that we are already scaled so that the active area
% is the rectangle [0,Mwidth-Mlmarg-Mrmarg]x[0,Mheight-Mbmarg-Mtmarg].
% also keep bias and scale info for PostScript commands
/MathScale {		% <user> [pnts] MathScale -
	Mwidth			% <user> [pnts] width
	Mheight			% <user> [pnts] width height
	Mlp			% <user> Ax Ay Bx By
	translate		% <user> Ax Ay
	scale			% <user>
	/yscale exch def
	/ybias exch def
	/xscale exch def
	/xbias exch def
	/Momatrix			% this transforms from
	xscale yscale matrix scale	% Original to Display coordinates
	xbias ybias matrix translate
	matrix concatmatrix def
	/Mgmatrix		% /Mgmatrix
	matrix currentmatrix	% /Mgmatrix graphics_matrix
	def			% -
} bind def


% Given a non-empty array of points to fit ([p]) and a maximum width (sx)
% and height (sy) find the largest scale (Ax and Ay) and offsets (Bx and By)
% such that the transformation
%	[gx gy tx ty] -> (Ax gx + tx + bx, Ay gy + ty + By)
% maps the points into the rectangle [0,sx]x[0,sy]
/Mlp {		% [p] sx sy Mlp Ax Ay Bx By
	3 copy		% [p] sx sy [p] sx sy
	Mlpfirst	% [p] sx sy Ax Ay
	{		% [p] sx sy Ax Ay
	Mnodistort	% [p] sx sy Ax Ay nodistort?
	{		% [p] sx sy Ax Ay
	Mmin		% [p] sx sy A
	dup		% [p] sx sy Ax Ay
	} if		% [p] sx sy Ax Ay
	4 index		% [p] sx sy Ax Ay [p]
	2 index		% [p] sx sy Ax Ay [p] Ax
	2 index		% [p] sx sy Ax Ay [p] Ax Ay
	Mlprun		% [p] sx sy Ax Ay ctx wtx cgx wgx cty wty cgy wgy
	11 index	% [p] sx sy Ax Ay ctx wtx cgx wgx cty wty cgy wgy sx
	11 -1 roll	% [p] sx sy Ay ctx wtx cgx wgx cty wty cgy wgy sx Ax
	10 -4 roll	% [p] sx sy Ay cty wty cgy wgy sx Ax ctx wtx cgx wgx
	Mlp1		% [p] sx sy Ay cty wty cgy wgy Ax Bx xok?
	8 index		% [p] sx sy Ay cty wty cgy wgy Ax Bx xok? sy
	9 -5 roll	% [p] sx sy Ax Bx xok? sy Ay cty wty cgy wgy
	Mlp1		% [p] sx sy Ax Bx xok? Ay By yok?
	4 -1 roll	% [p] sx sy Ax Bx Ay By yok? xok?
	and		% [p] sx sy Ax Bx Ay By ok?
	{ exit } if	% [p] sx sy Ax Bx Ay By
	3 -1 roll	% [p] sx sy Ax Ay Bx By
	pop pop		% [p] sx sy Ax Ay
	} loop		% [p] sx sy Ax Bx Ay By
	exch		% [p] sx sy Ax Bx By Ay
	3 1 roll	% [p] sx sy Ax Ay Bx By
	7 -3 roll	% Ax Ay Bx By [p] sx sy
	pop pop pop	% Ax Ay Bx By
} bind def


% Given an array of points in the [gx gy tx ty] form, with the last two
% being [gxlow gylow 0 0] and [gxhigh gyhigh 0 0], and the width and height
% (sx and sy) in which to fit them, compute the maximum scaling (Ax and Ay).
/Mlpfirst {	% [pnts] sx sy Mlpfirst Ax Ay
	3 -1 roll	% sx sy [pnts]
	dup length	% sx sy [pnts] #pnts
	2 copy		% sx sy [pnts] #pnts [pnts] #pnts
	-2 add		% sx sy [pnts] #pnts [pnts] #pnts-2
	get		% sx sy [pnts] #pnts [gxl gyl 0 0]
	aload		% sx sy [pnts] #pnts gxl gyl 0 0 [gxl gyl 0 0]
	pop pop pop	% sx sy [pnts] #pnts gxl gyl
	4 -2 roll	% sx sy gxl gyl [pnts] #pnts
	-1 add		% sx sy gxl gyl [pnts] #pnts-1
	get		% sx sy gxl gyl [gxh gyh 0 0]
	aload		% sx sy gxl gyl gxh gyh 0 0 [gxh gyh 0 0]
	pop pop pop	% sx sy gxl gyl gxh gyh
	6 -1 roll	% sy gxl gyl gxh gyh sx
	3 -1 roll	% sy gxl gyl gyh sx gxh
	5 -1 roll	% sy gyl gyh sx gxh gxl
	sub		% sy gyl gyh sx delx
	div		% sy gyl gyh Ax
	4 1 roll	% Ax sy gyl gyh
	exch sub	% Ax sy dely
	div		% Ax Ay
} bind def


% Given a non-empty array of points to fit ([pnts]) and scale factors
% for graphics->text (Ax and Ay), compute the limiting points.
/Mlprun {	% [pnts] Ax Ay Mlprun ctx wtx cgx wgx cty wty cgy wgy
	2 copy		% [pnts] Ax Ay Ax Ay
	4 index		% [pnts] Ax Ay Ax Ay [pnts]
	0 get		% [pnts] Ax Ay Ax Ay [first]
	dup		% [pnts] Ax Ay Ax Ay [first] [first]
	4 1 roll	% [pnts] Ax Ay [first] Ax Ay [first]
	Mlprun1		% [pnts] Ax Ay [first] fx fy
	3 copy		% [pnts] Ax Ay [low] lx ly [high] hx hy
	8 -2 roll	% [pnts] [low] lx ly [high] hx hy Ax Ay
	9 -1 roll	% [low] lx ly [high] hx hy Ax Ay [pnts]
	{		% [low] lx ly [high] hx hy Ax Ay [pnt]
	3 copy		% [low] lx ly [high] hx hy Ax Ay [pnt] Ax Ay [pnt]
	Mlprun1		% [low] lx ly [high] hx hy Ax Ay [pnt] px py
	3 copy		% [low] lx ly [high] hx hy Ax Ay [pnt] px py [pnt] px py
	11 -3 roll	% [low] lx ly Ax Ay [pnt] px py [pnt] px py [high] hx hy
	/gt Mlpminmax	% [low] lx ly Ax Ay [pnt] px py [high] hx hy
	8 3 roll	% [low] lx ly [high] hx hy Ax Ay [pnt] px py
	11 -3 roll	% [high] hx hy Ax Ay [pnt] px py [low] lx ly
	/lt Mlpminmax	% [high] hx hy Ax Ay [low] lx ly
	8 3 roll	% [low] lx ly [high] hx hy Ax Ay
	} forall	% [low] lx ly [high] hx hy Ax Ay
	pop pop pop pop	% [low] lx ly [high]
	3 1 roll	% [low] [high] lx ly
	pop pop		% [low] [high]
	aload pop	% [low] hgx hgy htx hty
	5 -1 roll	% hgx hgy htx hty [low]
	aload pop	% hgx hgy htx hty lgx lgy ltx lty
	exch		% hgx hgy htx hty lgx lgy lty ltx
	6 -1 roll	% hgx hgy hty lgx lgy lty ltx htx
	Mlprun2		% hgx hgy hty lgx lgy lty ctx wtx
	8 2 roll	% ctx wtx hgx hgy hty lgx lgy lty
	4 -1 roll	% ctx wtx hgx hgy lgx lgy lty hty
	Mlprun2		% ctx wtx hgx hgy lgx lgy cty wty
	6 2 roll	% ctx wtx cty wty hgx hgy lgx lgy
	3 -1 roll	% ctx wtx cty wty hgx lgx lgy hgy
	Mlprun2		% ctx wtx cty wty hgx lgx cgy wgy
	4 2 roll	% ctx wtx cty wty cgy wgy hgx lgx
	exch		% ctx wtx cty wty cgy wgy lgx hgx
	Mlprun2		% ctx wtx cty wty cgy wgy cgx wgx
	6 2 roll	% ctx wtx cgx wgx cty wty cgy wgy
} bind def


% Given scale factors for graphics->text (Ax and Ay) and a point in the
% [gx gy tx ty] form, return the text x and y coordinate that results.
/Mlprun1 {	% Ax Ay [gx gy tx ty] Mlprun1 rx ry
	aload pop	% Ax Ay gx gy tx ty
	exch		% Ax Ay gx gy ty tx
	6 -1 roll	% Ay gx gy ty tx Ax
	5 -1 roll	% Ay gy ty tx Ax gx
	mul add		% Ay gy ty rx
	4 -2 roll	% ty rx Ay gy
	mul		% ty rx Ay*gy
	3 -1 roll	% rx Ay*gy ty
	add		% rx ry
} bind def


% Given a low and high coordinate, compute the center and width.
/Mlprun2 {	% low high Mlprun2 center width
	2 copy		% low high low high
	add 2 div	% low high (low+high)/2
	3 1 roll	% (low+high)/2 low high
	exch sub	% (low+high)/2 high-low
} bind def


% Given two points stored as [gx gy tx ty] followed by the scaled
% result (rx, ry), and a comparison function (lt or gt) leave the
% point which is the minimum (or maximum) in each dimension.
/Mlpminmax {	% [pnt1] r1x r1y [pnt2] r2x r2y cmp Mlpminmax [pnt] x y
	cvx		% [pnt1] r1x r1y [pnt2] r2x r2y cmp
	2 index		% [pnt1] r1x r1y [pnt2] r2x r2y cmp r2x
	6 index		% [pnt1] r1x r1y [pnt2] r2x r2y cmp r2x r1x
	2 index		% [pnt1] r1x r1y [pnt2] r2x r2y cmp r2x r1x cmp
	exec		% [pnt1] r1x r1y [pnt2] r2x r2y cmp take2?
	{		% [pnt1] r1x r1y [pnt2] r2x r2y cmp
	7 -3 roll	% [pnt2] r2x r2y cmp [pnt1] r1x r1y
	4 -1 roll	% [pnt2] r2x r2y [pnt1] r1x r1y cmp
	} if		% [pnt1] r1x r1y [pnt2] r2x r2y cmp
	1 index		% [pnt1] r1x r1y [pnt2] r2x r2y cmp r2y
	5 index		% [pnt1] r1x r1y [pnt2] r2x r2y cmp r2y r1y
	3 -1 roll	% [pnt1] r1x r1y [pnt2] r2x r2y r2y r1y cmp
	exec		% [pnt1] r1x r1y [pnt2] r2x r2y take2y?
	{		% [gx ? tx ?] rx ? [? gy ? ty] ? ry
	4 1 roll	% [gx ? tx ?] rx ry ? [? gy ? ty] ?
	pop		% [gx ? tx ?] rx ry ? [? gy ? ty]
	5 -1 roll	% rx ry ? [? gy ? ty] [gx ? tx ?]
	aload		% rx ry ? [? gy ? ty] gx ? tx ? [gx ? tx ?]
	pop pop		% rx ry ? [? gy ? ty] gx ? tx
	4 -1 roll	% rx ry ? gx ? tx [? gy ? ty]
	aload pop	% rx ry ? gx ? tx ? gy ? ty
	[		% rx ry ? gx ? tx ? gy ? ty mark
	8 -2 roll	% rx ry ? tx ? gy ? ty mark gx ?
	pop		% rx ry ? tx ? gy ? ty mark gx
	5 -2 roll	% rx ry ? tx ? ty mark gx gy ?
	pop		% rx ry ? tx ? ty mark gx gy
	6 -2 roll	% rx ry ? ty mark gx gy tx ?
	pop		% rx ry ? ty mark gx gy tx
	5 -1 roll	% rx ry ? mark gx gy tx ty
	]		% rx ry ? [pnt]
	4 1 roll	% [pnt] rx ry ?
	pop		% [pnt] rx ry
	}
	{		% [gx gy tx ty] rx ry ? ? ?
	pop pop pop	% [pnt] rx ry
	} ifelse	% [pnt] rx ry
} bind def


% Given a size (s), graphics->text scale (A), text center (ct), text
% width (wt), graphics center (cg) and graphics width (wg), compute
% a new graphics->text scale (Anew) and offset (B) and whether or not
% we are done.
% Note, the mysterious .99999 is magic juju which is supposed to ward
% off the possibility that floating point errors would cause this
% routine to return the old A and yet claim not-done.
/Mlp1 {		% s A ct wt cg wg Mlp1 Anew B done?
	5 index		% s A ct wt cg wg s
	3 index	sub	% s A ct wt cg wg s-wt
	5 index		% s A ct wg cg wg s-wt A
	2 index mul	% s A ct wg cg wg s-wt A*wg
	1 index		% s A ct wg cg wg s-wt A*wg s-wt
	le		% s A ct wg cg wg s-wt fits?
	1 index		% s A ct wg cg wg s-wt fits? s-wt
	0 le		% s A ct wg cg wg s-wt fits? impossible?
	or		% s A ct wg cg wg s-wt done?
	dup		% s A ct wg cg wg s-wt done? done?
	not		% s A ct wg cg wg s-wt done? notdone?
	{		% s A ct wg cg wg s-wt done? (not done case)
	1 index		% s A ct wg cg wg s-wt done? s-wt
	3 index	div	% s A ct wg cg wg s-wt done? (s-wt)/wg
	.99999 mul	% s A ct wg cg wg s-wt done? Anew
	8 -1 roll	% s ct wg cg wg s-wt done? Anew A
	pop		% s ct wg cg wg s-wt done? Anew
	7 1 roll	% s Anew ct wg cg wg s-wt done?
	}
	if		% s Anew ct wg cg wg s-wt done?
	8 -1 roll	% Anew ct wg cg wg s-wt done? s
	2 div		% Anew ct wg cg wg s-wt done? s/2
	7 -2 roll	% Anew cg wg s-wt done? s/2 ct wg
	pop sub		% Anew cg wg s-wt done? s/2-ct
	5 index		% Anew cg wg s-wt done? s/2-ct Anew
	6 -3 roll	% Anew done? s/2-ct Anew cg wg s-wt
	pop pop		% Anew done? s/2-ct Anew cg
	mul sub		% Anew done? s/2-ct-Anew*cg
	exch		% Anew B done?
} bind def


% The following are the workings of the tick, axes and plot labels.
% NOTE a possible source of confusion is that for xticks ie tickmarks on
% the x axis we keep y information and vice versa for yticks
%
%	When Minner is found then
%
% assumes that box starts at zero on the left lower side
%
%		0)	if outflag = 1 then intop = 0, inrht = 0 outflag = 0
%		1)	Save intop 	largest top of box 
%		2)	Save inrht 	largest rht of box
%		3)	set inflag	notifies that inner marks are present
%
%	When Mouter is found then
%
%	if inflag is set then
%		1)	get vecx and vecy off the stack (points in direcn to move)
%		2)	vecx < 1 xadrht = inrht*abs(vecx)
%		3)	vecx > 1 xadlft = inrht*abs(vecx)
%		4)	vecy < 1 yadtop = intop*abs(vecy)
%		5)	vecy > 1 yadbot = intop*abs(vecy)
%		6)	set outflag = 1
%		7)	clear inflag, inrht, intop
%	guaranteed to be zero if no inner is present??
%
%
%	These all have effects in Mrotsboxa and Mrotshowa
%		check inflag and if set
%
%		1) increase top of bbox by yadtop
%		2) decrease bot of bbox by yadbot
%		3) increase rht of bbox by xadrht
%		4) increase lft of bbox by xadlft
%		5) clear outflag, yadtop, yadbot,
%			         xadrht, xadlft
%
%/ 
 
/intop 0 def
/inrht 0 def
/inflag 0 def
/outflag 0 def
/xadrht 0 def
/xadlft 0 def
/yadtop 0 def
/yadbot 0 def

% This saves the top right corner of the bounding box as a side effect
% This is to allow the adjustment of text placed with Mouter so that
% it misses the Minner text.  It is assumed that the ang is 0
% in the same way it is assumed that the text of Mouter is 0 or 90
%
/Minner { 	% [(str)] gx gy sx sy ang Minner [(str)] gx gy sx sy ang
	outflag 	% do a bit of tidying up if necessary
	1
	eq
	{
	/outflag 0 def
	/intop 0 def
	/inrht 0 def
	} if		
	5 index		% [(str)] gx gy sx sy ang [(str)]
	gsave
	Mtmatrix setmatrix
	Mvboxa pop	% [(str)] gx gy sx sy ang xlow ylow xhigh yhigh
	grestore
	3 -1 roll	% [(str)] gx gy sx sy ang xlow xhigh yhigh ylow
	pop		% [(str)] gx gy sx sy ang xlow xhigh yhigh
	dup		% [(str)] gx gy sx sy ang xlow xhigh yhigh yhigh
	intop		% is intop smaller than yhigh ?
	gt
	{
	/intop		% update if it is 
	exch def
	}
	{ pop }		% pop if it is not
	ifelse		% [(str)] gx gy sx sy ang xlow xhigh
	dup		% [(str)] gx gy sx sy ang xlow xhigh xhigh	
	inrht		% is inrht smaller than xhigh
	gt
	{
	/inrht		% update if it is
	exch def
	}
	{ pop }		% pop if it is no
	ifelse		% [(str)] gx gy sx sy ang xlow
	pop		% [(str)] gx gy sx sy ang
	/inflag		% set the inflag
	1 def
} bind def

% This takes two number off the stack and uses them as a vector in graphics
% coordinates which points in the direction in which the Mouter text is to move
% it calculates the bouding box adjustments yadtop yadbot xadrht and xadlft
% these are in Mboxout to adjust the bounding box to compensate.
/Mouter {		% vecx vecy Mouter ..
	/xadrht 0 def	% reset everything
	/xadlft 0 def
	/yadtop 0 def
	/yadbot 0 def
	inflag		% was there an inflag ?
	1 eq
	{
	dup		% vecx vecy vecy
	0 lt
	{
	dup		% vecx vecy vecy
	intop		% vecx vecy vecy intop
	mul
	neg		% vecx vecy -vecy*intop
	/yadtop 	% make into yadtop
	exch def	% vecx vecy
	} if
	dup		% vecx vecy vecy
	0 gt
	{
	dup		% vecx vecy vecy
	intop		% vecx vecy vecy intop
	mul		% vecx vecy vecy*intop	
	/yadbot		% make into yadbot
	exch def	% vecx vecy
	}
	if
	pop		% vecx
	dup		% vecx vecx
	0 lt
	{
	dup		% vecx vecx
	inrht		% vecx vecx inrht
	mul
	neg		% vecx -vecx*inrht
	/xadrht		% make into xadrht
	exch def	% vecx
	} if
	dup		% vecx vecx
	0 gt
	{
	dup		% vecx vecx
	inrht		% vecx vecx inrht
	mul		% vecx vecx*inrht
	/xadlft		% make into xadlft
	exch def
	} if
	pop		%
	/outflag 1 def	% set outflag
	}
	{ pop pop}	%
	ifelse
	/inflag 0 def
	/inrht 0 def
	/intop 0 def
} bind def	

%
% This adjusts the bounding box to account for adjacent text
% This allows the two text strings to avoid each other 
% current matrix is the text matrix
/Mboxout {	% tlx tly thx thy Mboxout new_tlx new_tly new_thx new_thy
	outflag		% do nothing unless Minner was found 
	1
	eq
	{
	4 -1
	roll		% tly thx thy tlx 
	xadlft
	leadjust
	add		% tly thx thy tlx xadlft+lead
	sub		% tly thx thy tlx_new
	4 1 roll	% tlx_new tly thx thy
	3 -1
	roll		% tlx_new thx thy tly
	yadbot		% tlx_new thx thy tly yadbot
	leadjust	% tlx_new thx thy tly yadbot lead
	add		% tlx_new thx thy tly yadbot+lead
	sub		% tlx_new thx thy tly_new
	3 1
	roll		% tlx_new tly_new thx thy
	exch		% tlx_new tly_new thy thx
	xadrht		% tlx_new tly_new thy thx xadrht
	leadjust	% tlx_new tly_new thy thx xadrht lead
	add		% tlx_new tly_new thy thx xadrht+lead
	add		% tlx_new tly_new thy thx_new
	exch		% tlx_new tly_new thx_new thy
	yadtop		% tlx_new tly_new thx_new thy yadtop
	leadjust	% tlx_new tly_new thx_new thy yadtop lead
	add		% tlx_new tly_new thx_new thy yadtop+lead
	add		% tlx_new tly_new thx_new thy_new 
	/outflag 0 def  % reset everything to 0
	/xadlft 0 def
	/yadbot 0 def
	/xadrht 0 def
	/yadtop 0 def
	} if
} bind def


/leadjust {
	(m) stringwidth pop
	.5 mul
} bind def


% The offsets sx and sy refer to the graphics coordinate system 
% thus they must be altered if a rotation has taken place.
% We must also change the bounding box computations for Minner
%
/Mrotcheck {		% sx sy ang Mrotcheck new_sx new_sy ang
	dup
	90
	eq
	{
%
% Mouter only applies to strings which are either at 0 or 90
% sort out the box adjust factors
%
%	xadrht -> yadbot
%	xadlft -> yadtop
%	yadtop -> xadrht
%	yadbot -> xadlft
	yadbot
	/yadbot
	xadrht
	def	
	/xadrht
	yadtop
	def
	/yadtop
	xadlft
	def
	/xadlft
	exch
	def
	}
	if
	dup		% sx sy ang ang
	cos	 	% sx sy ang Cos 
	1 index		% sx sy ang Cos	ang
	sin		% sx sy ang Cos Sin
	Checkaux	% new_sx sx sy ang 
	dup		% new_sx sx sy ang ang
	cos		% new_sx sx sy ang Cos
	1 index		% new_sx sx sy ang Cos ang
	sin neg		% new_sx sx sy ang Cos -Sin
	exch		% new_sx sx sy ang -Sin Cos
	Checkaux	% new_sx new_sy sx sy ang
	3 1 roll	% new_sx new_sy ang sx sy
	pop pop 	% new_sx new_sy ang
} bind def

%
% Checkaux is an auxilliary function for Mrotcheck it multiplies a 
% row vector by a column vector
% 
/Checkaux {		% r1 r2 dumy c1 c2 Checkaux r1 r2 dumy r1*c1+r2*c2
	4 index		% r1 r2 dumy c1 c2 r1	 
	exch		% r1 r2 dumy c1 r1 c2
	4 index		% r1 r2 dumy c1 r1 c2 r2
	mul		% r1 r2 dumy c1 r1 c2*r2
	3 1 roll	% r1 r2 dumy c2*r2 c1 r1
	mul add		% r1 r2 dumy c2*r2+c1*r1
	4 1 roll	% c2*r2+c1*r1 r1 r2 dumy
} bind def

%
% Mboxrot converts the bounding box back from the rotated coordinate
% system to the Mgmatrix system to compensate for a rotation
% It has the opposite functionality of Mrotcheck
% This is not the most neatest or most efficient implementation but it works
%
/Mboxrot {		% tlx thx tly thy Mboxrot new_tlx new_thx new_tly new_thy
	Mrot
	90 eq
	{
% old		 tlx  thx  tly  thy
% new		-thy -tly  tlx  thx
%
	brotaux 	% tlx thx -thy -tly
	4 2
	roll		% -thy -tly tlx thx
	}
	if
	Mrot
	180 eq
	{
% old		 tlx  thx  tly  thy
% new		-thx -tlx -thx -tly
%
	4 2
        roll		% tly thy tlx thx
	brotaux		% tly thy -thx -tlx
	4 2
	roll		% -thx -tlx tlx thy
	brotaux		% -thx -tlx -thy -tly	
	}	
	if
	Mrot
	270 eq
	{
% old		 tlx  thx  tly  thy
% new		 tly  thy -thx -tlx
%
	4 2
	roll		% tly thy tlx thx
	brotaux		% tly thy -thx -tlx
	}
	if
} bind def

%
% auxilliary function negate and reverse
/brotaux {		% x y boxrotaux -y -x
	neg
	exch
	neg
} bind def

%
% Mabsproc takes a measurement in the default user units and converts
% it to the present units.   This allows absolute thickness and dashing
% to work.  It works by using a {0, x} vector and using the RMS of the result.
/Mabsproc { % abs thing Mabsproc
	0
        matrix defaultmatrix
        dtransform idtransform
	dup mul exch
	dup mul
	add sqrt
} bind def

%
% Mabswid allows the linewidth to be specified in absolute coordinates
% It does this by recording the graphics transformation matrix at the
% begining of the plot.
% This will break if the scaling in the x and y directions is
% different.  This is the case if Mnodistort is false
%
/Mabswid {	%abswid	Mabswid	
        Mabsproc
	setlinewidth	
} bind def

% Mabsdash allows the dashing pattern to be specified in absolute coordinates
% It does this by recording the graphics transformation matrix at the
% begining of the plot.
% This will break if the scaling in the x and y directions is
% different.  This is the case if Mnodistort is false
%
/Mabsdash {	%[d1 d2 d3 .. ] off Mabsdash	
        exch    % off [d1 d2 d3 ..]
        [               % off [d1 d2 d3 ..]
        exch            % off [ [d1 d2 d3 ..]
        {
        Mabsproc
        }
        forall
        ]               % off [ fact*d1 fact*d2 fact*d3 .. ]
        exch            % [ nd1 nd2 nd3 .. ] off
        setdash
} bind def

%MBeginOrig start coordinates in user coordinates
/MBeginOrig { Momatrix concat} bind def

%MEndOrig start coordinates in user coordinates
/MEndOrig { Mgmatrix setmatrix} bind def

/sampledsound where
{ pop}
{ /sampledsound { % str rate nsamp bs proc bool nchan
	exch
	pop			% str rate nsamp bs proc nchan
	exch		% str rate nsamp bs nchan proc
	5 1 roll		% str proc rate nsamp bs nchan
	mul
	4 idiv		% str proc rate nsamp bs*nchan/4
	mul 			% str proc rate nsamp*bs*nchan/4
	2 idiv		% str proc rate nbytes
	exch pop		% str proc nbytes
	exch		% str nbytes proc
	/Mtempproc exch def
	{ Mtempproc pop}
	repeat
	} bind def
} ifelse

%
% now simple conversion of cmykcolor to rgbcolor
% subtract k and then take complements
/setcmykcolor where
{ pop}
{ /setcmykcolor {	 % c m y k
	4 1
	roll			% k c m y
	[			% k c m y [
	4 1 
	roll			% k [  c m y
	] 			% k [ c m y ]
	{
	1 index		% k elem k
	sub			% k elem-k
	1
	sub neg		% k 1-(elem-k)
	dup
	0
	lt
	{
	pop
	0
	}
	if
	dup
	1
	gt
	{
	pop
	1
	}
	if
	exch		% 1-(elem-k) k
	} forall	% r g b k
	pop
	setrgbcolor
} bind def
} ifelse

/Mcharproc	% max
{
  	currentfile
  	(x)
  	readhexstring
  	pop		% max val
  	0 get
  	exch		% val max
 	div		% nval
} bind def

/Mshadeproc	% max ncols
{
	dup		% max ncols ncols
	3 1
	roll		% ncols max ncols
	{		% ncols max 
	dup		% ncols max max
	Mcharproc		% ncols max val
	3 1
	roll		% v1.. ncols max
	} repeat
	1 eq
	{
	setgray
	}
	{
	3 eq
	{
	setrgbcolor
	}
	{
	setcmykcolor
	} ifelse
	} ifelse
} bind def

/Mrectproc % x0 x1 y0 y1
{
	3 index         % x0 x1 y0 y1 x0
	2 index         % x0 x1 y0 y1 x0 y0
	moveto          % x0 x1 y0 y1
	2 index         % x0 x1 y0 y1 x1
	3 -1
	roll            % x0 x1 y1 x1 y0
	lineto          % x0 x1 y1
	dup             % x0 x1 y1 y1
	3 1
	roll            % x0 y1 x1 y1
	lineto          % x0 y1
	lineto
	fill
} bind def

/Mcolorimage     % nx ny depth matrix proc bool ncols
{
	7 1
	roll		% ncols nx ny depth matrix proc bool
	pop
	pop
	matrix
	invertmatrix
	concat          % ncols nx ny depth
	2 exch exp      % ncols nx ny 2^depth
	1 sub           % ncols nx ny max
	3 1 roll        % ncols max nx ny
	1 1             % ncols max nx ny 1 1
	2 index         % ncols max nx ny 1 1 ny
	{               % ncols max nx ny iy
	1 1             % ncols max nx ny iy 1 1
	4 index         % ncols max nx ny iy 1 1 nx
	{               % ncols max nx ny iy ix
	dup             % ncols max nx ny iy ix ix
	1 sub           % ncols max nx ny iy ix x0
	exch            % ncols max nx ny iy x0 x1
	2 index         % ncols max nx ny iy x0 x1 iy
	dup             % ncols max nx ny iy x0 x1 iy iy
	1 sub           % ncols max nx ny iy x0 x1 iy y0
	exch            % ncols max nx ny iy x0 x1 y0 y1
	7 index         % ncols max nx ny iy x0 x1 y0 y1 max
	9 index		% ncols max nx ny iy x0 x1 y0 y1 max ncols
	Mshadeproc	% ncols max nx ny iy x0 x1 y0 y1
	Mrectproc        % max nx ny iy
	} for           % x loop
	pop             % max nx ny
	} for           % y loop
	pop pop pop pop
} bind def

/Mimage  % nx ny depth matrix proc
{
	pop
	matrix
	invertmatrix
	concat          % nx ny depth
	2 exch exp      % nx ny 2^depth
	1 sub           % nx ny max
	3 1 roll        % max nx ny
	1 1             % max nx ny 1 1
	2 index         % max nx ny 1 1 ny
	{               % max nx ny iy
	1 1             % max nx ny iy 1 1
	4 index         % max nx ny iy 1 1 nx
	{               % max nx ny iy ix
	dup             % max nx ny iy ix ix
	1 sub           % max nx ny iy ix x0
	exch            % max nx ny iy x0 x1
	2 index         % max nx ny iy x0 x1 iy
	dup             % max nx ny iy x0 x1 iy iy
	1 sub           % max nx ny iy x0 x1 iy y0
	exch            % max nx ny iy x0 x1 y0 y1
	7 index         % max nx ny iy x0 x1 y0 y1 max
	Mcharproc	% max nx ny iy x0 x1 y0 y1 val
	setgray         % max nx ny iy x0 x1 y0 y1
	Mrectproc        % max nx ny iy
	} for           % x loop
	pop             % max nx ny
	} for           % y loop
	pop pop pop
} bind def

/Ma /Mabswid load def
/a /arc load def
/c /curveto load def
/C /curveto load def
/d /setdash load def
/f /fill load def
/F /fill load def
/g /setgray load def
/gr /grestore load def
/gs /gsave load def
/k /stroke load def
/l /lineto load def
/L /lineto load def
/lw /setlinewidth load def
/m /moveto load def
/n /newpath load def
/p /gsave load def
/P /grestore load def
/r /setrgbcolor load def
/s /stroke load def
/w /setlinewidth load def
/beginmath /MBeginOrig load def
/endmath /MEndOrig load def

end
