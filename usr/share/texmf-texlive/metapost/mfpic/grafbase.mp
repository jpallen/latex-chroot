%%
%% This is file `grafbase.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% grafbase.dtx  (with options: `MP')
%% 
%% -------------------------------------------------------------------
%% 
%% Copyright 2002--2006, Daniel H. Luecking
%% 
%% Mfpic may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3b of this license or (at
%% your option) any later version. The latest version of this license is in
%%    <http://www.latex-project.org/lppl.txt>
%% and version 1.3b or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%% 
%% Mfpic has maintenance status "author-maintained". The Current Maintainer
%% is Daniel H. Luecking. There are several Base Interpreters associated
%% with mfpic: plain TeX, LaTeX, plain Metafont and plain MetaPost.
%% 
if (known grafbaseversion) or (known grafbase):
  message "Grafbase (" & jobname & "): You have loaded grafbase more "
    & "than once! Please make sure that it is loaded only once.";
  endinput;
fi
boolean grafbase; grafbase := true;

string fileversion, filedate;
fileversion := "0.9";  filedate := "2006/05/26";

message " Loading grafbase macros, version " & fileversion & " " &
   filedate & ".";

def GBmsg expr s =  message "Grafbase (" & jobname & "): " & s;  enddef;
def GBwarn expr s =  GBmsg "Warning, " & s;  enddef;
def GBerrmsg (expr s) expr t =  errhelp t;
  errmessage "Grafbase (" & jobname & "): " & s;  errhelp "";
enddef;

boolean MFPIC;  MFPIC := false;

def checkversions (expr g)=
  numeric grafbaseversion;  grafbaseversion := g;
  if unknown mfpicversion:  % no mfpic, or  < 0.63
    GBmsg "Recent mfpic not detected.";
  elseif g = mfpicversion:
    MFPIC := true;
  else:
    message "";
    GBwarn "Version mismatch: "
         & "mfpic and grafbase versions do not match.";
    message "";
  fi
enddef;

checkversions (90);

if unknown base_name       :  input plain;
elseif not string base_name:  input plain;
elseif base_name <> "plain":  input plain;
fi

boolean METAPOST;

if known color Geamparalele din Babadag:
  METAPOST := true;
else:
  METAPOST := false;
fi

if not METAPOST:
  GBerrmsg ("wrong compiler.")
    "This file is for Metapost. For Metafont use grafbase.mf.";
fi

if not boolean debug:  boolean debug;  debug := false;  fi

def GBdebug =
  begingroup
    save >>;  def >> =  message  enddef;
    >> "Grafbase DEBUG";
enddef;
def GBenddebug =
    >> "End DEBUG";
  endgroup
enddef;

vardef mftitle expr t =
  if string t:  t;  message t;  fi
enddef;

pt# := pt;  bp# := bp;
def t_ =  transformed currenttransform  enddef;
if unknown aspect_ratio:  aspect_ratio := 1;  fi
if unknown hppp:  hppp := 1  fi;
if unknown currenttransform:
  transform currenttransform;
  currenttransform := identity yscaled aspect_ratio;
fi

interim warningcheck := 0;

numeric unitlen, xscale, yscale, xneg, xpos, yneg, ypos;

unitlen := 1 bp#;
xscale := 7.2;
yscale := 7.2;
xneg := 0;  xpos := 10;
yneg := 0;  ypos := 10;

newinternal deg, pi, radian;
deg := 1;  pi := 3.14159;
radian := 57.29578;
numeric degree;  degree := deg;

newinternal penwd;  penwd := 0.5pt;
pen drawpen;

def resizedrawpen (expr s) =
  interim penwd := s;
  setvariable (pen) (drawpen) pencircle scaled penwd;
  save currentpen;  pen currentpen;  pickup drawpen;
enddef;

numeric hatchwd;  hatchwd := 0.5bp;
pen hatchpen;  hatchpen := pencircle scaled hatchwd;

boolean clipall;  clipall := false;
boolean ClipOn;  ClipOn := false;
path ClipPath[];  numeric ClipPath;  ClipPath = 0;
boolean truebbox;  truebbox := false;

def DoClip (suffix v) =
  if ClipOn and (ClipPath > 0):  clipsto (v, ClipPath);  fi
enddef;

def noclip (text t) =
  hide ( setboolean (ClipOn) false;  t)
enddef;

boolean showbbox;  showbbox := false;

def _wc_ =  withcolor  enddef;

color currentcolor, drawcolor, fillcolor, hatchcolor,
  headcolor, pointcolor, tlabelcolor, background;
currentcolor := fillcolor := drawcolor := hatchcolor :=
  headcolor := pointcolor := tlabelcolor := black;
background := white;

vardef snapto expr t =
  if unknown t:            0
  elseif not (numeric t):  0
  elseif t < 0:            0
  elseif t > 1:            1
  else:                    t
  fi
enddef;

vardef gray (expr g) =  (snapto g)*white  enddef;

vardef makeclr (expr r, g, b) =
  (r, g, b)
enddef;

vardef rgb (expr r, g, b) =
  makeclr (snapto r, snapto g, snapto b)
enddef;

vardef cmyk (expr c, m, y, k) =
  rgb (1-c-k, 1-m-k, 1-y-k)
enddef;

vardef RGB (expr R, G, B) =
  rgb (R/255, G/255, B/255)
enddef;

vardef named (suffix c) =
  if unknown c:  black  else:  forceclr (c)  fi
enddef;
vardef forceclr (expr c) =
  if numeric c:    gray (c)
  elseif color c:  c
  else:            black
  fi
enddef;

color red, green, blue, cyan, magenta, yellow;
red     := rgb (1, 0, 0);
green   := rgb (0, 1, 0);
blue    := rgb (0, 0, 1);
cyan    := rgb (0, 1, 1);
magenta := rgb (1, 0, 1);
yellow  := rgb (1, 1, 0);

def list (suffix v) (text lst) =
  v := 0;  for _itm = lst:  v[incr v] := _itm;  endfor
  if v = 0:
    GBerrmsg ("no list to process!")
      "An attempt was made to produce an array from a "
    & "list of expressions having no valid entries.";
  fi
enddef;

def map (text proc) (text lst) =
  hide (_map := 0;)
  for _a = lst:
    if _map = 0:  hide (_map := 1;)  else:  ,  fi
    proc (_a)
  endfor
enddef;

vardef knownnumericarray suffix arr =
  setboolean (_kna) (known arr) and (numeric arr);
  if _kna :
    _kna := (arr = floor arr) and (arr >= 1);
    for _idx = 1 upto arr :
      exitif not _kna;
      _kna := (known arr[_idx]) and (numeric arr[_idx]);
    endfor
  fi
  _kna
enddef;

def copyarray (suffix src, dest) =
  for _idx = 1 upto src:  dest[_idx] := src[_idx];  endfor
  dest := src;
enddef;

def maparr (text proc) (suffix p) =
  for _idx = 1 upto p:  proc (p[_idx]);  endfor
enddef;

def textpairs =  gsetarray (pair)  enddef;

def setuniquepairs (suffix p) (text t) =
  save p;  pair p[];
  setpairs (_up) (t);
  if _up > 0:
    p := 1;  p1 := _up1;
    for _i = 2 upto _up:
      if _up[_i] <> p[p]:  p[incr p] := _up[_i];  fi
    endfor
  else:
    p := 0;
  fi
enddef;

vardef chpair (text proc) (expr p) =
  (proc (xpart p), proc (ypart p))
enddef;

vardef floorpair (expr p) =  (floor (xpart p), floor (ypart p))  enddef;
vardef ceilingpair (expr p) =
  (ceiling (xpart p), ceiling (ypart p))
enddef;

vardef emin (expr a, b) =  if a < b:  a  else:  b  fi  enddef;
vardef emax (expr a, b) =  if a > b:  a  else:  b  fi  enddef;

vardef pairmin (expr z, w) =
    ( emin (xpart z,  xpart w), emin (ypart z, ypart w ) )
enddef;
vardef pairmax (expr z, w) =
    ( emax (xpart z,  xpart w), emax (ypart z, ypart w ) )
enddef;

vardef minpair (suffix p) =  setpair (_mp) p1;
  for _idx = 2 upto p - 1:  _mp := pairmin (_mp, p[_idx]);  endfor
  pairmin (_mp, p[p])
enddef;
vardef maxpair (suffix p) =  setpair (_mp) p1;
  for _idx = 2 upto p - 1:  _mp := pairmax (_mp, p[_idx]);  endfor
  pairmax (_mp, p[p])
enddef;

primarydef Z xprod W =  (xpart Z * ypart W - xpart W * ypart Z)  enddef;

def force_initial (expr p) (suffix f) =
  hide( setnumeric (_n) length f;
  f := p
    if _n = 0:
      {0,0}
    else:
      ..controls post0 (f) and pre 1 (f).. subpath (1,_n) of f
    fi;)
enddef;

def force_terminal (expr p) (suffix f) =
  hide(setpath (_f) reverse f;
  force_initial (p) (_f);
  f := reverse _f;)
enddef;

def force_equal_ends (suffix f, g) =
  hide(save _p;  pair _p;
  _p := .5[pnt[length f] (f), pnt0(g)];
  force_terminal (_p) (f);  force_initial (_p) (g);)
enddef;

def replace_ends_of_cycle (expr p) (suffix f) =
hide(
if cycle f:
  save _n;  _n := length f;
  f := p
    if _n = 0:  &cycle
    else:  .. controls post0 (f) and pre 1 (f) ..
      if _n = 1:  cycle
      else:  subpath (1, _n - 1) of f ..
        controls post[_n - 1](f) and pre[_n](f) .. cycle
      fi
    fi;
fi)
enddef;

pair thetimes;
numeric _Xtime, _Ytime;
tertiarydef a intersects b =
  begingroup
    thetimes := a intersectiontimes b;
    _Xtime := xpart thetimes;
    _Ytime := ypart thetimes;
    (_Xtime > -1)
  endgroup
enddef;

tertiarydef a misses b =  ((a intersectiontimes b) < origin)  enddef;

vardef makepicture (expr s) =
  if picture s:    s
  elseif string s:  s infont defaultfont scaled defaultscale
  elseif path s:   picpath (s)
  else:            nullpicture
  fi
enddef;

vardef onepointpath (expr cyclic, q) =
  q if cyclic:  &cycle  else:  {0,0}  fi
enddef;

vardef fallbackpath (expr cyclic, p) (text t) =
  onepointpath (cyclic, p)
enddef;

def even =  not odd  enddef;

primarydef a divides b =
  ((b mod a) = 0)
enddef;

def beginimage =
  begingroup
    newpicture (currentpicture);
enddef;
def endimage =
  ;  currentpicture
  endgroup
enddef;

def makeimage (suffix name) (expr refpt) =
  setpair (_image_reference_point) zconv(refpt);
  setpicture (name) beginimage
enddef;
def concludeimage  =
  endimage shifted
    -_image_reference_point
enddef;

def setvariable (text kind) (suffix name) =
  save name;  kind name;  name :=
enddef;
def gsetvariable (text kind) (suffix name) =  kind name;  name :=
enddef;

def setnumeric (suffix name) =  save name;  name :=  enddef;
def setboolean   =  setvariable (boolean)  enddef;
def setpair      =  setvariable (pair)  enddef;
def setpath      =  setvariable (path)  enddef;
def setcolor     =  setvariable (color)  enddef;
def setpicture   =  setvariable (picture)  enddef;
def settension (suffix tn) expr tens =
  setnumeric (tn) if tens > 0:  tens  else:  default_tension  fi;
enddef;
def fixtension (suffix tn) =  if tn < .75:  tn := .75;  fi  enddef;

def newpicture (suffix pic) =  setpicture (pic) nullpicture;  enddef;
def convertpath (suffix g) expr f =  setpath (g) zconv (f);  enddef;

def setarray (text kind) (suffix name) =
  save name;  kind name[];  list (name)
enddef;
def setpairs =  setarray (pair)  enddef;
def gsetarray (text kind) (suffix name) =
  numeric name;  kind name[];  list (name)
enddef;


def setbbox (suffix ll, ur) =
  save ll, ur;  pair ll, ur;  getbbox (ll, ur)
enddef;

def setsplit (suffix s) expr ss =
  setnumeric (s) emax (1, ceiling ss);
enddef;

transform ztr, vtr;
def setztr =
  if debug:
    GBdebug;
      >> "w_ = " & decimal w_ & "bp";
      >> "h_ = " & decimal h_ & "bp";
      >> "unitlen = " & decimal unitlen & "bp";
      >> "xneg = " & decimal xneg;
      >> "xpos = " & decimal xpos;
      >> "yneg = " & decimal yneg;
      >> "ypos = " & decimal ypos;
      >> "xscale = " & decimal xscale;
      >> "yscale = " & decimal yscale;
    GBenddebug;
  fi
  save ztr, vtr;
  transform ztr, vtr;
  vtr := identity xscaled xscale yscaled yscale scaled (unitlen*hppp);
  ztr := identity shifted (-xneg, -yneg) transformed vtr;
  if debug:
    GBdebug;
      >> "ztr is";
      show ztr;
      >> "vtr is";
      show vtr;
    GBenddebug;
  fi
enddef;

vardef zconv (expr a) =  a transformed ztr  enddef;
vardef invzconv (expr a) =  a transformed (inverse ztr)  enddef;
vardef vconv (expr v) =  v transformed vtr  enddef;
vardef invvconv (expr v) =  v transformed (inverse vtr)  enddef;

def active_plane =  currentpicture  enddef;

boolean overlaylabels, underlaylabels, havebackground;
overlaylabels := false;
underlaylabels := false;
havebackground := false;

def initpic =
  setztr;
  resizedrawpen (penwd);
  if ClipOn:  ClipPath := 1;
    ClipPath1 := rect (origin, (w_, h_));
  fi
  if debug:
    GBdebug;
      >> "Drawing nominal bounding box around picture";
    GBenddebug;
    noclip ( safedraw rect (origin, (w_, h_)) );
  fi
  newpicture (foreground_labels);
  newpicture (background_labels);
  havebackground := false;
  save labelbb;  pair labelbb.ll, labelbb.ur;
  labelbb.ll := labelbb.ur := origin;
enddef;

def mfpicenv =  enddef;
def endmfpicenv =  enddef;
def bounds (expr a, b, c, d) =
  xneg := a;  xpos := b;
  yneg := c;  ypos := d;
enddef;

string extra_beginmfpic;  extra_beginmfpic := "";
string   extra_endmfpic;   extra_endmfpic := "";

def beginmfpic (expr ch) =
  beginfig (ch);
    gcode := ch;
    save w_, h_, d_;
    charwd := (xpos-xneg)*xscale*unitlen;
    charht := (ypos-yneg)*yscale*unitlen;
    chardp := 0;
    w_ := charwd;
    h_ := charht;
    d_ := chardp;
    initpic;
    scantokens extra_beginmfpic;
