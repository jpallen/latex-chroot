%H  package name: piechartMP
%H  description:  Metapost package for 2D/3D pie charts
%H  file:         piechartmp.mp
%H  author:       Jens-Uwe Morawski <morawski@gmx.net>
%H  version:      0.3.0 2002/05/14

%L  Copyright 2002, Jens-Uwe Morawski
%L  License: LPPL 1.0, see LEGAL


%I * all user commands start with uppercase letters:
%I     Segment, SegmentState,
%I     SetupColors, SetupNumbers, SetupText,
%I     SetupValue, SetupPercent, SetupName,
%I     PieChart, Label
%I * user variables start with uppercase letters:
%I     PiechartBBox, R
%I * all internal functions start with '_' except
%I     SegmentColor, SegmentPoint
%I * all internal variables start with 'pc_' except 
%I     auto, hidden, normal, invisible, this,
%I     inwards, outwards, name, percent, value

%\
% initialisation
%\
if known piechart_module: endinput ; fi ;
boolean piechart_module ; piechart_module := true ;

% === data / input routines === (pc-input.mp)
%\
% vars / internals
%\
newinternal hidden    ; hidden      := -1 ;
newinternal invisible ; invisible   := 0  ;
newinternal normal    ; normal      := 1  ;

%\
% data input/ user values / segment state
%\
numeric pc_Count ; pc_Count := 0 ; % number of defined segments
numeric pc_xValue[], pc_xOffset[], pc_xState[];
color pc_xFill[] ;
string pc_n_Label[], pc_v_Label[] ;

def Segment(text s) =
	begingroup;
	save i ; numeric i ; i:=0;
	pc_Count := pc_Count + 1 ;
	for e=s:
		i := i+1 ;
		if i=1:
			pc_xValue[pc_Count] := e ;
			pc_n_Label[pc_Count] := _numericToString(pc_Count, -1) ;
			pc_xFill[pc_Count] := auto ;
			pc_v_Label[pc_Count] := _numericToString(e, -1) ;
		elseif i=2:
			pc_n_Label[pc_Count] := e ;
		elseif i=3:
			pc_xFill[pc_Count] := _applyColorOrPattern(e) ;
		elseif i=4:
			pc_v_Label[pc_Count] := e ;
		fi;
	endfor;
	
	if i=0:
		errmessage "Segment: too few arguments for segment " &
						(decimal pc_Count) ;
	fi;
	
	pc_xState[pc_Count] := normal ;
	pc_xOffset[pc_Count] := 0 ;
	endgroup;
enddef;

def SegmentState(expr s, st, sh ) = 
	if not _isThis(st):
		pc_xState[s] := st ;
	fi;
	
	if not _isThis(sh):
		pc_xOffset[s] := sh ;
	fi;
enddef;

%C reset diagramm data
def ResetSegments =
	pc_Count := 0 ;
enddef;

% === drawing routines === (pc-draw.mp)
%\
% vars / internals
%\

newinternal R;
pair pc_Centre; pc_Centre := origin ;
numeric pc_Offset ;
numeric pc_Depth ;
numeric pc_View ;
numeric pc_Sum ;
numeric pc_xStart[], pc_xEnd[] ;


boolean pc_Metafun ; pc_Metafun := false ;
if known context_spec : pc_Metafun := true  ; fi ;


%\
% diagram drawing
%\

%C PieChart(<diagramm radius>, <thickness in R>, <angle>, <rotation>,<global offset in R>)
def PieChart (expr u, d, va, r, go) =
	begingroup ;
	save rot, pointer ; numeric rot , pointer;
	R := u ;
	if ( va < 90 ) and ( va >= 0 ):
		pc_View := va ;
	else:
		message "Warning: Observation angle of " & ( decimal va ) & " is not valid. Substituted with 65." ;
		pc_View := 65 ;
	fi ;

	pc_Offset := go ;

	pc_Sum := 0 ;
	for i=1 upto pc_Count:
		if (pc_xState[i] >= 0):
			pc_Sum := pc_Sum + pc_xValue[i] ;
		fi ;
	endfor;

	if (( r >= 0 ) and ( r <= 359 )):
		rot := r ;
	else:
		rot := 0 ;
		message "Warning: Rotation " &  (decimal r)  & " is not within 0-359. Defaults to 0" ;
	fi ;
	pointer := rot ;
	for i=1 upto pc_Count:
		if ( pc_xState[i] >= 0 ):
			pc_xStart[i] := pointer ;
			pc_xEnd[i]   := pc_xStart[i] + (pc_xValue[i] / pc_Sum)*360.00 ;
		else:
			pc_xStart[i] := pointer ;
			pc_xEnd[i]   := pointer ;
		fi ;
		pointer := pc_xEnd[i] ;
	endfor;	
	
	pc_Depth := d*R*(sind pc_View) ;
	if (pc_View > 0): _drawSides ; fi ;
	_drawTop ;
	endgroup ;
