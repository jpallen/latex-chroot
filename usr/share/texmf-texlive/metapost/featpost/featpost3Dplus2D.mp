% featpost3Dplus2D.mp
% L. Nobre G., C. Barbarosie, J. Schwaiger and B. Jackowski
% nobre@lince.cii.fc.ul.pt
% http://matagalatlante.org
% Copyright (C) 2005
% see also featpost.mp

% This set of macros extends the MetaPost language
% to three dimensions and eases the production of 
% physics diagrams.

% This is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.

% This set of macros is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
% GNU General Public License for more details.

    message "Preloading FeatPost macros, version 0.6.7";

    warningcheck := 0;

    background := 0.987white;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Global Variables %%%%%%%%%%%

    boolean	 ParallelProj, SphericalDistortion, FCD[], ShadowOn;
    boolean      OverRidePolyhedricColor;
    numeric      Nobjects, RefDist[], HoriZon, RopeColorSeq[], PhotoMarks;
    numeric	 Spread, PrintStep, PageHeight, PageWidth, ActuC, Shifts;
    numeric      NL, npl[], NF, npf[], FC[], MaxFearLimit, TableColors;
    numeric      TDAtiplen, TDAhalftipbase, TDAhalfthick, RopeColors, NCL;
    pair	 OriginProjPagePos, ShiftV, PhotoPair[];
    path	 VGAborder, CLPath[];
    color        f, viewcentr, V[], L[]p[], F[]p[], TableC[]; 
    color        HigColor, SubColor, LightSource, PhotoPoint[];
    string       ostr[];
    pen          BackPen, ForePen;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Kept for backward compatibility

            Shifts := 105.00mm;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Default Values %%%%%%%%%%%%%%%

            f := (3,5,4);   % This f is the point of view in 3D
	    
	    viewcentr := black; % This is the aim of the view
	    
            Spread := 140;   % Magnification

            ShiftV := 105.00mm*(1,1); % Central coordinates on paper

	    OriginProjPagePos := (105.00mm,148.45mm); % This should be the
	                                              % page center. 

	    ParallelProj := false; % Kind of perspective 
				       % Can't have both true
	    SphericalDistortion := false; % Kind of lens

	    ShadowOn := false; % Some objects may block the light and

	    HoriZon := 0; % cast a shadow on a horizontal plane at this Z
	    
	    VGAborder := (182.05,210.00)--       % This definition assumes
			 (412.05,210.00)--       % ShiftV = 105.00mm(1,1)
			 (412.05,382.05)--       % Use: gs -r200 and you 
			 (182.05,382.05)--cycle; % get few extra pixels

	    PrintStep := 5;   % Coarseness, in resolvec

	    defaultscale := 0.75;
	    defaultfont := "cmss17";   % This is used by cartaxes

	    PageHeight := 9in;
	    PageWidth := 6in;   % And this is used by produce_auto_scale

            MaxFearLimit := 15;       % Valid Maximum Distance from Origin
	    
            HigColor := 0.85white;          % These two colors are used in
	    SubColor := 0.35white;          %        fillfacewithlight
	    LightSource := 10*(4,-3,4);     % This also
	    OverRidePolyhedricColor:=false; % And also this
	    	    
	    TableC0 := 0.85white;           % grey        %% G N U P L O T
	    TableC1 := red;                 % red         %% 
	    TableC2 := ( 0.2, 0.2, 1.0 );   % blue        %%    colors 
	    TableC3 := ( 1.0, 0.7, 0.0 );   % orange      %%
	    TableC4 := 0.85green;           % pale green  %%
	    TableC5 := 0.90*(red+blue);     % magenta     %%
	    TableC6 := 0.85*(green+blue);   % cyan        %%
	    TableC7 := 0.85*(red+green);    % yellow      %%
	    
	    TableColors := 7;
	    ActuC := 5;

	    RopeColorSeq0 := 3;             % 
	    RopeColorSeq1 := 3;             % 
	    RopeColorSeq2 := 1;             % 
	    RopeColorSeq3 := 3;             % ropepattern 
	    RopeColorSeq4 := 7;             % 
	    RopeColorSeq5 := 5;             % 
                                            %
	    RopeColors := 5;                % 

	    Nobjects := 0;                  % getready and doitnow

	    TDAtiplen := 0.05;              % tdarrow
	    TDAhalftipbase := 0.02;         % Three-Dimensional
	    TDAhalfthick := 0.01;           % Arrow

	    NCL := 0;                       % closedline
	    ForePen := pencircle scaled 15pt;
	    BackPen := pencircle scaled 9pt;
	    
            %%% The variables PhotoMarks, PhotoPair[], PhotoPoint[]
	    %%% and CLPath[] have NO default values.
	    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Part I:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Very basic:
	    
% Colors have three coordinates. Get one. 

    def X(expr A) =   
        redpart A 
    enddef;

    def Y(expr A) = 
        greenpart A 
    enddef;

    def Z(expr A) =  
        bluepart A 
    enddef;

% The length of a vector.

    def conorm(expr A) = 
       ( X(A) ++ Y(A) ++ Z(A) )  
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Vector Calculus:
	    
% Calculate the unit vector of a vector (or a point)

    def N(expr A) =
        begingroup
            save M, exitcolor;
            numeric M;
            color exitcolor;
            M = conorm( A );
            if M > 0:
                exitcolor = ( X(A)/M, Y(A)/M, Z(A)/M );
            else:
                exitcolor := black;
            fi;
            ( exitcolor )
        endgroup
    enddef;

    def cdotprod(expr A, B) = 
        ( X(A)*X(B) + Y(A)*Y(B) + Z(A)*Z(B) )
    enddef;

    def ccrossprod(expr A, B) = 
        ( Y(A)*Z(B) - Z(A)*Y(B), 
          Z(A)*X(B) - X(A)*Z(B), 
          X(A)*Y(B) - Y(A)*X(B) )
    enddef;

% The dotproduct of two normalized vectors is the cosine of the angle 
% they form.

    def ndotprod(expr A, B) = 
        begingroup
            save a, b;
            color a, b;
            a = N(A);
            b = N(B);
            ( ( X(a)*X(b) + Y(a)*Y(b) + Z(a)*Z(b) ) )
        endgroup
    enddef;

% The normalized crossproduct of two vectors. 
% Also check getangle below.

    def ncrossprod(expr A, B) = 
        N( ccrossprod( A, B ) )
    enddef;

% Haahaa! Trigonometry. 

    def getangle(expr A, B) =
        begingroup 
            save coss, sine;
            numeric coss, sine;
            coss := cdotprod( A, B );
            sine := conorm( ccrossprod( A, B ) );
            ( angle( coss, sine ) )
        endgroup
    enddef;

% Something I need for spatialhalfsfear.

    def getcossine( expr Center, Radius ) =
      begingroup
	save a, b;
	numeric a, b;
	a = conorm( f - Center );
	b = Radius/a;
	if abs(b) >= 1:
	  show "The point of view f is too close (getcossine).";
	  b := 2;                                                % DANGER!
	fi;
	( b )
      endgroup
    enddef;
    
% The following routine could be used by kindofcube and may be used to
% rotate polyhedra (must cycle through all Vs before calling makeface).

    def eulerrotation( expr AngA, AngB, AngC, Vec ) =
      begingroup
	save auxx, auxy, veca, vecb, vecc;
	color auxx, auxy, veca, vecb, vecc;
	veca = ( cosd(AngA)*cosd(AngB),
	  sind(AngA)*cosd(AngB),
	  sind(AngB) );
	auxx = ( cosd(AngA+90), sind(AngA+90), 0 );
	auxy = ccrossprod( veca, auxx );
	vecb = cosd(AngC)*auxx + sind(AngC)*auxy;
	vecc = cosd(AngC+90)*auxx + sind(AngC+90)*auxy;
	( X(Vec)*veca + Y(Vec)*vecb + Z(Vec)*vecc )
      endgroup
    enddef;

% inplanarvolume is used by kindofcube.    
    
    def inplanarvolume( expr PointPerpA, PointPerpB, Point ) =
      begingroup
	save va, vb, vc;
	color va, vb, vc;
	va = Point - PointPerpA;
	vb = Point - PointPerpB;
	vc = PointPerpB - PointPerpA;
	( cdotprod(va,vc)*cdotprod(vb,vc) <= 0 )
      endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Auxiliary:
	    
% Projection Size. Meant for objects with size one.
% Used by signalvertex.

    def ps(expr A, Thicken_Factor) =
        Thicken_Factor/conorm(A-f)/3
    enddef;

% Rigorous Projection of a Point. Draws a circle with
% a diameter inversely proportional to the distance of
% that Point from the point of view.

    def signalvertex(expr A, TF, Col) =
      draw rp(A) withcolor Col withpen pencircle scaled (Spread*ps(A,TF))
    enddef;

    def signalshadowvertex(expr A, TF, Col) =
      begingroup
	save auxc, auxn;
	color auxc;
	numeric auxn;
	auxc := cb(A);
	auxn := TF*conorm(f-auxc)/conorm(LightSource-A);
	signalvertex( auxc, auxn, Col )
      endgroup
    enddef;

% Get the vector that projects onto the resolution

    def resolvec(expr A, B) =
        begingroup
            save sizel, returnvec;
            numeric sizel;
            color returnvec;
            sizel = abs( rp(A) - rp(B) );
            if sizel > 0:
                returnvec = PrintStep*(B-A)/sizel;
            else:
                returnvec = 0.3*(B-A);
            fi;
            ( returnvec )
        endgroup
    enddef;

% Movies need a constant frame

    def produce_vga_border =
      begingroup
	draw VGAborder withcolor background withpen pencircle scaled 0;
	clip currentpicture to VGAborder
      endgroup
    enddef;

    def produce_auto_scale =
        begingroup
            picture storeall, scaleall;
	    numeric pwidth, pheight;
	    storeall = currentpicture shifted -(center currentpicture);
	    currentpicture := nullpicture;
	    pwidth = xpart ((lrcorner storeall)-(llcorner storeall));
	    pheight = ypart ((urcorner storeall)-(lrcorner storeall));
	    if PageHeight/PageWidth < pheight/pwidth:
	        scaleall = storeall scaled (PageHeight/pheight);
            else:
	        scaleall = storeall scaled (PageWidth/pwidth);
            fi;
	    draw scaleall shifted OriginProjPagePos
        endgroup
    enddef;

    vardef cstr( expr Cl ) =
      "(" &
	decimal(X(Cl)) &
	"," &
	decimal(Y(Cl)) &
	"," &
	decimal(Z(Cl)) &
	")"
    enddef;

    vardef bstr( expr bv ) =
      save bstring; string bstring;
      if bv: bstring = "true"; else: bstring = "false"; fi;
      bstring
    enddef;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Fundamental:
	    
% Rigorous Projection. This the kernel of all these lines of code.
% It won't work if R belongs the plane that contains f and that is 
% ortogonal to vector f, unless SphericalDistortion is true.
% f must not be on a line parallel to zz and that contains the
% viewcentr.
 
    def rp(expr R) =
        begingroup

	    save projpoi;
            save v, u;
            save verti, horiz, eta, squarf, radio, ang, lenpl;
	    pair projpoi;
            color v, u;
            numeric verti, horiz, eta, squarf, radio, ang, lenpl;

            v = N( (-Y(f-viewcentr), X(f-viewcentr), 0) );
            u = ncrossprod( f-viewcentr, v );

	    horiz = cdotprod( R-viewcentr, v );
	    verti = cdotprod( R-viewcentr, u );

	    if SphericalDistortion:
		if ( horiz <> 0 ) or ( verti <> 0 ):
	    	    lenpl = ( horiz ++ verti )*20; %%%%%%%%%%%%%%% DANGER
	    	    ang = getangle( f-R, f-viewcentr );
		    horiz := ang*horiz/lenpl;
		    verti := ang*verti/lenpl;
		    projpoi = (horiz,verti);
		else:
		    projpoi = origin;
		fi;			
	    else:
	        if ParallelProj:
		    eta = 1;
	        else:
	            squarf = cdotprod( f-viewcentr, f-viewcentr );
		    radio = cdotprod( R-viewcentr, f-viewcentr );
		    eta = 1 - radio/squarf;
		    if eta < 0.03:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DANGER
		        eta := 0.03;
		    fi;
	        fi;
	        projpoi = (horiz,verti)/eta;
	    fi;

	    ( projpoi*Spread + ShiftV )

        endgroup
    enddef;

% Much improved rigorous pseudo-projection algorithm that follows 
% an idea from Cristian Barbarosie. This makes shadows.

    def cb(expr R) =
      begingroup
	save    ve, ho;
	numeric ve, ho;
	LightSource-ho*red-ve*green-HoriZon*blue=whatever*(LightSource-R);
	( ho*red + ve*green + HoriZon*blue ) 
      endgroup
    enddef;

% And this just projects points rigorously on some generic plane using
% LightSource as the point of convergence (focus).
    
    def projectpoint(expr ViewCentr, R) =
        begingroup
            save    verti, horiz;
            save    v, u, lray;
            numeric verti, horiz;
            color   v, u, lray;
	    lray = LightSource-ViewCentr;
            v = N( (-Y(lray), X(lray), 0) );
            u = ncrossprod( lray, v );
            lray - horiz*v - verti*u = whatever*( LightSource - R );
            ( horiz*v + verti*u + ViewCentr ) 
        endgroup
    enddef;

% And this is the way to calculate the intersection of some line with some
% plan.

    def lineintersectplan( expr LinePoi, LineDir, PlanPoi, PlanDir ) =
      begingroup
	save incognitus;
	color incognitus;
	cdotprod( incognitus-PlanPoi, PlanDir ) = 0;
	whatever*LineDir + LinePoi = incognitus;
	( incognitus )
      endgroup
    enddef;
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Basic Functions:
	    
% Get the 2D path of a straight line in beetween 3D points A and B.
% This would add rigor to rigorousdisc, if one would introduce the
% the concept of three-dimensional path. That is not possible now.
% Also this is only interesting when using SphericalDistortion:=true
    
    def pathofstraightline( expr A, B ) =
        begingroup
            save  k, i, mark, stepVec, returnp, pos; 
            numeric k, i;
            color mark, stepVec;
	    path returnp;
	    pair pos[];
            stepVec = resolvec(A,B);
	    pos0 = rp( A );
            k = 1;
            forever:
	        mark := A+(k*stepVec);
                exitif cdotprod(B-mark,stepVec) <= 0;
		pos[k] = rp( mark );
		k := incr(k);
	    endfor;
	    pos[k] = rp(B);
	    returnp = pos0 for i=1 upto k: ..pos[i] endfor;
	    ( returnp )
	endgroup
    enddef;

    def drawsegment( expr A, B )=
        begingroup
	    if SphericalDistortion:
	      draw pathofstraightline( A, B );
	    else:
	      draw rp(A)--rp(B);
	    fi
	endgroup
    enddef;

% Cartesian axes with prescribed lengths.

    def cartaxes(expr axex, axey, axez) =
        begingroup
            save orig, axxc, ayyc, azzc;
            color orig, axxc, ayyc, azzc;
            orig = (0,0,0);
            axxc = (axex,0,0);
            ayyc = (0,axey,0);
            azzc = (0,0,axez);
            drawarrow rp(orig)..rp(axxc);
            drawarrow rp(orig)..rp(ayyc);
            drawarrow rp(orig)..rp(azzc);
            label.bot( "x" ,rp(axxc));       %%%%%%%%%%%%%%%%%%%%%%%%% 
            label.bot( "y" ,rp(ayyc));       %%   Some  Labels...   %%
            label.lft( "z" ,rp(azzc));       %%%%%%%%%%%%%%%%%%%%%%%%% 
        endgroup
    enddef;