enddef;

def endmfpic =
  scantokens extra_endmfpic;
  if debug:
    GBdebug;
      >> "width = " & decimal w_ & "bp";
      >> "height = " & decimal h_ & "bp";
    GBenddebug;
  fi
  DoClip (active_plane);
  if clipall:  clipto (active_plane) rect (origin, (w_, h_));  fi
  if showbbox:  noclip ( safedraw rect (origin, (w_, h_)) );  fi
  save _ll, _ur;
  pair _ll, _ur;
  if truebbox:
    _ll := llcorner active_plane;
    _ur := urcorner active_plane;
  elseif clipall:
    _ll := origin;
    _ur := (w_,h_);
  else:             % expand to accomodate labels
    _ll := pairmin ((0,  0 ), labelbb.ll);
    _ur := pairmax ((w_, h_), labelbb.ur);
  fi
  _ur := pairmax (_ur, _ll + eps*(1, 1));
  setbounds active_plane to rect (_ll, _ur);
    if havebackground:
      addto background_labels also active_plane;
      active_plane := background_labels;
      background_labels := nullpicture;
    fi
    addto active_plane also foreground_labels;
    foreground_labels := nullpicture;
  endfig;
enddef;

pair label_adjust;
label_adjust := origin;
numeric label_sep, labelpath_sep ;
label_sep :=  0;  labelpath_sep := 0;


vardef newgblabel (expr hf, vf, BL, r) (expr s) (text pts) =
  save _lab, _ll, _ur;  picture _lab;  pair _ll, _ur;
  _lab := makepicture (s);
  pathdims (origin, _lab) (_ll, _ur);
  readjustdims (_ll, _ur) (label_sep);
  _lab := thegblabel (ref_shift (hf, vf, BL, _ll, _ur), r, _lab);
  save _b;  pair _b;
  for _itm = pts:
    _b := zconv (_itm);
    if overlaylabels:
      addto foreground_labels also _lab shifted _b _wc_ tlabelcolor;
    elseif underlaylabels:
      addto background_labels also _lab shifted _b _wc_ tlabelcolor;
      havebackground := true;
    else:
      addto active_plane also _lab shifted _b _wc_ tlabelcolor;
      labelbb.ll := pairmin (_b + llcorner _lab, labelbb.ll);
      labelbb.ur := pairmax (_b + urcorner _lab, labelbb.ur);
    fi
  endfor
enddef;

vardef gblabel (expr a, b, c, d, r) (expr s) (text t) =
  newgblabel (b, d, (c = 0) and (d = 0), r) (s) (t);
enddef;

vardef ref_shift (expr hf, vf, BL, ll, ur) =
  - ( (hf)[xpart ll, xpart ur],
        (vf)[if BL:  0  else:  (ypart ll) fi, ypart ur] )
enddef;

vardef thegblabel (expr z, r, p) =
  ((p shifted z) rotated r) shifted label_adjust
enddef;

vardef textrect (expr lbl, rad, loc) =
  textrectx (.5, .5, false, 0) (origin, lbl, rad, loc)
enddef;
vardef textoval (expr lbl, mult, loc) =
  xellipse (true, .5, .5, false, 0) (origin, lbl, mult, loc)
enddef;
vardef textellipse (expr lbl, rat, loc) =
  xellipse (false, .5, .5, false, 0) (origin, lbl, rat, loc)
enddef;

boolean roundends;  roundends := true;
vardef textrectx (expr a, b, c, rot, xy, lbl, rad, loc) =
  save ll, ur, _r, f, zz;
  pair ll, ur, zz;  path f;
  pathdims (xy, lbl) (ll, ur);
  readjustdims (ll, ur) (labelpath_sep)
  _r := if numeric rad:  rad
    elseif not boolean rad:  0
    elseif rad:  emin (xpart(ur-ll), ypart (ur-ll))/sqrt(2)
    else:  0
    fi;
  if _r = 0:
    f :=  rect (ll, ur);
  else:
    save p, q;
    pair p[];  path q;
    p1 := ur - _r*dir(45);
    p3 := ll + _r*dir(45);
    p2 := (xpart p3, ypart p1);
    p4 := (xpart p1, ypart p3);
    q := if _r < 0:  reverse  fi  quartercircle scaled 2_r;
    f :=
        (q shifted p1)--(q rotated 90 shifted p2)
             --(q rotated 180 shifted p3)
             --(q rotated -90 shifted p4)--cycle;

  fi
  readjustdims (ll, ur) (label_sep - labelpath_sep);
  invvconv (thegblabel (ref_shift(a, b, c, ll, ur), rot, f)) shifted loc
enddef;

def textovalx =  xellipse (true)  enddef;
def textellipsex =  xellipse (false)  enddef;

vardef xellipse (expr aspect, a, b, c, r, xy, lbl, mult, loc) =
  if mult = 0:
    textrectx (a, b, c, r) (xy, lbl, 0, loc)
  else:
    save ll, ur, cc, ww, hh, f;
    pair ll, ur, cc;  path f;
    pathdims (xy, lbl) (ll, ur);
    readjustdims (ll, ur) (labelpath_sep)
    cc := .5[ll, ur];
    (ww, hh) = ur - cc;
    if (ww = 0) or (hh = 0):
      f = (ll--ur);
    else:
      save aa, bb;
      aa := ww ++ if aspect:  ww  else:  hh  fi  *mult;
      bb := hh ++ if aspect:  hh  else:  ww  fi  /mult;
      f := ellipse (cc, aa, bb, 0);
    fi
    readjustdims (ll, ur) (label_sep - labelpath_sep);
    invvconv (thegblabel (ref_shift(a, b, c, ll, ur), r, f)) shifted loc
  fi
enddef;

def pathdims (expr xy, lbl) (suffix ll, ur) =
  if pair lbl:
    ll := xy;  ur := lbl;
  else:
    setpicture (_lbl) makepicture (lbl);
    ll := llcorner _lbl;
    ur := urcorner _lbl;
  fi
enddef;

def readjustdims (suffix ll, ur) (expr s) =
  ll := ll - s*(1,1);
  ur := ur + s*(1,1);
enddef;

newinternal reallysmall;  reallysmall := 3epsilon;
newinternal nottoosmall;  nottoosmall := eps/2 + 2epsilon;
def signof (expr X) =  if X < 0:  -  fi  enddef;
def TruncateWarn expr s =
  GBwarn s & " is too large or undefined, so it will be truncated.";
enddef;

vardef secd primary X =
  setnumeric (temp) cosd(X);
  if abs(temp) < reallysmall:
    TruncateWarn "Secant or Tangent";
    temp := signof (temp) reallysmall;
  fi
  1/temp
enddef;
vardef tand primary X =  sind(X)*secd(X)  enddef;

vardef cscd primary X =
  setnumeric (temp) sind(X);
  if abs(temp) < reallysmall:
    TruncateWarn "Cosecant or Cotangent";
    temp := signof(temp) reallysmall;
  fi
  1/temp
enddef;
vardef cotd primary X =  cosd(X)*cscd(X)  enddef;

vardef acos primary X =
  if abs X > 1:
    TruncateWarn "Argument of arccosine";
    angle (signof(X) 1, 0)
  else:
    angle (X, 1 +-+ X)
  fi
enddef;
vardef asin primary X =
  if abs X > 1:
    TruncateWarn "Argument of arcsine";
    angle (0, signof(X) 1)
  else:
    angle (1 +-+ X, X)
  fi
enddef;
vardef atan primary X =  angle (1, X)  enddef;

vardef sin primary X =  sind (X*radian)  enddef;
vardef cos primary X =  cosd (X*radian)  enddef;
vardef tan primary X =  tand (X*radian)  enddef;
vardef cot primary X =  cotd (X*radian)  enddef;
vardef sec primary X =  secd (X*radian)  enddef;
vardef csc primary X =  cscd (X*radian)  enddef;

vardef degrees (expr t) =  t*radian  enddef;
vardef radians (expr t) =  t/radian  enddef;
vardef invcos primary X =  (acos X)/radian  enddef;
vardef invsin primary X =  (asin X)/radian  enddef;
vardef invtan primary X =  (atan X)/radian  enddef;

vardef exp primary X =  mexp (256 * X)  enddef;
vardef ln  primary X =  (mlog X) / 256  enddef;
def log =  ln  enddef;
vardef logbase (expr B) primary X =  (mlog X)/(mlog B)  enddef;
def logtwo =  logbase( 2)  enddef;
def logten =  logbase(10)  enddef;

vardef Arg primary Z =  (angle Z)/radian  enddef;
vardef Log primary Z =  (ln (abs Z), Arg Z)  enddef;
vardef cis primary T =  dir (T*radian)  enddef;
vardef zexp primary Z =  (exp (xpart Z)) * cis (ypart Z)  enddef;
vardef sgn primary Z =  if not (Z = origin):  unitvector  fi  Z  enddef;

vardef cosh primary X =
  setnumeric (temp) 2 exp (-abs(X));
  if temp < reallysmall:
    TruncateWarn "Cosh";
    temp := reallysmall;
  fi
  1/temp + temp/4
enddef;

vardef sinh primary X =
  setnumeric (temp) 2 exp (-abs(X));
  if temp < reallysmall:
    TruncateWarn "Sinh";
    temp := reallysmall;
  fi
  signof (X) (1/temp - temp/4)
enddef;

vardef sech primary X =
  setnumeric (temp) exp(-(abs (X)));
  2temp/(1 + temp*temp)
enddef;

vardef tanh primary X =
  setnumeric (temp) exp(-2(abs (X)));
  signof (X) (1 - temp)/(1 + temp)
enddef;

vardef csch primary X =
  save temp, tempa;  temp := exp(-(abs (X)));
  tempa := (1 - temp*temp)/2;
  if tempa < reallysmall:
    TruncateWarn "Csch";
    tempa := reallysmall;
  fi
  signof (X) temp / tempa
enddef;

vardef coth primary X =
  setnumeric (temp) tanh(X);
  if abs(temp) < reallysmall:
    TruncateWarn "Coth";
    temp := signof (X) reallysmall;
  fi
  1/temp
enddef;

vardef acosh primary y =
  if y < 1:
    TruncateWarn "acosh";
    0
  else:
    ln (y + (y +-+ 1))
  fi
enddef;

vardef asinh primary y =  ln (y + (y ++ 1))  enddef;

vardef atanh primary y =
  if abs (y) < 1:
    (ln (1 + y) - ln (1 - y))/2
  else:
    TruncateWarn "atanh";
    signof (y) infinity
  fi
enddef;

vardef polar primary p =  (xpart p) * dir (ypart p)  enddef;
def id (expr x) =  x  enddef;

primarydef x**y =
  if y=2:  x*x
  elseif (x = floor x) and (abs y = floor y):
    1 for n=1 upto y:  *x endfor
  else:  takepower y of x
  fi
enddef;
let ^ = **;
transform T_stack[];
numeric T_stack;  T_stack := 0;
def T_push (expr T) =  T_stack[incr T_stack] := T;  enddef;
def T_pop (suffix $) =
  if T_stack > 0:
    $ := T_stack[T_stack];
    T_stack := T_stack - 1;
  fi
enddef;

def bcoords =  hide ( T_push (ztr) )  enddef;
def ecoords =  hide ( T_pop (ztr);  vtr := vectorpart ztr )  enddef;

vardef vectorpart primary T =  T shifted -(origin transformed T)  enddef;

def apply_t (text Transformer) =
  ztr := identity Transformer transformed ztr;
  vtr := vectorpart ztr;
enddef;

def xslant =  slanted  enddef;  % (x+sy, y).
def yslant primary s =  % (x, y+sx).
  transformed
    begingroup
      save T;  transform T;
      origin transformed T = origin;
      (1, 0) transformed T = (1, s);
      (0, 1) transformed T = (0, 1);
      T
    endgroup
enddef;

def zslant primary p =  % (xu+yv, xv+yu), where p =  (u, v).
  transformed
    begingroup
      save T;  transform T;
      xpart T = ypart T = 0;
      xxpart T = yypart T = xpart p;
      xypart T = yxpart T = ypart p;
      T
    endgroup
enddef;

def xyswap =  zslant (0, 1)  enddef;
def boost primary X =  zslant (cosh X, sinh X)  enddef;

vardef transformedpath (text Transformer) expr f =  f Transformer
enddef;

def rotatedpath (expr p, th) =
  transformedpath (
    transformed vtr
    rotatedaround (p transformed vtr, th)
    transformed (inverse vtr)
  )
enddef;
def reflectedpath (expr p, q) =
  transformedpath (
    transformed vtr
    reflectedabout (p transformed vtr, q transformed vtr)
    transformed (inverse vtr)
  )
enddef;

def scaledpath (expr p, s) =
  transformedpath (shifted -p scaled s shifted p)
enddef;
def xscaledpath (expr a, s) =
  transformedpath (shifted (-a, 0) xscaled s shifted (a, 0))
enddef;
def yscaledpath (expr b, s) =
  transformedpath (shifted (0, -b) yscaled s shifted (0, b))
enddef;

def slantedpath =  xslantedpath  enddef;
def xslantedpath (expr b, s) =
  transformedpath (shifted (0, -b) slanted s shifted (0, b))
enddef;
def yslantedpath (expr a, s) =
  transformedpath (shifted (-a, 0) yslant s shifted (0, a))
enddef;

def shiftedpath (expr v) =  transformedpath (shifted v)  enddef;

def xyswappedpath =  transformedpath (xyswap)  enddef;

vardef partialpath (expr a, b) expr f =
  save flag, flo, fhi, lo, hi, n;
  boolean flag;  flag = true;
  convertpath (g) f;
  n := length f;

  flo := snapto emin(a,b);
  if flo = 0:
    lo := 0;
  elseif flo < 1:
    setuplengtharray (cum, tot, idx) g;
    flag := false;
    lo := gettime (cum, idx) (flo*tot);
  else:
    lo := n;
  fi

  fhi := snapto emax (a,b);
  if flo = fhi:
    hi := lo;
  elseif fhi < 1:
    if flag:  setuplengtharray (cum, tot, idx) g;  fi
    hi := gettime (cum, idx) (fhi*tot);
  else:
    hi := n;
  fi

  if a > b:  reverse  fi  subpath (lo, hi) of f
enddef;

vardef gsubpath (expr a, b) expr f =  subpath (a, b) of f  enddef;

def setuplengtharray (suffix cum, tot, idx) =
  save cum, tot, idx;  idx := 0;  tot := makelengtharray (cum)
enddef;