enddef;

%C draws top sides of all visible segments
def _drawTop =
	begingroup ;
	save c , a, e, p ; path c, a, e ; picture p ;
	for i=1 upto pc_Count:
		if ( pc_xState[i] > 0) :
			c := fullcircle rotated (pc_xStart[i]) scaled (2*R) ;
			e := origin--(1.1*R*(cosd pc_xEnd[i]) , 1.1*R*(sind pc_xEnd[i]) ) ;
			c := c cutafter e ; c := origin--c--cycle ;
			fill ( c yscaled (cosd pc_View) ) shifted _calcSegmentShift(i) withcolor SegmentColor(i) ;
			if ( greenpart pc_xFill[i]) = -2 :
				p := _makePattern(i, c) ;
				draw ( p yscaled (cosd pc_View) ) shifted _calcSegmentShift(i) withcolor _patternColor(i) ;
			fi;
		fi ;	
	endfor;
	endgroup ;
enddef;

%C visual ordering of side elements
def _drawSides =
	begingroup ;
	save _etd, c , a , e;
	numeric _etd[][] , c , a , e;
	c := 0 ;
	for i=1 upto pc_Count:
		if (pc_xState[i] > 0) : 
			if _visibleStart(i):
				c := c + 1 ;
				_etd[c][1] := 1 ;
				_etd[c][2] := sind ( _normalizeAngle(pc_xStart[i])) ;
				_etd[c][3] := i ;
				_etd[c][4] := _normalizeAngle(pc_xStart[i]) ;
			fi
			if _visibleEnd(i):
				c := c + 1 ;
				_etd[c][1] := 1 ;
				_etd[c][2] := sind ( _normalizeAngle(pc_xEnd[i])) ;
				_etd[c][3] := i ;
				_etd[c][4] := _normalizeAngle(pc_xEnd[i]) ;
			fi
			if _visibleOutside(i):
				c := c + 1 ;
				if _outsideIsDivided(i):
					_etd[c][1] := 2 ;
					_etd[c][3] := i ;
					_etd[c][4] := _normalizeAngle(pc_xStart[i]) ;
					_etd[c][5] := 360 ;
					c := c + 1 ;
					_etd[c][1] := 2 ;
					_etd[c][3] := i ;
					_etd[c][4] := 180 ;
					_etd[c][5] := _normalizeAngle(pc_xEnd[i]) ;
				else :
					a := pc_xStart[i] ;
					e := pc_xEnd[i] ;

					if ( (sind a) >= 0 ):
						a := 180 ;
					fi ;
					if ( (sind e) >= 0 ) :
						e := 360 ;
					fi ;

					_etd[c][1] := 2 ;
					_etd[c][3] := i ;
					_etd[c][4] := _normalizeAngle(a) ;
					_etd[c][5] := _normalizeAngle(e) ;				
				fi
			fi
		fi
	endfor;

	for i=1 upto c:
		if (_etd[i][1] = 2 ):
			if (( (cosd _etd[i][4])*(cosd _etd[i][5]) ) >= 0):
				_etd[i][2] := sind (0.5*(_etd[i][4] + _etd[i][5]));
			else :
				_etd[i][2] := -1 ;
			fi
		fi
	endfor;
	
	for i=1 upto c :
		a := -2 ; e := 0 ;
		for j=1 upto c:
			if (_etd[j][1] > 0) and (_etd[j][2] > a):
				e := j ;
				a := _etd[j][2] ;
			fi
		endfor;
		if (e > 0):
			if (_etd[e][1] = 1):
				_drawInside(_etd[e][3],_etd[e][4]) ;
			else:
				_drawOutside(_etd[e][3],_etd[e][4],_etd[e][5]) ;
			fi
			_etd[e][1] := 0 ;
		fi
	endfor;
	endgroup ;
enddef;

def _drawInside (expr s, a) =
	begingroup ;
	save b, e; path e, b;

	e := origin--(R*(cosd a), R*(sind a)*(cosd pc_View) ) ;
	b := (R*(cosd a), R*(sind a)*(cosd pc_View) )--origin ;
	%if ( (sind a) > 0): b := b yscaled (1 + (0.1*(sind a)*(sind pc_View))); fi ;

	b := b shifted (0, -pc_Depth) ;
	e := b--e--cycle ; e := e shifted _calcSegmentShift(s) ;
	fill e withcolor _calcInsideColor(s,a) ;
	endgroup ;