% This is it. Draw an arch beetween two straight lines with a
% common point (Or) in three-dimensional-euclidian-space and 
% place a label near the middle of the arch. Points A and B
% define the lines. The arch is at a distance W from Or. The
% label is S and the position is RelPos (rt,urt,top,ulft,lft,
% llft,bot,lrt). But arches must be smaller than 180 degrees.

    def angline(expr A, B, Or, W, S)(suffix RelPos) =
        begingroup
            save G, Dna, Dnb, al;
            numeric G;
            color Dna, Dnb;
            path al;
            G = conorm( W*( N(A-Or) - N(B-Or) ) )/2.5; %%%%%%% BIG DANGER!
            Dna = ncrossprod(ncrossprod(A-Or,B-Or),A-Or);
            Dnb = ncrossprod(ncrossprod(B-Or,A-Or),B-Or);
            al = rp(W*N(A-Or)+Or)..
                                  controls rp(W*N(A-Or)+Or+G*Dna) 
                                       and rp(W*N(B-Or)+Or+G*Dnb)..
                  rp(W*N(B-Or)+Or);
            draw al;
            label.RelPos( S, point 0.5*length al of al )
        endgroup
    enddef;

% As i don't know how to declare variables of type suffix,
% i provide a way to avoid the problem. This time RelPos may
% be 0,1,2,3,4,6,7 or anything else.

    def anglinen(expr A, B, Or, W, S, RelPos) =
        begingroup
            save G, Dna, Dnb, al, middlarc;
            numeric G;
            color Dna, Dnb;
            path al;
            pair middlarc;
            G = conorm( W*( N(A-Or) - N(B-Or) ) )/3;
            Dna = ncrossprod(ncrossprod(A-Or,B-Or),A-Or);
            Dnb = ncrossprod(ncrossprod(B-Or,A-Or),B-Or);
            al = rp(W*N(A-Or)+Or)..
                                  controls rp(W*N(A-Or)+Or+G*Dna) 
                                       and rp(W*N(B-Or)+Or+G*Dnb)..
                  rp(W*N(B-Or)+Or);
            draw al;
            middlarc = point 0.5*length al of al;
            if RelPos = 0:
                label.rt( S, middlarc );
            elseif RelPos =1:
                label.urt( S, middlarc );
            elseif RelPos =2:
                label.top( S, middlarc );
            elseif RelPos =3:
                label.ulft( S, middlarc );
            elseif RelPos =4:
                label.lft( S, middlarc );
            elseif RelPos =5:
                label.llft( S, middlarc );
            elseif RelPos =6:
                label.bot( S, middlarc );
            elseif RelPos =7:
                label.lrt( S, middlarc );
            else:
                label( S, middlarc );
            fi
        endgroup
    enddef;

% As a bigger avoidance, replace the arch by a paralellogram.

    def squareangline(expr A, B, Or, W) =
      begingroup
	save sal;
	path sal;
	sal = rp(Or)--rp(W*N(A-Or)+Or)-- 
	      rp(W*(N(B-Or)+N(A-Or))+Or)--rp(W*N(B-Or)+Or)--cycle;
	draw sal
      endgroup
    enddef;

% Just as we are here we can draw circles. (color,color,numeric)

    def rigorouscircle( expr CenterPos, AngulMom, Radius ) =
      begingroup
	save ind, G, Dna, Dnb, al;
	numeric ind, G;
	color vec[], Dna, Dnb;
	path al;
	vec1 = ncrossprod( CenterPos-f, AngulMom);
	for ind=2 step 2 until 8:
	  vec[ind+1] = ncrossprod( vec[ind-1], AngulMom );
	  vec[ind] = N( vec[ind-1] + vec[ind+1] ); 
	endfor;
	G = conorm( Radius*( vec1 - vec2 ) )/3;
	al = rp(Radius*vec1+CenterPos)
	for ind=2 upto 8: 
	  hide(
	    Dna:=ncrossprod(ncrossprod(vec[ind-1],vec[ind]),vec[ind-1]);
	    Dnb:=ncrossprod(ncrossprod(vec[ind],vec[ind-1]),vec[ind]) 
	    )
	  ..controls rp(Radius*vec[ind-1]+CenterPos+G*Dna) 
	  and rp(Radius*vec[ind]  +CenterPos+G*Dnb)
	  ..rp(Radius*vec[ind]  +CenterPos)
	endfor
	...cycle;
	( al ) 
      endgroup
    enddef;

% 3D arrow.

    def tdarrow(expr FromPos, ToTip ) =
      begingroup
	save basevec, longvec, a, b, c, d, e, g, h, len, p;
	color basevec, longvec, a, b, c, d, e, g, h;
	numeric len;
	path p;
	len = conorm( ToTip - FromPos );
	longvec := N( ToTip - FromPos );
	basevec := ncrossprod( FromPos-f, longvec );
	if len <= TDAtiplen:
	  b = basevec*TDAhalftipbase*len/TDAtiplen;
	  c = FromPos+b;
	  e = FromPos-b;
	  p = rp(ToTip)--rp(c)--rp(e)--cycle;
	else:
	  d = ToTip-longvec*TDAtiplen;
	  a = FromPos+basevec*TDAhalfthick;
	  h = FromPos-basevec*TDAhalfthick;
	  b = d+basevec*TDAhalfthick;
	  g = d-basevec*TDAhalfthick;
	  c = d+basevec*TDAhalftipbase;
	  e = d-basevec*TDAhalftipbase;
	  p = rp(a)--rp(b)--rp(c)--rp(ToTip)--rp(e)--rp(g)--rp(h)--cycle;
	fi;
	unfill p;
	draw p
      endgroup
    enddef;

% Draw lines with a better expression of three-dimensionality.

    def emptyline(expr JoinP,ThickenFactor,OutCol,InCol,theN,EmptyFrac,sN)
      (text LinFunc) = 
      begingroup
	save i, j, k; 
	numeric i, j, k;
	k = ThickenFactor*EmptyFrac;
	if ShadowOn:
	  for i = 0 upto theN:
	    signalshadowvertex( LinFunc(i/theN), ThickenFactor, black );
	  endfor;
	fi;
	for j = 0 upto sN-1:
	  signalvertex( LinFunc(j/theN), ThickenFactor, OutCol );
	endfor;
	if JoinP:
	  for j = -sN upto 0:
	    signalvertex( LinFunc(j/theN), k, InCol );
	  endfor;
	fi;
	for i = sN upto theN:
	  signalvertex( LinFunc( i/theN ), ThickenFactor, OutCol );
	  for j = sN downto 0: 
	    signalvertex( LinFunc( (i-j)/theN ), k, InCol );
	  endfor;
	endfor
      endgroup 
    enddef;

% Draw space-paths of possibly closed lines making use of "getready"

    def closedline( expr ThisIsClosed, theN, ForeFrac, BackFrac )  
      ( text LinFunc ) =
      begingroup
	save i, comm;
	numeric i;
	string comm;
	NCL := incr( NCL );
	if ThisIsClosed:
	  CLPath[NCL] :=
	    for i=1 upto theN:
	      rp(LinFunc(i/theN))..
	    endfor
	    cycle;
	  for i=1 upto theN:
	    comm:="draw subpath ("
	      & decimal(i-ForeFrac)
	      & ","
	      & decimal(i+ForeFrac)
	      & ") of CLPath"
	      & decimal(NCL)
	      & " withpen ForePen; undraw subpath ("
	      & decimal(i-BackFrac)
	      & ","
	      & decimal(i+BackFrac)
	      & ") of CLPath"
	      & decimal(NCL)
	      & " withpen BackPen;";
	    getready( comm, LinFunc(i/theN) );
	  endfor;
	else:
	  CLPath[NCL] := rp(LinFunc(0))
	    for i=1 upto theN: ..rp(LinFunc(i/theN)) endfor;
	  comm:="draw subpath (0,"
	    & decimal(ForeFrac)
	    & ") of CLPath"
	    & decimal(NCL)
	    & " withpen ForePen; undraw subpath (0,"
	    & decimal(BackFrac)
	    & ") of CLPath"
	    & decimal(NCL)
	    & " withpen BackPen;";
	  getready( comm, LinFunc(1/theN) );
	  for i=2 upto theN-1:
	    comm:="draw subpath ("
	      & decimal(i-ForeFrac)
	      & ","
	      & decimal(i+ForeFrac)
	      & ") of CLPath"
	      & decimal(NCL)
	      & " withpen ForePen; undraw subpath ("
	      & decimal(i-BackFrac)
	      & ","
	      & decimal(i+BackFrac)
	      & ") of CLPath"
	      & decimal(NCL)
	      & " withpen BackPen;";
	    getready( comm, LinFunc(i/theN) );
	  endfor;
	  comm:="draw subpath ("
	    & decimal(theN-ForeFrac)
	    & ","
	    & decimal(theN)
	    & ") of CLPath"
	    & decimal(NCL)
	    & " withpen ForePen; undraw subpath ("
	    & decimal(theN-BackFrac)
	    & ","
	    & decimal(theN)
	    & ") of CLPath"
	    & decimal(NCL)
	    & " withpen BackPen;";
	  getready( comm, LinFunc(1) );
	fi
      endgroup
    enddef;

% The next allows you to draw any solid that has no vertices and that has 
% two, exactly two, cyclic edges. In fact, it doesn't need to be a solid. 
% In order to complete the drawing of this solid you have to choose one of
% the edges to be drawn immediatly afterwards.    
    
    def twocyclestogether( expr CycleA, CycleB )=
        begingroup
	    numeric TheLengthOfA, TheLengthOfB, TheMargin, Leng, i;
	    path SubPathA, SubPathB, PolygonPath, FinalPath;
	    TheMargin = 0.02;
	    TheLengthOfA = ( length CycleA ) - TheMargin;
	    TheLengthOfB = ( length CycleB ) - TheMargin;
	    SubPathA = subpath ( 0, TheLengthOfA ) of CycleA;
	    SubPathB = subpath ( 0, TheLengthOfB ) of CycleB;
	    PolygonPath = makepath makepen ( SubPathA--SubPathB--cycle );
	    Leng = (length PolygonPath) - 1;
	    FinalPath = point 0 of PolygonPath
		        for i = 1 upto Leng:	  
			    --point i of PolygonPath
			endfor
			--cycle;
	    ( FinalPath )
        endgroup
    enddef;
    
% Ellipse on the air.

    def ellipticpath(expr CenterPos, OneAxe, OtherAxe ) =
      begingroup
	save cirath, ind, vec;
	numeric ind;
	color vec[];
	path cirath;
	for ind=1 upto 36:
	  vec[ind] = CenterPos+OneAxe*cosd(ind*10)+OtherAxe*sind(ind*10);
	endfor;
	cirath = rp( vec1 ) 
	  for ind=2 upto 36: 
	    ...rp( vec[ind] )
	  endfor
	  ...cycle;
	( cirath ) 
      endgroup
    enddef;

% Shadow of an ellipse on the air.

    def ellipticshadowpath(expr CenterPos, OneAxe, OtherAxe ) =
      begingroup
	save cirath, ind, vec;
	numeric ind;
	color vec[];
	path cirath;
	for ind=1 upto 36:
	  vec[ind] = CenterPos+OneAxe*cosd(ind*10)+OtherAxe*sind(ind*10);
	endfor;
	cirath = rp( cb( vec1 ) ) 
	  for ind=2 upto 36: 
	    ...rp( cb( vec[ind] ) )
	  endfor
	  ...cycle;
	( cirath ) 
      endgroup
    enddef;

% It should be possible to attach some text to some plan.
% Unfortunately, this only works correctly when ParallelProj := true;
    
    def labelinspace(expr KeepRatio,RefPoi,BaseVec,UpVec)
      (text SomeString)=
      begingroup
	save labelpic, plak, lrc, ulc, llc, centerc, aratio, newbase;
	picture labelpic;
	pair lrc, ulc, llc;
	transform plak;
	color centerc, newbase;
	numeric aratio;
	labelpic = thelabel( SomeString, origin );
	lrc = lrcorner labelpic;
	ulc = ulcorner labelpic;
	llc = llcorner labelpic;
	aratio = (xpart  lrc - xpart llc)/(ypart ulc - ypart llc);
	if KeepRatio:
	  newbase = conorm(UpVec)*aratio*N(BaseVec);
	else:
	  newbase = BaseVec;
	fi;
	rp(RefPoi+newbase) = lrc transformed plak;
	rp(RefPoi+UpVec) = ulc transformed plak;
	centerc = RefPoi+0.5(newbase+UpVec);
	rp(RefPoi) = llc transformed plak;
	label( labelpic transformed plak, rp(centerc) )
      endgroup
    enddef;

% It should be possible to attach some path to some surface.
    
    def closedpathinspace( expr SomeTDPath )( text ConverterFunc )=
      begingroup
	save i, outpath;
	numeric i;
	path outpath;
	outpath = for i=0.25 step 0.25 until (length SomeTDPath):
	  ConverterFunc( point i of SomeTDPath ) --
	endfor cycle;
	( outpath )
      endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Standard Objects:
	    
% And more precisely. The next routines spatialhalfcircle and 
% rigorousfear require circles drawn in a systematic and precise way.

    def goodcirclepath(expr CenterPos, AngulMom, Radius ) =
        begingroup
            save cirath, vecx, vecy, ind, goodangulmom, decision;
            numeric ind, decision;
            color vecx, vecy, vec[], goodangulmom, view;
            path cirath;
	    view = f-CenterPos;
	    decision = cdotprod( view, AngulMom );
	    if decision < 0: 
	        goodangulmom = -AngulMom;
	    else:
		goodangulmom = AngulMom;
	    fi;
            vecx = ncrossprod( view, goodangulmom );
	    decision := getangle( view, goodangulmom );
	    if decision > 0.5:                  %%%%%%%%%%%%%%% DANGER %%%
                vecy = ncrossprod( goodangulmom, vecx );
		for ind=1 upto 36:
		    vec[ind] := vecx*cosd(ind*10) + vecy*sind(ind*10);
		    vec[ind] := CenterPos + vec[ind]*Radius;
                endfor;
		cirath = rp( vec1 ) 
		         for ind=2 upto 36: 
			     ...rp( vec[ind] )
			 endfor
			 ...cycle;
	    else:
	      cirath = head_on_circle( CenterPos, Radius );
	    fi;
            ( cirath ) 
        endgroup
    enddef;

% And its shadow. 

    def circleshadowpath(expr CenterPos, AngulMom, Radius ) =
      begingroup
	save cirath, vecx, vecy, view, decision;
	numeric decision;
	color vecx, vecy, view;
	path cirath;
	view = LightSource-CenterPos;
	vecx = ncrossprod( view, AngulMom );
	decision := getangle( view, AngulMom );
	if decision > 0.5:                  %%%%%%%%%%%%%%% DANGER %%%
	  vecy = ncrossprod( AngulMom, vecx );
	  cirath = ellipticshadowpath(CenterPos,vecx*Radius,vecy*Radius);
	else:
	  vecx := N( (-Y(view), X(view), 0) );
	  vecy = ncrossprod( view, vecx );
	  cirath = ellipticshadowpath(CenterPos,vecx*Radius,vecy*Radius);
	fi;
	( cirath ) 
      endgroup
    enddef;