vardef pathtime@# (suffix p) =
  if @# <= 0:  0
  elseif @# >= 1:  length p
  else:
    setuplengtharray (cum, tot, idx) p;
    gettime (cum, idx) (@#*tot)
  fi
enddef;

vardef pathpoint (expr frac) (suffix p) =
  convertpath (_pp) p;  pnt[pathtime[frac] (_pp)] (p)
enddef;

def coloraddto (expr clr) (suffix u) (expr v) =
  addto u also v _wc_ clr;
enddef;

def  orto (suffix u) (expr v) =  addto u also v;  enddef;

def coloraddon (expr clr) (suffix v) =
  addto active_plane also v _wc_ clr;
enddef;

def _orto (suffix u, v) =
  addto u also v;
enddef;

vardef interior expr c =
  newpicture (v);
  addto v contour (c.t_);
  v
enddef;

vardef interiors suffix cc =
  newpicture (_ints);
  for _idx = 1 upto cc:
    addto _ints also interior cc[_idx]);
  endfor
  _ints
enddef;

def clipto (suffix vt) expr c =
  if path c:
  clip vt to c;
  fi
enddef;
def clipsto (suffix vt, cc) =
  begingroup
    save _cl, _cl_;  picture _cl, _cl_;  _cl_ := nullpicture;
    for _idx = 1 upto cc:
      _cl := vt;  clip _cl to cc[_idx];  addto _cl_ also _cl;
    endfor
    vt := _cl_;
  endgroup
enddef;

vardef Clipped (suffix vt) expr c =
  setpicture (_Cl) vt;  clipto (_Cl) c;  _Cl
enddef;

vardef picneg (suffix vt) expr c =
  setpicture (_cl) vt;  clip _cl to c;
  newpicture (_pn);
  addto _pn also (interior c ) _wc_ fillcolor;
  addto _pn also _cl _wc_ background;
  _pn
enddef;

def shpath (suffix v) (expr q, f) =
  addto v doublepath (f.t_) withpen (q.t_);
enddef;

numeric minpenwd;
minpenwd := .05bp;  % 1 pixel at 1440dpi
vardef picpath expr d =
  newpicture (v);
  if penwd >= minpenwd:
    shpath (v, drawpen) (d);
  fi
  v
enddef;

def picdot (suffix v) (expr w, p) =
  addto v also
    (w shifted p);
enddef;

vardef setdot (expr apath, sc) =
  if cycle apath:  interior
  else:           picpath
  fi
    (apath scaled emax (sc, minpenwd))
enddef;

vardef shaded (expr clr) expr c =
  if cycle c:
    newpicture (v);
    addto v contour c _wc_ clr;
    v
  else:  picpath c % should we? or just make it null?
  fi
enddef;

vardef fillwith (suffix v) (expr pic, dims, ll, ur) =
  newpicture (b);
  for s = xpart ll step xpart dims until xpart ur:
    addto b also pic shifted (s, 0);
  endfor
  for s = ypart ll step ypart dims until ypart ur:
    addto v also b shifted (0, s);
  endfor
enddef;

def thatchf (suffix v) (expr CT, sp, a, b) =
  begingroup
    setnumeric (_sp) signof (ypart b - ypart a) abs(sp);
    for _y = _sp*( ceiling ((ypart a)/_sp) ) step _sp until ypart b:
      shpath (v, hatchpen)
        ( ( (xpart a, _y)--(xpart b, _y) ) transformed CT );
    endfor
  endgroup
enddef;

def tile (suffix atile) (expr unit, width, height, clipit) =
  picture atile.pic;  atile.pic := nullpicture;
  pair atile.dims;
  atile.dims := (width, height)*unit;
  begingroup
    save active_plane;
    def active_plane =  atile.pic  enddef;
    save ztr, vtr;  transform ztr, vtr;
    ztr := identity scaled unit;  vtr := ztr;
    save xneg, xpos, yneg, ypos;
    xneg := 0;  xpos := width;  yneg := 0;  ypos := height;
    save ClipOn;  boolean ClipOn;
    if clipit:
      ClipOn := true;
      setarray (path) (ClipPath) (rect(origin, atile.dims));
    else:
      ClipOn := false;
    fi
enddef;
def endtile =
    DoClip (active_plane);
  endgroup
enddef;

vardef is_tile (suffix atile) =
  (known atile.pic ) and (picture atile.pic) and
  (known atile.dims) and (pair  atile.dims )
enddef;

vardef pnt@#  (expr p) =  point       @# of p  enddef;
vardef pre@#  (expr p) =  precontrol  @# of p  enddef;
vardef post@# (expr p) =  postcontrol @# of p  enddef;

def getbbox (suffix ll, ur) expr g =
  ll := llcorner g;  ur := urcorner g;
  if showbbox:  noclip ( safedraw rect (ll, ur) );  fi
enddef;

def safedraw =  colorsafedraw (drawcolor)  enddef;
def colorsafedraw (expr clr) expr d =
  begingroup
    setpicture (v) picpath d;
    DoClip (v);  coloraddon (clr, v);
  endgroup
enddef;

def NoCycle (expr s) expr p =
  GBwarn  s & " cannot be applied to an open path."
            & " The path will be drawn instead.";
  safedraw p;
enddef;

def safefill =  colorsafefill (fillcolor)  enddef;
vardef colorsafefill (expr clr) expr c =
  if cycle c:
    setpicture (v) interior c;
    DoClip (v);
    coloraddon (clr, v);
  else:  NoCycle("fill") c;
  fi
enddef;
def safeunfill expr c =
  if cycle c:  noclip (colorsafefill (background) c);
  else:  NoCycle("unfill") c;
  fi
enddef;

def safeclip expr c =
  if cycle c:  clipto (active_plane) c;
  else:  NoCycle("clip") c;
  fi
enddef;

def store (suffix fs) expr f =
hide (
  if (not path f) and (not pair f):
    GBerrmsg ("improper expression type.")
      "The second argument to `store' must be a path or pair.";
  fi
  if not path fs:  path fs;  fi
  fs := f
)
enddef;
vardef stored (suffix fs) expr f =  store (fs) f;  f  enddef;

def drawn =  colordrawn (drawcolor)  enddef;
vardef colordrawn (expr clr) expr f =
  colorsafedraw (clr) (zconv (f));  f
enddef;

def zigzag =  colorzigzag (drawcolor)  enddef;
def colorzigzag (expr clr) =  colorwiggle (false, clr, 0)  enddef;
def sinewave =  colorsinewave (drawcolor)  enddef;
def colorsinewave =  colorwiggle (true)  enddef;

vardef colorwiggle (expr smth, clr, tens, blen, elen, len, wid) expr f =
  convertpath (g) f;
  setuplengtharray (cumlen, totlen, ct) g;
  save B;
  if cycle f:
    B := 0;
  else:
    B := abs(blen)/_rescale_factor;
    totlen := totlen - B - abs(elen)/_rescale_factor;
  fi
  setnumeric (n) 2*round (totlen/len*_rescale_factor);
  if n < 2:
    colorsafedraw (clr) g;
  else:
    save T, U, X, Y, Z, p;
    pair U, X, Y, Z;  path p;
    T := if cycle f:  0  else:  gettime (cumlen, ct) (B) fi;
    Z := pnt[T] (g);
    p :=if not cycle f:  (subpath (0,T) of g)
          if smth:  {curl 0} ..tension tens..  else:  --  fi
        fi
        for i = 1 upto n:
          hide(
            T := gettime (cumlen, ct) (B+(i/n)*totlen);
            X := Z;  Z := pnt[T] (g);
            Y := .5[X,Z];  U := sgn (Z-X);
          )
          (Y + (U zscaled (0, if even i:  -  fi  wid)))
            if smth:  {U}..tension tens..  else:  --  fi
        endfor
        if cycle f:  cycle
        else:  if smth:  {curl 0}  fi  (subpath (T, length g) of g)
        fi;
    newpicture (v);
    shpath (v, drawpen) (p);
    DoClip(v);  coloraddon (clr, v);
  fi
  f
enddef;

def corkscrew =  colorcorkscrew (drawcolor)  enddef;
vardef colorcorkscrew (expr clr, tens, blen, elen, len, wid) expr f =
  convertpath (g) f;
  setuplengtharray (cumlen, totlen, ct) g;
  save B;
  if cycle f:
    B := 0;
  else:
    B := abs(blen)/_rescale_factor;
    totlen := totlen - B - abs(elen)/_rescale_factor;
  fi
  setnumeric (n) round (totlen/len*_rescale_factor);
  if n < 2:
    colorsafedraw (clr) g;
  else:
    save T, U, X, Y, Z, p;
    pair U, X, Y, Z;  path p;
    T := if cycle f:  0  else:  gettime (cumlen, ct) (B) fi;
    Z := pnt[T] (g);
    p :=if (not cycle f) and (B > 0):  (subpath (0,T) of g)--  fi
        for i = 1 upto n:
          hide(
            T := gettime (cumlen, ct) (B+(i/n)*totlen);
            X := Z;  Z := pnt[T] (g);
            Y := .5[X,Z];  U := sgn (Z-X);
          )
          (X + (U zscaled (0,-wid))){ U}..tension tens..
          (Y + (U zscaled (0, wid))){-U}..tension tens..
        endfor
        if cycle f:  cycle
        else:
          {U}(Z + (U zscaled (0,-wid)))
          if elen <> 0:  --(subpath(T, length g) of g)  fi
        fi;
    newpicture (v);
    shpath (v, drawpen) (p);
    DoClip(v);  coloraddon (clr, v);
  fi
  f
enddef;

def filled =  colorfilled (fillcolor)  enddef;
vardef colorfilled (expr clr) expr c =
  colorsafefill (clr) zconv (c);  c
enddef;
vardef unfilled expr c =  safeunfill zconv (c);  c  enddef;
vardef Clip expr c =  safeclip zconv (c);  c  enddef;

numeric shadewd;  shadewd := 0.5bp;
path shadedotpath;
shadedotpath := fullcircle;

vardef shade (expr sp) expr f =
  convertpath (g) f;
  setnumeric (gr) 1 - (.88*abs(shadewd)/sp)**2;
  if not cycle g:  NoCycle("shade") g;
  elseif gr <= 0:  safefill g;
  else:
    colorsafefill (gr*white) g;
  fi
  f
enddef;

polkadotwd := 5bp;
mindotspace := 1bp;
path polkadotpath;  polkadotpath := fullcircle;

vardef polkadot (expr sp) expr f =
  convertpath (g) f;
  if not cycle g:  NoCycle("polkadot") g;
  elseif sp <= emax (2*polkadotwd/3, mindotspace):
    safefill g;
  else:
    setbbox (ll, ur) g;
    save dx, dy, dshift;  pair dshift;
    dx := sp/2;  dy := dx*sqrt 3;
    dshift := (xpart(ur - ll) mod dx, ypart (ur - ll) mod dy)/2;
    save p, dims;  pair p, dims;
    p := ll + dshift;
    dims :=  2(dx, dy);
    setpicture (thepolkadot) setdot (polkadotpath, polkadotwd);
    newpicture (v);
    fillwith (v) (thepolkadot, dims, p, ur);
    fillwith (v) (thepolkadot, dims, p + (dx, dy), ur);
    DoClip (v);  clipto (v) g;
    coloraddon (fillcolor, v);
  fi
  f
enddef;

def thatch =  colorthatch (hatchcolor)  enddef;
vardef colorthatch (expr clr) (expr sp, theta) expr f =
  convertpath (g) f;
  if not cycle g:  NoCycle("hatch") g;
  elseif sp <= abs(hatchwd):  colorsafefill (clr) g;
  else:
    newpicture (v);
    setbbox (ll, ur) g rotated -theta;
    thatchf (v, identity rotated theta, sp, ll, ur);
    DoClip (v);  clipto (v) (g);
    coloraddon (clr, v);
  fi
  f
enddef;

def hhatch (expr sp) =  thatch (sp, 0)   enddef;
def vhatch (expr sp) =  thatch (sp, 90)  enddef;
def lhatch (expr sp) =  thatch (sp, -45)  enddef;
def rhatch (expr sp) =  thatch (sp, 45)  enddef;

def xhatch =  colorxhatch (hatchcolor)  enddef;
def colorxhatch (expr clr, sp) =
  colorthatch (clr) (sp, 45) colorthatch (clr) (sp, -45)
enddef;

vardef NoTile (suffix atile) expr g =
  GBwarn str atile & " is not a valid tile for tess()."
                   & " The path will be drawn instead.";
  safedraw g;
enddef;
vardef tess (suffix atile) expr c =
  convertpath (_g) c;
  if not cycle _g:  NoCycle("tess") _g;
  elseif not is_tile (atile):  NoTile (atile) _g;
  else:
    setbbox (_ll, _ur) _g;
    newpicture (_ts);
    fillwith (_ts) (atile.pic, atile.dims, _ll, _ur);
    DoClip (_ts);  clipto (_ts) _g;
    _orto (active_plane, _ts);
  fi
  c
enddef;

if unknown segment_split:  segment_split := 8;  fi
if unknown dashsize:  dashsize  := 3bp;  fi
if unknown dashgap:  dashgap := dashsize + 2penwd;  fi
if unknown dash_finish:  dash_finish := .5;  fi
if unknown dash_start:  dash_start := .5;  fi
if unknown _rescale_factor:  _rescale_factor := 0.1in;  fi

numeric last_dot_size;  last_dot_size := 0;
vardef gendashed (suffix pat) expr f =
  convertpath (_g) f;
  save _dpat;
  if not mkdasharrays (pat) (_dpat):
    GBwarn "Dash pattern " & str pat
      & " undefined. Path will be drawn instead.";
    safedraw _g;
  elseif _dpat.rep < 2:
    safedraw _g;
  else:
    save _dl;
    forsuffixes _s = start, rep, finish:
      _dl._s := 0;
      for i = 1 upto _dpat._s:
        _dpat._s[i] := _dpat._s[i]/_rescale_factor;
        _dl._s := _dl._s + _dpat._s[i];
      endfor
    endfor

    if _dl.rep = 0:
      GBwarn "Dash pattern " & str pat & " has length 0. "
        & "Path will be drawn instead.";
      safedraw _g;
    else:
      setuplengtharray (_cumlen, _totlen, _ct) _g;
      save _n, _sf, _no_dots;
      boolean _no_dots;  _no_dots := true;
      _sf := scale_adjust (_n, _dl) (_totlen);
      if _n < 0:  safedraw _g;
      else:
        forsuffixes _s = start, rep, finish:
          for _i = 1 upto _dpat._s:
            if (_dpat._s[_i] = 0) and _no_dots:  _no_dots := false;
            else:  _dpat._s[_i] := _dpat._s[_i]*_sf;
            fi
          endfor
          _dl._s := _dl._s*_sf;
        endfor
        if _no_dots:
        else:
          if unknown plot_pic:
            save plot_pic;  path plot_pic;
            plot_pic := dotpath;
          fi;
          last_dot_size :=
            if known plot_pic.size:  plot_pic.size  else:  penwd fi;
          setpicture (dashingdot) makesymbol (plot_pic, last_dot_size);
        fi
        save _t, _d, _v;
        picture _v;  _v := nullpicture;
        _d0 := 0;  _t0 := 0;
        dashit (_dpat.start) (_v);

        if _n > 0:
          save _m;  _m := ceiling sqrt(_n);
          for _j = 0 step _m until _n - 1:
            for _i = 0 upto _m - 1:
              exitif (_i + _j) > _n - 1;
              _d0 := _dl.start + (_j + _i)*_dl.rep;
              _t0 := gettime (_cumlen, _ct) (_d0);
              dashit (_dpat.rep) (_v);
            endfor
            DoClip (_v);
            coloraddon (drawcolor, _v);
            _v := nullpicture;
          endfor
        fi

        _d0 := _totlen - _dl.finish;
        _t0 := gettime (_cumlen, _ct) (_d0);
        dashit (_dpat.finish) (_v);
        DoClip (_v);
        coloraddon (drawcolor, _v);
      fi
    fi
  fi
  f
