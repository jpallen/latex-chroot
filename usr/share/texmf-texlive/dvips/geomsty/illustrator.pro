%%BeginResource: procset Adobe_packedarray 2.0 0
%%Title: (Packed Array Operators)
%%Version: 2.0 
%%CreationDate: (8/2/90) ()
%%Copyright: ((C) 1987-1990 Adobe Systems Incorporated All Rights Reserved)

userdict /Adobe_packedarray 5 dict dup begin put
/initialize			% - initialize -
{
/packedarray where
	{
	pop
	}
	{
	Adobe_packedarray begin
	Adobe_packedarray
		{
		dup xcheck
			{
			bind
			} if
		userdict 3 1 roll put
		} forall
	end
	} ifelse
} def
/terminate			% - terminate -
{
} def
/packedarray		% arguments count packedarray array
{
array astore readonly
} def
/setpacking			% boolean setpacking -
{
pop
} def
/currentpacking		% - setpacking boolean
{
false
} def
currentdict readonly pop end
%%EndResource
%%BeginResource: procset Adobe_cmykcolor 1.1 0
%%Title: (CMYK Color Operators)
%%Version: 1.1 
%%CreationDate: (1/23/89) ()
%%Copyright: ((C) 1987-1990 Adobe Systems Incorporated All Rights Reserved)

currentpacking true setpacking
userdict /Adobe_cmykcolor 4 dict dup begin put
/initialize			% - initialize -
{
/setcmykcolor where
	{
	pop
	}
	{
	userdict /Adobe_cmykcolor_vars 2 dict dup begin put
	/_setrgbcolor
		/setrgbcolor load def
	/_currentrgbcolor
		/currentrgbcolor load def
	Adobe_cmykcolor begin
	Adobe_cmykcolor
		{
		dup xcheck
			{
			bind
			} if
		pop pop
		} forall
	end
	end
	Adobe_cmykcolor begin
	} ifelse
} def
/terminate			% - terminate -
{
currentdict Adobe_cmykcolor eq
	{
	end
	} if
} def
/setcmykcolor		% cyan magenta yellow black setcmykcolor -
{
1 sub 4 1 roll
3
	{
	3 index add neg dup 0 lt
		{
		pop 0
		} if
	3 1 roll
	} repeat
Adobe_cmykcolor_vars /_setrgbcolor get exec
pop
} def 
/currentcmykcolor	% - currentcmykcolor cyan magenta yellow black
{
Adobe_cmykcolor_vars /_currentrgbcolor get exec
3
	{
	1 sub neg 3 1 roll
	} repeat
0
} def
currentdict readonly pop end
setpacking

%%EndResource
%%BeginResource: procset Adobe_cshow 1.1 0
%%Title: (cshow Operator)
%%Version: 1.1 
%%CreationDate: (1/23/89) ()
%%Copyright: ((C) 1987-1990 Adobe Systems Incorporated All Rights Reserved)

currentpacking true setpacking
userdict /Adobe_cshow 3 dict dup begin put
/initialize			% - initialize -
{
/cshow where
	{
	pop
	}
	{
	userdict /Adobe_cshow_vars 1 dict dup begin put
	/_cshow		% - _cshow proc
		{} def
	Adobe_cshow begin
	Adobe_cshow
		{
		dup xcheck
			{
			bind
			} if
		userdict 3 1 roll put
		} forall
	end
	end
	} ifelse
} def
/terminate			% - terminate -
{
} def
/cshow				% proc string cshow -
{
exch
Adobe_cshow_vars
	exch /_cshow
	exch put
	{
	0 0 Adobe_cshow_vars /_cshow get exec
	} forall
} def
currentdict readonly pop end
setpacking

%%EndResource
%%BeginResource: procset Adobe_customcolor 1.0 0
%%Title: (Custom Color Operators)
%%Version: 1.0 
%%CreationDate: (5/9/88) ()
%%Copyright: ((C) 1987-1990 Adobe Systems Incorporated All Rights Reserved)