% When there are numerical problems with the previous routine
% use the following alternative:

    def head_on_circle(expr Pos, Radius ) =
        begingroup
            save cirath, vecx, vecy, ind, view;
            numeric ind;
            color vecx, vecy, vec[], view;
            path cirath;
	    view = f-Pos;
            vecx = N( (-Y(view), X(view), 0) );
            vecy = ncrossprod( view, vecx );
            for ind=1 upto 36:
                vec[ind] := vecx*cosd(ind*10) + vecy*sind(ind*10);
		vec[ind] := Pos + vec[ind]*Radius; 
            endfor;
            cirath = rp( vec1 ) 
	        for ind=2 upto 36: 
		    ...rp( vec[ind] )
		endfor
		...cycle;
            ( cirath ) 
        endgroup
    enddef;

% The nearest or the furthest part of a circle returned as a path.
% This function has been set to work for rigorousdisc (next).
% Very tough settings they were.

    def spatialhalfcircle(expr Center, AngulMom, Radius, ItsTheNearest ) =
      begingroup
	save auxil, auxih;
	color va, vb, vc, cc, vd, ux, uy, pa, pb;
	numeric nr, cn, valx, valy, valr, choiceang;
	path auxil, auxih, fcirc, returnp;
	boolean choice;
	va := Center - f; 
	vb := N( AngulMom ); 
	vc := vb*( cdotprod( va, vb ) );
	cc := f + vc;
	vd := cc - Center;  % vd := va + vc;
	nr := conorm( vd );
	if Radius >= nr:
	  returnp := rp( cc );
	else:
	  valr := Radius*Radius;
	  valx := valr/nr;
	  valy := sqrt( valr - valx*valx ); 
	  ux := N( vd );
	  choiceang := getangle( vc, va );                   %%%%%%%%%%%%%
	  choice := ( choiceang < 89 ) or ( choiceang > 91 );%%  DANGER  %
	  if choice:                                         %%%%%%%%%%%%%
	    uy := ncrossprod( vc, va );
	  else:
	    uy := ncrossprod( AngulMom, va );
	  fi;
	  pa := valx*ux + valy*uy + Center;
	  pb := pa - 2*valy*uy;
	  if choice:
	    auxil := rp(1.1[Center,pb])--rp(0.9[Center,pb]);
	    auxih := rp(1.1[Center,pa])--rp(0.9[Center,pa]);
	    fcirc := goodcirclepath( Center, AngulMom, Radius );
	    if ItsTheNearest:
	      returnp := (fcirc cutafter auxih) cutbefore auxil;
	    else:
	      returnp := (fcirc cutbefore auxih)..(fcirc cutafter auxil);
	    fi;
	  else:
	    if ItsTheNearest:
	      if cdotprod( va, AngulMom ) > 0:
		returnp := rp(pb)--rp(pa);
	      else:
		returnp := rp(pa)--rp(pb);
	      fi;
	    else:
	      if cdotprod( va, AngulMom ) < 0:
		returnp := rp(pb)--rp(pa);
	      else:
		returnp := rp(pa)--rp(pb);
	      fi;
	    fi;
	  fi;
	fi;
	( returnp )
      endgroup
    enddef;

% Cylinders or tubes ( numeric, boolean, color, numeric, color ).
% Great stuff. The "disc" in the name comes from the fact that
% when SphericalDistortion := true; the sides of cylinders are
% not drawn correctly (they are straight). And when it is a tube
% you should force the background to be white.
 
    def rigorousdisc(expr InRay, FullFill, BaseCenter, Radius, LenVec) =
      begingroup
        save va, vb, vc, cc, vd, base, holepic;
	save vA, cC, nr, vala, valb, hashole, istube;
	save auxil, auxih, rect, halfl, halfh, thehole;
	save auxili, auxihi, rect, theshadow;

        color va, vb, vc, cc, vd, base;
	picture holepic;
	color vA, cC;
        numeric nr, vala, valb;
	boolean hashole, istube;
	path auxil, auxih, halfl, halfh, thehole;
	path auxili, auxihi, rect, theshadow;

	va := BaseCenter - f; 
        vb := N( LenVec ); 
        vc := vb*( cdotprod( va, vb ) );
        cc := f + vc;
	vd := cc - BaseCenter;
        nr := conorm( vd );
	base := BaseCenter + LenVec;
	vA := base - f;
	vala := conorm( va );
	valb := conorm( vA );
	if ShadowOn:
	  auxil := circleshadowpath( BaseCenter, LenVec, Radius );
	  auxih := circleshadowpath( base, LenVec, Radius );
	  fill twocyclestogether( auxil, auxih );
	fi;
	auxil := goodcirclepath( base, LenVec, Radius );
	auxih := goodcirclepath( BaseCenter, LenVec, Radius );
	istube := false;
	hashole := false;
	if InRay > 0:
	  istube := true;
	  auxili := goodcirclepath( base, LenVec, InRay );
	  auxihi := goodcirclepath( BaseCenter, LenVec, InRay );
	  hashole := (-1,-1) <> ( auxili intersectiontimes auxihi );
	  if hashole:
	    draw auxili;
	    draw auxihi;
	    holepic := currentpicture;
	    clip holepic to auxili;
	    clip holepic to auxihi;
	  fi;
	fi;
			 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if Radius >= nr: % THE CASE Radius > nr > InRay IS NOT SUPPORTED %
          if vala <= valb :
	    thehole := auxil;
	    auxil := auxih;
	    auxih := thehole;
	  fi;
	  if istube:
            if vala <= valb :
	      thehole := auxili;
	      auxili := auxihi;
	      auxihi := thehole;
	    fi;
	    holepic := currentpicture;
	    clip holepic to auxihi;
	  fi;
	  unfill auxil;
	  draw auxil;
	  if istube:
	    draw holepic;
	    draw auxihi;
	  fi;
	else:
	  cC := base + vd;
          if ( cdotprod( f - cc, f - cC ) <= 0 ) or ( not FullFill ):
	    halfl := spatialhalfcircle(BaseCenter,LenVec,Radius,true);
	    halfh := spatialhalfcircle(base,LenVec,Radius,true);
	    if FullFill:
	      rect := halfl--halfh--cycle;
	    else:
	      rect := halfl--(reverse halfh)--cycle;
	    fi;
	    unfill rect;
	    draw rect;
	  elseif vala > valb:
	    halfl := spatialhalfcircle(BaseCenter,LenVec,Radius,true);
	    halfh := spatialhalfcircle(base,LenVec,Radius,false);
	    rect := halfl--halfh--cycle;
	    unfill rect;
	    draw rect;
	    if istube:
	      if hashole:
	        draw holepic;
	      fi;
	      draw auxili;
	    fi;
	    draw auxil;
	  else:
	    halfl := spatialhalfcircle(BaseCenter,LenVec,Radius,false);
	    halfh := spatialhalfcircle(base,LenVec,Radius,true);
	    rect := halfl--halfh--cycle;
	    unfill rect;
	    draw rect;
	    if istube:
	      if hashole:
	        draw holepic;
	      fi;
	      draw auxihi;
	    fi;
	    draw auxih;
	  fi;
	fi
      endgroup
    enddef;

% And maybe a full cone border. The vertex may go anywhere.
% Choose the full cone border (UsualForm=true) or just the nearest
% part of the base edge (UsualForm=false).
% This is used by tropicalglobe as a generic spatialhalfcircle to
% draw only the in fact visible part of circular lines. Please, don't
% put the vertex too close to the base plan when UsualForm=false.
 
    def rigorouscone(expr UsualForm,CenterPos,AngulMom,Radius,VertexPos)=
      begingroup
	save basepath, themargin, thelengthofc, thesubpath, fullpath;
	save newlen, finalpath, i, auxpath, pa, pb, auxt, bigcirc;
	save startt, endt;
	path basepath, thesubpath, fullpath, finalpath, auxpath;
	path bigcirc;
	numeric themargin, newlen, i, auxt, startt, endt;
	pair pa, pb, pc, pd, pe;
	themargin = 0.02; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DANGER
	basepath = goodcirclepath( CenterPos, AngulMom, Radius );
	thelengthofc = ( length basepath ) - themargin;
	thesubpath = subpath ( 0, thelengthofc ) of basepath;
	fullpath = makepath makepen ( rp(VertexPos)--thesubpath--cycle );
	pa = 0.995[rp(CenterPos),rp(VertexPos)];
	pb = 1.005[rp(CenterPos),rp(VertexPos)];
	auxpath = pa--pb;
	pc = auxpath intersectiontimes fullpath;
	if pc <> (-1,-1):
	  auxt = ypart pc;
	  newlen = length fullpath;
	  if UsualForm:
	    finalpath = point auxt of fullpath
	      --point auxt+1 of fullpath
	      for i = auxt+2 upto auxt+newlen-1:	  
	        ...point i of fullpath
	      endfor
	      --cycle;
	  else:
	    bigcirc = goodcirclepath( CenterPos, AngulMom, 1.005*Radius );
	    pd = bigcirc intersectiontimes fullpath;
	    pe = ( reverse bigcirc ) intersectiontimes fullpath;
	    startt = floor( xpart pd );
	    endt = ceiling( ( length bigcirc ) - ( xpart pe ) );
	    finalpath = subpath (startt,endt) of basepath;
	  fi;
	else:
	  finalpath = rp(VertexPos);
	fi;
	( finalpath )
      endgroup
    enddef;
    
    def verygoodcone(expr BackDash,CenterPos,AngulMom,Radius,VertexPos)=
      begingroup
	save thepath, lenpath, bonevec, sidevec, viewaxe, cipath;
	save thelengthofc, thesubpath, themargin, basepath;
	color bonevec, sidevec, viewaxe;
	path thepath, cipath, basepath, thesubpath;
	numeric lenpath, thelengthofc, themargin;
	themargin = 0.02;
	bonevec = VertexPos - CenterPos;
	if cdotprod( bonevec, AngulMom ) < 0:
	  sidevec = -N(AngulMom);
	else:
	  sidevec = N(AngulMom);
	fi;
	viewaxe = f-CenterPos;
	if ShadowOn:
	  basepath = circleshadowpath( CenterPos, AngulMom, Radius );
	  thelengthofc = ( length basepath ) - themargin;
	  thesubpath = subpath ( 0, thelengthofc ) of basepath;
	  fill makepath makepen ( rp(cb(VertexPos))--thesubpath--cycle );
	fi;
	thepath = rigorouscone(true,CenterPos,AngulMom,Radius,VertexPos);
	lenpath = length thepath;
	if lenpath<>0:
	  unfill thepath;
	  draw thepath;
	  if cdotprod( sidevec, viewaxe ) < 0:
	    draw goodcirclepath( CenterPos, AngulMom, Radius );
	  else:
	    if BackDash:
	      draw
	      goodcirclepath( CenterPos, AngulMom, Radius ) dashed evenly;
	    fi;
	  fi;
	else:
	  cipath = goodcirclepath( CenterPos, AngulMom, Radius );
	  unfill cipath;
	  draw cipath;
	  if cdotprod( sidevec, viewaxe ) > 0:
	    draw rp( VertexPos );
	  fi;	  
	fi
      endgroup
    enddef;

% Its a sphere, don't fear, but remember that the rigorous projection
% of a sphere is an ellipse. 

    def rigorousfearpath(expr Center, Radius ) =
        begingroup
	    save auxil;
            color ux, uy, newcen;
            numeric nr, valx, valy, valr;
	    path auxil;
            nr := conorm( Center - f );
	    valr := Radius**2;
	    valx := valr/nr;
	    valy := sqrt( valr - valx**2 );
	    newcen := valx*( f - Center )/nr;
	    auxil := head_on_circle( Center+newcen, valy );
	    ( auxil )
        endgroup
    enddef;

    def rigorousfearshadowpath(expr Center, Radius ) =
        begingroup
	    save auxil, auxih;
            color ux, uy, newcen;
            numeric nr, valx, valy, valr, lenr;
	    path auxil, auxih, fcirc, returnp;
	    pair dcenter;
            nr := conorm( Center - LightSource );
	    valr := Radius**2;
	    valx := valr/nr;
	    valy := sqrt( valr - valx**2 );
	    newcen := valx*( LightSource - Center )/nr;
	    auxil := circleshadowpath( Center+newcen, newcen, valy );
	    ( auxil )
        endgroup
    enddef;

% It's a globe (without land).

    def tropicalglobe( expr NumLats, TheCenter, Radius, AngulMom )=
      begingroup
	save viewaxe, sinalfa, sinbeta, globaxe, aux, limicos, lc;
	save stepang, actang, newradius, foc, newcenter, cpath, i;
	save outerpath, conditiona, conditionb;
	color viewaxe, globaxe, foc, newcenter;
	numeric sinalfa, sinbeta, aux, limicos, stepang, actang;
	numeric newradius, lc, i;
	path cpath, outerpath;
	boolean conditiona, conditionb;
	if ShadowOn:
	  fill rigorousfearshadowpath( TheCenter, Radius );
	fi;
	viewaxe = f-TheCenter;
	sinalfa = Radius/conorm( viewaxe );
	aux = cdotprod( viewaxe, AngulMom );
	if aux < 0:
	  globaxe = -N(AngulMom);
	else:
	  globaxe = N(AngulMom);
	fi;
	sinbeta = cdotprod( globaxe, N(viewaxe) );
	aux := sqrt((1-sinalfa**2)*(1-sinbeta**2));
	limicos = aux - sinalfa*sinbeta;
	stepang = 180/NumLats;
	globaxe := globaxe*Radius;
	outerpath = rigorousfearpath(TheCenter,Radius);
	unfill outerpath;
	draw outerpath;
	for actang = 0.5*stepang step stepang until 179:
	  if cosd(actang) < limicos-0.005: %%%%%%%%%%%%%%%%%%%%%%%% DANGER
	    newradius := Radius*sind(actang);
	    newcenter := TheCenter - globaxe*cosd(actang);
	    conditiona:=(actang<94) and (actang>86); % DANGER % DANGER VV
	    conditionb:=abs(cdotprod(globaxe/Radius,N(f-newcenter)))<0.08;
	    if conditiona or conditionb:
	      draw spatialhalfcircle(newcenter,globaxe,newradius,true);
	    else:
	      foc := TheCenter - globaxe/cosd(actang);
	      lena := -Radius*cosd(actang);
	      lenb := cdotprod(viewaxe,globaxe/Radius);
	      if (actang <= 86) or ((lenb<lena) and (actang>=94)):
		cpath :=
		rigorouscone(false,newcenter,globaxe,newradius,foc);
		draw cpath;
	      else:
		cpath :=
		rigorouscone(true,newcenter,globaxe,newradius,foc);
		lc := length cpath;
		if lc <> 0:
		  draw subpath (1,lc-1) of cpath;
		else:
		  draw rigorouscircle( newcenter,globaxe,newradius );
		fi;
	      fi;
	    fi;
	  fi;
	endfor
      endgroup
    enddef;

% An elliptical frustum:
    
    def whatisthis(expr CenterPos,OneAxe,OtherAxe,CentersDist,TheFactor)=
      begingroup
	save patha, pathb, pathc, centersvec, noption;
	path patha, pathb, pathc;
	color centersvec;
	numeric noption;
	centersvec = CentersDist*ncrossprod( OneAxe, OtherAxe );
	if ShadowOn:
	  patha = ellipticshadowpath( CenterPos,
	    OneAxe,
	    OtherAxe );
	  pathb = ellipticshadowpath( CenterPos+centersvec,
	    TheFactor*OneAxe,
	    TheFactor*OtherAxe );
	  pathc = twocyclestogether( patha, pathb );
	  fill pathc;
	fi;
	patha := ellipticpath( CenterPos,
	  OneAxe,
	  OtherAxe );
	pathb := ellipticpath( CenterPos+centersvec,
	  TheFactor*OneAxe,
	  TheFactor*OtherAxe );
	pathc := twocyclestogether( patha, pathb );
	unfill pathc;
	draw pathc;
	noption = cdotprod( centersvec, f-CenterPos );
	if  noption > (CentersDist**2):
	  draw pathb;
	elseif noption < 0:
	  draw patha;
	fi
      endgroup
    enddef;
      