enddef;

vardef makelengtharray (suffix clen) suffix p =
  setsplit (_s) segment_split;
  numeric clen[];
  clen := _s * length p;  clen0 := 0;
  for _i = 1 upto clen:
    clen[_i] := clen[_i-1] + abs (pnt[_i/_s] (p) - pnt[(_i-1)/_s] (p)) /
        _rescale_factor;
  endfor
  clen[clen]
enddef;

vardef scale_adjust (suffix n, pl) (expr lngth) =
  n := (lngth - pl.start - pl.finish)/pl.rep;
  n := if n < 0:  -1  else:  round(n) fi;
  lngth/(pl.start + emax (n, 0)*pl.rep + pl.finish)
enddef;

vardef gettime (suffix arr, ct) (expr lngth) =
  setnumeric (_gtl) emax (arr[ct], emin (arr[arr], lngth));
  setsplit (_s) segment_split;
  forever:  exitif ( (arr[ct] <= _gtl) and (_gtl <= arr[ct+1]) );
    next ct;
  endfor
  if arr[ct] = arr[ct+1]:  ct
  else:  ( ct + (_gtl - arr[ct]) / (arr[ct+1] - arr[ct]) )
  fi  /_s
enddef;

def next suffix X =  X :=  X + 1;  enddef;

def dashit (suffix pos) (suffix pic) =
  for _k = 1 upto pos:
    if odd _k:
      if pos[_k] = 0:
        _d1 := _d0;  _t1 := _t0;
        picdot (pic, dashingdot, pnt [_t0] (_g));
      else:
        _d1 := _d0 + pos[_k];
        _t1 := gettime (_cumlen, _ct) (_d1);
        shpath (pic, drawpen) (subpath (_t0, _t1) of _g);
      fi
    else:
      _d0 := _d1 + pos[_k];
      _t0 := gettime (_cumlen, _ct) (_d0);
    fi
  endfor
enddef;

def dashpat (suffix pat) (text t) =
  list (pat) (t);
  if (pat = 0) or (odd (pat) and (pat > 1)):
    pat[incr pat] := 0;
  fi
enddef;

vardef mkdasharrays (suffix src, dest) =
  save _bad;  boolean _bad;  _bad := false;
  forsuffixes _s = start, rep, finish:
    numeric dest._s, dest._s[];
    boolean _bad._s;
    if knownnumericarray src._s:
      copyarray (src._s) (dest._s);
      _bad._s := false;
    else:
      _bad := _bad._s := true;
    fi
  endfor
  % _bad = one of the three arrays not copied.
  if _bad:
    if knownnumericarray src:  _bad := false;
      if _bad.rep:      % make dest.rep = src
        copyarray (src) (dest.rep);
      fi
      if _bad.start:    % shrink first dash to get dest.start
        copyarray (src) (dest.start);
        dest.start1 := dash_start*src1;
      fi
      if _bad.finish:   % use partial first dash for dest.finish
        dest.finish := 1;
        dest.finish1 := dash_finish*src1;
      fi
    fi
  fi
  not _bad
enddef;

vardef Dashed (expr dlen, dgap) expr f =
  save dashes;  dashpat (dashes) (dlen, dgap);
  gendashed (dashes) f
enddef;

def DASHED =  Dashed  enddef;

vardef doplot (expr spath, sc, dgap) expr f =
  save dots;  dashpat (dots) (0, dgap);
  setpicture (plot_pic) makesymbol (spath, sc);
  plot_pic.size := sc;
  gendashed (dots) f
enddef;

path dotpath;  dotpath := fullcircle;
def dotted =  doplot (dotpath)  enddef;

vardef plotnodes (expr symbol, size) expr f =
  if size > 0:
    save pln;  pair pln[];
    pln := 0;
    for _a = 0 upto (length f) if cycle f:  - 1 fi:
      pln[incr pln] := pnt[_a] (f);
    endfor
    dosymbols (drawcolor, symbol, size) (pln);
  fi
  f
enddef;

def showcontrols =  colorshowcontrols (pointcolor)  enddef;
vardef colorshowcontrols (expr clr, syma, symb, size) expr f =
  save shpre, shpost;
  pair shpre[], shpost[];
  shpre := 0;  shpost := 0;
  for a = 0 upto (length f) if cycle f:  - 1 fi:
    shpre [incr shpre]  := pre [a] (f);
    shpost[incr shpost] := post[a] (f);
    colorsafedraw (clr)
      (zconv (shpre[shpre]--pnt[a](f)--shpost[shpost]));
  endfor
  if size > 0:
    if not numeric syma:  dosymbols (clr, syma, size) (shpre) ;  fi
    if not numeric symb:  dosymbols (clr, symb, size) (shpost);  fi
  fi
  f
enddef;

def doubledraw =  colordoubledraw (drawcolor)  enddef;
vardef colordoubledraw (expr clr, sep) expr f =
  convertpath (g) f;
  colorsafedraw (clr) (parapath ( sep/2) g);
  colorsafedraw (clr) (parapath (-sep/2) g);
  f
enddef;

vardef centerit (expr pic) =
   pic shifted -(0.5[urcorner pic, llcorner pic])
enddef;

vardef makesymbol (expr spath, sc) =
  if picture spath :
    spath
  elseif path spath:  setdot (spath, sc)
  elseif string spath:
    spath infont defaultfont scaled defaultscale
  else:
    GBwarn "Undefined symbol for plotting, "
         & "dotpath will be used instead.";
    setdot (dotpath, sc)
  fi
enddef;

vardef bpoint (expr ptwd, b) =
  fullcircle scaled ptwd shifted b
enddef;

def pointd (expr ptwd, filled) (text t) =
  if filled:
    plotsymbol (SolidCircle, ptwd) (t);
  else:
    begingroup;
      setboolean (clearsymbols) true;
      plotsymbol (Circle, ptwd) (t);
    endgroup
  fi
enddef;

boolean clearsymbols;  clearsymbols := false;
vardef clearable (expr pth) =
  if path pth:
    ( pnt0 (pth) = pnt[length pth] (pth) ) and (not cycle pth)
      and (length pth > 0)
  else:  false
  fi
enddef;

def clearopenpath expr f =
  if clearable (f):  safeunfill f & cycle;  fi
enddef;

def plotsymbol =  colorplotsymbol (pointcolor)  enddef;
def colorplotsymbol (expr clr, spath, sc) (text t) =
  if sc > 0:
  begingroup
    setpairs (_cpls) (t);
    if _cpls > 0:  dosymbols (clr, spath, sc) (_cpls);  fi
  endgroup
  fi
enddef;

def dosymbols (expr clr, spath, sc) (suffix arr) =
  if clearsymbols and  clearable (spath):
    addsymbols (background, makesymbol (spath&cycle, sc)) (arr);
  fi
  addsymbols (clr, makesymbol (spath, sc)) (arr);
enddef;

def addsymbols (expr clr, symb) (suffix arr) =
  newpicture (_pls);
  for _idx = 1 upto arr:
    picdot (_pls, symb, zconv (arr[_idx]));
  endfor
  DoClip (_pls);  coloraddon (clr, _pls);
enddef;

def putimage (suffix pic) (text t) =
  newpicture (_pti);
  for _itm = t:
    addto _pti also
      (pic shifted zconv (_itm));
    DoClip (_pti);  addto active_plane also _pti;
    _pti := nullpicture;
  endfor
enddef;

def arrowdraw (expr hlen) (expr f) =
  store (curpath) headpath (hlen, 0, 0) drawn f;
enddef;

def xaxis (expr hlen) =  arrowdraw (hlen) ((xneg, 0)--(xpos, 0));
enddef;
def yaxis (expr hlen) =  arrowdraw (hlen) ((0, yneg)--(0, ypos));
enddef;
def axes (expr hlen) =  xaxis (hlen);  yaxis (hlen);  enddef;

laxis := baxis := raxis := taxis := 0;

vardef axisline.x =  (xneg + laxis, 0)--(xpos - raxis, 0)  enddef;
vardef axisline.y =  (0, yneg + baxis)--(0, ypos - taxis)  enddef;
vardef axisline.l =  axisline.y shifted (xneg + laxis, 0)  enddef;
vardef axisline.b =  axisline.x shifted (0, yneg + baxis)  enddef;
vardef axisline.r =  axisline.y shifted (xpos - raxis, 0)  enddef;
vardef axisline.t =  axisline.x shifted (0, ypos - taxis)  enddef;

vardef axis@# (expr len) =  headpath (len, 0, 0) axisline@#  enddef;

vardef borderrect =
  rect((xneg+laxis,yneg+baxis),(xpos-raxis,ypos-taxis))
enddef;
numeric inside, outside, centered, onleft, onright, ontop, onbottom;
inside   := -2;
outside  := -1;
onright  :=  1;
onleft   :=  2;
centered := .5[onright, onleft];
onbottom := onright;
ontop    := onleft;
ltick := rtick := ttick := btick := inside;
xtick := ytick := centered;

vardef axismarks (expr inang, tp, loc, pdir) (expr len) (text t) =
 save _tp, _U, _P, _tic, _ticang;
 pair _U, _P;  path _tic;
 _ticang := if tp < 0:  inang  else:  90 fi;
 _tp := abs(tp) - 1;
 _U := unitvector (vconv (pdir)) rotated _ticang;
 _tic := (-_U--(0,0)) shifted (_tp*_U) scaled len;
 for _a = t:
   safedraw (_tic shifted zconv (loc + _a*pdir));
 endfor
enddef;

def xmarks =  axismarks ( 90, xtick, origin, right)  enddef;
def ymarks =  axismarks (-90, ytick, origin, up)    enddef;
def lmarks =  axismarks (-90, ltick, (xneg + laxis, 0), up)    enddef;
def bmarks =  axismarks ( 90, btick, (0, yneg + baxis), right)  enddef;
def rmarks =  axismarks ( 90, rtick, (xpos - raxis, 0), up)    enddef;
def tmarks =  axismarks (-90, ttick, (0, ypos - taxis), right)  enddef;

path griddotpath;  griddotpath := fullcircle;
def grid =  vargrid (0.5bp)  enddef;
vardef vargrid (expr dsize, xsp, ysp) =
  save gdot, gridpic;  picture gdot, gridpic;
  gdot := setdot (griddotpath, dsize);
  gridpic := nullpicture;
  for n = ceiling ((xneg + laxis)/xsp) upto floor ((xpos - raxis)/xsp):
  for m = ceiling ((yneg + baxis)/ysp) upto floor ((ypos - taxis)/ysp):
    picdot (gridpic, gdot, zconv ((n*xsp, m*ysp)));
  endfor
  endfor
  coloraddon (pointcolor, gridpic);
enddef;
def vgrid =  vargrid  enddef;

def hgridlines (expr ysp) =
  for n = ceiling ((yneg + baxis)/ysp) upto floor ((ypos - taxis)/ysp):
    safedraw zconv ((xneg + laxis, n*ysp)--(xpos - raxis, n*ysp));
  endfor
enddef;
def vgridlines (expr xsp) =
  for n = ceiling ((xneg + laxis)/xsp) upto floor ((xpos - raxis)/xsp):
    safedraw zconv ((n*xsp, yneg + baxis)--(n*xsp, ypos - taxis));
  endfor
enddef;
def gridlines (expr xsp, ysp) =
  vgridlines (xsp);  hgridlines (ysp);
enddef;

def vectorfield (expr len, xsp, ysp) (text fcn) (text cond) =
  save _vf, _is_OK;
  vardef _vf (expr x,y) =  ((0,0)--(fcn)) shifted (x,y)  enddef;
  vardef _is_OK (expr x,y) =  cond  enddef;
  mkvectorfield (len, xsp, ysp) (_vf, _is_OK);
enddef;

vardef mkvectorfield (expr len, xsp, ysp) (suffix vf, isOK) =
  for n = ceiling ((xneg + laxis)/xsp) upto floor ((xpos - raxis)/xsp):
  for m = ceiling ((yneg + baxis)/ysp) upto floor ((ypos - taxis)/ysp):
    if isOK (n*xsp,m*ysp):  arrowdraw (len) (vf(n*xsp,m*ysp));  fi
  endfor
  endfor
enddef;

def plrvectorfield (expr len, rsp, tsp) (text fcn) (text cond) =
  save _vf, _is_OK, _A, _B, _C, _D;
  _A := xneg + laxis;  _B := xpos + raxis;
  _C := yneg + baxis;  _D := ypos + taxis;
  vardef _vf (expr r,t) =  ((0,0)--(fcn)) shifted (r*dir t)  enddef;
  vardef _is_OK (expr r,t) =
    save _X, _Y;  _X := r*cosd t;  _Y := r*sind t;
    (cond) and (_A < _X) and (_X < _B) and (_C < _Y) and (_Y < _D)
  enddef;
  mkplrvectorfield (len, rsp, tsp) (_vf, _is_OK);
enddef;

vardef mkplrvectorfield (expr len, rsp, tsp) (suffix vf, isOK) =
  save rmin, rmax, tmin, tmax;
  getpolarbounds;
  if rmin = 0:
    if isOK (0,tmin):  arrowdraw (len) (vf (0,tmin));  fi
    rmin := rsp;
  fi
  for n = ceiling (rmin/rsp) upto floor (rmax/rsp):
  for m = ceiling (tmin/tsp) upto floor (tmax/tsp):
    if isOK (n*rsp,m*tsp):  arrowdraw (len) (vf (n*rsp,m*tsp));  fi
  endfor
  endfor
enddef;

def patcharcs (suffix X) (expr rstart, rstop, rstep, tstart, tstop) =
  for rad = (if rstart = 0:  rstep  else:  rstart fi)
      step rstep until rstop:
    orto (X, picpath zconv (arcplr (origin, tstart, tstop, rad)) );
  endfor