currentpacking true setpacking
userdict /Adobe_customcolor 5 dict dup begin put
/initialize			% - initialize -
{
/setcustomcolor where
	{
	pop
	}
	{
	Adobe_customcolor begin
	Adobe_customcolor
		{
		dup xcheck
			{
			bind
			} if
		pop pop
		} forall
	end
	Adobe_customcolor begin
	} ifelse
} def
/terminate			% - terminate -
{
currentdict Adobe_customcolor eq
	{
	end
	} if
} def
/findcmykcustomcolor	% cyan magenta yellow black name findcmykcustomcolor object
{
5 packedarray
}  def
/setcustomcolor		% object tint setcustomcolor -
{
exch
aload pop pop
4
	{
	4 index mul 4 1 roll
	} repeat
5 -1 roll pop
setcmykcolor
} def
/setoverprint		% boolean setoverprint -
{
pop
} def
currentdict readonly pop end
setpacking

%%EndResource
%%BeginResource: procset Adobe_IllustratorA_AI3 1.0 1
%%Title: (Adobe Illustrator (R) Version 3.0 Abbreviated Prolog)
%%Version: 1.0 
%%CreationDate: (7/22/89) ()
%%Copyright: ((C) 1987-1990 Adobe Systems Incorporated All Rights Reserved)

currentpacking true setpacking
userdict /Adobe_IllustratorA_AI3 61 dict dup begin put
% initialization
/initialize				% - initialize -
{
% 47 vars, but leave slack of 10 entries for custom Postscript fragments
userdict /Adobe_IllustratorA_AI3_vars 57 dict dup begin put

% paint operands
/_lp /none def
/_pf {} def
/_ps {} def
/_psf {} def
/_pss {} def
/_pjsf {} def
/_pjss {} def
/_pola 0 def
/_doClip 0 def

% paint operators
/cf	currentflat def	% - cf flatness

% typography operands
/_tm matrix def
/_renderStart [/e0 /r0 /a0 /o0 /e1 /r1 /a1 /i0] def 
/_renderEnd [null null null null /i1 /i1 /i1 /i1] def
/_render -1 def
/_rise 0 def
/_ax 0 def			% x character spacing	(_ax, _ay, _cx, _cy follows awidthshow naming convention)
/_ay 0 def			% y character spacing
/_cx 0 def			% x word spacing
/_cy 0 def			% y word spacing
/_leading [0 0] def
/_ctm matrix def
/_mtx matrix def
/_sp 16#020 def
/_hyphen (-) def
/_fScl 0 def
/_cnt 0 def
/_hs 1 def
/_nativeEncoding 0 def
/_useNativeEncoding 0 def
/_tempEncode 0 def
/_pntr 0 def
/_tDict 2 dict def

% typography operators
/Tx {} def
/Tj {} def

% compound path operators
/CRender {} def

% printing
/_AI3_savepage {} def

% color operands
/_gf null def
/_cf 4 array def
/_if null def
/_of false def
/_fc {} def
/_gs null def
/_cs 4 array def
/_is null def
/_os false def
/_sc {} def
/_i null def
Adobe_IllustratorA_AI3 begin
Adobe_IllustratorA_AI3
	{
	dup xcheck
		{
		bind
		} if
	pop pop
	} forall
end
end
Adobe_IllustratorA_AI3 begin
Adobe_IllustratorA_AI3_vars begin
newpath
} def
/terminate				% - terminate -
{
end
end
} def
% definition operators
/_					% - _ null
null def
/ddef				% key value ddef -
{
Adobe_IllustratorA_AI3_vars 3 1 roll put
} def
/xput				% key value literal xput -
{
dup load dup length exch maxlength eq
	{
	dup dup load dup
	length 2 mul dict copy def
	} if
load begin def end
} def
/npop				% integer npop -
{
	{
	pop
	} repeat
} def
% marking operators
/sw					% ax ay string sw x y 
{
dup length exch stringwidth
exch 5 -1 roll 3 index 1 sub mul add
4 1 roll 3 1 roll 1 sub mul add
} def
/swj				% cx cy fillchar ax ay string swj x y
{
dup 4 1 roll
dup length exch stringwidth 
exch 5 -1 roll 3 index 1 sub mul add
4 1 roll 3 1 roll 1 sub mul add 
6 2 roll /_cnt 0 ddef
{1 index eq {/_cnt _cnt 1 add ddef} if} forall pop
exch _cnt mul exch _cnt mul 2 index add 4 1 roll 2 index add 4 1 roll pop pop
} def
/ss					% ax ay string matrix ss -
{
4 1 roll
	{				% matrix ax ay char 0 0 {proc} -
	2 npop 
	(0) exch 2 copy 0 exch put pop
	gsave
	false charpath currentpoint
	4 index setmatrix
	stroke
	grestore
	moveto
	2 copy rmoveto
	} exch cshow
3 npop
} def
/jss				% cx cy fillchar ax ay string matrix jss -
{
4 1 roll
	{				% cx cy fillchar matrix ax ay char 0 0 {proc} -   
	2 npop 
	(0) exch 2 copy 0 exch put 
	gsave
	_sp eq 
		{
		exch 6 index 6 index 6 index 5 -1 roll widthshow  
		currentpoint
		}
		{
		false charpath currentpoint
		4 index setmatrix stroke
		}ifelse
	grestore
	moveto
	2 copy rmoveto
	} exch cshow
6 npop
} def