enddef;


def _drawOutside (expr s, a, e) =
	begingroup ;
	save p, h, g ;
	path p, h, g ;
	if (pc_Metafun and (a < 270) and (e > 270)) :
		_drawOutside(s,a,270) ;
		_drawOutside(s,270,e) ;
	else :
		g := fullcircle xscaled (2*R) yscaled (2*R*(cosd pc_View));
		g := subpath (4,8) of g ; %top
		h := g shifted (0, -pc_Depth) ; % below
		g := g xscaled -1 ; % in the reverse direction
	
		p := (R*(cosd e),0)--(R*(cosd e),-1.1*(R*(cosd pc_View)+pc_Depth)) ;
		h := h cutafter p ;
		g := g cutbefore p ;

		p := (R*(cosd a),0)--(R*(cosd a),-1.1*(R*(cosd pc_View)+pc_Depth)) ;
		h := h cutbefore p ;
		g := g cutafter p ;
	
		p := h--g--cycle ; p := p shifted _calcSegmentShift(s) ;
		if pc_Metafun:
			linear_shade(p,0,_calcOutsideColor(s,a),_calcOutsideColor(s,e)) ;
		else :
			fill p withcolor _calcOutsideColor(s, (0.5*(a+e)) ) ;
		fi ;
	fi ;
	endgroup ;
enddef;

%\
% help macros
%\

vardef _visibleStart (expr s) =
	save b; boolean b;
	b:=  ( ( cosd ( _normalizeAngle(pc_xStart[s]) )) > 0 ) and
		( (pc_Offset > 0) or (pc_xOffset[s] > 0)  or
			(pc_xState[ _prevSegment(s) ] = 0) or
			(pc_xOffset[_prevSegment(s)] > 0) );
	b
enddef;

vardef _visibleEnd (expr s) =
	save b; boolean b;
	b:=  ( ( cosd ( _normalizeAngle(pc_xEnd[s]) )) < 0 ) and
		( (pc_Offset > 0) or (pc_xOffset[s] > 0) or
			(pc_xState[ _nextSegment(s) ] = 0) or
			(pc_xOffset[_nextSegment(s)] > 0) );
	b
enddef;

vardef _visibleOutside (expr s) =
	save b; boolean b;
	b := ((sind pc_xStart[s] < 0) or (sind (pc_xEnd[s]) < 0) or
		 (sind (0.5*(pc_xStart[s] + pc_xEnd[s])) < 0)) ;
	b
enddef;

vardef _outsideIsDivided (expr s) =
	save b; boolean b;
	b := ( ( (sind pc_xStart[s]) < 0 ) and
		( (sind pc_xEnd[s]  ) < 0 ) and
		( (sind (0.5*(pc_xStart[s]+pc_xEnd[s])) ) >= 0 ) );
	b
enddef;

% === colors ==== (pc-color.mp)
%\
% vars / internals
%\
color auto      ; auto      := (-1,-1,-1) ;

%\
% color
%\

%C returns the color of the segment with number s;
%C if the segment uses pattern fill it returns the
%C background color
vardef SegmentColor(expr s) =
	save tC; color tC;
	if pc_xFill[s] = (-1,-1,-1):
		tC := _autoColor( 0.5*(pc_xStart[s]+pc_xEnd[s]) - pc_xStart[1] ) ;
	elseif ( (greenpart pc_xFill[s]) = -2 ) :
		tC := pc_patternBGColor[(bluepart pc_xFill[s])] ;
		if tC = (-1,-1,-1):
			tC := _autoColor( 0.5*(pc_xStart[s]+pc_xEnd[s]) - pc_xStart[1] ) ;
		fi ;
	else:
		tC := pc_xFill[s] ;
	fi;
	if pc_sGrayscale:
		tC := (0.3*(redpart tC) + 0.59*(greenpart tC) + 0.11*(bluepart tC))*white ;
	fi ;
	tC
enddef;

%C returns the foreground color of the pattern
vardef _patternColor (expr s) =
	save tC, v, h ; color tC; numeric v, h ;
	tC := pc_patternFGColor[(bluepart pc_xFill[s])] ;
	if tC = (-1,-1,-1):
		tC := SegmentColor(s) ;
		tC := _rgbToHsv(tC) ;
		h := redpart tC ;
		h := h - 180 ;
		if h<0: h := h + 360 ; fi ;
		v := bluepart tC ;
		v := 1 - v ;
		tC := ( h , greenpart tC , v) ;
		tC := _hsvToRgb(tC) ;
	fi;
	if pc_sGrayscale:
		tC := (0.3*(redpart tC) + 0.59*(greenpart tC) + 0.11*(bluepart tC))*white ;
	fi ;
	tC