enddef;
def patchrays (suffix X) (expr tstart, tstop, tstep, rstart, rstop) =
  for _ang = tstart step tstep until tstop:
    orto (X) (picpath zconv ((rstart*dir _ang)--(rstop*dir _ang)));
  endfor
enddef;

def plrpatch (expr rstart, rstop, rstep, tstart, tstop, tstep) =
begingroup
  newpicture (v);
  patcharcs (v) (rstart, rstop, rstep, tstart, tstop);
  coloraddon (drawcolor, v);
  v := nullpicture;
  patchrays (v) (tstart, tstop, tstep, rstart, rstop);
  coloraddon (drawcolor, v);
endgroup
enddef;

def gridarcs (expr rstep) =
  beginpolargrid;
    if rmin = 0:
      picdot (gridpic, setdot (griddotpath, penwd), zconv (origin));
    fi
    rmin := rstep * floor (rmin/rstep + 1);
    rmax := rstep * ceiling (rmax/rstep - 1);
    patcharcs (gridpic) (rmin, rmax, rstep, tmin, tmax);
  endpolargrid (drawcolor, .5penwd);
enddef;

def gridrays (expr tstep) =
  beginpolargrid;
    tmin := tstep * ceiling (tmin/tstep);
    tmax := tstep * floor (tmax/tstep);
    patchrays (gridpic) (tmin, tmax, tstep, rmin, rmax);
  endpolargrid (drawcolor, .5penwd);
enddef;

def polargrid (expr rstep, tstep) =
  gridarcs (rstep);  gridrays (tstep);
enddef;

def polargridpoints (expr dsize, rstep, tstep) =
  beginpolargrid;
    setpicture (gdot) setdot (griddotpath, dsize);
    if rmin = 0:
      picdot (gridpic, gdot, zconv (origin));
      rmin := rstep;
    fi
    for n = ceiling (rmin/rstep) upto floor (rmax/rstep):
    for m = ceiling (tmin/tstep) upto floor (tmax/tstep):
      picdot ( gridpic, gdot, zconv ( polar ((n*rstep, m*tstep)) ) );
    endfor
    endfor
  endpolargrid (pointcolor, .5dsize);
enddef;

def beginpolargrid =
begingroup;
  save rmax, rmin, tmax, tmin;
  getpolarbounds;
  newpicture (gridpic);
enddef;

def getpolarbounds =
    save p, r, t;
    pair p[];
    p0 := (xneg, yneg);  p1 := (xneg, ypos);
    p2 := (xpos, ypos);  p3 := (xpos, yneg);
    r0 := abs(p0);  rmax := r0;
    for j = 1 upto 3:
      r[j] := abs(p[j]);
      if rmax < r[j]:  rmax := r[j];  fi
    endfor
    rmin := 0;
    if (xneg < 0) and (xpos > 0) and (yneg < 0) and (ypos > 0):
      tmin := 0;  tmax := 360;
    elseif (p0 = origin):  tmin :=    0;  tmax :=  90;
    elseif (p1 = origin):  tmin :=  -90;  tmax :=   0;
    elseif (p2 = origin):  tmin := -180;  tmax := -90;
    elseif (p3 = origin):  tmin :=   90;  tmax := 180;
    else:
      tmax := tmin := t0 := angle p0;
      for j = 1 upto 3:
        t := t0 + anglefromto (p0, p[j]);
        if tmax < t:  tmax := t;  fi
        if tmin > t:  tmin := t;  fi
      endfor
      if (xneg < 0) and (0 < xpos):
        rmin := emin (abs(yneg), abs(ypos));
      elseif (yneg < 0) and (0 < ypos):
        rmin := emin (abs(xneg), abs(xpos));
      else:
        rmin := min (r0, r1, r2, r3);
      fi
    fi
enddef;


def endpolargrid (expr clr, size)=
    clipto (gridpic) rect ( zconv ((xneg, yneg)) - size*(1,1),
                            zconv ((xpos, ypos)) + size*(1,1) );
    coloraddon (clr, gridpic);
  endgroup
enddef;

vardef polarpatch (expr rstart, rstop, rstep, tstart, tstop, tstep) =
  plrpatch (rstart, rstop, rstep, tstart, tstop, tstep);
  safedraw zconv ( arcplr (origin, tstart, tstop, rstop) );
  safedraw zconv ( ((rstart, 0)--(rstop, 0)) rotated tstop );
enddef;

vardef rect (expr ll, ur) =
  ll--(xpart ur, ypart ll)--ur--(xpart ll, ypart ur)--cycle
enddef;
vardef triangle (expr A, B, C) =  A--B--C--cycle  enddef;

vardef regularpolygon (expr n) (suffix Bob) (text eqns) =
  pair Bob[];  Bob := emax (round (abs (n)), 2);
  eqns;
  for _uncle = 1 upto Bob - 1:
    (Bob1 - Bob0) rotated (360/Bob*_uncle) = Bob[_uncle+1] - Bob0;
  endfor
  mkpoly (true) (Bob)
enddef;

vardef altitudept expr n of t =
  save A, B, C, zz;  pair A, B, C, zz;
  B := pnt[n + 1] (t);
  C := pnt[n + 2] (t);
  zz = whatever[B,C];
  zz = pnt[n](t) + whatever*((C-B) rotated 90);
  zz
enddef;

vardef altitude expr n of t =
  (pnt[n](t))--(altitudept n of t)
enddef;

vardef medianpt expr n of t =
  0.5[pnt[n + 1] (t), pnt[n + 2] (t)]
enddef;

vardef median expr n of t =
  (pnt[n](t))--(medianpt n of t)
enddef;

vardef anglebisectorpt expr n of t =
  save A, B, C;  pair A, B, C;
  A := pnt[n    ] (t);
  B := pnt[n + 1] (t);
  C := pnt[n + 2] (t);
  save zz;  pair zz;
  zz = whatever[B,C];
  zz = A + whatever*((B-A) rotated (.5*cornerangle (A,B,C)));
  zz
enddef;

vardef anglebisector expr n of t =
  (pnt[n](t))--(anglebisectorpt n of t)
enddef;

vardef anglefromto (expr u, v) =
  if (u = origin) or (v = origin):  0
  else:  angle (v rotated (-angle u))
  fi
enddef;

vardef cornerangle (expr A, B, C) =
  if (A = B) and (B = C) :  60
  elseif (A=B) or (A=C) :  90
  else:  anglefromto (B - A, C - A)
  fi
enddef;

vardef mkpath (expr smooth, tens, cyclic) (suffix pts) =
  if smooth:  mksmooth (tens)
  else:      mkpoly
  fi  (cyclic, pts)
enddef;

vardef mkpoly (expr cyclic) (suffix pts) =
  for _i = 1 upto pts-1:  pts[_i]-- endfor
  pts[pts] if cyclic:  -- cycle  else:  {0,0}  fi
enddef;

vardef polyline (expr cyclic) (text t) =
  setpairs (_pl) (t);
  if _pl=0:  NoPoints ("polyline", _pl);  fi
  mkpoly (cyclic, _pl)
enddef;

def NoPoints (expr s) (suffix pts) =
  GBwarn  s & " attempted with empty list.";  pts[incr pts] := origin;
enddef;

vardef turtle (text t) =
  setnumeric (_tu) 0;
  pair _tu[];  _tu0 := origin;
  for _a = t:  _tu[incr _tu] := _tu[_tu - 1] + _a;  endfor
  if _tu = 0:  NoPoints("turtle", _tu);  fi
  mkpoly (false, _tu)
enddef;

vardef mksmooth (expr tens, cyclic) (suffix pts) =
  if pts = 1:  onepointpath (cyclic, pts1)
  else:
    settension (_tn) tens;  fixtension (_tn);
    pts1  if cyclic:  {pts[2]-pts[pts]}  fi
    for _i = 2 upto pts-1:
      ..tension _tn..pts[_i]{pts[_i+1]-pts[_i-1]}
    endfor
    ..tension _tn..pts[pts]
    if cyclic:  {pts[1]-pts[pts-1]}..tension _tn..cycle  fi
  fi
enddef;

vardef mktenser (expr tens, cyclic) (suffix pts) =
  if pts = 1:  onepointpath (cyclic, pts1)
  else:
    settension (_tn) tens;  fixtension (_tn);
    pts1  if cyclic:  {pts[2]-pts[pts]}  fi
    for _i = 2 upto pts-1:
      ..tension atleast _tn..pts[_i]{pts[_i+1]-pts[_i-1]}
    endfor
    ..tension atleast _tn..pts[pts]
    if cyclic:  {pts[1]-pts[pts-1]}..tension atleast _tn..cycle  fi
  fi
enddef;

vardef mkconvex (expr tens, cyclic) (suffix pts) =
  save _B, _d, _tmp;  pair _d[];
  settension (_tn) tens;  fixtension (_tn);
  if pts < 4:  mktenser (_tn, cyclic) (pts)
  else:
    for _j = 2 upto pts - 1:
      _B[_j] := sqrt(abs((pts[_j]-pts[_j-1])xprod(pts[_j+1]-pts[_j])));
    endfor
    if cyclic:
      _B1     := sqrt(abs((pts1    -  pts[pts])xprod(pts2 - pts1)));
      _B[pts] := sqrt(abs((pts[pts]-pts[pts-1])xprod(pts1 - pts[pts])));
    else:
      _B1     := _B2;
      _B[pts] := _B[pts-1];
    fi
    for _j = 2 upto pts - 1:
      _tmp := _B[_j-1] + _B[_j+1];
      _d[_j] :=
        if _tmp = 0:  origin % signal to use curl1
        else:
          ( _B[_j+1]*(pts[_j] - pts[_j-1]) +
            _B[_j-1]*(pts[_j+1] - pts[_j]) )/_tmp
        fi;
    endfor
    if cyclic:
      _tmp := _B[pts] + _B2;
      _d1 :=
        if _tmp = 0:  origin
        else:
          (_B2*(pts1 - pts[pts]) + _B[pts]*(pts2 - pts1))/_tmp
        fi;
      _tmp := _B[pts-1] + _B1;
      _d[pts] :=
        if _tmp = 0:  origin
        else:
          ( _B1*(pts[pts] - pts[pts-1]) +
            _B[pts-1]*(pts1 - pts[pts]) )/_tmp
        fi;
    else:
      _d1 := origin;  _d[pts] := origin;
    fi
    pts1
    for _j = 1 upto pts-1:
      {if _d[_j] = origin:  curl1  else:  _d[_j] fi}
      ..tension atleast _tn..pts[_j+1]
    endfor
      {if _d[pts] = origin:  curl1  else:  _d[pts] fi}
    if cyclic:  ..tension atleast _tn..cycle  fi
  fi
enddef;

numeric default_tension;  default_tension := 1;
def curve =  tcurve (default_tension)  enddef;
vardef tcurve  (expr tens, cyclic) (text t) =
  setpairs (_tc) (t);  mksmooth (tens, cyclic, _tc)
enddef;

def ccurve =  tccurve (default_tension)  enddef;
vardef tccurve (expr tens, cyclic) (text t) =
  setuniquepairs (_tcc) (t);  mkconvex (tens, cyclic, _tcc)
enddef;

vardef mkbezier (expr tens, cyclic) (suffix pts) =
  settension (_tn) tens;  fixtension (_tn);
  pts1
    for _i = 2 upto pts:  ..tension _tn..pts[_i] endfor
    if cyclic:  ..tension _tn..cycle  else:  {0,0}  fi
enddef;

def bezier =  tbezier (default_tension)  enddef;
vardef tbezier (expr tens, cyclic) (text t) =
  setpairs (_tbs) (t);
  if _tbs=0:  NoPoints ("bezier", _tbs);  fi
  mkbezier (tens, cyclic) (_tbs)
enddef;

vardef mkqbezier (expr cyclic) (suffix pts) =
  pts1
  if pts=1:  {0,0}
  else:
    for _i = 2 step 2 until pts - 1:
      ..controls 1/3[pts[_i], pts[_i-1] ] and 1/3[pts[_i], pts[_i+1] ]..
      pts[_i+1]
    endfor
    if cyclic:
      ..controls 1/3[ pts[pts], pts[pts - 1] ]
        and 1/3[ pts[pts], pts1 ]..cycle
    fi
  fi
enddef;

vardef qbezier (expr cyclic) (text t) =
  setpairs (_qbz) (t);
  if _qbz=0:  NoPoints ("qbezier", _qbz);  fi
  if _qbz=1:  onepointpath (cyclic, _qbz1)
  else:
    if (cyclic and odd _qbz) or (not cyclic and even _qbz):
      _qbz[incr _qbz] := _qbz[_qbz-1];
    fi
    mkqbezier (cyclic) (_qbz)
  fi
enddef;

vardef fcncontrol (expr ftens, X, Y, Z) =
  Y if (xpart(Z-Y) <> 0) and (xpart(Y-X) <> 0):
      + xpart(Z-Y)/3/xpart(Z-X)*(Z - X)/ftens  fi
enddef;

vardef mkfcnpath (expr ftens) (suffix q) =
  settension (_tn) ftens;
  if _tn <= 0:  _tn := 1;  fi
  for _i = 1 upto q - 1:
    q[_i]..controls fcncontrol (_tn) (q[_i-1], q[_i],  q[_i+1])
           and fcncontrol (_tn) (q[_i+2], q[_i+1], q[_i])..
  endfor
  q[q]{0,0}
enddef;

def fcncurve =  functioncurve (default_tension)  enddef;
def tfcncurve =  functioncurve  enddef;
vardef functioncurve (expr ftens) (text t) =
  settension (_ftens) ftens;  if _ftens < 1/3:  _ftens := 1/3;  fi
  setuniquepairs (_fc) (t);
  if _fc > 1:  _fc0 :=  _fc1;  _fc[_fc+1] := _fc[_fc];  fi
  mkfcnpath (_ftens) (_fc)
enddef;

def openqbs  =  qspline (false)  enddef;
def closedqbs =  qspline (true)  enddef;

vardef mkqbs (suffix b) =
  0.5[ b1, b2]
  if b<3:  {0,0}
  else:
    for _i = 2 upto b-1:
      ..controls 1/6[ b[_i], b[_i-1] ] and 1/6[ b[_i], b[_i+1] ]..
      0.5[ b[_i], b[_i+1] ]
    endfor
  fi
enddef;

vardef qspline (expr cyclic) (text t) =
  setpairs (_qs) (t);
  if _qs=0:  NoPoints ("qspline", _qs);  fi
  if _qs=1:  _qs[incr _qs] := _qs1;  fi
  if cyclic:
    _qs[incr _qs] := _qs1;  _qs[incr _qs] := _qs2;
  fi
  mkqbs (_qs) if cyclic:  & cycle  fi