% path operators
/sp					% ax ay string sp -
{
	{
	2 npop (0) exch
	2 copy 0 exch put pop
	false charpath
	2 copy rmoveto
	} exch cshow
2 npop
} def
/jsp					% cx cy fillchar ax ay string jsp -
{
	{					% cx cy fillchar ax ay char 0 0 {proc} -
	2 npop 
	(0) exch 2 copy 0 exch put 
	_sp eq 
		{
		exch 5 index 5 index 5 index 5 -1 roll widthshow  
		}
		{
		false charpath
		}ifelse
	2 copy rmoveto
	} exch cshow
5 npop
} def

% path construction operators
/pl				% x y pl x y
{
transform
0.25 sub round 0.25 add exch
0.25 sub round 0.25 add exch
itransform
} def
/setstrokeadjust where
	{
	pop true setstrokeadjust
	/c				% x1 y1 x2 y2 x3 y3 c -
	{
	curveto
	} def
	/C
	/c load def
	/v				% x2 y2 x3 y3 v -
	{
	currentpoint 6 2 roll curveto
	} def
	/V
	/v load def
	/y				% x1 y1 x2 y2 y -
	{
	2 copy curveto
	} def
	/Y
	/y load def
	/l				% x y l -
	{
	lineto
	} def
	/L
	/l load def
	/m				% x y m -
	{
	moveto
	} def
	}
	{%else
	/c
	{
	pl curveto
	} def
	/C
	/c load def
	/v
	{
	currentpoint 6 2 roll pl curveto
	} def
	/V
	/v load def
	/y
	{
	pl 2 copy curveto
	} def
	/Y
	/y load def
	/l
	{
	pl lineto
	} def
	/L
	/l load def
	/m
	{
	pl moveto
	} def
	}ifelse

% graphic state operators
/d					% array phase d -
{
setdash
} def
/cf	{} def			% - cf flatness
/i					% flatness i -
{
dup 0 eq
	{
	pop cf
	} if
setflat
} def
/j					% linejoin j -
{
setlinejoin
} def
/J					% linecap J -
{
setlinecap
} def
/M					% miterlimit M -
{
setmiterlimit
} def
/w					% linewidth w -
{
setlinewidth
} def