enddef;

%C returns the color of the insides in 3D view of the segment s
%C a is the angle/direction of the side in the diagram
vardef _calcInsideColor (expr s, a) =
	save tC, f; color tC; numeric f ;
	f := cosd ( (abs(cosd a))*pc_View ) ;
	tC := SegmentColor(s) + f*(xpart pc_sShadeSV)*( _minSaturation(SegmentColor(s)) - SegmentColor(s) ) ;
	tC := tC + f*(ypart pc_sShadeSV)*( black - tC ) ;
	tC
enddef;

%C returns the color of the outsides in 3D view of the segment s
%C a is the angle/direction of the side in the diagram
vardef _calcOutsideColor (expr s, a) =
	save tC, f; color tC; numeric f ;
	f := cosd ( (abs(sind a))*pc_View ) ;
	tC := SegmentColor(s) + f*(xpart pc_sShadeSV)*( _minSaturation(SegmentColor(s)) - SegmentColor(s) ) ;
	tC := tC + f*(ypart pc_sShadeSV)*( black - tC ) ;
	tC
enddef;

%\
% help macros
%\

%C return a color from c as if saturation is set to zero
vardef _minSaturation (expr c)=
	save sat; numeric sat; sat := 0 ;
	sat := 0.3*(redpart c) + 0.59*(greenpart c) + 0.11*(bluepart c) ;
	sat*white
enddef;


%C automatic color values
vardef _autoColor(expr a) =
	_hsvToRgb( (a, (xpart pc_sAutoSV), (ypart pc_sAutoSV)) )
enddef;

vardef _hsvToRgb(expr c) =
	save h,s,v, H,o, b, d, pc, sc;
	numeric h,s,v,H, o, b, d, pc, sc ;
	
	h := redpart c ;
	s := greenpart c ;
	v := bluepart c ;
	
	H := _normalizeAngle(h) / 60 ;
	pc := floor H ;
	sc := H - pc ;
	o := (1 - s)*v ;
	b := (1 - (sc*s) )*v;
	d := (1 - ((1-sc)*s) )*v ;
	
	if (pc = 0) or (pc = 6):
		(v,d,o)
	elseif pc = 1:
		(b,v,o)	
	elseif pc = 2:
		(o,v,d)	
	elseif pc = 3:
		(o,b,v)	
	elseif pc = 4:
		(d,o,v)	
	else:
		(v,o,b)	
	fi
enddef;

vardef _rgbToHsv (expr c) =
	save r,g,b,h,s,v, _r, _g, _b, min, max ;
	numeric r,g,b,h,s,v, _r, _g, _b, min, max ;
	
	r := redpart c ;
	g := greenpart c ;
	b := bluepart c ;
	
	min := r ; max := r ;
	
	if (g < min): min := g ; fi ;
	if (g > max): max := g ; fi ;
	if (b < min): min := b ; fi ;
	if (b > max): max := b ; fi ;
	
	if max > 0:
		s := (max - min)/max ; v := max ;
	else:
		s := 0; v := 0 ;
	fi ;
	
		
	if (s = 0):
		h := 0 ; % is undefined
	else:
		_r := (max - r)/(max - min) ;
		_g := (max - g)/(max - min) ;
		_b := (max - b)/(max - min) ;
	
		if ((r = max ) and (g = min)):      h := 5 + _b ;
		elseif ((r = max ) and (g <> min)): h := 1 - _g ;
		elseif ((g = max ) and (b = min)):  h := 1 + _r ;
		elseif ((g = max ) and (b <> min)): h := 3 - _b ;
		elseif (r = max):                   h := 3 + _g ; 
		else:                               h := 5 - _r ;
		fi ;
	fi ;
	h := 60 * h ;
	(h,s,v)
enddef;
% === pattern routines === (pc-pattr.mp)

%\
% vars
%\
numeric pc_patternType[] ;
color   pc_patternFGColor[], pc_patternBGColor[] ;
pair pc_patternDimen[] ;

%\
% routines
%\

%C called via Segment(); 
vardef _applyColorOrPattern (expr c) =
	if color c:
		c
	else:
		if ( numeric c ):
			if known pc_patternType[c]:
				(-1,-2,c)
			else:
				errmessage "Pattern number " & (decimal c) &  " not defined" ;
				(-1,-1,-1)				
			fi
		else:
			show c ;
			hide(errmessage "Not a valid pattern number.") ;
			(-1,-1,-1)
		fi
	fi
enddef;

%C defines a pattern with number n, of type t
%C with foreground color f and background color b
%C with dimensions (pair) d
def DefinePattern (expr n, t, b, f, d) =
	pc_patternType[n] := t ;
	pc_patternFGColor[n] := f ;
	pc_patternBGColor[n] := b ;
	pc_patternDimen[n] := d ;
