%%
%% This is file `expressg.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% expressg.dtx  (with options: `up')
%% 
%%   Author: Peter Wilson (CUA) now at peter.r.wilson@boeing.com until June 2004
%%                              (or pandgwilson@earthlink.net)
%%   Copyright 1996, 2003 Peter R. Wilson
%% 
%%  v1.0 1996/05/09 (first release)
%%  v1.2 1999/11/15
%%  v1.3 2000/05/22
%%  v1.4 2000/07/10
%%  v1.5 2003/07/31
%%  v1.6 2004/02/29
%%  v1.61 2004/03/17
%% 
%%   This work may be distributed and/or modified under the
%%   conditions of the LaTeX Project Public License, either
%%   version 1.3 of this license or (at your option) any
%%   later version.
%%   The latest version of the license is in
%%      http://www.latex-project.org/lppl.txt
%%   and version 1.3 or later is part of all distributions of
%%   LaTeX version 2003/06/01 or later.
%% 
%%   This work has the LPPL maintenance status "author-maintained".
%% 
%%   This work consists of the files listed in the README file.
%%  This program is provided under the terms of the
%%  LaTeX Project Public License distributed from CTAN
%%  archives in directory macros/latex/base/lppl.txt.
%% 
%%% EXPRESSG.MP  MetaPost macros for EXPRESS-G and other BLA diagrams
%%% version 1.5, 31 July 2003
%%% version 1.6, 29 February 2004
%%% version 1.61, 17 March 2004

show "expressg.mp version 1.61, 2004/03/17";

newinternal u; numeric u;
u := 1mm;

newinternal maxx, maxy;
numeric maxx, maxy;
maxx := 159.5u;        % smidgeon under 160mm for ISO
maxy := 210u;          % 210mm for ISO

newinternal defaultdotdiam, dotdiam;
numeric defaultdotdiam, dotdiam;
defaultdotdiam := 2u;
dotdiam := defaultdotdiam;

newinternal normalpensize, thickpensize, thinpensize;
numeric normalpensize, thickpensize, thinpensize;
normalpensize := 0.5bp;
thickpensize  := 1.5bp;
thinpensize   := 0.25bp;
newinternal dotsscale; numeric dotsscale;
dotsscale := 2;

newinternal normalpen, thickpen, thinpen, dotspen, dotpen;
pen normalpen, thickpen, thinpen, dotspen, dotpen;
normalpen := pencircle scaled normalpensize; % i.e. defaultpen;
thickpen  := pencircle scaled thickpensize;
thinpen   := pencircle scaled thinpensize;
dotspen   := pencircle scaled (dotsscale*normalpensize);
dotpen    := pencircle scaled dotdiam;

newinternal defaultsmoothrad;
numeric smoothrad, defaultsmoothrad;
smoothrad := defaultsmoothrad := 2u;

newinternal defaultdrumlid;
numeric drumlid, defaultdrumlid;
drumlid := defaultdrumlid := 0.2;

%%% default length and base width for arrowheads and fanin
newinternal defaultgal, defaultgab, defaultgfl, defaultgfb;
numeric defaultgal, defaultgab, defaultgfl, defaultgfb;
defaultgal := defaultgfl := defaultdotdiam;
defaultgab := defaultgfb := defaultgal;

%%% length and base width of arrowheads and fanins
newinternal gal, gab, gfl, gfb;
numeric gal, gab, gfl, gfb;
gal := defaultgal;
gab := defaultgab;
gfl := defaultgfl;
gfb := defaultgfb;

newinternal onelineh;
numeric onelineh;
onelineh := 5u;

%%% length, height & inset for simple data type boxes
newinternal sdtbl, sdtbh, sdtbs;
numeric sdtbl, sdtbh, sdtbs;
sdtbl := 22u;
sdtbh := onelineh;
sdtbs := 2u;

%%% length, height & inset for EXPRESSION data type boxes
newinternal sdtbel, sdtbeh, sdtbes;
numeric sdtbel, sdtbeh, sdtbes;
sdtbel := 28u;
sdtbeh := sdtbh; sdtbes := sdtbs;

%%% length, height & inset for GENERICENT data type boxes
newinternal sdtbgel, sdtbgeh, sdtbges;
numeric sdtbgel, sdtbgeh, sdtbges;
sdtbgel := 38u;
sdtbgeh := sdtbh; sdtbges := sdtbs;

%%% average length of numeric page connector
newinternal pconl;
numeric pconl; % length of page connector (for e.g., 9,9 (9,9) )
pconl:=15u;
%%% height of page connectors (one line)
newinternal pconh;
numeric pconh;
pconh := onelineh;

%%% heights of entity, enum, select, type boxes (One text line)
newinternal enth, typeh;
numeric enth, typeh;
enth := onelineh;
typeh := onelineh;

%%% height of interschema boxes (one text line, no rename), and (name + rename)
newinternal ish, isrh;
numeric ish, isrh;
ish  := 2onelineh;
isrh := 3onelineh;

%%% height of schema boxes (one text line)
newinternal schemah;
numeric schemah;
schemah := 2onelineh;

%%% height and slope of event boxes
newinternal eventh, eventslope;
numeric eventh, eventslope;
eventh := onelineh;
eventslope := 0.25;

%%% extra namespaces for boxed names
newinternal nextra, niextra;
numeric nextra, niextra;
nextra := 2u;
niextra := nextra+sdtbs;