% You can't see through this hole. f must not be on the hole axis.
% Not yet documented because "buildcycle" doesn't work properly.
    
    def fakehole( expr CenterPos, LenVec, Radius )=
      begingroup
	save patha, pathb, pathc, noption, hashole, auxv, poption, vv;
	path patha, pathb, pathc;
	numeric noption;
	boolean hashole, poption;
	color auxv, vv;
	vv = f-CenterPos;
	patha := rigorouscircle( CenterPos, LenVec, Radius );
	pathb := rigorouscircle( CenterPos+LenVec, LenVec, Radius );
% 	patha := goodcirclepath( CenterPos, LenVec, Radius );
% 	pathb := goodcirclepath( CenterPos+LenVec, LenVec, Radius );
	auxv := ncrossprod( LenVec, ccrossprod( vv, LenVec ) );
	poption := abs( cdotprod( vv, auxv ) ) <= 1.05*Radius;% DANGER!
	if poption:
	  draw patha;
	  draw pathb;
	else:
%	  draw patha withcolor green; show patha;
%	  draw pathb withcolor green; show pathb;
	  hashole := (-1,-1) <> ( patha intersectiontimes pathb );
	  if hashole:
	    pathc := buildcycle( patha, pathb ); % I don't get it!
	    %fill pathc withcolor red;            % see fakehole.mp
	  fi;
	  noption = cdotprod( LenVec, vv );
	  if  noption > (conorm(LenVec)**2):
	    draw pathb;
	    if hashole:
	      draw pathc;
	    fi;
	  elseif noption < 0:
	    draw patha;
	    if hashole:
	      draw pathc;
	    fi;
	  fi;
	fi
      endgroup
    enddef;
      
% It is time for a kind of cube. Don't use SphericalDistortion here.
    
    def kindofcube(expr WithDash, IsVertex, RefP,
	AngA, AngB, AngC, LenA, LenB, LenC ) =
      begingroup
	save star, pos, patw, patb, refv, near, centre, farv;
	save newa, newb, newc, veca, vecb, vecc, auxx, auxy, i;
	color star, pos[], refv, near, newa, newb, newc;
	color veca, vecb, vecc, auxx, auxy, centre, farv;
	path patw, patb;
	numeric i;
	veca = ( cosd(AngA)*cosd(AngB),
	  sind(AngA)*cosd(AngB),
	  sind(AngB) );
	auxx = ( cosd(AngA+90), sind(AngA+90), 0 );
	auxy = ccrossprod( veca, auxx );
	vecb = cosd(AngC)*auxx + sind(AngC)*auxy;
	vecc = cosd(AngC+90)*auxx + sind(AngC+90)*auxy;
	veca := LenA*veca;
	vecb := LenB*vecb;
	vecc := LenC*vecc;
	if IsVertex:
	  star = RefP;
	  centre = RefP + 0.5*( veca + vecb + vecc);
	else:
	  star = RefP - 0.5*( veca + vecb + vecc);
	  centre = RefP;
	fi;
	pos1 = star + veca;
	pos2 = pos1 + vecb;
	pos3 = pos2 + vecc;
	pos4 = pos3 - vecb;
	pos5 = pos4 - veca;
	pos6 = pos5 + vecb;
	pos7 = pos6 - vecc;
	if ShadowOn:
	  patw = rp(cb(star))--rp(cb(pos1))--rp(cb(pos2))
	    --rp(cb(pos3))--rp(cb(pos4))
	    --rp(cb(pos5))--rp(cb(pos6))--rp(cb(pos7))--cycle;
	  patb = makepath makepen patw;
	  fill patb;
	fi;  
	patw := rp(star)--rp(pos1)--rp(pos2)--rp(pos3)--rp(pos4)
	  --rp(pos5)--rp(pos6)--rp(pos7)--cycle;
	patb := makepath makepen patw;  
	unfill patb;
	draw patb;
	i = 0;
	if inplanarvolume( star, star+veca, f ): i := incr( i ); fi;
	if inplanarvolume( star, star+vecb, f ): i := incr( i ); fi;
	if inplanarvolume( star, star+vecc, f ): i := incr( i ); fi;
	if (i=2) and WithDash:
	  message "Unable to dash kindofcube " & cstr( RefP ) & ".";
	elseif i = 3:
	  message "f is inside kindofcube " & cstr( RefP ) & ".";
	else:  
	  refv = f - centre;
	  if cdotprod( refv, veca ) > 0:
	    newa = -veca;
	  else:
	    newa = veca;
	  fi;
	  if cdotprod( refv, vecb ) > 0:
	    newb = -vecb;
	  else:
	    newb = vecb;
	  fi;
	  if cdotprod( refv, vecc ) > 0:
	    newc = -vecc;
	  else:
	    newc = vecc;
	  fi;
	  near = centre - 0.5*( newa + newb + newc );
	  draw rp(near)--rp(near+newa);
	  draw rp(near)--rp(near+newb);
	  draw rp(near)--rp(near+newc);
	  if WithDash:
	    if i=1:
	      message "Unable to dash kindofcube " & cstr( RefP ) & ".";
	    else:
	      farv = centre + 0.5*( newa + newb + newc );
	      draw rp(farv)--rp(farv-newa) dashed evenly;
	      draw rp(farv)--rp(farv-newb) dashed evenly;
	      draw rp(farv)--rp(farv-newc) dashed evenly;
	    fi;
	  fi;
	fi
      endgroup
    enddef;
    
% Maybe you would like to calculate the angular arguments of kindofcube...
    
    def getanglepair( expr InVec ) =
      begingroup
	save alphaone, alphatwo;
	numeric alphaone, alphatwo;
	alphaone = angle( ( X(InVec), Y(InVec) ) );
	alphatwo = angle( ( X(InVec) ++ Y(InVec), Z(InVec) ) );
	( (alphaone,alphatwo) ) 
      endgroup
    enddef;

% It's a bit late now but the stage must be set.

    def setthestage( expr NumberOfSideSquares, SideSize )=
      begingroup
	save i, j, squaresize, squarepath, ca, cb, cc, cd;
	numeric i, j, squaresize;
	path squarepath;
	color ca, cb, cc, cd;
	squaresize = SideSize/(2*NumberOfSideSquares-1);
	for i=-0.5*SideSize step 2*squaresize until 0.5*SideSize:
	  for j=-0.5*SideSize step 2*squaresize until 0.5*SideSize:
	    ca := (i,j,HoriZon);
	    cb := (i,j+squaresize,HoriZon);
	    cc := (i+squaresize,j+squaresize,HoriZon);
	    cd := (i+squaresize,j,HoriZon);
	    squarepath := rp(ca)--rp(cb)--rp(cc)--rp(cd)--cycle;
	    unfill squarepath;
	    draw squarepath;
	  endfor;
	endfor
      endgroup
    enddef;
    
    def setthearena( expr NumberOfDiameterCircles, ArenaDiameter )=
      begingroup
	save i, j, circlesize, polar, currpos, phi, cpath;
	numeric i, j, circlesize, polar, phi;
	color currpos;
	path cpath;
 	circlesize = ArenaDiameter/NumberOfDiameterCircles;
	for i=0.5*ArenaDiameter step -circlesize until 0.4*circlesize:
	  polar := floor(6.28318*i/circlesize);
	  for j=1 upto polar:
	    phi := 360*j/polar;
	    currpos := i*(cosd(phi),sind(phi),0)+(0,0,HoriZon);
	    cpath := rigorouscircle( currpos, blue, 0.3*circlesize);
	    unfill cpath;
	    draw cpath;
	  endfor;
	endfor
      endgroup
    enddef;

% And a transparent dome. The angular momentum vector is supposed 
% to point from the concavity of the dome and into outer space.
% The pen can only be changed with a previous drawoptions().

    def spatialhalfsfear(expr Center, AngulMom, Radius ) =
      begingroup
	save spath, cpath, fpath, rpath, cutp;
	path spath, cpath, fpath, rpath, cutp;
	save ap, bp, cp, dp, cuti, cute, vp;    
	pair ap, bp, cp, dp, cuti, cute, vp;
	save auxcos, actcos, actsin, auxsin;
	numeric auxcos, actcos, actsin, auxsin;
	picture partoffear;
	save A, B;
	color A, B;
	spath = rigorousfearpath( Center, Radius );
	auxcos = getcossine( Center, Radius );
	actcos = cdotprod( N( f - Center ), N( AngulMom ) );
	actsin = sqrt(1-actcos**2);
	auxsin = sqrt(1-auxcos**2);
	if actsin <= auxcos:
	  if actcos >= 0:
	    cpath = goodcirclepath( Center, AngulMom, Radius );
	    draw cpath;
	  else:
	    draw spath;
	  fi;
	else:
	  fpath = spatialhalfcircle( Center, AngulMom, Radius, true );
	  rpath = spatialhalfcircle( Center, AngulMom, Radius, false );
	  cuti = point 0 of rpath;
	  cute = point ( length rpath ) of rpath;
	  ap = 1.1[cuti,cute];
	  bp = 1.1[cute,cuti];
	  partoffear = nullpicture;
	  addto partoffear doublepath spath;
	  A = ncrossprod( f-Center, ncrossprod( f-Center, AngulMom ) );
	  B = Center + 1.1*Radius*( auxcos*N( f-Center ) + auxsin*A );
	  vp = rp(B) - rp(Center);
	  cp = ap + vp;
	  dp = bp + vp;
	  cutp = ap--cp--dp--bp--cycle;
	  clip partoffear to cutp;
	  draw fpath;
	  draw partoffear;
	  if actcos >= 0:
	    draw rpath;
	  fi;
	fi
      endgroup
    enddef;
	      
% Take a donut. 

    def smoothtorus( expr Tcenter, Tmoment, Bray, Sray ) =
      begingroup
	save nearaxe, sideaxe, viewline, circlecenter, circlemoment;
	save ang, ind, i, anglim, angstep, cuspcond, holepic, coofrac;
	save cpath, apath, opath, ipath, wp, ep, refpair, distance, lr;
	color nearaxe, sideaxe, viewline, circlecenter, circlemoment;
	numeric ang, ind, i, anglim, angstep, distance, coofrac, lr;
	path cpath, apath, opath, ipath, wp, ep;
	pair outerp[], innerp[], refpair;
	boolean cuspcond;
	picture holepic;
	save tmoment;
	color tmoment;
	angstep= 4; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DANGER!
	viewline = f-Tcenter;
	if cdotprod( viewline, Tmoment ) < 0:
	  tmoment = -Tmoment;
	else:
	  tmoment = Tmoment;
	fi;
	refpair = unitvector( rp(Tcenter+tmoment)-rp(Tcenter) );
	sideaxe = Bray*ncrossprod( tmoment, viewline );
	nearaxe = Bray*ncrossprod( sideaxe, tmoment );
	coofrac = cdotprod( viewline, N( tmoment ) )/Sray;
	if (coofrac <= 1.04) and (coofrac >= 1.01): %%%%%%%%%%% DANGER!
	  ind = 360/angstep;
	  anglim = 0.5*angstep;
	  for i=1 upto ind:
	    ang := i*angstep-anglim-180.0;
	    circlecenter:= nearaxe*cosd(ang)+sideaxe*sind(ang)+Tcenter;
	    circlemoment:=-nearaxe*sind(ang)+sideaxe*cosd(ang);
	    cpath:=spatialhalfcircle(circlecenter,circlemoment,Sray,true);
	    if i >= 0.5*ind+1:
	      outerp[i]=point 0 of cpath;
	    else:
	      outerp[i]=point (length cpath) of cpath;
	    fi;
	  endfor;
	  opath = for i=1 upto ind: outerp[i].. endfor cycle;
	  unfill opath;
	  draw opath;
	elseif coofrac < 1.01:  
	  distance = conorm( viewline );
	  lr = Bray + Sray*( 1 +-+ coofrac );
	  anglim = angle( ( lr, distance +-+ lr ) );
	  ind = 2*floor(anglim/angstep);
	  angstep := 2*anglim/(ind+1);
	  for i=0 upto 0.5*ind-1:
	    ang := i*angstep-anglim;
	    circlecenter:= nearaxe*cosd(ang)+sideaxe*sind(ang)+Tcenter;
	    circlemoment:=-nearaxe*sind(ang)+sideaxe*cosd(ang);
	    cpath:=spatialhalfcircle(circlecenter,circlemoment,Sray,true);
	    innerp[i]=point 0 of cpath;
	    outerp[i]=point (length cpath) of cpath;
	  endfor;
	  for i=0.5*ind upto ind-2:
	    ang := (i+2)*angstep-anglim;
	    circlecenter:= nearaxe*cosd(ang)+sideaxe*sind(ang)+Tcenter;
	    circlemoment:=-nearaxe*sind(ang)+sideaxe*cosd(ang);
	    cpath:=spatialhalfcircle(circlecenter,circlemoment,Sray,true);
	    outerp[i]=point 0 of cpath;
	    innerp[i]=point (length cpath) of cpath;
	  endfor;
	  if coofrac > 0.94:
	    apath = innerp0
	      for i=1 upto ind-2:
	        ..innerp[i]
	      endfor
	      --cycle;
	  else:
	    apath = innerp0 for i=2 upto ind-2: ..innerp[i] endfor
	    ..outerp[ind-2] for i=ind-3 downto 0: ..outerp[i] endfor
	    ..cycle;
	  fi;
	  unfill apath;
	  draw apath;
	else:
	  ind = 360/angstep;
	  anglim = 0.5*angstep;
	  for i=1 upto ind:
	    ang := i*angstep-anglim-180.0;
	    circlecenter:= nearaxe*cosd(ang)+sideaxe*sind(ang)+Tcenter;
	    circlemoment:=-nearaxe*sind(ang)+sideaxe*cosd(ang);
	    cpath:=spatialhalfcircle(circlecenter,circlemoment,Sray,true);
	    if i >= 0.5*ind+1:
	      outerp[i]=point 0 of cpath;
	      innerp[i]=point (length cpath) of cpath;
	    else:
	      innerp[i]=point 0 of cpath;
	      outerp[i]=point (length cpath) of cpath;
	    fi;
	  endfor;
	  opath = for i=1 upto ind: outerp[i].. endfor cycle;
	  ipath = for i=1 upto ind: innerp[i].. endfor cycle;
	  holepic = currentpicture;
	  clip holepic to ipath;
	  unfill opath;
	  draw holepic;
	  draw opath;
	  draw ipath;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perhaps there is an analytic way of getting the angle of the cusp point?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	  i := ceiling(1+0.5*ind);
	  cuspcond = false;
	  forever:
	    i := incr( i );
	    exitif i > ind-1;
	    cuspcond :=
	      refpair dotprod innerp[i+1] < refpair dotprod innerp[i];
	    exitif cuspcond;
	  endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	  if cuspcond:
	    show "Torus shows cusp points.";
	    ep = outerp[ind-i+1]--innerp[ind-i+1];
	    wp = innerp[i]--outerp[i];
	    unfill buildcycle(reverse opath,ep,ipath,wp);
	    draw opath;
	    draw subpath (i-1,ind-i) of ipath;
	  fi;
	fi;
      endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Non-standard objects:
	    
    def positivecharge( expr InFactPositive, Center, BallRay ) =
      begingroup
	save auxc, axehorf, axeside, viewline, spath, pa, pb, pc, pd;
	color auxc, axehorf, axeside, viewline, pa, pb, pc, pd;
	path spath;
	viewline = f - Center;
	axehorf = N( ( X(viewline), Y(viewline), 0 ) );
	axeside = ccrossprod( axehorf, blue );
	if ShadowOn:
	  fill rigorousfearshadowpath( Center, BallRay );
	fi;
	spath = rigorousfearpath( Center, BallRay );
	unfill spath;
	draw spath;
	auxc = Center + sqrt(3)*axehorf;
	pa = auxc + axeside;
	pb = auxc - axeside;
	angline( pa, pb, Center, BallRay, "", top );
	if InFactPositive:
	  pc = auxc + blue;
	  pd = auxc - blue;
	  angline( pc, pd, Center, BallRay, "", top );
	fi
      endgroup
    enddef;

    def simplecar(expr RefP, AngCol, LenCol, FronWheelCol, RearWheelCol )=
      begingroup
	save veca, vecb, vecc, anga, angb, angc, lena, lenb, lenc;
	save auxn, viewline, auxm, fl, fr, rl, rr, auxx, auxy;
	save fmar, fthi, fray, rmar, rthi, rray, inrefp;;
	color veca, auxx, auxy, vecb, vecc, viewline;
	color fl, fr, rl, rr, inrefp;
	numeric anga, angb, angc, lena, lenb, lenc, auxm, auxn;
	numeric fmar, fthi, fray, rmar, rthi, rray;
	anga = X( AngCol );
	angb = Y( AngCol );
	angc = Z( AngCol );
	lena = X( LenCol );
	lenb = Y( LenCol );
	lenc = Z( LenCol );
	fmar = X( FronWheelCol );
	fthi = Y( FronWheelCol );
	fray = Z( FronWheelCol );
	rmar = X( RearWheelCol );
	rthi = Y( RearWheelCol );
	rray = Z( RearWheelCol );
	veca = ( cosd(anga)*cosd(angb),
	  sind(anga)*cosd(angb),
	  sind(angb) );
	auxx = ( cosd(anga+90), sind(anga+90), 0 );
	auxy = ccrossprod( veca, auxx );
	vecb = cosd(angc)*auxx + sind(angc)*auxy;
	vecc = cosd(angc+90)*auxx + sind(angc+90)*auxy;
	viewline = f - RefP;
	auxm = cdotprod( viewline, veca );
	auxn = cdotprod( viewline, vecb );
	inrefp = RefP - 0.5*lenc*vecc;
	fl = inrefp + (0.5*lena-fmar-fray)*veca + 0.5*lenb*vecb;
	fr = inrefp + (0.5*lena-fmar-fray)*veca - 0.5*lenb*vecb;
	rl = inrefp - (0.5*lena-rmar-rray)*veca + 0.5*lenb*vecb;
	rr = inrefp - (0.5*lena-rmar-rray)*veca - 0.5*lenb*vecb;
	if auxn > 0.5*lenb:
	  if auxm > 0:
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	  else:
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	  fi;
	elseif auxn < -0.5*lenb:
	  if auxm > 0:
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	  else:
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	  fi;
	else:
	  if auxm > 0:
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	  else:
	    rigorousdisc( 0, true, fl, fray, fthi*vecb );
	    rigorousdisc( 0, true, rl, rray, rthi*vecb );
	    rigorousdisc( 0, true, fr, fray, -fthi*vecb );
	    rigorousdisc( 0, true, rr, rray, -rthi*vecb );
	    kindofcube(false,false,RefP,anga,angb,angc,lena,lenb,lenc);
	  fi;
	fi
      endgroup
    enddef;
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Differential Equations:
	    