enddef;


%C returns a picture including the pattern
%C for segment s in path p
vardef _makePattern (expr s, p) =
	save o, u, type, spacing, dimen, b, xs, ys, q ;
	pair o, u ; numeric type, spacing, dimen ;
	picture b ;
	b := nullpicture ;
	type := pc_patternType[(bluepart pc_xFill[s])] ;
	dimen := ypart pc_patternDimen[(bluepart pc_xFill[s])] ;
	spacing := xpart pc_patternDimen[(bluepart pc_xFill[s])] ;
	o := ulcorner p ;
	u := lrcorner p ;
	
	if type = 0:
		b := PrivatePattern (o, u, spacing, dimen) ;	
	elseif type = 1:
		numeric ys ; path line ;
		ys := ( ypart o ) + ypart (o - u ) - spacing ;
		forever:
			exitif ( ys <= ypart u ) ;
			line := (xpart o, ys)--(xpart u, ys - ypart(o-u)) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			ys := ys - spacing ;
		endfor;
	elseif type = 2:
		numeric ys ; path line ;
		ys := ( ypart o ) + ypart (o - u ) - spacing ;
		forever:
			exitif ( ys <= ypart u ) ;
			line := (xpart o, ys  - ypart(o-u) )--(xpart u, ys ) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			ys := ys - spacing ;
		endfor;
	elseif type = 3:
		numeric ys ; path line ;
		ys := ( ypart o ) + ypart (o - u ) - spacing ;
		forever:
			exitif ( ys <= ypart u ) ;
			line := (xpart o, ys  - ypart(o-u) )--(xpart u, ys ) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			line := (xpart o, ys )--(xpart u, ys - ypart(o-u) ) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			ys := ys - spacing ;
		endfor;
	elseif type = 4:
		numeric ys ; path line ;
		ys := ( ypart o ) - spacing ;
		forever:
			exitif ( ys <= ypart u ) ;
			line := (xpart o, ys )--(xpart u, ys ) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			ys := ys - spacing ;
		endfor;
	elseif type = 5:
		numeric xs ; path line ;
		xs := ( xpart o ) - spacing ;
		forever:
			exitif ( xs >= xpart u ) ;
			line := (xs,  ypart o)--(xs, ypart u) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			xs := xs + spacing ;
		endfor;
	elseif type = 6:
		numeric xs, ys ; path line ;
		xs := ( xpart o ) - spacing ;
		forever:
			exitif ( xs >= xpart u ) ;
			line := (xs,  ypart o)--(xs, ypart u) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			xs := xs + spacing ;
		endfor;
		ys := ( ypart o ) - spacing ;
		forever:
			exitif ( ys <= ypart u ) ;
			line := (xpart o, ys )--(xpart u, ys ) ;
			addto b doublepath line withpen pencircle scaled dimen ;
			ys := ys - spacing ;
		endfor;
	elseif type = 7:
		numeric xs, ys ;
		xs := ( xpart o ) ;
		forever:
			exitif ( xs >= xpart u ) ;
			ys := ( ypart o ) ;
			forever:
				exitif ( ys <= ypart u ) ;
				addto b doublepath (xs,ys) withpen pencircle scaled dimen ;
				ys := ys - spacing ;
			endfor;			
			xs := xs + spacing ;
		endfor;
	elseif type = 8:
		numeric xs, ys ;
		xs := ( xpart o ) ;
		forever:
			exitif ( xs >= xpart u ) ;
			ys := ( ypart o ) ;
			forever:
				exitif ( ys <= ypart u ) ;
				addto b doublepath (xs,ys) withpen pencircle scaled dimen ;
				addto b doublepath (xs+.5*spacing,ys+.5*spacing) withpen pencircle scaled dimen ;
				ys := ys - spacing ;
			endfor;			
			xs := xs + spacing ;
		endfor;
	elseif type = 9:
		numeric xs, ys ; path q[] ;
		q1 := (0,0){curl 0}..(0.25*spacing, -0.2*spacing )..{curl 0}(0.5*spacing, 0) ;
		q2 := q1..(q1 yscaled -1 shifted (.5*spacing, 0)) ;
		xs := ( xpart o ) ;
		forever:
			exitif ( xs >= xpart u ) ;
			ys := ( ypart o ) ;
			forever:
				exitif ( ys <= ypart u ) ;
				addto b doublepath (q[2] shifted (xs,ys)) withpen pencircle scaled dimen ;
				ys := ys - spacing ;
			endfor;			
			xs := xs + spacing ;
		endfor;
	elseif type = 10:
		numeric xs, ys ; path q ;
		q := (0,0)--(0.5*spacing, -0.5*spacing )--(0,-spacing) ;
		xs := ( xpart o ) ;
		forever:
			exitif ( xs >= xpart u ) ;
			ys := ( ypart o ) ;
			forever:
				exitif ( ys <= ypart u ) ;
				addto b doublepath (q shifted (xs,ys)) withpen pencircle scaled dimen ;
				ys := ys - spacing ;
			endfor;			
			xs := xs + spacing ;
		endfor;
	else:
		errmessage "pattern type " & (decimal type) & " not defined."
		b := nullpicture;
	fi;
	clip b to p ;
	b