%%% extra namespace for attribute names
newinternal ndextra;
numeric ndextra;
ndextra := nextra+dotdiam;

%%% calculates mid-point on a path like |_ (vertical, horizontal)
%%% final points are: z$, z$vh, z$$, where z$vh=(x$,y$$)
def VH(suffix $, $$) =
  z$vh=(x$,y$$);
enddef;

%%% Calculates mid-points on a path like |_
%%%                                        |  (vertical, horizontal, vertical)
%%% final points are: z$, z$vhv, z$$vhv, z$$
def VhV(suffix $, $$) =
  y$$vhv=1/2[y$,y$$]; x$$vhv=x$$;
  z$vhv=(x$,y$$vhv);
enddef;

%%% Calculates mid-points on a path like -|_ (horizontal, vertical, horizontal)
%%% final points are: z$, z$hvh, z$$hvh, z$$
def HvH(suffix $, $$) =
  x$hvh=1/2[x$,x$$]; y$hvh=y$;
  z$$hvh=(x$hvh,y$$);
enddef;

%%% Calculates turning points on a U shaped path (vertical, horizontal, vertical)
%%% final points are: z$, z$vyv, z$$vyv, z$$
def VyV(suffix $, @, $$) =
  z$$vyv=(x$$,y@);
  z$vyv =(x$, y@);
enddef;

%%% Calculates corner points rotated U shaped path (horizontal, vertical, horizontal)
%%% final points are: z$, z$hxh, z$$hxh, z$$
def HxH(suffix $, @, $$) =
  z$$hxh=(x@,y$$);
  z$hxh =(x@,y$);
enddef;

%%% calculates length taken up by typesetting str, plus margin
def namespace(text str)(expr margin) =
  (xpart lrcorner(str) - xpart llcorner(str) + margin)
enddef;

def dashes =
  dashed evenly
enddef;

def dots =
  dashed withdots
enddef;

def dashedgrid(expr nx, ny, dist) =
  save zg_, zg__, oldpen;
  pair zg_[], zg__[];
  pen oldpen; oldpen = currentpen;
  pickup thinpen;
  for i = 0 upto nx:
    zg_[i] = (i*dist, 0); zg_[i+1000] = (i*dist, ny*dist);
    draw zg_[i]--zg_[i+1000] dashes;
    label.bot(decimal(i), zg_[i]);
  endfor
  for i = 0 upto ny:
    zg__[i] = (0, i*dist); zg__[i+1000] = (nx*dist, i*dist);
    draw zg__[i]--zg__[i+1000] dashes;
    label.lft(decimal(i), zg__[i]);
  endfor
  pickup oldpen;
enddef;

%%% draw a 1cm spaced grid of 16(x) by 21(y) cms. (units are mm)
def drawgrid =
  dashedgrid(16, 21, 10mm);
enddef;

%%% calculates corner and midpoints of a rectangle,
%%% bottom left at $, length l, height h
def rectpoints(suffix $)(expr l, h) =
  z$bl = z$;
  z$tr = (x$+l, y$+h);
  z$br = (x$tr, y$bl);
  z$tl = (x$bl, y$tr);
  z$ml = 1/2[z$bl, z$tl];
  z$mr = 1/2[z$br, z$tr];
  z$bm = 1/2[z$bl, z$br];
  z$tm = 1/2[z$tl, z$tr];
enddef;

%%% calculate corner, midpoints and center point of a rhomboid.
def rhompoints(suffix $)(expr l, h, s) =
  save eshift;
  numeric eshift; eshift = s*h;
  z$bl = z$;
  z$tr = (x$+l+eshift, y$+h);
  z$br = (x$bl+l, y$bl);
  z$tl = (x$bl+eshift, y$tr);
  z$ml = 1/2[z$bl, z$tl];
  z$mr = 1/2[z$br, z$tr];
  z$bm = (1/2[x$ml,x$mr], y$bl);
  z$tm = (x$bm, y$tr);
enddef;

%%% calculate circumferential points on a circle
def circpoints(suffix $)(expr diam) =
  save rad, sinrad, cosrad;
  numeric rad, sinrad, cosrad;
  rad = diam/2;
  sinrad = rad*(sind 45);
  cosrad = rad*(cosd 45);
  z$c=z$;
  z$ml=(x$c-rad, y$c);
  z$mr=(x$c+rad, y$c);
  z$bm=(x$c, y$c-rad);
  z$tm=(x$c, y$c+rad);
  z$tr=(x$c+cosrad, y$c+sinrad);
  z$bl=(x$c-cosrad, y$c-sinrad);
  z$br=(x$tr, y$bl);
  z$tl=(x$bl, y$tr);
enddef;

%%% circular arc join between two paths
tertiarydef p ~ q =
  begingroup
  c_ := fullcircle scaled 2smoothrad shifted point 0 of q;
  a_ := ypart(c_ intersectiontimes p);
  b_ := ypart(c_ intersectiontimes q);
  if a_ < 0: point 0 of p{direction 0 of p} else: subpath(0,a_) of p fi
    ... if b_ < 0: {direction infinity of q}point infinity of q
        else: subpath(b_,infinity) of q fi
  endgroup
enddef;