% path painting operators
/H					% - H -
{} def
/h					% - h -
{
closepath
} def
/N					% - N -
{
_pola 0 eq 
	{
	_doClip 1 eq {clip /_doClip 0 ddef} if 
	newpath
	} 
	{
	/CRender {N} ddef
	}ifelse
} def
/n					% - n -
{N} def
/F					% - F -
{
_pola 0 eq 
	{
	_doClip 1 eq 
		{
		gsave _pf grestore clip newpath /_lp /none ddef _fc 
		/_doClip 0 ddef
		}
		{
		_pf
		}ifelse
	} 
	{
	/CRender {F} ddef
	}ifelse
} def
/f					% - f -
{
closepath
F
} def
/S					% - S -
{
_pola 0 eq 
	{
	_doClip 1 eq 
		{
		gsave _ps grestore clip newpath /_lp /none ddef _sc 
		/_doClip 0 ddef
		}
		{
		_ps
		}ifelse
	} 
	{
	/CRender {S} ddef
	}ifelse
} def
/s					% - s -
{
closepath
S
} def
/B					% - B -
{
_pola 0 eq 
	{
	_doClip 1 eq 	% F clears _doClip
	gsave F grestore 
		{
		gsave S grestore clip newpath /_lp /none ddef _sc
		/_doClip 0 ddef
		} 
		{
		S
		}ifelse
	}
	{
	/CRender {B} ddef
	}ifelse
} def
/b					% - b -
{
closepath
B
} def
/W					% - W -
{
/_doClip 1 ddef
} def
/*					% - [string] * -
{
count 0 ne 
	{
	dup type (stringtype) eq {pop} if
	} if 
_pola 0 eq {newpath} if
} def

% group operators
/u					% - u -
{} def
/U					% - U -
{} def
/q					% - q -
{
_pola 0 eq {gsave} if
} def
/Q					% - Q -
{
_pola 0 eq {grestore} if
} def
/*u					% - *u -
{
_pola 1 add /_pola exch ddef
} def
/*U					% - *U -
{
_pola 1 sub /_pola exch ddef 
_pola 0 eq {CRender} if
} def
/D					% polarized D -
{pop} def
/*w					% - *w -
{} def
/*W					% - *W -
{} def

% place operators
/`					% matrix llx lly urx ury string ` -
{
/_i save ddef
6 1 roll 4 npop
concat
userdict begin
/showpage {} def
false setoverprint
pop
} def
/~					% - ~ -
{
end
_i restore
} def

% color operators
/O					% flag O -
{
0 ne
/_of exch ddef
/_lp /none ddef
} def
/R					% flag R -
{
0 ne
/_os exch ddef
/_lp /none ddef
} def
/g					% gray g -
{
/_gf exch ddef
/_fc
{ 
_lp /fill ne
	{
	_of setoverprint
	_gf setgray
	/_lp /fill ddef
	} if
} ddef
/_pf
{
_fc
fill
} ddef
/_psf
{
_fc
ashow
} ddef
/_pjsf
{
_fc
awidthshow
} ddef
/_lp /none ddef
} def
/G					% gray G -
{
/_gs exch ddef
/_sc
{
_lp /stroke ne
	{
	_os setoverprint
	_gs setgray
	/_lp /stroke ddef
	} if
} ddef
/_ps
{
_sc
stroke
} ddef
/_pss
{
_sc
ss
} ddef
/_pjss
{
_sc
jss
} ddef
/_lp /none ddef
} def
/k					% cyan magenta yellow black k -
{
_cf astore pop
/_fc
{
_lp /fill ne
	{
	_of setoverprint
	_cf aload pop setcmykcolor
	/_lp /fill ddef
	} if
} ddef
/_pf
{
_fc
fill
} ddef
/_psf
{
_fc
ashow
} ddef
/_pjsf
{
_fc
awidthshow
} ddef
/_lp /none ddef
} def
/K					% cyan magenta yellow black K -
{
_cs astore pop
/_sc
{
_lp /stroke ne
	{
	_os setoverprint
	_cs aload pop setcmykcolor
	/_lp /stroke ddef
	} if
} ddef
/_ps
{
_sc
stroke
} ddef
/_pss
{
_sc
ss
} ddef
/_pjss
{
_sc
jss
} ddef
/_lp /none ddef
} def
/x					% cyan magenta yellow black name gray x -
{
/_gf exch ddef
findcmykcustomcolor
/_if exch ddef
/_fc
{ 
_lp /fill ne
	{
	_of setoverprint
	_if _gf 1 exch sub setcustomcolor
	/_lp /fill ddef
	} if
} ddef
/_pf
{
_fc
fill
} ddef
/_psf
{
_fc
ashow
} ddef
/_pjsf
{
_fc
awidthshow
} ddef
/_lp /none ddef
} def
/X					% cyan magenta yellow black name gray X -
{
/_gs exch ddef
findcmykcustomcolor
/_is exch ddef
/_sc
{
_lp /stroke ne
	{
	_os setoverprint
	_is _gs 1 exch sub setcustomcolor
	/_lp /stroke ddef
	} if
} ddef
/_ps
{
_sc
stroke
} ddef
/_pss
{
_sc
ss
} ddef
/_pjss
{
_sc
jss
} ddef
/_lp /none ddef
} def

% locked object operator
/A					% value A -
{
pop
} def

currentdict readonly pop end
setpacking

% annotate page operator
/annotatepage
{
} def
%%EndResource