enddef;

vardef PrivatePattern (expr ulc, lrc, spc, lwd) =
	save pic, cntr, c, k ;
	picture pic ; pic := nullpicture ;
	pair cntr ;
	numeric c ;
	path k ;
	
	cntr := 0.5*( lrc + ulc ) ;
	
	c := ((xpart (ulc - cntr))++(ypart (ulc - cntr))) / spc ;
	c := ( floor c ) ;
	
	for i=1 upto c:
		k := fullcircle scaled (i*2*spc) shifted cntr ;
		addto pic doublepath k withpen pencircle scaled lwd ;
	endfor;
	pic
enddef;

% === label commands === (pc-label.mp)

%\
% vars
%\


%C 
color name, percent, value ;
name := (-1,-4,1) ; percent := (-1,-4,2) ; value := (-1,-4,3) ;
%C additional label positioning parameters
pair laboff.auto; laboff.auto=(-3,-3) ;
labxf.auto=0;   labyf.auto=0;

%\
% text / labels / legend
%\

def Label = draw _theLabel enddef ;

vardef _theLabel@#(text t)(text d)(expr sp, sh) =
	save pic ; picture pic ; pic := nullpicture ;
	for S=t: 
		if S=0:
			for i=1 upto pc_Count:
				if pc_xState[i] = 1:
					addto pic also _makeSegLabel.@#(i,sp,sh)(d) ;
				fi;
			endfor;
		else:
			if (S > 0) and (S <= pc_Count):
				if pc_xState[S]= 1 :
					addto pic also _makeSegLabel.@#(S,sp,sh)(d) ;
				fi;
			else:
				message "Label: segment " & (decimal S) & " not defined.";
			fi;
		fi;
	endfor;
	pic
enddef;



vardef _makeSegLabel@# (expr s, sp, sh)(text dat) =
	save d , t, p, o , pic, l;
	numeric l;
	pair p, o ;
	picture t, pic ; pic := nullpicture ;
	string d ; d := "" ;

	for f=dat:
		if color f:
			if (bluepart f = 1 ):% name of segment
				d := d & pc_n_Pre & pc_n_Label[s] & pc_n_Post ;
			elseif (bluepart f = 2 ):% percent value
				d := d & pc_p_Pre & 
					_numericToString( 100*(pc_xValue[s]/pc_Sum), pc_sPrecision) &
					pc_p_Post ;
			elseif (bluepart f = 3 ):%segment value
				d := d & pc_v_Pre & pc_v_Label[s] & pc_v_Post ;
			fi;
		elseif string f:% free string
			d := d & f ;
		else:
			errmessage "Not a valid label-data: "; show f ;
		fi;
	endfor;

	t := _makeText(d) ;

	if pair sh :
		if sh = (0,0):
			o := SegmentPoint(s,(0,0)) ;
			p := SegmentPoint(s,sp) ;
			addto pic doublepath p withpen currentpen ;
		else:
			o := SegmentPoint(s,sp) ;
			p := o shifted sh ;
			addto pic doublepath o--p withpen currentpen ;
		fi;
	else:
		p := SegmentPoint(s,sp)    ;
		o := SegmentPoint(s,(0,0)) ;
		
	fi;
	
	if laboff.@# = (-3,-3): % auto justification

		l := _normalizeAngle( angle(p-o) ) ;
		laboff.auto := ((cosd l),(sind l)) ;
		labxf.auto  := ((cosd l) - 1) / -2 ;
		labyf.auto  := ((sind l) - 1) / -2 ;

		if (not pair sh) and ((xpart sp) >= 1):
			if (sind _normalizeAngle( angle(p-o) )) < 0 :
				p := p + (0,-pc_Depth) ;
			fi;
		fi;

	fi;
	addto pic also thelabel.@#(t,p) ;

	laboff.auto := (-3,-3) ;
	pic
enddef;


%\
% help functions
%\ 