enddef;
vardef mkcbs (suffix b) =
  (b[1]+4b[2]+b[3])/6
  if b < 4:  {0,0}
  else:
    for _i = 3 upto b-1:
      ..controls 1/3[ b[_i-1], b[_i] ] and 1/3[ b[_i], b[_i-1] ]
      .. (b[_i-1] + 4b[_i] + b[_i+1])/6
    endfor
  fi
enddef;

def mkopencbs =  mkcbs  enddef;
vardef mkclosedcbs (suffix b) =
  mkcbs (b) & opencbs (b[b-2],b[b-1],b[b], b1, b2, b3) & cycle
enddef;

def opencbs  =  cspline (false)  enddef;
def closedcbs =  cspline (true)  enddef;

vardef cspline (expr cyclic) (text t) =
  setpairs (_cs) (t);
  if _cs=0:  NoPoints ("cspline", _cs);  fi
  for _idx = _cs upto 2:  _cs[incr _cs] := _cs[_idx];  endfor
  if cyclic:
    for _idx = 1 upto 3:  _cs[incr _cs] := _cs[_idx];  endfor
  fi
  mkcbs (_cs) if cyclic:  & cycle  fi
enddef;
def init_spline_eqns (suffix pts) =
  save _spl_pre, _spl_post;
  pair _spl_pre[], _spl_post[];
  for j= 2 upto pts - 1:
   _spl_post[j] + _spl_pre[j] = 2pts[j];
   _spl_pre[j+1]+2_spl_pre[j] = 2_spl_post[j]+_spl_post[j-1];
  endfor
enddef;

def closed_spline_eqns (suffix pts) =
  _spl_post1 + _spl_pre1 = 2pts1;
  _spl_post[pts] + _spl_pre[pts] = 2pts[pts];
  _spl_pre2 + 2_spl_pre1 = 2_spl_post1 + _spl_post[pts];
  _spl_pre1+2_spl_pre[pts] = 2_spl_post[pts]+_spl_post[pts-1];
enddef;

def relaxed_spline_eqns (suffix pts) =
  _spl_pre2 + pts1 = 2_spl_post1;
  pts[pts] + _spl_post[pts-1] = 2_spl_pre[pts];
enddef;

vardef mksplinepath (expr closed) (suffix pts) =
  pts1..controls _spl_post1 and
  for j = 2 upto pts if not closed:  -1 fi:
    _spl_pre[j]..pts[j]..controls _spl_post[j] and
  endfor
    if closed:  _spl_pre1..cycle  else:  _spl_pre[pts]..pts[pts]  fi
enddef;

def mkspline (expr closed) (suffix pts) =
  init_spline_eqns (pts);
  if closed:  closed_spline_eqns (pts);
  else:     relaxed_spline_eqns (pts);
  fi
  mksplinepath (closed) (pts)
enddef;

vardef dospline (expr closed) (text the_list) =
  setpairs (_sp) (the_list);
  if _sp=0:  NoPoints ("dospline", _sp);  fi
  if _sp=1:  _sp[incr _sp] := _sp1;  fi
  mkspline (closed) (_sp)
enddef;

def init_fcnspl_eqns (suffix pts) =
  save _dx, _sl;  numeric _dx[], _sl[];
  _dx1 := xpart (pts2 - pts1);
  for j = 2 upto pts - 1:
    _dx[j] := xpart (pts[j+1] - pts[j]);
    _sl[j + 1]*_dx[j] + _sl[j-1]*_dx[j-1] + 2_sl[j]*(_dx[j] + _dx[j-1])
            = 3*ypart(pts[j+1] - pts[j-1]);
  endfor
enddef;

def periodic_fcnspl_eqns (suffix pts) =
  _sl1 = _sl[pts];
  _sl2*_dx1 + 2_sl1*_dx1 + 2_sl[pts]*_dx[pts-1] + _sl[pts-1]*_dx[pts-1]
          = 3 * ypart (pts[2] - pts[pts-1]);
enddef;

def relaxed_fcnspl_eqns (suffix pts) =
  _sl2*_dx1 + 2_sl1*_dx1 = 3 * ypart(pts2 - pts1);
  _sl[pts-1]*_dx[pts-1] + 2_sl[pts]*_dx[pts-1]
        = 3 * ypart(pts[pts] - pts[pts-1]);
enddef;

vardef mkfcnsplpath (suffix pts) =
  pts1..controls (pts1 + (1, _sl1)/3*_dx1) and
    for j = 2 upto pts - 1:
      (pts[j] - (1, _sl[j])/3*_dx[j-1]) ..pts[j]..
        controls (pts[j] + (1,_sl[j])/3*_dx[j]) and
    endfor
    (pts[pts] - (1,_sl[pts])*_dx[pts-1]/3)..pts[pts]
enddef;

vardef mkfcnspline (expr periodic) (suffix pts) =
  init_fcnspl_eqns (pts);
  if periodic:  periodic_fcnspl_eqns (pts);
  else:         relaxed_fcnspl_eqns (pts);
  fi
  mkfcnsplpath (pts)
enddef;

vardef fcnspline (expr periodic) (text the_list) =
  setpairs (_fs) (the_list);
  if _fs<2:
    if _fs=0:  NoPoints ("fcnspline", _fs);  fi
    onepointpath (false, _fs1)
  else:
    mkfcnspline (periodic) (_fs)
  fi
enddef;

vardef mkarc (expr center, begpt, endpt, sweep) =
  if (sweep = 0):  begpt--endpt
  else:
    setnumeric (n) ceiling (abs(sweep)/45);
    setpair (d) (begpt - center) rotated (signof (sweep) 90);
    begpt{d}
    for j = 1 upto n-1:
      ..(begpt rotatedabout (center, j/n*sweep)){d rotated (j/n*sweep)}
    endfor ..endpt{d rotated sweep}
  fi
enddef;

vardef arc (expr center, begpt, sweep) =
  if (center = begpt) or (sweep = 0):  begpt--begpt
  else:
    mkarc (center, begpt, begpt rotatedabout (center, sweep), sweep)
  fi
enddef;
def arccps =  arc  enddef;

vardef arcpps (expr begpt, endpt, sweep) =
  if begpt = endpt:  begpt--endpt
  else:
    setpair (cd) unitvector (endpt-begpt);
    if abs(sweep) <= 45:
      begpt{cd rotated (-sweep/2)}..endpt{cd rotated (sweep/2)}
    elseif abs(sweep) <= 90:
      save m;  pair m;
      m = begpt + whatever*( cd rotated (-sweep/4));
      m = 0.5[begpt, endpt] + whatever*(cd rotated 90);
      begpt{cd rotated (-sweep/2)}..m{cd}..endpt{cd rotated (sweep/2)}
    else:
      setnumeric (ang) 90 - ((sweep/2) mod 180);
      if abs(ang) = 90:
        GBwarn "undefined arc. A line segment will be used instead.";
        begpt--endpt
      else:
        save c;  pair c;
        c = begpt + whatever*(cd rotated ang);
        c = if abs(ang) < 30:
              (0.5)[begpt, endpt] + whatever*(cd rotated 90)
            else:
              endpt + whatever*(-cd rotated -ang)
            fi;
        mkarc (c, begpt, endpt, sweep)
      fi
    fi
  fi
enddef;

vardef arcpp (expr small, begpt, endpt, rad) =
  save full, ang;  full := signof (rad) 360;
  if 2*abs(rad) > abs(begpt - endpt):
    ang := if not small:  full -  fi  2*asin (abs(begpt-endpt)/(2rad));
  else:  ang := signof (rad) 180;
  fi
  arcpps (begpt, endpt, ang)
enddef;
def arcppr (expr begpt, endpt, rad, small) =
  arcpp (small, begpt, endpt, rad)
enddef;

vardef arcplr (expr center, frtheta, totheta, rad) =
  if rad = 0:  center--center
  else:
    mkarc (center, center + rad*dir frtheta,
                   center + rad*dir totheta, totheta - frtheta)
  fi
enddef;

vardef arcalt (expr center, radius, frtheta, totheta) =
  arcplr (center, frtheta, totheta, radius)
enddef;

vardef arcppp (expr first, second, third) =
  arcpps (first, second, 2*cornerangle (third, first, second)) &
  arcpps (second, third, 2*cornerangle (first, second, third))
enddef;

vardef ellipse (expr center, radx, rady, angle) =
  fullcircle xscaled (2*radx) yscaled (2*rady) rotated angle
    shifted center
enddef;
vardef circle (expr center, rad) =
  fullcircle scaled (2*rad) shifted center
enddef;
vardef circlecp (expr center, point) =
  mkarc (center, point, point, 360) & cycle
enddef;
vardef circleppp (expr one, two, three) =
  arcpps (one, two, 2*cornerangle (three, one, two))
    & arcpps (two, three, 2*cornerangle (one, two, three))
    & arcpps (three, one, 2*cornerangle (two, three, one))
    & cycle
enddef;
vardef circlepps (expr one, two, sweep) =
  save ang, full;
  full := signof (sweep) 360;
  ang := sweep mod full;
  arcpps (one, two, ang) & arcpps (two, one, full - ang) & cycle
enddef;
vardef circlepp (expr small, one, two, rad) =
 arcpp (small, one, two, rad) & arcpp (not small, two, one, rad) & cycle
enddef;
def circleppr (expr one, two, rad, small) =
  circleppr (one, two, rad, small)
enddef;
vardef pathcenter expr p =
  save a, cntr, n;  pair cntr, a[];
  n := length p;
  a1 = pnt   0   (p);
  a3 = pnt [n/2] (p);
  if cycle p:
    a2 = pnt [n/4] (p);
    a4 = pnt [3n/4] (p);
  else:
    a2 := a3;
    a4 := pnt[n] (p);
  fi
  cntr = .5[a1, a3] + whatever*((a3 - a1) rotated 90);
  cntr = .5[a2, a4] + whatever*((a4 - a2) rotated 90);
  cntr
enddef;

vardef circumcircle expr t =
  circleppp (pnt0 (t), pnt1 (t), pnt2 (t))
enddef;

vardef incircle expr t =
  save A, B, C;  pair A, B, C;
  A := pnt0 (t);
  B := pnt1 (t);
  C := pnt2 (t);
  save a, b, c, D, E, F;
  D := abs (B-A) = a + b;
  E := abs (C-B) = b + c;
  F := abs (A-C) = a + c;
  circleppp ((a/D)[A,B], (b/E)[B,C], (c/F)[C,A])
enddef;

vardef excircle expr n of t =
  save A, B, C;  pair A, B, C;
  A := pnt[n] (t);
  B := pnt[n + 1] (t);
  C := pnt[n + 2] (t);
  save a, b, c, D, E, F;
  D := abs (B-A) = a - b;
  E := abs (C-B) = b + c;
  F := abs (C-A) = a - c;
  circleppp ((a/D)[A,B], (b/E)[B,C], (c/F)[A,C])
enddef;

vardef ninepointcircle expr t =
  circleppp (medianpt 0 of t, medianpt 1 of t, medianpt 2 of t)
enddef;

vardef barycenter expr t =
  save m;  m := length t if not cycle t:  + 1 fi;
  pnt0(t)/m  for k = 1 upto m - 1:  + pnt[k](t)/m  endfor
enddef;

vardef sector (expr center, rad, frtheta, totheta) =
  center -- arcalt (center, rad, frtheta, totheta) -- cycle
enddef;

vardef mkfcn (expr sm, tens) (expr bmin, bmax, bst) (text pf) =
  save _p;  pair _p[];  _p := 0;
  save _dx, _n, _r;  numeric _dx, _n, _r;
  if bmax = bmin:  _n := 1;
  else:
    _r := bmax - bmin;
    _dx := max (abs(bst), nottoosmall*abs(_r), epsilon);
    _n := emax (round(abs(_r)/_dx), 1);
  fi
  for _i = 0 upto _n:  _p[incr _p] := pf(bmin + _i/_n*_r);  endfor
  mkpath (sm, tens, false, _p)
enddef;

def tfcn (expr sm) =  mkfcn (sm, default_tension)  enddef;

def parafcn (expr sm) =  tparafcn (sm, default_tension)  enddef;
vardef tparafcn (expr sm, tn) (expr bmin, bmax, bst) (text pf) =
  save _fp;  vardef _fp (expr t) =  pf  enddef;
  mkfcn (sm, tn) (bmin, bmax, bst) (_fp)
enddef;

vardef xfcn (expr sm) (expr xmin, xmax, st) (text _fx) =
  save _fp;  vardef _fp (expr _x) =  (_x, _fx(_x))  enddef;
  mkfcn (sm, default_tension) (xmin, xmax, st) (_fp)
enddef;

def function (expr sm) =  tfunction (sm, default_tension)  enddef;
vardef tfunction (expr sm, tens, xmin, xmax, st) (text _fx) =
  save _fp;  vardef _fp (expr x) =  (x, _fx)  enddef;
  mkfcn (sm, tens) (xmin, xmax, st) (_fp)
enddef;

def btwnfcn (expr sm) =  tbtwnfcn (sm, default_tension)  enddef;
vardef tbtwnfcn (expr sm, tn, xlo, xhi, st)(text _fx)(text _gx) =
  tfunction (sm, tn) (xlo, xhi, st) (_fx) --
  ( reverse tfunction (sm, tn) (xlo, xhi, st) (_gx) ) -- cycle
enddef;

def belowfcn (expr sm) =  tbelowfcn (sm, default_tension)  enddef;
vardef tbelowfcn (expr sm, tn, xlo, xhi, st)(text _fx) =
  (xlo,0)--(xhi,0)--
    (reverse tfunction (sm, tn, xlo, xhi, st)(_fx))--cycle
enddef;

vardef rfcn (expr sm, tmin, tmax, st) (text ft) =
  save _fq;  vardef _fq (expr t) =  (ft(t)) * (dir t)  enddef;
  mkfcn (sm, default_tension) (tmin, tmax, st) (_fq)
enddef;

def plrfcn (expr sm) =  tplrfcn (sm, default_tension)  enddef;
vardef tplrfcn (expr sm, tens, tmin, tmax, st) (text ft) =
  save _fq;  vardef _fq (expr t) =  (ft) * (dir t)  enddef;
  mkfcn (sm, tens) (tmin, tmax, st) (_fq)
enddef;

def btwnplrfcn (expr sm) =  tbtwnplrfcn (sm, default_tension)  enddef;
vardef tbtwnplrfcn (expr sm, tn, tlo, thi, st)(text _ft)(text _gt)=
  tplrfcn (sm, tn, tlo, thi, st) (_ft) --
  ( reverse tplrfcn (sm, tn, tlo, thi, st) (_gt) ) -- cycle
enddef;

def plrregion (expr sm) =  tplrregion (sm, default_tension)  enddef;
vardef tplrregion (expr sm, tn, tlo, thi, st) (text _ft) =
  (0,0)--tplrfcn (sm, tn, tlo, thi, st ) (_ft)--cycle