%%% piecewise linear path between the given points
def sharply(text t) =     % t is a list of pairs
  hide(n_:=0; for z=t: z_[incr n_]:=z; endfor)
  z_1 for k=2 upto n_: --z_[k] endfor
enddef;

%%% piecewise linear path between the given points with smooth corners
def smoothly(text t) =     % t is a list of pairs
  hide(n_:=0; for z=t: z_[incr n_]:=z; endfor)
  (z_1 for k=2 upto n_-1: --z_[k]) ~ (z_[k] endfor --z_[n_])
enddef;

%%% Draw an open circle at end of vector from $ to $$
def drawO(suffix $, $$) =
  begingroup
  save v_, c_, l, p;
  pair v_, c_;
  numeric l;
  path p;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (dotdiam/(2l))[z$$,z$];
  p := fullcircle scaled dotdiam shifted c_;
  unfill p;
  draw p; draw p;
  endgroup
enddef;

%%% Draw a closed circle at end of vector from $ to $$
def drawD(suffix $, $$) =
  begingroup
  save v_, c_, l, p;
  pair v_, c_;
  numeric l;
  path p;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (dotdiam/(2l))[z$$,z$];
  p := fullcircle scaled dotdiam shifted c_;
  fill p;
  endgroup
enddef;

%%% draw an open arrowhead at end of vector from $ to $$
def drawOA(suffix $, $$) =
  begingroup
  save v_, c_, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gab/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gal/(l))[z$$,z$];      % base of arrowhead
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p = c_b--z$$--c_t--cycle;
  unfill p;
  draw p; draw p;
  endgroup
enddef;

%%% draw a closed arrowhead at end of vector from $ to $$
def drawCA(suffix $, $$) =
  begingroup
  save v_, c_, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gab/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gal/(l))[z$$,z$];      % base of arrowhead
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p = c_b--z$$--c_t--cycle;
  filldraw p;
  endgroup
enddef;

%%% draw a simple arrowhead at end of vector from $ to $$
def drawA(suffix $, $$) =
  begingroup
  save v_, c_, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gab/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gal/(l))[z$$,z$];      % base of arrowhead
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p = c_b--z$$--c_t;
  draw p;
  endgroup
enddef;

%%% draws a fanin at the end of the vector from $ to $$
def drawF(suffix $, $$) =
  begingroup
  save v_, c_, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gfb/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gfl/(l))[z$$,z$];      % apex of fan
  v_u := unitvector v_;
  c_t := z$$ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - z$$ = z$$ - c_t;
  p = c_b--c_--c_t;
  draw p;
  endgroup
enddef;

%%% Draw a dotted line from $ to $$
def drawdots(suffix $, $$) =
  pickup dotspen;
  draw z$--z$$ dots;
  pickup normalpen;
enddef;

%%% Draws the dotted line $--@--$$
def drawdotsthree(suffix $, @, $$) =
  pickup dotspen;
  draw z$--z@--z$$ dots;
  pickup normalpen;
enddef;

%%% Draw the dotted line $--@--@@--$$
def drawdotsfour(suffix $, @, @@, $$) =
  pickup dotspen;
  draw z$--z@--z@@--z$$ dots;
  pickup normalpen;
enddef;

%%% Draw a dotted line from $ to $$ with open circle at $$
def drawdotsO(suffix $, $$) =
  pickup dotspen;
  draw z$--z$$ dots;
  pickup normalpen;
  drawO($, $$);
enddef;

%%% Draws the dotted line $--@--$$
def drawdotsthreeO(suffix $, @, $$) =
  pickup dotspen;
  draw z$--z@--z$$ dots;
  pickup normalpen;
  drawO(@, $$);
enddef;

%%% Draw the dotted line $--@--@@--$$
def drawdotsfourO(suffix $, @, @@, $$) =
  pickup dotspen;
  draw z$--z@--z@@--z$$ dots;
  pickup normalpen;
  drawO(@@, $$);
enddef;

%%% Draw the dotted line from $ to $$, ending in circles diameter dotdiam at $ and $$
def drawdotsOO(suffix $, $$) =
  pickup dotspen;
  draw z$--z$$ dots;
  pickup normalpen;
  drawO($, $$); drawO($$, $);
enddef;

%%% draws a dashed line from $ to $$
def drawdash(suffix $, $$) =
  draw z$--z$$ dashes;
enddef;

%%% draws the dashed line $--@--$$
def drawdashthree(suffix $, @, $$) =
  draw z$--z@--z$$ dashes;
enddef;