% Oh! Well... I couldn't do without differential equations.
% The point is that I want to draw vectorial field lines in space.
% Keep it simple: second-order Runge-Kutta method.

    def fieldlinestep( expr Spos, Step )( text VecFunc )=
      begingroup
	save kone, ktwo;
	color kone, ktwo;
	kone = Step*VecFunc( Spos );
	ktwo = Step*VecFunc( Spos+0.5*kone );
	( Spos+ktwo )
      endgroup
    enddef;

    def fieldlinepath( expr Numb, Spos, Step )( text VecFunc )=
      begingroup
	save ind, flpath, prevpos, thispos;
	numeric ind;
	color prevpos, thispos;
	path flpath;
	prevpos = Spos;
	flpath = rp( Spos )
	for ind=1 upto Numb:
	  hide( thispos := fieldlinestep( prevpos, Step, VecFunc ) )
	  ..rp( thispos )
	  hide( prevpos := thispos )
	endfor;
	( flpath )
      endgroup
    enddef;
    
% Another point is that I want to draw trajectories in space.

    def trajectorypath( expr Numb, Spos, Svel, Step )( text VecFunc )=
      begingroup
	save ind, flpath, prevpos, thispos, prevvel, thisvel;
	save rone, rtwo, vone, vtwo;
	numeric ind;
	color prevpos, thispos, prevvel, thisvel;
	color rone, rtwo, vone, vtwo;
	path flpath;
	prevpos = Spos;
	prevvel = Svel;
	flpath = rp( Spos )
	for ind=1 upto Numb:
	  hide(
	    vone := Step*VecFunc( prevpos );
	    rone := Step*prevvel;
	    vtwo := Step*VecFunc( prevpos+0.5*rone );
	    rtwo := Step*( prevvel+0.5*vone );
	    thisvel := prevvel+vtwo;
	    thispos := prevpos+rtwo
	    )
	  ..rp( thispos )
	  hide(
	    prevpos := thispos;
	    prevvel := thisvel
	    )
	endfor;
	( flpath )
      endgroup
    enddef;    

% And now i stop.

    def magnetictrajectorypath( expr Numb, Spos, Svel, Step )
      ( text VecFunc )=
      begingroup
	save ind, flpath, prevpos, thispos, prevvel, thisvel;
	save rone, rtwo, rthr, rfou, vone, vtwo, vthr, vfou;
	numeric ind;
	color prevpos, thispos, prevvel, thisvel;
	color rone, rtwo, rthr, rfou, vone, vtwo, vthr, vfou;
	path flpath;
	prevpos = Spos;
	prevvel = Svel;
	flpath = rp( Spos )
	for ind=1 upto Numb:
	  hide(
	    vone := Step*ccrossprod( VecFunc( prevpos ), prevvel );
	    rone := Step*prevvel;
	    vtwo :=
	      Step*ccrossprod(VecFunc(prevpos+0.5*rone),prevvel+0.5*vone);
	    rtwo := Step*( prevvel+0.5*vone );
	    vthr :=
	      Step*ccrossprod(VecFunc(prevpos+0.5*rtwo),prevvel+0.5*vtwo);
	    rthr := Step*( prevvel+0.5*vtwo );
	    vfou :=
	      Step*ccrossprod( VecFunc( prevpos+rthr ), prevvel+vthr );
	    rfou := Step*( prevvel+vthr );	    
	    thisvel := prevvel+(vtwo+vthr)/3+(vone+vfou)/6;
	    thispos := prevpos+(rtwo+rthr)/3+(rone+rfou)/6
	    )
	  ..rp( thispos )
	  hide(
	    prevpos := thispos;
	    prevvel := thisvel
	    )
	endfor;
	( flpath )
      endgroup
    enddef;    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Part II:
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Advanced 3D-Object Definition Functions %%%%%
% Please check the examples in planpht.mp or the default object below %%%%

    vardef makeline@#( text vertices )= 
      save counter;
      numeric counter;
      counter = 0;
      for ind=vertices:
	counter := incr( counter );
	L@#p[counter] := V[ind];
      endfor;
      npl@# := counter;
      NL := @#
    enddef;

    vardef makeface@#( text vertices )= 
      save counter;
      numeric counter;
      counter = 0;
      for ind=vertices:
	counter := incr( counter );
	F@#p[counter] := V[ind];
      endfor;
      npf@# := counter;
      NF := @#;
      FCD[NF] := false
    enddef;

    vardef getready( expr commstr, refpoi ) =
      Nobjects := incr( Nobjects );
      ostr[Nobjects] := commstr;
      RefDist[Nobjects] := conorm( f - refpoi )
    enddef;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Definition of a 3D-Object 
% define vertices
    V1 := (1,0,0);
    V2 := (0,0,0);
    V3 := (0,1,0);
    V4 := (-0.3,0.2,1);
    V5 := (1,0,1);
    V6 := (0,1,1);
    V7 := (0,0,2);
    V8 := (-0.5,0.6,1.2);
    V9 := (0.6,-0.5,1.2);
    makeline1(8,9);
    makeface1(1,2,7);
    makeface2(2,3,7);
    makeface3(5,4,6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% or the old way below %%%%%%%%%
% define lines
%    NL := 1;     % number of lines
%    npl1 := 2;   % number of vertices of the first line
%    L1p1 := V8;
%    L1p2 := V9;
% define faces
%    NF := 3;     % number of faces
%    npf1 := 3;   % number of vertices of the first face
%    F1p1 := V1;
%    F1p2 := V2;
%    F1p3 := V7;
%    npf2 := 3;   % number of vertices of the second face
%    F2p1 := V2;
%    F2p2 := V3;
%    F2p3 := V7;
%    npf3 := 3;   % number of vertices of the third face
%    F3p1 := V5;
%    F3p2 := V4;
%    F3p3 := V6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% Flip first argument accordingly to the second

    def flipvector(expr A, B) =
        begingroup
            save  nv;
            color nv;
            if cdotprod( A, B) < 0 :
                nv = -A;
            else:
                nv = A;
            fi;
            ( nv )
        endgroup
    enddef;

% Frontside of a face given by three of its vertices

    def facevector(expr A, B, C) =
        begingroup
            save  nv;
            color nv;
            nv = ncrossprod( A-B, B-C );
            ( flipvector( nv, f-B ) )
        endgroup
    enddef;

% Center or inside of a face

    def masscenter(expr Nsides)(suffix Coords) =
        begingroup
            save mc, counter;
            numeric  counter;
            color mc;
            mc = (0,0,0);
            for counter=1 upto Nsides:
                mc := mc + Coords[counter];
            endfor;
            ( mc / Nsides )
        endgroup
    enddef;

% Direction of coverability. The trick is here.
% The condition for visibility is 
% that the angle beetween the vector that goes from the side of a face to
% the mark position and the covervector must be greater than 90 degrees.

    def covervector(expr A, B, MassCenter) =
        begingroup
            save  nv;
            color nv;
            nv = ncrossprod( A-f, B-f );
            ( flipvector( nv, MassCenter-B) )
        endgroup
    enddef;

% O.K., the following macro tests the visibility of a point

    def themarkisinview(expr Mark, OwnFace) =
        begingroup
            save  c, faceVec, centerPoint, coverVec, inview, l, m; 
            color c, faceVec, centerPoint, coverVec;
            boolean inview;
            numeric l, m;
            l = 0;
            forever:          % cycle over faces until the mark is covered
                l := incr(l);
                if l = OwnFace:
                    l := incr(l);
                fi;
                exitif l > NF;
                faceVec := facevector(F[l]p1,F[l]p2,F[l]p3);
                inview := true;
                if cdotprod(Mark-F[l]p1, faceVec) < 0:     
                    centerPoint := masscenter(npf[l], F[l]p);
                    m := 0;
                    forever:              % cycle over segments of a face 
                        m := incr(m);
                        exitif m > npf[l];
                        if m < npf[l]:
                            c := F[l]p[m+1];
                        else:
                            c := F[l]p1;
                        fi;
                        coverVec := covervector(F[l]p[m], c, centerPoint);
                        inview := cdotprod(Mark-c,coverVec) <= 0;
                        exitif inview;
                    endfor;
                fi;
                exitif not inview;
            endfor;
            ( inview )
        endgroup
    enddef;

% Check for possible intersection or crossing.

    def maycrossviewplan(expr Ea, Eb, La, Lb) =
        begingroup
            ( abs( cdotprod( ccrossprod(Ea-f,Eb-f), La-Lb ) ) > 0.001 )
        endgroup
    enddef;

% Calculate the intersection of two sides. This is very nice.

    def crossingpoint(expr Ea, Eb, La, Lb) =
        begingroup
            save  thecrossing, perpend, exten, aux;
            color thecrossing, perpend;
            numeric exten, aux;
            if ( Ea = Lb ) or ( Ea = La ):
                thecrossing = Ea;
            elseif ( Eb = Lb ) or ( Eb = La ):
                thecrossing = Eb;
            else:
                perpend = ccrossprod( Ea-f, Eb-f );
                if conorm( perpend ) = 0:
                    thecrossing = Eb;
                else: 
                    aux = cdotprod( perpend, f );
                    cdotprod( perpend, thecrossing ) = aux;
                    ( La-Lb )*exten = La-thecrossing;
                fi;
            fi; 
            ( thecrossing )
        endgroup
    enddef;

% Calculate the intersection of an edge and a face.

    def crossingpointf(expr Ea, Eb, Fen) =
        begingroup
            save  thecrossing, perpend, exten;
            color thecrossing, perpend;
            numeric exten;
            perpend = ccrossprod( F[Fen]p1-F[Fen]p2, F[Fen]p3-F[Fen]p2 );
            cdotprod(perpend,thecrossing) = cdotprod( perpend, F[Fen]p2 );
            ( Ea-Eb )*exten = Ea-thecrossing; 
            ( thecrossing )
        endgroup
    enddef;

% Check for possible intersection of an edge and a face.

    def maycrossviewplanf(expr Ea, Eb, Fen) =
        begingroup
            save perpend;
            color perpend;
            perpend = ccrossprod( F[Fen]p1-F[Fen]p2, F[Fen]p3-F[Fen]p2 );
            ( abs( cdotprod( perpend, Ea-Eb ) ) > 0.001 )
        endgroup
    enddef;

% The intersection point must be within the extremes of the segment.

    def insidedge(expr Point, Ea, Eb) =
        begingroup
            save fract;
            numeric fract;
            fract := cdotprod( Point-Ea, Point-Eb );
            ( fract < 0 )
        endgroup
    enddef;

% Skip edges that are too far away

    def insideviewsphere(expr Ea, Eb, La, Lb) =
        begingroup
            save furthestofedge, nearestofline, flag, exten;
            color nearestofline, furthestofedge;
            boolean flag;
            numeric exten;
            nearestofline = La+exten*(Lb-La);
            cdotprod( nearestofline-f, Lb-La ) = 0;
            if conorm(Ea-f) < conorm(Eb-f):
                furthestofedge := Eb;
            else:
                furthestofedge := Ea;
            fi;
            if conorm(nearestofline-f) < conorm(furthestofedge-f):
                flag := true;
            else:
                flag := false;
            fi;
            ( flag )
        endgroup
    enddef;

% The intersection point must be within the triangle defined by 
% three points. Really smart.

    def insidethistriangle(expr Point, A, B, C ) =
        begingroup
            save arep, area, areb, aret, flag;
            color arep, area, areb, aret;
            boolean flag;
            aret = ccrossprod( A-C, B-C );
            arep = flipvector( ccrossprod( C-Point, A-Point ), aret );
            area = flipvector( ccrossprod( A-Point, B-Point ), aret );
            areb = flipvector( ccrossprod( B-Point, C-Point ), aret );
            flag = ( conorm( arep + area + areb ) <= 2*conorm( aret ) ); 
            ( flag )
        endgroup
    enddef;

% The intersection point must be within the triangle defined by the
% point of view f and the extremes of some edge. 

    def insideviewtriangle(expr Point, Ea, Eb) =
        insidethistriangle( Point, Ea, Eb, f )
    enddef;

% The intersection point must be within the face

    def insidethisface(expr Point, FaN) =
        begingroup
            save flag, m, central;
            boolean flag;
            numeric m;
            color central;
            m = npf[FaN];
            central = masscenter( m, F[FaN]p );
            flag = insidethistriangle( Point, 
                              central, F[FaN]p[m], F[FaN]p[1] );
            for m=2 upto npf[FaN]:
                exitif flag;
                flag := insidethistriangle( Point, 
                              central, F[FaN]p[m-1], F[FaN]p[m] );
            endfor;
            ( flag )
        endgroup
    enddef;

% Draw the visible parts of a straight line in beetween points A and B
% changing the thickness of the line accordingly to the distance from f

    def coarse_line(expr A, B, Facen, Press, Col) =
        begingroup
            save  k, mark, stepVec; 
            numeric k;
            color mark, stepVec;
            stepVec := resolvec(A,B); 
            k := 0;
            forever:                    % cycle along a whole segment 
                mark := A+(k*stepVec);
                exitif cdotprod(B-mark,stepVec) < 0;
                if themarkisinview(mark,Facen):
                    signalvertex(mark, Press, Col);
                fi;
                k := incr(k);
            endfor
        endgroup
    enddef;

% Get the 2D rigorous projection path of a face.
% Don't use SphericalDistortion here.

    def facepath(expr Facen) =
        begingroup
            save thispath, counter;
            path thispath;
            numeric counter;
            thispath = rp(F[Facen]p[1])--
            for counter=2 upto (npf[Facen]):
                rp(F[Facen]p[counter])--
            endfor
            cycle;
            ( thispath )
        endgroup
    enddef;

    def faceshadowpath(expr Facen) =
        begingroup
            save thispath, counter;
            path thispath;
            numeric counter;
            thispath = rp(cb(F[Facen]p[1]))--
            for counter=2 upto (npf[Facen]):
                rp(cb(F[Facen]p[counter]))--
            endfor
            cycle;
            ( thispath )
        endgroup
    enddef;

% FillDraw a face

    def face_invisible( expr Facen )( text LineAtribs )=
        begingroup
            save ghost;
            path ghost;
            ghost = facepath( Facen );
            unfill ghost;
            draw ghost LineAtribs
        endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Different kinds of renderers:

% Draw only the faces, calculating edge-intersections. 
% Mind-blogging kind of thing.
% Only two constraints: i) faces must be planar and
%                      ii) faces must be convex.
% Pay attention: depends on PrintStep (resolvec).
    
    def sharpraytrace