enddef;
numeric tolerancefactor;
tolerancefactor := .02;
vardef mklevelset (expr sm, tens, X, Y, t, a, b, c, d) =
  save _inside_;
  vardef _inside_ (expr U, V) =
    inside_levelset (U, V) and (a < U) and (U < b)
      and (c < V) and (V < d)
  enddef;
  if not _inside_ (X, Y):
    GBwarn "Invalid seed point for levelset.";
    pairmax((a,c), pairmin((X,Y), (b,d)))&cycle
  else:
    save ls, W, A, B, prev, curr, seed;
    pair ls[], prev, curr, seed;
    seed := (X,Y);
    ls := 0;  W := 0;

    save _first_, _next_, get_next;
    vardef _first_ (expr U) =  _inside_ (U, Y)  enddef;
    vardef _next_ (expr ang) =
      _inside_ (X_curr + t * cosd ang, Y_curr + t * sind ang)
    enddef;
    def get_next (expr angA, angB) =
      X_curr := xpart curr;  Y_curr := ypart curr;
      ls[incr ls] := curr + t * dir (solve _next_ (angA, angB));
      prev := curr;  curr := ls[ls];
      W := W + anglefromto (prev - seed, curr - seed);
    enddef;

    interim tolerance := t*tolerancefactor;
    ls[incr ls] := (solve _first_ (X, b), Y);
    curr := ls[ls];
    interim tolerance := radian*tolerancefactor;
    get_next (180, 0);
    for n = 3 upto max_points:
      A := angle (curr - prev);
      get_next (A + 120, A - 120);
      exitif ((abs(W) > 180) or (ls > 10))
        and (abs(ls[ls] - ls1) < 1.2t);
    endfor
    mkpath (sm, tens, true) (ls)
  fi
enddef;

numeric max_points;
max_points := 2000;

def levelset (expr s) =  tlevelset (s, default_tension)  enddef;
vardef tlevelset (expr smth, tens, seed, seg) (text cond) =
  save inside_levelset, _t;
  vardef inside_levelset (expr x, y) =  cond  enddef;
  _t := if seg <= 0:  emax (xpos-xneg, ypos-yneg)/max_points * 20
        else:  seg fi;
  mklevelset (smth, tens, xpart seed, ypart seed, _t)
    (xneg, xpos, yneg, ypos)
enddef;

vardef lclosed expr f =
  f
  if not cycle f:
    if pnt0(f) = pnt[infinity](f):  &  else:  --  fi  cycle
  fi
enddef;

def sclosed =  sclosedt (default_tension)  enddef;
vardef sclosedt (expr t) expr f =
  if cycle f:  f
  else:  save n;  n := length f;
    if n = 0:  f&cycle
    elseif n = 1:  pnt0(f)..tension t..pnt1(f)..tension t..cycle
    else:
      (pnt0 (f)) { (pnt1(f)) - (pnt[n] (f)) }..tension t
         ..(subpath (1, n-1) of f)..tension t
         ..(pnt[n](f)) { pnt0(f) - pnt[n-1](f) }
         ..tension t..cycle
    fi
  fi
enddef;

def bclosed =  bclosedt (default_tension)  enddef;
vardef bclosedt (expr t) expr f =
  f
  if not cycle f:
    if pnt0(f) = pnt[infinity](f):  &  else:  ..tension t..  fi  cycle
  fi
enddef;

def uclosed =  bclosed  enddef;
def uclosedt =  bclosedt  enddef;

def cbcontrols (suffix b, t) =
  b1 := 2[t3, t2];
  b2 := 2[t2, t1];
  b3 := 2[b1, b2];
  b4 := 2[b2, b3];
enddef;

vardef cbclosed expr f =
  save n;  n := length f;
  if cycle f:  f
  elseif n = 0:  f&cycle
  else:
    save p, q, t;  pair p[], q[], t[];
    t1 := pnt0(f);  t2 := post0(f);  t3 := pre1(f);
    cbcontrols (p, t);       % defines p1 to p4
    t1 := pnt[n](f);  t2 := pre[n](f);  t3 := post[n-1](f);
    cbcontrols (q, t);       % defines q1 to q4
    f..controls q2 and q3..opencbs (q1,q4,p4,p1)
     ..controls p3 and p2..cycle
  fi
enddef;

vardef qbclosed expr f =
  if cycle f:  f
  else:  save n;  n := length f;
    if n = 0:  f&cycle
    else:
      save p;  pair p[];  p := 4;
      p1 := (3/2)[pnt[n](f), pre[n](f)];
      p2 := 2[p1, pnt[n](f)];
      p4 := (3/2)[pnt 0 (f), post0 (f)];
      p3 := 2[p4, pnt 0 (f)];
      f & mkqbs (p) & cycle
    fi
  fi
enddef;

vardef makesector expr p =  (pathcenter p)--p--cycle  enddef;
vardef arccomplement expr p =
  if cycle p:  onepointpath (false, pnt0(p))
  else:
    setnumeric (nn) length p;
    setpairs (pp) (pnt0(p), pnt[.5nn](p), pnt[nn](p));
    arcpps (pp3,pp1,2*cornerangle(pp2,pp3,pp1))
  fi
enddef;

vardef cutoffbefore (expr b) expr f =
  save t, n;  n := length f;
  if n > 0:
    for k = 1 upto n:
      exitif (subpath (0,k) of f) intersects b;
    endfor
    if _Xtime < 0:
      cuttings := pnt0 (f){0,0};
      f
    else:
      cuttings := subpath (0,_Xtime) of f;
      subpath (_Xtime, n) of f
    fi
  else:  f
  fi
enddef;

vardef cutoffafter (expr b) expr f =
  setpath (g) cutoffbefore (b) reverse f;
  cuttings := reverse cuttings;
  reverse g
enddef;

vardef trimmedpath (expr btrim, etrim) expr f =
  save g, h;  path g, h;
  g := invvconv (fullcircle scaled 2btrim) shifted pnt0(f);
  h := invvconv (fullcircle scaled 2etrim) shifted pnt[length f] (f);
  cutoffafter (h) cutoffbefore (g) f
enddef;