%%% draws the dashed line $--@--@@--$$
def drawdashfour(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$ dashes;
enddef;

%%% draws a dashed line from $ to $$, ending in a circle diameter dotdiam at $$
def drawdashO(suffix $, $$) =
  draw z$--z$$ dashes;
  drawO($, $$);
enddef;

%%% draws the dashed line $--@--$$ with circle at $$
def drawdashthreeO(suffix $, @, $$) =
  draw z$--z@--z$$ dashes;
  drawO(@, $$);
enddef;

%%% draws the dashed line $--@--@@--$$ with circle at $$
def drawdashfourO(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$ dashes;
  drawO(@@, $$);
enddef;

%%% draws a dashed line from $ to $$, ending in circles diameter dotdiam at $ and $$
def drawdashOO(suffix $, $$) =
  draw z$--z$$ dashes;
  drawO($, $$); drawO($$, $);
enddef;

%%% draws a normal line from $ to $$.
def drawnormal(suffix $, $$) =
  draw z$--z$$;
enddef;

%%% draws the normal line $--@--$$
def drawnormalthree(suffix $, @, $$) =
  draw z$--z@--z$$;
enddef;

%%% draws the normal line $--@--@@--$$
def drawnormalfour(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$;
enddef;

%%% draws a normal line from $ to $$, ending in a circle diameter dotdiam at $$
def drawnormalO(suffix $, $$) =
  draw z$--z$$;
  drawO($, $$);
enddef;

%%% draws the normal line $--@--$$, ending in a circle at $$
def drawnormalthreeO(suffix $, @, $$) =
  draw z$--z@--z$$;
  drawO(@, $$);
enddef;

%%% draws the line $--@--@@--$$, ending in a circle at $$
def drawnormalfourO(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$;
  drawO(@@, $$);
enddef;

%%% draws a normal line from $ to $$, ending in circles diameter dotdiam at $ and $$
def drawnormalOO(suffix $, $$) =
  draw z$--z$$;
  drawO($, $$); drawO($$, $);
enddef;

%%% draws a normal line from $ to $$, ending in a dot diameter dotdiam at $$
def drawnormalD(suffix $, $$) =
  draw z$--z$$;
  drawD($, $$);
enddef;

%%% draws the normal line $--@--$$, ending in a dot at $$
def drawnormalthreeD(suffix $, @, $$) =
  draw z$--z@--z$$;
  drawD(@, $$);
enddef;

%%% draws the normal line $--@--@@--$$, ending in a dot at $$
def drawnormalfourD(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$;
  drawD(@@, $$);
enddef;

%%% draws a normal line from $ to $$, ending in dots diameter dotdiam at $ and $$
def drawnormalDD(suffix $, $$) =
  draw z$--z$$;
  drawD($, $$); drawD($$, $);
enddef;

%%% draws a normal line from $ to $$, ending with an open arrowhead at $$
def drawnormalOA(suffix $, $$) =
  draw z$--z$$;
  drawOA($, $$);
enddef;

%%% draws a normal line from $ to $$, ending with a closed arrowhead at $$
def drawnormalCA(suffix $, $$) =
  draw z$--z$$;
  drawCA($, $$);
enddef;

%%% draws the normal line $--@--$$, ending in a black arrowhead at $$
def drawnormalthreeCA(suffix $, @, $$) =
  draw z$--z@--z$$;
  drawCA(@, $$);
enddef;

%%% draws the normal line $--@--@@--$$, ending in a black arrowhead at $$
def drawnormalfourCA(suffix $, @, @@, $$) =
  draw z$--z@--z@@--z$$;
  drawCA(@@, $$);
enddef;

%%% draws a normal line from $ to $$, ending with a fanin at $$
def drawnormalF(suffix $, $$) =
  draw z$--z$$;
  drawF($, $$);
enddef;

%%% draws a normal line from $ to $$, with a fanin at $ and an open circle at $$
def drawnormalFO(suffix $, $$) =
  draw z$--z$$;
  drawO($, $$); drawF($$, $);
enddef;

%%% draws a thick line from $ to $$.
def drawthick(suffix $, $$) =
  pickup thickpen;
  draw z$--z$$;
  pickup normalpen;
enddef;

%%% draws a thick line from $ to $$, ending in a circle diameter dotdiam at $$
def drawthickO(suffix $, $$) =
  pickup thickpen;
  draw z$--z$$;
  drawO($, $$);
  pickup normalpen;
enddef;

%%% draws a thick line from $ to $$, ending in circles diameter dotdiam at $ and $$
def drawthickOO(suffix $, $$) =
  pickup thickpen;
  draw z$--z$$;
  drawO($, $$); drawO($$, $);
  pickup normalpen;
enddef;

%%% replaces the sharp corner on $--@--$$ with a circular arc radius smoothrad
def smooth(suffix $, @, $$) =
  begingroup
  save v_, c_, l, p;
  pair v_, v_', c_, c_';
  path p;
  v_ := z@-z$;
  l := (xpart v_)++(ypart v_);     % length of $--@
  c_ := (smoothrad/l)[z@,z$];      % start of arc on $--@
  v_' := z$$-z@;
  l := (xpart v_')++(ypart v_');   % length of @--$$
  c_' := (smoothrad/l)[z@,z$$];    % end of arc on @--$$
  undraw c_--z@--c_';              % blank original join
  draw c_{v_}..{v_'}c_';           % draw the arc
  endgroup
enddef;

%%% replaces the sharp corners on $--@--@@--$$ with a circular arc radius smoothrad
def smoothtwo(suffix $, @, @@, $$) =
  smooth($, @, @@); smooth(@, @@, $$);
enddef;

%%% replaces the sharp corner on the dashed lines $--@--$$
%%% with a circular arc radius smoothrad
def smoothdash(suffix $, @, $$) =
  begingroup
  save v_, c_, l, p;
  pair v_, v_', c_, c_';
  path p;
  v_ := z@-z$;
  l := (xpart v_)++(ypart v_);     % length of $--@
  c_ := (smoothrad/l)[z@,z$];      % start of arc on $--@
  v_' := z$$-z@;
  l := (xpart v_')++(ypart v_');   % length of @--$$
  c_' := (smoothrad/l)[z@,z$$];    % end of arc on @--$$
  undraw c_--z@--c_';              % blank original join
  draw c_{v_}..{v_'}c_' dashes;    % draw the dashed arc
  endgroup
enddef;

%%% replaces the sharp corner on the dotted line $--@--$$
%%% with a circular arc radius smoothrad
def smoothdots(suffix $, @, $$) =
  begingroup
  save oldpen;
  pen oldpen; oldpen := currentpen;
  save v_, c_, l, p;
  pair v_, v_', c_, c_';
  path p;
  v_ := z@-z$;
  l := (xpart v_)++(ypart v_);     % length of $--@
  c_ := (smoothrad/l)[z@,z$];      % start of arc on $--@
  v_' := z$$-z@;
  l := (xpart v_')++(ypart v_');   % length of @--$$
  c_' := (smoothrad/l)[z@,z$$];    % end of arc on @--$$
  undraw c_--z@--c_';              % blank original join
  pickup dotspen;
  draw c_{v_}..{v_'}c_' dots;      % draw the dotted arc
  pickup oldpen;
  endgroup
enddef;

%%% draws a schema box, bottom left at $, length l, height h
def drawSCHEMA(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  x$c = 1/2[x$ml, x$mr];
  y$c = 1/2[y$ml, y$tl];
  draw z$bl--z$br--z$tr--z$tl--cycle;  % outer box
  draw z$ml--z$mr;                     % dividing line
  label(str, z$c);
enddef;

def drawSDT(suffix $)(text str) =
  rectpoints($, sdtbl, sdtbh);
  z$ti = (x$tr-sdtbs, y$tr);
  z$bi = (x$ti, y$br);
  z$c = 1/2[z$bl,z$ti];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  draw z$bi--z$ti;
  label(str, z$c);
enddef;

def drawASDT(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  z$ti = (x$tr-sdtbs, y$tr);
  z$bi = (x$ti, y$br);
  z$c = 1/2[z$bl,z$ti];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  draw z$bi--z$ti;
  label(str, z$c);
enddef;

def drawBINARY(suffix $) =  drawASDT($)(sdtbl, sdtbh)("BINARY");
  enddef;
def drawBOOLEAN(suffix $) = drawASDT($)(sdtbl, sdtbh)("BOOLEAN");
  enddef;
def drawCOMPLEX(suffix $) = drawASDT($)(sdtbl, sdtbh)("COMPLEX");
  enddef;
def drawEXPRESSION(suffix $) = drawASDT($)(sdtbel, sdtbeh)("EXPRESSION");
  enddef;
def drawGENERIC(suffix $) = drawASDT($)(sdtbl, sdtbh)("GENERIC");
  enddef;
def drawINTEGER(suffix $) = drawASDT($)(sdtbl, sdtbh)("INTEGER");
  enddef;
def drawLOGICAL(suffix $) = drawASDT($)(sdtbl, sdtbh)("LOGICAL");
  enddef;
def drawNUMBER(suffix $) =  drawASDT($)(sdtbl, sdtbh)("NUMBER");
  enddef;
def drawREAL(suffix $) =    drawASDT($)(sdtbl, sdtbh)("REAL");
  enddef;
def drawSTRING(suffix $) =  drawASDT($)(sdtbl, sdtbh)("STRING");
  enddef;

%%% draw an enumeration type box, bottom left at $, length l, height h
def drawENUM(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  z$ti = (x$tr-sdtbs, y$tr);
  z$bi = (x$ti, y$br);
  z$c = 1/2[z$bl,z$ti];
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
  draw z$bi--z$ti dashes;
  label(str, z$c);
enddef;

%%% draw a select type box, bottom left at $, length l, height h
def drawSELECT(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  z$ti = (x$tl+sdtbs, y$tl);
  z$bi = (x$ti, y$bl);
  z$c = 1/2[z$br,z$ti];
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
  draw z$bi--z$ti dashes;
  label(str, z$c);
enddef;

%%% draw a simple user defined TYPE box, bottom left at $, length l, height h
def drawTYPE(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  z$c = 1/2[z$bl,z$tr];
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
  label(str, z$c);
enddef;

%%% draw an entity  box, bottom left at $, length l, height h
def drawENT(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  z$c = 1/2[z$bl,z$tr];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  label(str, z$c);
enddef;

def drawOB(suffix $)(expr l, h) =
  save rad;
  numeric rad; rad := h/2;
  rectpoints($, l, h);
  z$cl = 1/2[z$bl, z$tl];
  z$cr = 1/2[z$br, z$tr];
  z$bli = (x$bl+rad, y$bl);
  z$tli = (x$bli, y$tl);
  z$bri = (x$br-rad, y$br);
  z$tri = (x$bri, y$tr);
  z$c = 1/2[z$bl,z$tr];
  draw z$bli--z$bri..z$cr..z$tri--z$tli..z$cl..cycle;
enddef;

%%% draw a page reference box oval, bottom left at $, length l, height h
def drawPREF(suffix $)(expr l, h)(text str) =
  drawOB($, l, h);
  label(str, z$c);
enddef;

%%% draw an interschema USE box, bottom left at $, length l, height h
def drawISU(suffix $)(expr l, h)(text str) =
  save quarter;
  numeric quarter; quarter := h/4;
  rectpoints($, l, h);
  z$o = (x$, y$+quarter);
  drawOB($o, l, 2quarter);
  z$c = 1/2[z$bl,z$tr];
  label(str, z$c);
  draw z$bl--z$br--z$tr--z$tl--cycle;
enddef;

%%% draw an interschema USE RENAME box, bottom left at $, length l, height h
def drawISUR(suffix $)(expr l, h)(text str, rname) =
  save third;
  numeric third; third := h/3;
  rectpoints($, l, h);
  z$o = (x$, y$+third);
  drawOB($o, l, third);
  z$c = 1/2[z$bl, z$tr];
  label(str, z$c);
  z$rnm = 1/2[z$bl,(x$br,y$br+third)];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  label(rname, z$rnm);
enddef;

%%% draw an interschema REFERENCE box, bottom left at $, length l, height h
def drawISR(suffix $)(expr l, h)(text str) =
  save quarter;
  numeric quarter; quarter := h/4;
  rectpoints($, l, h);
  z$o = (x$, y$+quarter);
  drawOB($o, l, 2quarter);
  z$c = 1/2[z$bl,z$tr];
  label(str, z$c);
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
enddef;

%%% draw an interschema REFERENCE RENAME box, bottom left at $, length l, height h
def drawISRR(suffix $)(expr l, h)(text str, rname) =
  save third;
  numeric third; third := h/3;
  rectpoints($, l, h);
  z$o = (x$, y$+third);
  drawOB($o, l, third);
  z$c = 1/2[z$bl,z$tr];
  label(str, z$c);
  z$rnm = 1/2[z$bl,(x$br,y$br+third)];
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
  label(rname, z$rnm);
enddef;

%%% draw a Local EVENT box, bottom left at $, length l, height h
def drawLEVENT(suffix $)(expr l, h)(text str) =
  rhompoints($, l, h, eventslope);
  z$c = 1/2[z$ml,z$mr];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  label(str, z$c);
enddef;

%%% draw a Global EVENT box, bottom left at $, length l, height h
def drawGEVENT(suffix $)(expr l, h)(text str) =
  rhompoints($, l, h, eventslope);
  z$c = 1/2[z$ml,z$mr];
  pickup thickpen;
  draw z$bl--z$br--z$tr--z$tl--cycle;
  pickup normalpen;
  label(str, z$c);
enddef;

%%% draw a circled name, diameter diam centered at $
def drawcirclebox(suffix $)(expr diam)(text str) =
  circpoints($, diam);
  draw z$bl..z$bm..z$br..z$mr..z$tr..z$tm..z$tl..z$ml..cycle;
  label(str, z$c);
enddef;

%%% length and base width of diamond line end styles
newinternal gdl, gdb;
numeric gdl, gdb;
gdl := 2defaultgal;
gdb := 0.75defaultgab;

def ellipsepoints(suffix $)(expr l, h) =
  save epp, move;
  path epp;
  pair move;
  z$ml=(x$-l/2, y$); z$mr=(x$ml+l,y$);
  z$tm=(x$, y$+h/2); z$bm=(x$, y$tm-h);
  move = 1/2[z$ml,z$mr];
  epp = fullcircle scaled h xscaled (l/h) shifted move;
  z$tr = point 1.2 of epp;
  z$tl = point 2.8 of epp;
  z$bl = point 5.2 of epp;
  z$br = point 6.8 of epp;
enddef;

%%% draws double closed arrowheads at end of vector from $ to $$
def drawDCA(suffix $, $$) =
  begingroup
  save v_, c_, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, v_u, c_t, c_b;
  path p[];
  numeric l, hb;
  hb := gab/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gal/(l))[z$$,z$];      % base of arrowhead
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p1 := c_b--z$$--c_t--cycle;
  filldraw p1;
  p2 := p1 shifted ((xpart c_ - x$$), (ypart c_ - y$$));
  filldraw p2;
  endgroup
enddef;

%%% draws an open diamond at end of vector from $ to $$
def drawOD(suffix $, $$) =
  begingroup
  save v_, c_, c__, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, c__, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gdb/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gdl/(2l))[z$$,z$];     % base of diamond
  c__ := (gdl/(l))[z$$,z$];     % interior tip of diamond
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p = c_b--z$$--c_t--c__--cycle;
  unfill p;
  draw p; draw p;
  endgroup
enddef;

%%% draws a closed diamond at end of vector from $ to $$
def drawCD(suffix $, $$) =
  begingroup
  save v_, c_, c__, v_u, c_t, c_b, l, hb, p;
  pair v_, c_, c__, v_u, c_t, c_b;
  numeric l, hb;
  path p;
  hb := gdb/2;
  v_ := z$-z$$;
  l := (xpart v_)++(ypart v_);  % length of the line
  c_ := (gdl/(2l))[z$$,z$];     % base of diamond
  c__ := (gdl/(l))[z$$,z$];     % interior tip of diamond
  v_u := unitvector v_;
  c_t := c_ shifted (-hb*(ypart v_u), hb*(xpart v_u));
  c_b - c_ = c_ - c_t;
  p = c_b--z$$--c_t--c__--cycle;
  filldraw p;
  endgroup
enddef;

%%% draws a dashed line from $ to $$, ending with an arrowhead at $$
def drawdashA(suffix $, $$) =
  draw z$--z$$ dashes;
  drawA($, $$);
enddef;

%%% draws a dashed line from $ to $$, ending with an open arrowhead at $$
def drawdashOA(suffix $, $$) =
  draw z$--z$$ dashes;
  drawOA($, $$);
enddef;

%%% draws a normal line from $ to $$, ending with double closed arrowheads at $$
def drawnormalDCA(suffix $, $$) =
  draw z$--z$$;
  drawDCA($, $$);
enddef;

%%% draws a normal line from $ to $$, ending with an open diamond at $$
def drawnormalOD(suffix $, $$) =
  draw z$--z$$;
  drawOD($, $$);
enddef;

%%% draws a normal line from $ to $$, ending with a closed diamond at $$
def drawnormalCD(suffix $, $$) =
  draw z$--z$$;
  drawCD($, $$);
enddef;

%%% draws an open dashed circle, center z$, diameter diam
def drawdashcircle(suffix $)(expr diam) =
  circpoints($, diam);
  draw z$bl..z$bm..z$br..z$mr..z$tr..z$tm..z$tl..z$ml..cycle dashes;
enddef;

%%% draws an open circle, center z$, diameter diam, with an arrow at the top
def drawcircleA(suffix $)(expr diam) =
  circpoints($, diam);
  begingroup
  save c_, c_t, c_b, hb;
  pair c_, c_t, c_b;
  numeric hb;
  hb := gab/2;
  c_ := z$tm shifted (gal*right);  % base of arrowhead
  c_t := c_ shifted (hb*up);
  c_b := c_ shifted (hb*down);
  draw z$bl..z$bm..z$br..z$mr..z$tr..z$tm..z$tl..z$ml..cycle;
  draw c_t--z$tm--c_b;
  endgroup
enddef;

%%% draws black dot, center z$, diameter diam
def drawDot(suffix $)(expr diam) =
  begingroup
    save p;
    path p;
    p := fullcircle scaled diam shifted z$;
    filldraw p;
  endgroup
enddef;

%%% draws black dot surrounded by a circle, center z$, diameter diam
def drawCircledDot(suffix $)(expr diam) =
  begingroup
    save l_, p;
    numeric l_;
    path p[];
    l_ := 5/7diam;
    p1 := fullcircle scaled diam shifted z$;
    unfill p1;
    draw p1;
    p2 := fullcircle scaled l_ shifted z$;
    filldraw p2;
  endgroup
enddef;

def drawcardbox(suffix $)(expr l, h, m)(text str) =
  rectpoints($, l, h);
  begingroup
  save c;
  pair c[];
  c1 = (x$tr-m, y$tr);
  c3 = (x$tr, y$tr-m);
  c2 = (xpart c1, ypart c3);
  draw z$bl--z$br--c3--c1--z$tl--cycle;
  draw c1--c2--c3;
  endgroup;
  z$c = 1/2[z$ml,z$mr];
  label(str, z$c);
enddef;

def drawdiamondbox(suffix $)(expr l, h)(text str) =
  z$ml=(x$-l/2, y$); z$tm=(x$, y$+h/2);
  z$mr=(x$ml+l, y$); z$bm=(x$, y$tm-h);
  z$bl=1/2[z$ml,z$bm];
  z$br=1/2[z$bm,z$mr];
  z$tr=1/2[z$mr,z$tm];
  z$tl=1/2[z$tm,z$ml];
  z$c=z$;
  draw z$ml--z$bm--z$mr--z$tm--cycle;
  label(str, z$c);
enddef;

def drawtwodiamondbox(suffix $)(expr l, h, mrg)(text str) =
  z$ml=(x$-l/2, y$); z$tm=(x$, y$+h/2);
  z$mr=(x$ml+l, y$); z$bm=(x$, y$tm-h);
  z$bl=1/2[z$ml,z$bm];
  z$br=1/2[z$bm,z$mr];
  z$tr=1/2[z$mr,z$tm];
  z$tl=1/2[z$tm,z$ml];
  z$c=z$;
  begingroup
  save v_, p, tl, sf;
  pair v_;
  numeric tl, sf;
  path p[];
  p1 = z$ml--z$bm--z$mr--z$tm--cycle;
  draw p1;
  v_ := z$c-z$tr;
  tl := (xpart v_)++(ypart v_);
  sf = 1.0 - mrg/tl;
  p2 = p1 shifted -z$c scaled sf shifted z$c;
  draw p2;
  endgroup;
  label(str, z$c);

enddef;

def drawdoublerectangle(suffix $)(expr l, h, tf) =
  rectpoints($, l, h);
  z$tfl=tf[z$tl,z$bl]; z$tfr=tf[z$tr,z$br];
  z$cb=1/2[z$bl,z$tfr];
  z$ct=1/2[z$tfl,z$tr];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  draw z$tfl--z$tfr;
enddef;

def drawtriplerectangle(suffix $)(expr l, h, tf, bf) =
  rectpoints($, l, h);
  z$tfl=tf[z$tl,z$bl]; z$tfr=tf[z$tr,z$br];
  z$bfl=bf[z$bl,z$tl]; z$bfr=bf[z$br,z$tr];
  z$cb=1/2[z$bl,z$bfr];
  z$cm=1/2[z$bfl,z$tfr];
  z$ct=1/2[z$tfl,z$tr];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  draw z$bfl--z$bfr;
  draw z$tfl--z$tfr;
enddef;

def hiderectangle(suffix $)(expr l, h) =
  begingroup
  save c;
  pair c[];
  c1=(x$,y$);
  c2=c1+(l,0);
  c3=c1+(l,h);
  c4=c1+(0,h);
  unfilldraw c1--c2--c3--c4--cycle;
  endgroup
enddef;

def drawdashboxover(suffix $)(expr l, h) =
  rectpoints($, l, h);
  hiderectangle($, l, h);
  z$c = 1/2[z$bl,z$tr];
  draw z$bl--z$br--z$tr--z$tl--cycle dashes;
enddef;

def drawindexbox(suffix $)(expr l, h, lp, hp)(text str) =
  rectpoints($, l, h);
  z$c = 1/2[z$bl,z$tr];
  z$P = z$tl;
  rectpoints($P, lp, hp);
  z$P.c = 1/2[z$P.bl, z$P.tr];
  draw z$bl--z$br--z$tr--z$tl--cycle;
  draw z$P.bl--z$P.br--z$P.tr--z$P.tl--cycle;
  label(str, z$P.c);
enddef;

def drawroundedbox(suffix $)(expr l, h, r)(text str) =
  rectpoints($, l, h);
  begingroup
  save rad;
  numeric rad; rad := r;
  if rad > l/2:
    rad := l/2;
  fi
  if rad > h/2:
    rad := h/2;
  fi
  draw (x$br-rad, y$br){right}..{up}(x$br, y$br+rad)--
       (x$tr, y$tr-rad){up}..{left}(x$tr-rad, y$tr)--
       (x$tl+rad, y$tl){left}..{down}(x$tl, y$tl-rad)--
       (x$bl, y$bl+rad){down}..{right}(x$bl+rad, y$bl)--cycle;
  endgroup;
  z$c = 1/2[z$bl,z$tr];
  label(str, z$c);
enddef;

def drawovalbox(suffix $)(expr l, h)(text str) =
  ellipsepoints($, l, h);
  z$c = 1/2[z$ml,z$mr];
  begingroup
  save p;
  path p;
  p = fullcircle scaled h xscaled (l/h) shifted z$c;
  draw p;
  endgroup;
  label(str, z$c);
enddef;

def drawdashellipse(suffix $)(expr l, h) =
  ellipsepoints($, l, h);
  z$c = 1/2[z$ml,z$mr];
  begingroup
  save p;
  path p;
  p = fullcircle scaled h xscaled (l/h) shifted z$c;
  draw p dashes;
  endgroup
enddef;

def drawdrum(suffix $)(expr l, h)(text str) =
  save vdia; numeric vdia;
  vdia := drumlid*l;                % ellipse vertical diameter
  save pf, ph; path pf, ph;         % full & half ellipse paths

  % points on the basic rectangle
  z$bl = z$;
  z$tr = (x$+l, y$+h);
  z$br = (x$tr, y$);
  z$tl = (x$, y$tr);
  z$ml = 1/2[z$bl,z$tl];
  z$mr = 1/2[z$br,z$tr];
  z$tc = 1/2[z$tl,z$tr];    % center of top rectangle line
  z$bc = 1/2[z$bl,z$br];
  % draw box sides
  draw z$tl--z$bl; draw z$tr--z$br;

  % points on top ellipse
  z$T''' = z$tc;            % ellipse center
  ellipsepoints($T''', l, vdia);
  z$tm  = z$T'''.tm;
  z$tml = z$T'''.tl;
  z$tmr = z$T'''.tr;

  % points on bottom ellipse
  z$B''' = z$bc;
  ellipsepoints($B''', l, vdia);
  z$bm  = z$B'''.bm;
  z$bml = z$B'''.bl;
  z$bmr = z$B'''.br;

  % box center point
  z$c = 1/2[z$T'''.bm, z$B'''.bm];

  % draw top ellipse
  pf = fullcircle scaled vdia xscaled (l/vdia) shifted z$T''';
  draw pf;
  % draw bottom half ellipse
  ph = (halfcircle rotated 180) scaled vdia  xscaled (l/vdia) shifted z$B''';
  draw ph;
  label(str, z$c);
enddef;

def drawoutputbox(suffix $)(expr l, h)(text str) =
  rectpoints($, l, h);
  begingroup
    save c;
    pair c[];
    c1 = (x$br, y$br+1/8h); % right side of box is shorter
    c2 = (x$bm, y$bm+1/16h);
    % draw the tear
    draw z$bl..c2{dir 45}..c1{dir -15}--z$tr--z$tl--cycle;
  endgroup;
  z$c = (x$bm, 1/2(y$bm+y$tm));
  label(str, z$c);
enddef;

\def drawstickman(suffix $)(expr l, h) =
  rectpoints($,l,h);
  begingroup
    save c;
    pair c[];
    c1 = 8/24[z$bm,z$tm];
    c2 = 15/24[z$bm,z$tm];
    c3 = 18/24[z$bm,z$tm];
    c4 = 1/2[c3,z$tm];
    c6 = (x$bl, ypart(c2));
    c7 = (x$br, ypart(c2));
    draw z$bl--c1--z$br;               % legs
    draw c1--c3;                       % body
    draw c6--c7;                       % arms
    draw c3{right}..z$tm{left}..cycle; % head
  endgroup;
enddef;