vardef _numericToString (expr n , c) =
	save l, s ;
	string l, s ;l := "";
	if (c < 0):
		s := decimal n ;
		for i=1 upto (length s):
			if ((substring (i-1,i) of s) = "."):
				l := l & pc_sDelimiter;
			else:
				l := l & (substring (i-1,i) of s);
			fi;
		endfor;
	elseif ( (c=3) and (n>32.767) ):
		hide(message("Warning: Decrease precision for value " & decimal n & " to 2.")) ;
		s := decimal ( round(n*(10**(c-1))) ) ;
		l := substring (0,(length s)-2) of s &
			pc_sDelimiter &
			substring ((length s)-2,length s) of s ;
	else:
		s := decimal ( round(n*(10**c)) ) ;
		if (c>0):
			l := substring (0,(length s)-c) of s &
			     pc_sDelimiter &
			     substring ((length s)-c,length s) of s ;
		else:
			l := substring (0,(length s)-c) of s ;
		fi ;
	fi;
	l
enddef;

% === text routines === (pc-text.mp)
%\
% vars
%\
string pc_TeXFile ;
pc_TeXFile := jobname & ".pct" ;


%\
% TeX
%\

vardef _makeText primary s =
	if ( pc_sTextScheme > 0 ) :
		write "verbatimtex" to pc_TeXFile ;
		if ( pc_sTextScheme = 3 ):
			write "%&latex" to pc_TeXFile ;
		else:
			write pc_sTeXFormat to pc_TeXFile ;
		fi;
		if ( pc_sTextScheme > 1 ):
			write "\documentclass{minimal}" to pc_TeXFile ;
			write pc_sTeXSettings to pc_TeXFile ;
			write "\begin{document}" to pc_TeXFile ;
		else:
			write pc_sTeXSettings to pc_TeXFile ;
		fi;
		write "etex" to pc_TeXFile ;
		write "btex "&s&" etex" to pc_TeXFile;
		write EOF to pc_TeXFile;
		scantokens ("input " & pc_TeXFile )
	else:
		s infont defaultfont scaled defaultscale
	fi
enddef;

% === support routines === (pc-supp.mp)
%\
% vars / internals
%\
pair inwards, outwards ;
inwards := (.66, .5) ; outwards := (1.05, .5) ;

%\
% macros
%\
vardef SegmentPoint (expr s, t) =
	save p, a ; pair p ;
	numeric a ;
	if (( ( xpart t) >=0 ) and 
	    ( ( ypart t) >=0 ) and 
	    ( ( ypart t) <=1 ) ):
		a := pc_xStart[s] + (ypart t)*(pc_xEnd[s] - pc_xStart[s]) ;
		p := ( ( xpart t)*R*(cosd a) , ( xpart t)*R*(sind a)*(cosd pc_View) ) ;
		p := p + _calcSegmentShift(s) ;
	else :
		errmessage "SegmentPoint: point definition for segment " & (decimal s) & " is not valid. Substituted with default." ;
		p := SegmentPoint(s,(1,0.5)) ;
	fi ;
	p
enddef;

vardef _calcSegmentShift(expr s) =
	save o, x, y ;
	numeric o, x, y ;
	o := R*(pc_Offset + pc_xOffset[s]) ;
	x := o*(cosd (0.5*(pc_xStart[s] + pc_xEnd[s]))) ;
	y := o*(sind (0.5*(pc_xStart[s] + pc_xEnd[s])))*(cosd pc_View) ;
	(x,y) + pc_Centre
enddef;

vardef _normalizeAngle (expr a) =
	if a > 360:
		a - 360
	elseif a < 0:
		360 + a 
	else:
		a
	fi
enddef;

vardef _nextSegment(expr s) =
	if s < pc_Count:
		if pc_xState[s+1] >= 0:
			s+1
		else:
			_nextSegment(s+1)
		fi
	else:
		if pc_xState[1] >= 0:
			1
		else:
			_nextSegment(1)
		fi
	fi
enddef;

vardef _prevSegment(expr s) =
	if s = 1:
		if pc_xState[pc_Count] >= 0:
			pc_Count
		else:
			_prevSegment(pc_Count)
		fi
	else:
		if pc_xState[s-1] >= 0:
			s-1
		else:
			_prevSegment(s-1)
		fi
	fi
enddef;

% === setup routines === (pc-setup.mp)

%\
% vars
%\

boolean pc_sGrayscale ; pc_sGrayscale := false ;
pair pc_sAutoSV ; pc_sAutoSV := (1,1) ;
pair pc_sShadeSV ; pc_sShadeSV := (.4,.3) ;

numeric pc_sPrecision ; pc_sPrecision := 0 ;
string pc_sDelimiter ; pc_sDelimiter := "." ;