%%                     ( expr LabelCrossPoints ) 
						  =
       begingroup
          save i, j, k, l, counter, a, b, c, d, currcross; 
          save flag, swapc, swapn, somepoint, frac, exten;
          save trythis, refpath, otherpath, intertimes;
          save counter, infolabel;
          numeric i, j, k, l, counter, swapn;
          color a, b, c, d, currcross, swapc;
          boolean flag, trythis;
          path refpath, otherpath;
          pair intertimes;
          string infolabel;
          color crosspoin[];
          numeric sortangle[];
          for i=1 upto NF:                   % scan all faces
             for j=1 upto npf[i]:            % scan all edges
                a := F[i]p[j];
                if j <> npf[i]:
                   b := F[i]p[j+1];
                else:
                   b := F[i]p1;
                fi;
                crosspoin[1] := a;
                counter := 2;
                refpath := rp(a)--rp(b); % The limits a and b of one
		                         % side of one face 
                for k=1 upto NF:
                   otherpath := facepath(k);
                   intertimes := refpath intersectiontimes otherpath;
                   trythis := xpart intertimes <> 0;
                   if trythis and (xpart intertimes <> 1) and (k <> i):
                      for l=1 upto npf[k]:    
                         c := F[k]p[l];
                         if l < npf[k]:
                            d := F[k]p[l+1];
                         else:
                            d := F[k]p1;
                         fi; 
                         if insideviewsphere( a, b, c, d ):
                           if maycrossviewplan( a, b, c, d ):
                             currcross := crossingpoint( a, b, c, d );
                             if insideviewtriangle( currcross, a, b ):
                               if insidedge( currcross, c, d ):
                                 swapc := ccrossprod( a-b, f-currcross);
                                 swapc := ccrossprod(swapc,f-currcross);
                                 color somepo;
                                 numeric fract;
                                 (b-a)*fract = somepo-a;
                                 cdotprod(swapc,somepo)=cdotprod(swapc,f);
                                 if (fract>0) and (fract<1):
                                   crosspoin[counter] := somepo;
                                   counter := incr(counter);
                                 fi;
                               fi;
                             fi;
                           fi;
                         fi;
                      endfor;
                      if maycrossviewplanf( a, b, k ):
                         currcross := crossingpointf( a, b, k );
                         if insidethisface( currcross, k ):
                            if insidedge( currcross, a, b ):
                               crosspoin[counter] := currcross;
                               counter := incr(counter);
                            fi;
                         fi;
                      fi;
                   fi;
                endfor;
                crosspoin[counter] := b;
                sortangle[1] := 0;
                for k=2 upto counter:
                   sortangle[k] := conorm(crosspoin[k]-a);
                endfor;
                forever:
                   flag := true;
                   for k=2 upto counter:
                      if sortangle[k] < sortangle[k-1]:
                         swapn := sortangle[k-1];
                         sortangle[k-1] := sortangle[k];
                         sortangle[k] := swapn;
                         swapc := crosspoin[k-1];
                         crosspoin[k-1] := crosspoin[k];
                         crosspoin[k] := swapc;
                         flag := false;
                      fi;
                   endfor;
                   exitif flag;
                endfor;
                for k=2 upto counter:
                   swapc := resolvec(crosspoin[k-1],crosspoin[k]);
                   flag := themarkisinview( crosspoin[k-1]+swapc, i );
                   if flag and themarkisinview( crosspoin[k]-swapc, i ):
                      draw rp(crosspoin[k-1])--rp(crosspoin[k]);
                   fi;
                endfor;
%                if LabelCrossPoints:
%                  for k=1 upto counter:
%                    infolabel:=decimal(i)&","&decimal(j)&","&decimal(k); 
%                    infolabel := "0";
%                    dotlabelrand(infolabel,rp(crosspoin[k]));
%                  endfor;
%                fi;
             endfor;
          endfor
       endgroup
    enddef;

% Draw three-dimensional lines checking visibility. 

    def lineraytrace(expr Press, Col) =
        begingroup
            save  i, j, a, b; 
            numeric i, j;
            color a, b;
            for i=1 upto NL:                    % scan all lines
                for j=1 upto npl[i]-1:
                    a := L[i]p[j];
                    b := L[i]p[j+1]; 
                    coarse_line( a, b, 0, Press, Col);
                endfor;    
            endfor
        endgroup
    enddef;

% Draw only the faces, rigorously projecting the edges. 

    def faceraytrace(expr Press, Col)=
        begingroup
            save  i, j, a, b; 
            numeric i, j;
            color a, b;
            for i=1 upto NF:                    % scan all faces
                for j=1 upto npf[i]:
                    a := F[i]p[j];
                    if j <> npf[i]:
                        b := F[i]p[j+1];
                    else:
                        b := F[i]p1;
                    fi; 
                    coarse_line( a, b, i, Press, Col);
                endfor;    
            endfor
        endgroup
    enddef;

% Fast test for your three-dimensional object

    def draw_all_test( expr AlsoDrawLines )=
      begingroup
	save  i, j, a, b; 
	numeric i, j;
	color a, b;
	if ShadowOn:
	  for i=1 upto NF:                    
	    fill faceshadowpath( i );
	  endfor;
	  if AlsoDrawLines:
	    for i=1 upto NL:                    % scan all lines
	      for j=1 upto npl[i]-1:
		a := L[i]p[j];
		b := L[i]p[j+1]; 
		drawsegment( cb(a), cb(b) );
	      endfor;    
	    endfor;
	  fi;
	fi;
	for i=1 upto NF:                    % scan all faces
	  for j=1 upto npf[i]:
	    a := F[i]p[j];
	    if j <> npf[i]:
	      b := F[i]p[j+1];
	    else:
	      b := F[i]p1;
	    fi; 
	    drawsegment( a, b );
	  endfor;    
	endfor;
	if AlsoDrawLines:
	  for i=1 upto NL:                    % scan all lines
	    for j=1 upto npl[i]-1:
	      a := L[i]p[j];
	      b := L[i]p[j+1]; 
	      drawsegment( a, b );
	    endfor;    
	  endfor;
	fi
      endgroup
    enddef;

% Don't use SphericalDistortion here.

    def fill_faces( text LineAtribs )=
        begingroup
            save  i; 
            numeric i;
	    if ShadowOn:
	      for i=1 upto NF:                    
                fill faceshadowpath( i );
	      endfor;
	    fi;
            for i=1 upto NF:                    
                face_invisible( i, LineAtribs );
            endfor
        endgroup
    enddef;

    def doitnow =
      begingroup
	save i, j, farone;
	numeric i, j, farone[];
	for i=1 upto Nobjects:
	  farone[i] := i;
	endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shell's Method of sorting %%%%%%%%
	save inc, v, vv;
	numeric inc, v, vv;
	inc = 1;
	forever:
	  inc := 3*inc+1;
	  exitif inc > Nobjects;
	endfor;
	forever:
	  inc := round(inc/3);
	  for i=inc+1 upto Nobjects:
	    v := RefDist[i];
	    vv:= farone[i];
	    j := i;
	    forever:
	      exitunless RefDist[j-inc] > v;
	      RefDist[j] := RefDist[j-inc];
	      farone[j] := farone[j-inc];
	      j := j-inc;
	      exitif j <= inc;
	    endfor;
	    RefDist[j] := v;
	    farone[j] := vv;
	  endfor;
	  exitunless inc > 1;
	endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for i=Nobjects downto 1:
	  j := farone[i];
	  scantokens ostr[j];
	endfor
      endgroup
    enddef;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Nematic Liquid Crystal wise:

    def generatedirline(expr Lin, Phi, Theta, Long, Currpos ) =
        begingroup
            save longvec;
            color longvec;
            npl[Lin] := 2;
            longvec := Long*( cosd(Phi)*cosd(Theta),
                              sind(Phi)*cosd(Theta),
                              sind(Theta) );
            L[Lin]p1 := Currpos-0.5*longvec;
            L[Lin]p2 := Currpos+0.5*longvec
        endgroup
    enddef;

    def generatedirface(expr Fen, Phi, Theta, Long, Base, Currpos ) =
        begingroup
            save basevec, longvec;
            color basevec, longvec;
            npf[Fen] := 3;
            longvec := Long*( cosd(Phi)*cosd(Theta),
                              sind(Phi)*cosd(Theta),
                              sind(Theta) );
            basevec := Base*ncrossprod( Currpos-f, longvec );
            F[Fen]p1 := Currpos-0.5*(longvec+basevec);
            F[Fen]p2 := Currpos+0.5*longvec;
            F[Fen]p3 := Currpos-0.5*(longvec-basevec)
        endgroup
    enddef;

    def generateonebiax(expr Lin, Phi, Theta, Long, 
                                  SndDirAngl, Base, Currpos ) =
        begingroup
            save basevec, longvec, u, v;
            color basevec, longvec, u, v;
            npl[Lin] := 4;
            longvec := Long*( cosd(Phi)*cosd(Theta),
                              sind(Phi)*cosd(Theta),
                              sind(Theta) );
            v = (-sind(Phi), cosd(Phi), 0);
            u = ( cosd(Phi)*cosd(Theta+90),
                  sind(Phi)*cosd(Theta+90),
                  sind(Theta+90) );
            basevec := Base*( v*cosd(SndDirAngl)+u*sind(SndDirAngl) );
            L[Lin]p1 := Currpos-0.5*longvec;
            L[Lin]p2 := Currpos+0.5*basevec;
            L[Lin]p3 := Currpos+0.5*longvec;
            L[Lin]p4 := Currpos-0.5*basevec
        endgroup
    enddef;

    def director_invisible( expr SortEmAll, ThickenFactor, CyclicLines )=
      begingroup
	save i, j, k, farone, thisfar;
	save outerr, innerr, direc, ounum; 
	numeric i, j, k, farone[], dist[], thisfar, ounum;
	pen actualpen, outerr, innerr;
	path direc;
	actualpen = currentpen;
	if SortEmAll:
	  for i=1 upto NL:                    % scan all lines
	    dist[i] := conorm( masscenter( npl[i], L[i]p ) - f );
	    farone[i] := i;
	  endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shell's Method of sorting %%%%%%%%
	  save inc, v, vv;
	  numeric inc, v, vv;
	  inc = 1;
	  forever:
	    inc := 3*inc+1;
	    exitif inc > NL;
	  endfor;
	  forever:
	    inc := round(inc/3);
	    for i=inc+1 upto NL:
	      v := dist[i];
	      vv:= farone[i];
	      j := i;
	      forever:
		exitunless dist[j-inc] > v;
		dist[j] := dist[j-inc];
		farone[j] := farone[j-inc];
		j := j-inc;
		exitif j <= inc;
	      endfor;
	      dist[j] := v;
	      farone[j] := vv;
	    endfor;
	    exitunless inc > 1;
	  endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	else:
	  for i=1 upto NL:
	    farone[i] := i;
	  endfor;
	fi;
	for i=NL downto 1:                    % draw all pathes
	  j := farone[i];
	  direc := rp( L[j]p1 )
	  for k=2 upto npl[j]:
	    --rp( L[j]p[k] )
	  endfor;
	  if CyclicLines:
	    direc := direc--cycle;
	  fi;
	  ounum := Spread*ps( masscenter(npl[j],L[j]p), ThickenFactor );
	  outerr := pencircle scaled ounum;
	  innerr := pencircle scaled (0.8*ounum); %% DANGER %%
	  pickup outerr;
	  draw direc withcolor black;
	  pickup innerr;
	  draw direc withcolor background;
	endfor;
	pickup actualpen
      endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Plotting:

% Define and draw surfaces with a triangular mesh.
% On a hexagonal or triangular area. Without sorting (no need).
    
    def hexagonaltrimesh( expr BeHexa,theN,SideSize )( text SurFunc ) = 
        begingroup
	    save i, j, posx, posy, posz, higx, higy,
	    counter, stepx, stepy, poi, lowx, lowy,
	    newn, bola, bolb, bolc;
	    numeric i, j, posx, posy, posz, higx, higy,
                    counter, stepx, stepy, lowx, lowy, newn;
	    color poi[][];
	    boolean bola, bolb, bolc;
	    npf0 := 3;
	    FCD0 := true; % this is used in the calls to fillfacewithlight
	    ActuC := incr( ActuC );
	    if ActuC > TableColors:
	      ActuC := 1;
	    fi;
	    FC0  := ActuC;    %%
	    counter = 0;
            stepy = SideSize/theN;
            stepx = 0.5*stepy*sqrt(3);
	    lowy = -0.5*SideSize;
	    lowx = -sqrt(3)*SideSize/6;
	    higy = -lowy;
	    higx = sqrt(3)*SideSize/3;
	    for i=0 upto theN:
	        for j=0 upto theN-i:
                    posx := lowx + i*stepx;
                    posy := lowy + i*stepx/sqrt(3) + j*stepy;
	    	    posz := SurFunc( posx, posy );
	    	    poi[i][j] := ( posx, posy, posz );
	        endfor;
	    endfor;
	    if BeHexa:
	        newn = round((theN+1)/3)+1;
	    else:
	        newn = 1;
	    fi;
	    for j=newn upto theN-newn+1:
	        F0p1 := poi[0][j-1];
	        F0p2 := poi[0][j];
	        F0p3 := poi[1][j-1];
	        fillfacewithlight( 0 );   % see below
	    endfor;
	    for i=1 upto theN-1:
	        for j=1 upto theN-i:
		    bola := ( i < newn ) and ( j < newn-i );
		    bolb := ( i < newn ) and ( j > theN-newn+1 );
		    bolc := ( i > theN-newn );
		    if not ( bola or bolb or bolc ):
	                F0p1 := poi[i-1][j];
			F0p2 := poi[i][j-1];
			F0p3 := poi[i][j];
			fillfacewithlight( 0 );
			F0p1 := poi[i+1][j-1];
			fillfacewithlight( 0 );
		    fi;
	        endfor;
	    endfor;
	    i := theN-newn+1;
	    for j=1 upto newn-1:
	        F0p1 := poi[i-1][j];
		F0p2 := poi[i][j-1];
		F0p3 := poi[i][j];
		fillfacewithlight( 0 );
	    endfor;
        endgroup 
    enddef;
    
    def fillfacewithlight( expr FaceN ) =
      begingroup
	save perpvec, reflectio, viewvec, inciden, refpos, projincid;
	save shiftv, fcol, lcol, theangle, ghost, pa, pb, pc, j, lowcolor;
	color perpvec, reflectio, viewvec, inciden, refpos, projincid;
	color shiftv, fcol, lcol, pa, pb, pc, lowcolor;
	numeric theangle, j;
	path ghost;
	ghost := rp( F[FaceN]p1 )
	  for j=2 upto npf[FaceN]:
	    --rp( F[FaceN]p[j] )
	  endfor
	  --cycle;
	if OverRidePolyhedricColor:
	  unfill ghost;
	else:
	  refpos = masscenter( npf[FaceN], F[FaceN]p );
	  pa = F[FaceN]p1;
	  pb = F[FaceN]p2;
	  pc = F[FaceN]p3;
	  inciden = LightSource - refpos;
	  viewvec = f - refpos;
	  perpvec = ncrossprod( pa-pb, pb-pc );
	  if cdotprod( perpvec, blue ) < 0:
	    perpvec := -perpvec;
	  fi;
	  projincid = perpvec*cdotprod( perpvec, inciden );
	  shiftv = inciden - projincid;
	  reflectio = projincid - shiftv;
	  theangle = getangle( reflectio, viewvec );
	  if FCD[FaceN]:
	    lowcolor = TableC[FC[FaceN]];
	  else:
	    lowcolor = TableC0;
	  fi;
	  lcol = (cosd( theangle ))[lowcolor,HigColor];
	  if cdotprod( viewvec, perpvec ) < 0:
	    fcol = lcol - SubColor;
	  else:
	    fcol = lcol;
	  fi;
	  fill ghost withcolor fcol;
	fi;
	draw ghost;
      endgroup
    enddef;
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Part III (parametric plots and another renderer):
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                         %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%   Kindly contributed by Jens Schwaiger  %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                         %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% dmin_ is the minimal distance of all faces to f;
% dmax_ is the maximal distance of all faces to f;
% (both values are determined in "draw_invisible")
% Facen is the number of the face to be filled;
% ColAtrib is the color used for filling;
% ColAtribone the color used for drawing;
% Colordensity depends on distance of the face from f

    def face_drawfill( expr Facen, dmin_, dmax_ ,ColAtrib, ColAtribone )=
      begingroup
	save j, ptmp, colfac_, coltmp_;
	path ghost;
	numeric j, colfac_;
	color ptmp, coltmp_;
	ghost := rp( F[Facen]p1 );
	for j=2 upto npf[Facen]:
	  ghost := ghost--rp( F[Facen]p[j] );
	endfor;
	ghost := ghost--cycle;
	ptmp:= masscenter( npf[Facen], F[Facen]p ) - f;
        % 0<=colfac_<=1
	colfac_ := ( conorm(ptmp)-dmin_ )/( dmax_ - dmin_ );
        % color should be brighter, if distance to f is smaller
	colfac_ := 1 - colfac_;
        % color should be not to dark, i.e., >=0.1 (and <=1)
	colfac_ := 0.9colfac_ + 0.1; 
        % now filling and drawing with appropriate color;
	fill ghost withcolor colfac_*ColAtrib;
	draw ghost withcolor colfac_*ColAtribone;
      endgroup
    enddef;

% Now a much faster faces-only-ray-tracer based upon the unfill
% command and the constraint of non-intersecting faces of similar
% sizes. Faces are sorted by distance from nearest vertex or
% masscenter to the point of view. This routine may be used to 
% draw graphs of 3D surfaces (use masscenters in this case).
%    
% Option=true: test all vertices
% Option=false: test masscenters of faces
% DoJS=true: use face_drawfill by J. Schwaiger
% DoJS=false: use fillfacewithlight by L. Nobre G.
% ColAtrib=color for filling faces
% ColAtribone=color for drawing edges

    def draw_invisible( expr Option, DoJS, ColAtrib, ColAtribone )=
      begingroup
	save  i, j, a, b, thisfar, ptmp, farone;
	numeric i, j, farone[], dist[], thisfar, distmin_, distmax_;
	color a, b, ptmp;
	for i=1 upto NF:                         % scan all faces
	  if Option:                             % for distances of
	    dist[i] = conorm( F[i]p1 - f );      % nearest vertices
	    if i=1: 
	      distmin_ := dist1;                 % initialisation of
	      distmax_ := dist1;                 % dmin_ and dmax_
	    fi;
	    distmin_ := min( distmin_, dist[i] );
	    distmax_ := max( distmax_, dist[i] );
	    for j=2 upto npf[i]:
	      thisfar := conorm( F[i]p[j] - f );
	      distmin_ := min( distmin_, thisfar );
	      distmax_ := max( distmax_, thisfar );
	      if thisfar < dist[i]:
		dist[i] := thisfar;
	      fi;
	    endfor;
	  else:                        % for distances of centers of mass
	    dist[i] := conorm( masscenter( npf[i], F[i]p ) - f );
	    if i=1:
	      distmin_ := dist1;       % initialisation of
	      distmax_ := dist1;       % dmin_ and dmax_ in this case 
	    fi;
	    distmin_ := min( distmin_, dist[i] );
	    distmax_ := max( distmax_, dist[i] );
	  fi;
	  farone[i] = i;
	endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shell's Method of sorting %%%%%%%%
	save inc, v, vv;
	numeric inc, v, vv;
	inc = 1;
	forever:
	  inc := 3*inc+1;
	  exitif inc > NF;
	endfor;
	forever:
	  inc := round(inc/3);
	  for i=inc+1 upto NF:
	    v := dist[i];
	    vv:= farone[i];
	    j := i;
	    forever:
	      exitunless dist[j-inc] > v;
	      dist[j] := dist[j-inc];
	      farone[j] := farone[j-inc];
	      j := j-inc;
	      exitif j <= inc;
	    endfor;
	    dist[j] := v;
	    farone[j] := vv;
	  endfor;
	  exitunless inc > 1;
	endfor;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for i=NF downto 1:                     % draw and fill all pathes
	  j := farone[i];
	  if DoJS:
	    face_drawfill( j, distmin_, distmax_, ColAtrib, ColAtribone );
	  else:
	    fillfacewithlight( j );
	  fi;
	endfor;
      endgroup
    enddef;

% Move to the good range (-1,1).

    def bracket( expr low, poi, hig ) = 
        begingroup
            save zout;
            numeric zout;
            zout = (2*poi-hig-low)/(hig-low);
            if zout > 1:
                zout := 1;
            fi;
            if zout < -1:
                zout := -1;
            fi;
            ( zout )
        endgroup 
    enddef;

% Define parametric surfaces with a triangular mesh... unless a
% quadrangular mesh can do a fine, rigorous job just as well.

    def partrimesh( expr nt,ns,
	lowt,higt,lows,higs,
	lowx,higx,lowy,higy,
	lowz,higz,
	facz)( text parSurFunc ) =
      begingroup
	save i, j, k, posx, posy, posz;
	save counter, stept, steps, poss, post, tmpaux;
	save veca, vecb, vecc, vecd;
	numeric i, j, k, posx, posy, posz, counter, stept, steps;
	color poi[][], tmpaux, veca, vecb, vecc, vecd;
	counter := NF;                     % <-- NF must be initialized!
	ActuC := incr( ActuC );
	if ActuC > TableColors:
	  ActuC := 1;
	fi;
	steps = ( higs - lows )/ns;
	stept = ( higt - lowt )/nt;
	for i=0 upto ns: 
	  for j=0 upto nt:
	    poss := lows + i*steps;
	    post := lowt + j*stept;
	    tmpaux := parSurFunc( poss, post );
	    posz := Z(tmpaux); 
	    posx := X(tmpaux);
	    posy := Y(tmpaux);
	    posx := bracket(lowx,posx,higx);      
	    posy := bracket(lowy,posy,higy);      
	    posz := bracket(lowz,posz,higz)/facz; 
	    poi[i][j] := ( posx, posy, posz );
	  endfor;
	endfor;
	for i=1 upto ns:
	  for j=1 step 1 until nt:
	    veca := poi[i][j]-poi[i-1][j];
	    vecb := poi[i][j]-poi[i-1][j-1];
	    vecc := poi[i][j]-poi[i][j-1];
	    if abs(cdotprod(ccrossprod(veca,vecb),vecc))<0.00005: %DANGER!
	      counter := incr(counter);
	      npf[counter] := 4;
	      F[counter]p1 := poi[i-1][j-1];
	      F[counter]p2 := poi[i-1][j];
	      F[counter]p3 := poi[i][j];
	      F[counter]p4 := poi[i][j-1];
	      FC[counter] := ActuC;
	      FCD[counter] := true;
	    else:
	      tmpaux:=
	        0.25*(poi[i-1][j-1]+poi[i-1][j]+poi[i][j]+poi[i][j-1]);
	      veca := poi[i-1][j-1]-tmpaux;
	      vecb := poi[i-1][j]-tmpaux;
	      vecc := poi[i][j]-tmpaux;
	      vecd := poi[i][j-1]-tmpaux;
	      if getangle(vecb,vecd)>getangle(veca,vecc):
		for k=-1 upto 0:
		  counter := incr(counter);
		  npf[counter] := 3;
		  F[counter]p1 := poi[i-1][j-1];
		  F[counter]p2 := poi[i+k][j-1-k];
		  F[counter]p3 := poi[i][j];
		  FC[counter] := ActuC;
		  FCD[counter] := true;
		endfor;
	      else:
		for k=-1 upto 0:
		  counter := incr(counter);
		  npf[counter] := 3;
		  F[counter]p1 := poi[i+k][j+k];
		  F[counter]p2 := poi[i][j-1];
		  F[counter]p3 := poi[i-1][j];
		  FC[counter] := ActuC;
		  FCD[counter] := true;
		endfor;
	      fi;
	    fi;
	  endfor;
	endfor;
	NF := counter;
      endgroup
    enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part IV (automatic perspective tuning, polyhedric vertex approximation):
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    def randomfear =
      begingroup
	save a, b, c, i, h;
	numeric a, b, c, i, h;
	i = uniformdeviate( 360 );
	h = uniformdeviate( 180 );
	a = cosd( h )*cosd( i );
	b = sind( h )*cosd( i );
	c = sind( i );
	( (a,b,c) )
      endgroup
    enddef;

    def renormalizevc( expr inF, inVC ) =
      begingroup
	save a;
	color a;
	cdotprod( inF, a ) = 0;
	inF - a = whatever*( inF - inVC );
	( a )
      endgroup
    enddef;

    def calculatecost( expr TryF, TryVc, TrySp, TrySh ) =
      begingroup
	save sumsquares, i, difpair, xx, yy;
	numeric sumsquares, i, xx, yy;
	pair difpair;
	sumsquares = 0;
	f := TryF;
	viewcentr := TryVc;
	Spread := TrySp;
	ShiftV := TrySh;
	for i=1 upto PhotoMarks:
	  difpair := 0.05*(rp(PhotoPoint[i]) - PhotoPair[i]); % DANGER
	  xx := ((xpart difpair)**2)/PhotoMarks;
	  yy := ((ypart difpair)**2)/PhotoMarks;
	  sumsquares := sumsquares + xx + yy;
	endfor;
	( sumsquares )
      endgroup
    enddef;
	
    def forcepointinsidefear( text A ) =
      begingroup
	if abs( X(A) ) > 0.5*MaxFearLimit :
	  A := 0.5*A*MaxFearLimit/abs( X(A) );
	fi;
	if abs( Y(A) ) > 0.5*MaxFearLimit :
	  A := 0.5*A*MaxFearLimit/abs( Y(A) );
	fi;
	if abs( Z(A) ) > 0.5*MaxFearLimit :
	  A := 0.5*A*MaxFearLimit/abs( Z(A) );
	fi;
	( A )
      endgroup
    enddef;

    def forcepairinsidepage( text A ) =
      begingroup
	if xpart A > 2*(xpart OriginProjPagePos):
	  A := ( 2*(xpart OriginProjPagePos), ypart A );
	fi;
	if ypart A > 2*(ypart OriginProjPagePos):
	  A := ( xpart A, 2*(ypart OriginProjPagePos) );
	fi;
	if xpart A < 0:
	  A := ( 0, ypart A );
	fi;
	if ypart A < 0:
	  A := ( xpart A, 0 );
	fi;
	( A )
      endgroup
    enddef;

    def calculatejump( expr AverCost, PrevCost, RandCost, JumpLimit ) =
      begingroup
	save funfact, numer, denom;
	numeric funfact, numer, denom;
	if RandCost+PrevCost > 2*AverCost:
	  numer := 3*PrevCost - 4*AverCost + RandCost;
	  denom := 4*( RandCost + PrevCost - 2*AverCost );
	  if abs( denom )*JumpLimit < abs( numer ):
	    funfact := 0;
	  else:
	    funfact := numer/denom;
	  fi;
	else:
	  funfact := 0;
	fi;
	( funfact )
      endgroup
    enddef;
    	
    def photoreverse( expr IterNum, ExpTao, JumpFact ) =
      begingroup
	save j, auxvc, actfact, auxfac;
	save prevf, randf, averf, prevvc, randvc, avervc;
	save prevsp, randsp, aversp, prevsh, randsh, aversh;
	save prevcost, randcost, avercost, spreadlimit, expfact;
	numeric j, prevsp, randsp, aversp, actfact;
	numeric prevcost, randcost, avercost;
	numeric spreadlimit, expfact;
	color prevf, randf, averf, prevvc, randvc, avervc, auxvc;
	pair prevsh, randsh, aversh;
	spreadlimit = 20;                                         % DANGER
	prevf = f;
	prevvc= viewcentr;
	prevsp= Spread;
	prevsh= ShiftV;
	prevcost = calculatecost( prevf, prevvc, prevsp, prevsh );
	show prevcost;
	auxfac = -1280.0/ExpTao/IterNum;
	for j=0 upto IterNum:
	  expfact := mexp(auxfac*j);
	  randf := prevf + expfact*randomfear;
	  randcost := calculatecost( randf, prevvc, prevsp, prevsh );
	  averf := 0.5[prevf,randf];
	  avercost := calculatecost( averf, prevvc, prevsp, prevsh );
	  actfact := calculatejump(avercost,prevcost,randcost,JumpFact);
	  prevf := actfact[prevf,randf];	  
	  auxvc := prevvc + expfact*randomfear;
	  randvc:= renormalizevc( randf, auxvc );
	  randcost := calculatecost( prevf, randvc, prevsp, prevsh );
	  auxvc := 0.5[prevvc,randvc];
	  avervc:= renormalizevc( averf, auxvc );
	  avercost := calculatecost( prevf, avervc, prevsp, prevsh );
	  actfact := calculatejump(avercost,prevcost,randcost,JumpFact);
	  auxvc := actfact[prevvc,randvc];
	  prevvc:= renormalizevc( prevf, auxvc );
	  randsp:= prevsp+expfact*spreadlimit*(uniformdeviate( 1 ) - 0.5);
	  randcost := calculatecost( prevf, prevvc, randsp, prevsh );
	  aversp:= 0.5[prevsp,randsp];
	  avercost := calculatecost( prevf, prevvc, aversp, prevsh );
	  actfact := calculatejump(avercost,prevcost,randcost,JumpFact);
	  prevsp:= actfact[prevsp,randsp];
	  randsh:= prevsh + expfact*dir( uniformdeviate( 360 ) ); % DANGER
	  randcost := calculatecost( prevf, prevvc, prevsp, randsh );
	  aversh:= 0.5[prevsh,randsh];
	  avercost := calculatecost( prevf, prevvc, prevsp, aversh );
	  actfact := calculatejump(avercost,prevcost,randcost,JumpFact);
	  prevsh:= actfact[prevsh,randsh];
	  prevcost := calculatecost( prevf, prevvc, prevsp, prevsh );
	  %show (prevcost,expfact);
	endfor;
	show prevcost;
      endgroup
    enddef;

    def calculatecostver(expr VerA,DisA,VerB,DisB,VerC,DisC,TryV) =
      begingroup
	save a, b, c;
	numeric a, b, c;
	a = conorm( TryV - VerA ) - DisA;
	b = conorm( TryV - VerB ) - DisB;
	c = conorm( TryV - VerC ) - DisC;
	( ( a ++ b ++ c )**2 )
      endgroup
    enddef;
    