vardef predirection@# (expr p) =
  - postdirection[length p - @#] (reverse p)
enddef;

vardef postdirection@# (expr p) =
  save _n;  _n := length (p);
  setpair (v) __dir (subpath (@#, @# + _n) of p);
  if v = origin:
    v := - __dir (subpath (@#, @# - _n) of p);
  fi
  v
enddef;

vardef __dir (expr p) =
  save v, w;  pair v, w;  w := pnt0 (p);
  v := origin;
  for n = 1 upto length (p):
    v := post[n-1] (p) - w;  exitif v <> origin;
    v := pre [ n ] (p) - w;  exitif v <> origin;
    v := pnt [ n ] (p) - w;  exitif v <> origin;
  endfor
  sgn v
enddef;

vardef trivial expr p =  (__dir (p) = origin)  enddef;

newinternal hdwdr, hdten;
boolean hfilled;

def headshape (expr wr, tens, fil) =
  interim hdwdr := wr;
  interim hdten := if tens>0:  tens  else:  default_tension fi;
  if hdten < .75:  hdten := .75;  fi
  setboolean (hfilled) fil;
  mkheadpaths;
enddef;
def mkheadpaths =
  save Arrowhead, Leftharpoon, Rightharpoon;
  path Arrowhead, Leftharpoon, Rightharpoon,
       Arrowhead.clear, Leftharpoon.clear, Rightharpoon.clear;
  Rightharpoon := (0,0){down}..tension hdten..(.5hdwdr,-1);
  Rightharpoon.clear := Rightharpoon--(.5hdwdr,0)--cycle;
  Leftharpoon  := (reverse Rightharpoon) xscaled -1;
  Leftharpoon.clear := (reverse Rightharpoon.clear) xscaled -1;
  Arrowhead := Leftharpoon & Rightharpoon;
  Arrowhead.clear := Leftharpoon.clear & Rightharpoon.clear & cycle;
  if hfilled:
    Arrowhead := Arrowhead--cycle;
    Rightharpoon := Rightharpoon--(0,-1)--cycle;
    Leftharpoon := Leftharpoon--(0,-1)--cycle;
  fi
enddef;
headshape (1,1,false);

def head =  ahead  enddef;

vardef ahead (expr clr, front, back, hwr, tens, filled) =
  settension (_tn) tens;  fixtension (_tn);
  if front <> back:
    setpair (side) (hwr/2) * ((front-back) rotated 90);
    setpath (f) (back + side)..tension _tn..
       {front-back}front{back-front}..tension _tn..(back - side);
    if clearhead:
      safeunfill (back - side)--(front-side)--(front+side)--
        (back+side) & f & cycle;
      colorsafedraw (background) (back - side)--(front-side)--
        (front+side)--(back+side) & f & cycle;
    fi
    if filled:
      f := f--cycle;
      colorsafefill (clr) f;
    fi
    colorsafedraw (clr) f;
  fi
enddef;

def headpath =  Gheadpath (false) (Arrowhead)  enddef;
def headpathx =  Gheadpath (true) (Arrowhead)  enddef;

def colorheadpath =  colorGheadpath (false) (Arrowhead)  enddef;
def colorheadpathx =  colorGheadpath (true) (Arrowhead)  enddef;

def Gheadpath (expr trim) (suffix ah) =
  colorGheadpath (trim) (ah) (headcolor)
enddef;
vardef colorGheadpath
(expr trim) (suffix ah) (expr clr, sc, rot, pos) expr f =
  if (sc <> 0) and (known ah) and (path ah):
    convertpath (_g) f;
    setpair (_P) predirection[length _g] (_g);
    if _P <> origin:
      _P := _P rotated rot;
      setnumeric (_ang) anglefromto (up, _P);
      _P := pnt[length _g] (_g) - pos * _P;
      setpair (_tip) if known ah.tip:  ah.tip  else:  origin fi;

      if trim:
        if known ah.clear:
          safeunfill (ah.clear shifted - _tip)
            scaled sc
            rotated _ang
            shifted _P;
        fi
        setnumeric (_ys) max(bp, penwd, last_dot_size);
        safeunfill cut_path
          xscaled sc yscaled _ys
          rotated _ang shifted _P;
      fi
      if cycle ah:  colorsafefill  else:  colorsafedraw  fi  (clr)
        (ah shifted -_tip)
          scaled sc
          rotated _ang
          shifted _P;
    fi
  fi
  f
enddef;

def tailpath (suffix sh) =  colortailpath (sh) (headcolor)  enddef;
vardef colortailpath (suffix sh) (expr clr, sc, rot, pos) expr f =
  if (sc <> 0) and (known sh) and (path sh):
    convertpath (_g) f;
    setpair(_P) postdirection0 (_g);
    if _P <> origin:
      _P := _P rotated rot;
      if cycle sh:  colorsafefill  else:  colorsafedraw  fi  (clr)
        (sh if known sh.tip:  shifted -sh.tip fi)
          scaled sc
          rotated anglefromto (up, _P)
          shifted (pnt0 (_g) + pos * _P);
    fi
  fi
  f
enddef;

def midpath (suffix sh) =  colormidpath (sh) (headcolor)  enddef;
vardef colormidpath (suffix sh) (expr clr, sc, rot, pos) expr f =
  if (sc <> 0) and (known sh) and (path sh):
    convertpath (_g) f;
    setnumeric (_t) pathtime[pos] (_g);
    setpair (_P) postdirection[_t] (_g);
    if _P <> origin:
      _P := _P rotated rot;
      if cycle sh:  colorsafefill  else:  colorsafedraw  fi  (clr)
        sh scaled sc
           rotated anglefromto (up, _P)
           shifted (pnt[_t] (_g));
    fi
  fi
  f
enddef;

vardef signeddeviate primary X =
  (uniformdeviate 1)[-X,X]
enddef;
vardef scaledeviate (expr W, A) =
  2 ** (signeddeviate W) * dir A
enddef;
vardef polardeviate primary R =
  (uniformdeviate abs(R)) * dir uniformdeviate 360
enddef;
vardef xydeviate primary Z =
  (signeddeviate (xpart Z), signeddeviate (ypart Z))
enddef;

vardef randompair (expr maxshift) =
  if numeric maxshift:  polardeviate (maxshift)
  elseif pair maxshift:  xydeviate (maxshift)
  else:  (0,0)
  fi
enddef;

vardef detrivialized expr f =
  save g;  path p, g[];  g := 0;
  for k = 1 upto length f:
    p := subpath (k-1,k) of f;
    if not trivial p:  g[incr g] := p;  fi
  endfor
  if g = 0:  onepointpath (cycle f, pnt0(f))
  else:  g1 for k = 2 upto g:  &g[k] endfor if cycle f:  &cycle  fi
  fi
enddef;

vardef randompath (expr maxshift, weirdness) expr f =
  save g, n;  path g;
  g := detrivialized f;
  n := length g;
  if n = 0:
    f shifted randompair (maxshift)
  else:
    save X, U, V;
    pair X[], U[], V[];
    if cycle g:  n := n - 1;  fi
    for k = 0 upto n:
      X[k] := pnt[k](g);
      U[k] := X[k] - pre[k](g);
      V[k] := post[k](g) - X[k];
    endfor
    save A, B;
    for k := 0 upto n:
      X[k] := X[k] shifted randompair (maxshift);
      A := anglefromto (U[k],V[k]);
      B := signeddeviate (30weirdness);
      U[k] := X[k] - (U[k] zscaled scaledeviate (weirdness,B));
      B := B - A + A * (2 ** signeddeviate weirdness);
      V[k] := X[k] + (V[k] zscaled scaledeviate (weirdness,B));
    endfor
    X0 for k = 1 upto n:
        .. controls V[k-1] and U[k] .. X[k]
       endfor
    if cycle g:
        .. controls V[n] and U0 .. cycle
    fi
  fi
enddef;

vardef randomlines (expr maxshift) expr f =
  save g, n;  path g;
  g := detrivialized f;
  n := length g;
  if n = 0:
    f shifted randompair (maxshift)
  else:
    if cycle g:  n := n - 1;  fi
    (pnt0(g) shifted randompair (maxshift))
      for k = 1 upto n:
        -- (pnt[k](g) shifted randompair (maxshift))
      endfor
      if cycle g:
        -- cycle
      fi
  fi
enddef;
vardef parasegment (expr d, segs, f) =
  if d = 0:  f
  else:
    save u, v, t;  pair u[], v[];
    for n = 0 upto segs:
      t := n/segs;
      u[n] := postdirection [t] (f);
      v[n] := pnt[t] (f) + (u[n] zscaled (0,d));
    endfor
    v0{u0}
    for n = 1 upto segs:  ...v[n]{u[n]} endfor
  fi
enddef;

vardef parapath (expr d) expr f =
  if d = 0:
    f
  else:
    save a, g, h, p, q, s, t, u, v, w;
    path g[], h, p[], q[];
    numeric a, s, t;
    pair u, v, w, w[];
    s := emax (3, emin (segment_split, ceiling (max_points/5/length f)));
    p := 0;
    for i = 1 upto length f:
      h := subpath (i-1, i) of f;
      if not trivial h:
        q[incr p] := h;
        p[p] := parasegment (d, s, h);
      fi
    endfor
    if p = 0:
      f
    else:
      a := if d>0: - fi 180;
      h := p1;
      for i = 1 upto p-1:
        u := predirection 1 (q[i]);
        v := postdirection 0 (q[i+1]);
        w1 := pnt 1  (q[i])  - (u zscaled (0,d));
        w2 := pnt 0 (q[i+1]) - (v zscaled (0,d));
        w3 := pnt [infinity] (h);
        w4 := pnt 0 (p[i+1]);
        g0 := arcpps(w3, w1, a);
        g1 := h & g0;
        g2 := arcpps(w2, w4, a) & p[i+1];
        if (p[i] & g0) intersects reverse g2:
          s := length g2 - _Ytime;
          t := length h - length p[i] + _Xtime;
          g1  := subpath (0, t) of g1;
          g2 := subpath (s, length g2) of g2;
          force_equal_ends (g1, g2);
          h := g1 & g2;
        else:
          h := h .. p[i+1];
        fi
      endfor

      if cycle f:
        u := predirection 1 (q[p]);
        v := postdirection 0 (q[1]);
        w1 := pnt 1  (q[p])  - (u zscaled (0,d));
        w2 := pnt 0 (q[1]) - (v zscaled (0,d));
        w3 := pnt [infinity] (h);
        w4 := pnt 0 (p[1]);
        g3 := arcpps(w3, w1, a);
        g0 := arcpps(w2, w4, a);
        g1 := g0 & h & g3;
        g2 := g0 & p[1];
        if (p[p] & g3) intersects reverse g2:
          s := length g2 - _Ytime;
          t := length g0 + length h - length p[p] + _Xtime;
          g1 := subpath (s, t) of g1;
          force_equal_ends (g1, g1);
          h := g1 & cycle;
        else:
          h := h..cycle;
        fi
      fi
      h
    fi
  fi
enddef;

vardef turnangle@# (expr f) =
  anglefromto(predirection@# (f), postdirection@#(f))
enddef;

def setdatadashes (text lst) =
  save __type;  __type := 0;
  forsuffixes _itm = lst:
    if knownnumericarray _itm :
      copyarray (_itm) (__type[__type]);
      next __type;
    else:  GBwarn "Improper dash pattern in setdatadashes.";
    fi
  endfor
  if __type > 1:
    save dashtype;  dashtype := __type;
    for _j = 0 upto dashtype - 1:
      copyarray (__type[_j]) (dashtype[_j]);
    endfor
  else:
    SetdataWarn "dashes";
  fi
enddef;
def getdashpat expr n =  dashtype[n mod dashtype]  enddef;

def SetdataWarn expr s =
  GBwarn "command setdata"& s &"() failed. Previous values retained.";
enddef;

numeric Solid, Simpledash, Simpledot, Dotdash, Dotdashdot, Dotdashdash;
dashpat (Solid) (0);
dashpat (Simple_dash) (3bp, 4bp);
dashpat (Simple_dot) (0, 4bp);
dashpat (Dot_dash) (0, 4bp, 3bp, 4bp);
dashpat (Dot_dash_dot) (0, 4bp, 3bp, 4bp, 0, 4bp);
dashpat (Dot_dash_dash) (0, 4bp, 3bp, 4bp, 3bp, 4bp);

numeric dashtype, dashtype[], dashtype[][];
def defaultdashes =
  setdatadashes (Solid, Simple_dash, Simple_dot,
    Dot_dash, Dot_dash_dot, Dot_dash_dash);
enddef;
defaultdashes;

def setdatasymbols (text lst) =
  save __type;  path __type[];
  __type := 0;
  for _itm = lst:
    if (known _itm) and (path _itm):
      __type[__type] := _itm;
      next __type;
    else:
      GBwarn "Improper path in setdatasymbols().";
    fi
  endfor
  if __type > 1:
    save pointtype;  pointtype := __type;
    path pointtype[];
    for _j = 0 upto pointtype - 1:
      pointtype[_j] := __type[_j];
    endfor
  else:
    SetdataWarn "symbols";
  fi
enddef;
def getsymbol expr n :=  pointtype[n mod pointtype]  enddef;

def DeclareGBSymbols (text S) =
  forsuffixes _itm = S:
    path _itm;
    path _itm.clear;
    pair _itm.tip;
  endfor
enddef;
DeclareGBSymbols(
  Triangle, Square, Circle, Diamond, Star, Plus, Cross,
  Asterisk, Crossbar, Leftbar, Rightbar, Righthook,
  Lefthook, SolidTriangle, SolidSquare, SolidCircle,
  SolidDiamond, SolidStar
);

vardef undo_cycle expr f =  subpath (0, length f) of f  enddef;

SolidTriangle := (up--(dir 210)--(dir -30)--cycle) scaled .78;
Triangle := undo_cycle SolidTriangle;

Triangle.clear := SolidTriangle.clear :=
  ((dir -30)--(cosd 30,1)--(cosd 210,1)--(dir 210)--up--cycle)
  scaled .78;

SolidSquare := (up--(-1,1)--(-1,-1)--(1,-1)--(1,1)--cycle) scaled .443;
Square := undo_cycle SolidSquare;

SolidCircle := fullcircle rotated 90;
Circle := undo_cycle SolidCircle;
Circle.clear := SolidCircle.clear :=
  halfcircle--(-.5,.5)--(.5,.5)--cycle;

SolidDiamond := (up--left--down--right--cycle)
                scaled .522 yscaled 1.44;
Diamond := undo_cycle SolidDiamond;
Diamond.clear := SolidDiamond.clear :=
  (right--(1,1)--(-1,1)--left--up--cycle) scaled .522 yscaled 1.44;

Plus := ((0,0)--up--down--(0,0)--left--right) scaled .65;
Plus.clear := (right--(1,1)--(-1,1)--(left)--cycle) scaled .65;

Cross := ((0,0)--(dir 45)--(dir -135)--(0,0)--(dir -45)--(dir 135))
         scaled .65;
Cross.clear := ((0,0)--(dir -45)--dir(45)--(dir 135)--(dir -135)--cycle)
               scaled .65;

Asterisk := ((0,0)--up--down--(0,0)--(dir 30)--(dir -150)
    --(0,0)--(dir -30)--(dir 150)) scaled .6;
Asterisk.clear := ((0,0)--(dir -30)--(cosd 30,1)--(cosd 150,1)
                  --(dir -150)--cycle) scaled .6;

Crossbar := ((0,0)--left--right) scaled .65;
Crossbar.clear := rect (right,(-1,.5)) scaled .65;

Leftbar := ((0,0)--left);
Rightbar := ((0,0)--right);
Leftbar.clear := rect((0,0),(-1,.5));
Rightbar.clear := rect((0,0),(1,.5));

Righthook := arcpps((0,0),(1,0),180);
Lefthook  := Righthook xscaled -1;
Righthook.clear := Righthook--cycle;
Lefthook.clear := Lefthook--cycle;

vardef mkstar (expr n, m) (suffix A) =
  save ang;  ang := 360/n;
  A1 := up;  A3 := up rotated ang;
  A2 = (whatever)[A1, A1 rotated ( ang*m)];
  A2 = (whatever)[A3, A3 rotated (-ang*m)];
  for i = 4 upto 2n:
    A[i] := A[i-2] rotated ang;
  endfor
  A := 2n;
  mkpoly (true, A)
enddef;

save _A;  pair _A[];
SolidStar := mkstar (5, 2, _A) scaled .84;
Star := undo_cycle SolidStar;
Star.clear := polyline (true)
  (_A9, _A10, _A1, _A2, _A3, (xpart _A3, 1), (xpart _A9, 1)) scaled .84;
SolidStar.clear := Star.clear;

forsuffixes S =
 Triangle, Square, Circle, Diamond, Star, Plus, Cross,
 Asterisk, Crossbar, Leftbar, Rightbar, Righthook,
 Lefthook, SolidTriangle, SolidSquare, SolidCircle,
 SolidDiamond, SolidStar :
  S.tip := point 0 of S;
endfor
vardef gcd (expr n, m) =
  save a, b, r;
  a := emax (abs(m), abs(n));
  b := emin (abs(m), abs(n));
  if b > 0:
    forever:
      r := a mod b;
      exitif r < 1;
      a := b;  b := r;
    endfor
    b
  else:
    a
  fi
enddef;

vardef lcm (expr n, m) =
  n*m/gcd(n, m)
enddef;

path cut_path;  cut_path := (.5,0)--(.5,.71)--(-.5,.71)--(-.5,0)--cycle;

numeric pointtype;  path pointtype[];
def defaultsymbols =
  setdatasymbols( Circle, Cross, SolidDiamond, Square, Plus,
    Triangle, SolidCircle, Star, SolidTriangle);
enddef;
defaultsymbols;

def setdatacolors (text lst) =
  save __type;  color __type[];
  __type := 0;
  for _itm = lst:
    if (known _itm) and (color _itm):
      __type[__type] := _itm;
      next __type;
    else:  GBwarn "Improper color in setdatacolors().";
    fi
  endfor
  if __type > 1:
    save colortype;  colortype := __type;
    color colortype[];
    for _j = 0 upto colortype - 1:
      colortype[_j] := __type[_j];
    endfor
  else:
    SetdataWarn "colors";
  fi
enddef;
def getcolor expr n =  colortype[n mod colortype]  enddef;

color dBlue, dOrange, dGreen, dMagenta, dCyan, dYellow;
dBlue := 0.80blue + .2white;
dOrange := 0.66yellow + .34red;
dGreen := 0.80green;
dMagenta := 0.85magenta;
dCyan := 0.85cyan;
dYellow := 0.85yellow;

numeric colortype;  color colortype[];
def defaultcolors =
  setdatacolors(black, red, dBlue, dOrange, dGreen,
    dMagenta, dCyan, dYellow);
enddef;
defaultcolors;

def computepie (suffix dat) (expr sign, ang, cent, rad) (text data) =
begingroup
  save _tot, _max, _toobig;
  _max := 0;  dat := 0;
  for _val = data:
    dat[incr dat] := _val;
    _max := emax (_max, _val);
  endfor
  if dat=0:  GBwarn  "piechart attempted with empty list.";
    _toobig := 1;
  else:
    _toobig := infinity/dat;
  fi
  if _max > _toobig:
    for _idx = 1 upto dat:
      dat[_idx] := dat[_idx]/_toobig;
    endfor
  fi
  for _idx = 2 upto dat:
    dat[_idx] := dat[_idx - 1] + dat[_idx];
  endfor
  _tot := dat[dat];
  for _idx = dat downto 2:
    dat[_idx] := ang + sign*dat[_idx-1]/_tot*360;
  endfor
  dat1 := ang; dat[dat + 1] := ang + 360sign;
endgroup
enddef;

def piechart (expr sign, ang, cent, rad) (text data) =
  save _dat;
  computepie (_dat) (sign, ang, cent, rad) (data);
  mkpiewedges (_dat, cent, rad);
enddef;

def mkpiewedges (suffix dat) (expr cent, rad) =
  numeric piewedge, piedirection, pieangle, pieangle[];
  pair piecenter, piedirection[];
  path piewedge[];
  piecenter := cent;
  piedirection := pieangle := piewedge := dat;
  for _idx = 1 upto dat:
    pieangle[_idx] := dat[_idx];
    piewedge[_idx] := sector (piecenter, rad, dat[_idx], dat[_idx+1]);
    piedirection[_idx] := dir(0.5[ dat[_idx], dat[_idx+1] ]);
  endfor
enddef;

def namedpiechart (suffix nm) (expr sign, ang, cent, rad) (text data) =
  save _dat;
  computepie (_dat) (sign, ang, cent, rad) (data);
  setnumeric (nm) _dat;
  pair nm.center, nm.direction[];
  path nm.wedge[];
  nm.center := cent;
  for _idx = 1 upto _dat:
    nm.wedge[_idx] := sector (cent, rad, _dat[_idx], _dat[_idx+1]);
    nm.direction[_idx] := dir(0.5[ _dat[_idx], _dat[_idx+1] ]);
  endfor
enddef;

def barchart (expr firstbar, sep, r, vert)(text data) =
  numeric barbegin, barbegin[],
          barend, barend[],
          barlength, barlength[],
          barstart, barstart[],
          chartbar, barwd;
  path chartbar[];
  chartbar := 0;  barwd := r*sep;
  for _itm = data:
    barend[incr chartbar] := if pair _itm:  ypart _itm  else:  _itm  fi;
    barbegin[chartbar]    := if pair _itm:  xpart _itm  else:  0  fi;
  endfor
  barbegin := barend := barlength := barstart := chartbar;
  for _nn = 1 upto chartbar:
    barstart[_nn]  := firstbar + sep*(_nn-1);
    barlength[_nn] := barend[_nn];
    chartbar[_nn]  :=  rect ((barbegin[_nn], 0), ( barend[_nn], barwd))
          shifted (0, barstart[_nn]) if vert:  xyswap  fi;
  endfor
enddef;

def namedbarchart (suffix nm) (expr first, sep, r, vert) (text data) =
  save nm;
begingroup
  save _bb, _ee, _ww;
  path nm.bar[];
  nm := 0;  _ww := r*sep;
  for _itm = data:
    _ee := if pair _itm:  ypart _itm  else:  _itm  fi;
    _bb := if pair _itm:  xpart _itm  else:  0  fi;
    nm.bar[incr nm] :=  rect ((_bb, 0), ( _ee, _ww) )
          shifted (0, first + sep*(nm-1)) if vert:  xyswap fi;
  endfor
endgroup
enddef;

picture totalpicture;
boolean totalnull, currentnull;
def clearit =
  currentpicture := totalpicture := nullpicture;
  currentnull := totalnull := true;
enddef;

def keepit =
  addto totalpicture also currentpicture;
  currentpicture := nullpicture;
  totalnull := totalnull or currentnull;
  currentnull := true;
enddef;

def addto_currentpicture =
  currentnull := false;
  addto currentpicture
enddef;

def mergeit (text do) =
  if totalnull:
    do currentpicture
  elseif currentnull:
    do totalpicture
  else:
    begingroup
      save _v_;  picture _v_;
      _v_ := currentpicture;
      addto _v_ also totalpicture;
      do _v_
    endgroup
  fi
enddef;

boolean noship;  noship := false;
def shipit =  if noship:  else:  mergeit (shipout)  fi  enddef;

numeric gcode;  gcode := 0;

input dvipsnam.mp;
%  end grafbase.mp
endinput.
%%
%% End of file `grafbase.mp'.