string pc_sTeXFormat, pc_sTeXSettings ;
pc_sTeXFormat := "" ; pc_sTeXSettings := "" ; 
numeric pc_sTextScheme ; pc_sTextScheme := 0 ;


string pc_p_Pre, pc_p_Post, pc_v_Pre, pc_v_Post,
	pc_n_Pre, pc_n_Post ;
pc_p_Pre := "" ; pc_p_Post := "" ; 
pc_v_Pre := "" ; pc_v_Post := "" ;
pc_n_Pre := "" ; pc_n_Post := "" ;


color this ; this := (-9,-9,-9) ;

vardef _isThis (expr t) =
	if color t :
		if t = this:
			true
		else:
			false
		fi
	else:
		false
	fi
enddef;

def SetupColors (expr a, s, g) =
	if not _isThis(a) : pc_sAutoSV := a ; fi ;
	if not _isThis(s) : pc_sShadeSV := s ; fi ;
	if not _isThis(g) : pc_sGrayscale := g ; fi ;
enddef;

def SetupNumbers (expr p, d) =
	if not _isThis(p) : pc_sPrecision := p ; fi ;
	if not _isThis(d) : pc_sDelimiter := d ; fi ;
enddef;

def SetupText (expr l, f, s) =
	if not _isThis(l) : pc_sTextScheme := l ; fi ;
	if not _isThis(f) : pc_sTeXFormat := f ; fi ;
	if not _isThis(s) : pc_sTeXSettings := s ; fi ;
enddef;

def SetupPercent (expr r, o) =
	if not _isThis(r) : pc_p_Pre := r  ; fi ;
	if not _isThis(o) : pc_p_Post := o ; fi ;
enddef;

def SetupValue (expr r, o) =
	if not _isThis(r) : pc_v_Pre := r  ; fi ;
	if not _isThis(o) : pc_v_Post := o ; fi ;
enddef;

def SetupName (expr r, o) =
	if not _isThis(r) : pc_n_Pre := r  ; fi ;
	if not _isThis(o) : pc_n_Post := o ; fi ;
enddef;

%C only activate bounding box code if PiechartBBox variable
%C is set by user
if not known PiechartBBox: endinput ; fi;
% === Bounding Box === (pc-bbox.mp)
%\
%  vars
%\

pair pc_bULC, pc_bLRC ;
string pc_BBoxFile ; pc_BBoxFile := jobname & ".pcb" ;

%\
% init
%\
begingroup;
save L ; string L ;
L := readfrom pc_BBoxFile ;
if ( L = EOF ): % file not readable
	pc_bULC := origin ; pc_bLRC := origin ;
else:
	scantokens L ;
	L := readfrom pc_BBoxFile ;
	scantokens L ;
fi ;
endgroup;

%\
% macros
%\

extra_endfig := extra_endfig & "_pcFitBBox ;" ;

%C merges bbox size of current picture with
%C the size saved in variables pc_bULC/LRC to obtain
%C ths size of a maximum bbox
def _pcFitBBox =
	begingroup;
	save L, YO, YU, XR, XL ; string L ;
	numeric YO, YU, XR, XL ;

	
	if (xpart (ulcorner currentpicture)) < (xpart pc_bULC) :
		XL := xpart ( ulcorner currentpicture ) ;
	else:
		XL := xpart pc_bULC ;
	fi ;
	if (ypart (ulcorner currentpicture)) > (ypart pc_bULC) :
		YO := ypart ( ulcorner currentpicture ) ;
	else:
		YO := ypart pc_bULC ;
	fi ;
	if (xpart ( lrcorner currentpicture)) > (xpart pc_bLRC) :
		XR := xpart ( lrcorner currentpicture ) ;
	else:
		XR := xpart pc_bLRC ;
	fi ;
	if (ypart ( lrcorner currentpicture)) < (ypart pc_bLRC) :
		YU := ypart ( lrcorner currentpicture ) ;
	else:
		YU := ypart pc_bLRC ;
	fi ;	
	
	setbounds currentpicture to (XL,YO)--(XR,YO)--(XR,YU)--(XL,YU)--cycle ;
	write "pc_bULC := ( " & 
		decimal (xpart (ulcorner currentpicture)) & " , " &
		decimal (ypart (ulcorner currentpicture)) & " )" to pc_BBoxFile ;
	write  "pc_bLRC := ( " & 
		decimal (xpart (lrcorner currentpicture)) & " , " &
		decimal (ypart (lrcorner currentpicture)) & " )" to pc_BBoxFile ;
	write EOF to pc_BBoxFile ;
	
	pc_bULC := (XL, YO) ; pc_bLRC := (XR, YU) ;
	endgroup;
enddef;