% Be aware of the next three danger parameters.
    
    def improvertex( expr VerA, DisA, VerB, DisB, VerC, DisC, IniV ) =
      begingroup
	save j, iternum, prevcost, factry, actpoi, actfact;
	save jumplim, trypoi, halfpo, expfact, randcost, avercost;
	numeric j, iternum, prevcost, factry, randcost, avercost, actfact;
	numeric jumplim, expfact;
	color actpoi, trypoi, halfpo;
	iternum = 100;                                       % DANGER!
	factry = 0.25;                                       % DANGER!
	jumplim = 2.5;                                       % DANGER!
	prevcost = calculatecostver(VerA,DisA,VerB,DisB,VerC,DisC,IniV);
	trypoi = IniV;
	show prevcost;
	for j=0 upto iternum:
	  expfact := mexp(-j*200/iternum);                    % DANGER!
	  actpoi := trypoi+factry*expfact*randomfear;
	  randcost :=
	    calculatecostver(VerA,DisA,VerB,DisB,VerC,DisC,actpoi);
	  halfpo := 0.5[trypoi,actpoi];
	  avercost :=
	    calculatecostver(VerA,DisA,VerB,DisB,VerC,DisC,halfpo);
	  actfact := calculatejump(avercost,prevcost,randcost,jumplim);
	  trypoi := actfact[trypoi,actpoi];
	  prevcost :=
	    calculatecostver(VerA,DisA,VerB,DisB,VerC,DisC,trypoi);
%	  show prevcost;
	endfor;
	show prevcost;
	( trypoi )
      endgroup;
    enddef;
	  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Part V (strictly two-dimensional):
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Produce the schematics of a spring.

    def springpath( expr begp, endp, piturnum, piturnproj, spgfrac )=  
	begingroup
	    boolean leftside;
	    numeric counter, springwidth;
	    pair stepdir, leftdir, rightdir, auxil, lastp, endvec;
	    path thespring;
	    leftside = true;
	    stepdir = spgfrac*(endp-begp)/piturnum;
	    endvec = (1-spgfrac)*(endp-begp)/2;
	    springwidth = piturnproj +-+ abs( stepdir );
	    auxil = ( -ypart stepdir, xpart stepdir );
	    leftdir = springwidth*unitvector( auxil );
	    auxil := ( ypart stepdir, -xpart stepdir );
	    rightdir = springwidth*unitvector( auxil );
	    leftdir := (stepdir + leftdir)/2;
	    rightdir := (stepdir + rightdir)/2;
	    lastp = begp+endvec;
	    thespring := begp--lastp;
	    for counter=1 upto piturnum:
		if leftside:
		    auxil := lastp + leftdir;
		else:
		    auxil := lastp + rightdir;
		fi;
		lastp := lastp + stepdir;
		thespring := thespring--auxil--lastp;
		leftside := not leftside;
	    endfor;
	    thespring := thespring--endp;
	    ( thespring )
	endgroup
    enddef;

% Summarize a great length in a zig-zag frontier line

    def zigzagfrontier( expr begp, endp, nzigs, 
			dev, zthick, tthick, fthick, excol, incol )=  
	begingroup
	    interim linecap := squared;
	    interim linejoin := mitered;
	    boolean leftside;
	    numeric counter, tmpval;
	    pair stepdir, leftdir, rightdir, auxil, lastp;
	    path thefrontier;
	    leftside = true;
	    stepdir = (endp-begp)/nzigs;
	    leftdir = unitvector( ( -ypart stepdir, xpart stepdir ) );
	    rightdir = unitvector( ( ypart stepdir, -xpart stepdir ) );
	    thefrontier = begp;
	    lastp = begp;
	    for counter=1 upto nzigs-1:
		lastp := lastp + stepdir;
		tmpval := zthick+normaldeviate*dev;
		if leftside:
		    auxil := lastp + leftdir*tmpval;
		else:
		    auxil := lastp + rightdir*tmpval;
		fi;
		thefrontier := thefrontier--auxil;
		leftside := not leftside;
	    endfor;
	    thefrontier := thefrontier--endp;
	    draw
	      thefrontier withcolor excol withpen pencircle scaled tthick;
	    draw
	      thefrontier withcolor incol withpen pencircle scaled fthick;
	    ( thefrontier )
	endgroup
    enddef;

% The name says it all.

    def randomcirc( expr radi, stddev, numpois )=  
	begingroup
	    numeric i, astep;
	    path ranc;
	    astep = 360/numpois;
	    ranc = (radi+stddev*normaldeviate)*dir(-180);
	    for i= -180+astep step astep until 180:
		ranc := ranc--((radi+stddev*normaldeviate)*dir(i));
	    endfor;
	    ranc := ranc--cycle;
	    ( ranc )
	endgroup
    enddef;

% Just label some 2D-place in a way similar to anglinen.

    def labeln(expr S, Pos, RelPos) =
        begingroup
            if RelPos = 0:
                label.rt( S, Pos );
            elseif RelPos =1:
                label.urt( S, Pos );
            elseif RelPos =2:
                label.top( S, Pos );
            elseif RelPos =3:
                label.ulft( S, Pos );
            elseif RelPos =4:
                label.lft( S, Pos );
            elseif RelPos =5:
                label.llft( S, Pos );
            elseif RelPos =6:
                label.bot( S, Pos );
            elseif RelPos =7:
                label.lrt( S, Pos );
            else:
                label( S, Pos );
            fi
        endgroup
    enddef;

% There must be a sort of planar cross-product. The z coordinate. 

    def paircrossprod(expr A, B) = 
        ( (xpart A)*(ypart B) - (xpart B)*(ypart A) )
    enddef;

% Just dot-label some 2D-place in a random way.

    def dotlabelrand(expr S, Pos ) =
        begingroup
            save RelPos;
            numeric RelPos;
            RelPos = floor( uniformdeviate(9) );
            if RelPos = 0:
                dotlabel.rt( S, Pos );
            elseif RelPos =1:
                dotlabel.urt( S, Pos );
            elseif RelPos =2:
                dotlabel.top( S, Pos );
            elseif RelPos =3:
                dotlabel.ulft( S, Pos );
            elseif RelPos =4:
                dotlabel.lft( S, Pos );
            elseif RelPos =5:
                dotlabel.llft( S, Pos );
            elseif RelPos =6:
                dotlabel.bot( S, Pos );
            elseif RelPos =7:
                dotlabel.lrt( S, Pos );
            else:
                dotlabel( S, Pos );
            fi
        endgroup
    enddef;

        def radialcross( expr A, la, B, lb, GoUp) =
                begingroup
                        numeric x, y, xa, xb, ya, yb, YM, YA, La, Lb;
                        numeric AA, BB, CC, auxil, na, nb, norm; 
                        pair As, Bs, selectedpoint;
                        na = abs(A);
                        nb = abs(B);
                        norm := 0;
                        for t = na, nb, la, lb:
                                if norm < t:
                                        norm := t;
                                fi;
                        endfor;
                        xa = xpart A/norm;
                        xb = xpart B/norm;
                        ya = ypart A/norm;
                        yb = ypart B/norm;
                        La = la/norm;
                        Lb = lb/norm;
                        if abs( ya - yb ) < 0.005 :
                                x := La**2 - Lb**2 + xb**2 - xa**2;
                                x := 0.5*x/( xb - xa );
                                auxil := sqrt( La**2 - (xa-x)**2 );
                                As  = ( x, ya + auxil );
                                Bs = ( x, ya - auxil );
                        else:
                                YM := (xb-xa)/(ya-yb);
                                YA := Lb**2 - La**2 + xa**2 - xb**2;
                                YA := 0.5*( YA - (ya-yb)**2 )/(ya-yb);
                                AA := 1 + YM**2;
                                BB := 2*( YM*YA - xa );
                                CC := xa**2 - La**2 + YA**2;
                                CC := sqrt( BB**2 - 4*AA*CC );
                                x  := -0.5*( BB + CC )/AA;
                                y  := YA + ya + YM*x;
                                Bs = ( x, y );
                                x  := -0.5*( BB - CC )/AA;
                                y  := YA + ya + YM*x;
                                As = ( x, y );
                        fi;
                        if ypart As > ypart Bs:
                                if GoUp:
                                        selectedpoint = As;
                                else:
                                        selectedpoint = Bs;
                                fi;
                        elseif ypart As = ypart Bs:
                                if xpart As > xpart Bs:
                                        if GoUp:
                                                selectedpoint = As;
                                        else:
                                                selectedpoint = Bs;
                                        fi;
                                else:
                                        if GoUp:
                                                selectedpoint = Bs;
                                        else:
                                                selectedpoint = As;
                                        fi;
                                fi;
                        else:
                                if GoUp:
                                        selectedpoint = Bs;
                                else:
                                        selectedpoint = As;
                                fi;
                        fi;                        
                        ( norm*selectedpoint )
                endgroup
        enddef;                        

	def ropethread( expr Index ) =
	  begingroup
	    save aux;
	    numeric aux;
	    if Index > RopeColors:
	      aux = 0;
	    else:
	      aux = Index;
	    fi;
	    ( aux )
	  endgroup
	enddef;
	  
	def ropepattern( expr BasePath, RopeWidth, Nturns ) =
	  begingroup
	    save indturns, nmoves, indthread, movelen, turnlen, totlen;
	    numeric indturns, nmoves, indthread, movelen, turnlen, totlen;
	    save lenpos, timar, steplen, indstep, startdownc, startupcol;
	    numeric lenpos, timar, steplen, startdownc, indstep;
	    save actuc, actdc, stepwidth;
	    numeric actuc, actdc, stepwidth, startupcol;
	    save p;
	    pair p[];
	    save actcolor;
	    color actcolor;
	    nmoves = 2*(RopeColors+1);
	    totlen = arclength BasePath;
	    turnlen = totlen/Nturns;
	    movelen = turnlen/nmoves;
	    steplen = movelen/2;
	    startdownc = 0;
	    startupcol = RopeColors;
	    stepwidth = RopeWidth/RopeColors;
	    for indturns=0 upto Nturns-1:
	      for indmove=0 upto nmoves-1:
		for indstep=0 upto 3:
		  lenpos :=
		    indturns*turnlen+indmove*movelen+indstep*steplen;
		  timar := arctime lenpos of BasePath;
		  p[indstep] := direction timar of BasePath rotated 90;
		  p[indstep] := unitvector( p[indstep] );
		  p[indstep+4] := point timar of BasePath; 
		endfor;
		actdc := startdownc;
		for indthread=0 upto RopeColors:
		  p8 := p5-p1*(0.5*RopeWidth-(indthread-0.5)*stepwidth);
		  p9 := p4-p0*(0.5*RopeWidth-indthread*stepwidth);
		  p10:= p5-p1*(0.5*RopeWidth-(indthread+0.5)*stepwidth);
		  p11:= p6-p2*(0.5*RopeWidth-indthread*stepwidth);
	          actcolor := TableC[RopeColorSeq[actdc]];
		  fill p8--p9--p10--p11--cycle withcolor actcolor;
		  actdc := ropethread( incr( actdc ) );
		endfor;
		startdownc := ropethread( incr( startdownc ) );
		actuc := startupcol;
		p9 := p5+p1*0.5*(RopeWidth+stepwidth);
		p10:= p6+p2*0.5*RopeWidth;
		p11:= p7+p3*0.5*(RopeWidth+stepwidth);
		actcolor := TableC[RopeColorSeq[actuc]];
		fill p9--p10--p11--cycle withcolor actcolor;
		actuc := ropethread( incr( actuc ) );
		for indthread=0 upto RopeColors-1:
		  p8 := p6+p2*(0.5*RopeWidth-indthread*stepwidth);
		  p9 := p5+p1*(0.5*RopeWidth-(indthread+0.5)*stepwidth);
		  p10:= p6+p2*(0.5*RopeWidth-(indthread+1)*stepwidth);
		  p11:= p7+p3*(0.5*RopeWidth-(indthread+0.5)*stepwidth);
	          actcolor := TableC[RopeColorSeq[actuc]];
		  fill p8--p9--p10--p11--cycle withcolor actcolor;
		  actuc := ropethread( incr( actuc ) );
		endfor;
		p8 := p6-p2*0.5*RopeWidth;
		p9 := p5-0.5*p1*(RopeWidth+stepwidth);
		p11:= p7-0.5*p3*(RopeWidth+stepwidth);
		actcolor := TableC[RopeColorSeq[actuc]];
		fill p8--p9--p11--cycle withcolor actcolor;
		startupcol := ropethread( incr( startupcol ) );
	      endfor;
	    endfor
	  endgroup
	enddef;
	
  def firsttangencypoint( expr Path, Point, ResolvN ) =
    begingroup
      save auxp, i, cutp, va, vb;
      path auxp;
      numeric i;
      pair cutp, va, vb;
      auxp =
        hide( va := unitvector( point 0 of Path - Point );
	      vb := unitvector( direction 0 of Path ); )
	( paircrossprod( va, vb ), 0 )
	for i=1/ResolvN step 1/ResolvN until length Path:
	  hide( va := unitvector( point i of Path - Point );
	        vb := unitvector( direction i of Path ); )
	  ...( paircrossprod( va, vb ), i )
	endfor;
      cutp = auxp intersectionpoint ( origin--( 0, length Path ) );
      ( point ( ypart cutp ) of Path )
    endgroup
  enddef;

% Calculate path areas (contributed by Boguslaw Jackowski
% to the metapost mailing list)

  vardef segmentarea( expr Ps ) = 
    save xa, xb, xc, xd, ya, yb, yc, yd;
    ( xa, 20ya ) = point 0 of Ps;
    ( xb, 20yb ) = postcontrol 0 of Ps;
    ( xc, 20yc ) = precontrol 1 of Ps;
    ( xd, 20yd ) = point 1 of Ps;
    ( xb - xa )*( 10ya + 6yb + 3yc +   yd )
      + ( xc - xb )*( 4ya + 6yb + 6yc +  4yd )
      + ( xd - xc )*( ya + 3yb + 6yc + 10yd )
    enddef;

    vardef cyclicpatharea( expr P ) = % result = area of the interior
      segmentarea(subpath (0,1) of P)
      for t=1 upto length(P)-1: + segmentarea(subpath (t,t+1) of P) endfor
    enddef;
      
% EOF
