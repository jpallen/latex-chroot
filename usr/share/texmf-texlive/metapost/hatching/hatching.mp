%%% addto clip hatchfill hatchfill_
%%% numeric color
%%% length withcolor
% This is HATCHING.MP file defining a set of METAPOST macros for
% hatching interior of closed paths.
%
% Made in BOP, Gda\'nsk, Poland
% E-mail contact: B.Jackowski@gust.org.pl
% Public domain software (no copyrights, copylefts, copyups, copydowns, etc.)
% Current version: 11.07.2000 -- ver 0.1 (pre-release)
% Current version: 21.09.2000 -- ver 0.11 (ending semicolon
%    added in |extra_beginfig|; |hatchfill_| introduced in order
%    to make possible something like |def fill = hatchfill enddef|
def hatchfill_ expr c = addto currentpicture contour c _op_ enddef;

vardef hatchfill text p =
 save c_,p_; path p_; color c_[\\]; c_.num:=0;
 save withcolor_; let withcolor_:=withcolor;
 def withcolor = ; c_[incr c_.num]:= enddef;
 p_:=p; let withcolor:=withcolor_;
 for i_:=c_.num downto 1: % find the least ``true'' fill
  c_.num':=i_; exitif bluepart(c_[i_])>0;
 endfor
 if c_.num>0:
  for i_:=c_.num' upto c_.num:
   if bluepart(c_[i_])<0: draw hatched(p_)c_[i_];
   else: hatchfill_ p_ withcolor c_[i_]; fi
  endfor
 else: hatchfill_ p_; fi
enddef;

vardef hatched(expr o) primary c =
 save a_, b_, d_, l_, i_, r_, za_, zb_, zc_, zd_;
 path b_; picture r_; pair za_, zb_, zc_, zd_;
 r_:=image(
  a_:=redpart(c) mod 180; l_:=greenpart(c); d_:=-bluepart(c);
  b_:=o rotated -a_;
  b_:=if a_>=90: (lrcorner b_--llcorner b_--ulcorner b_--urcorner b_--cycle)
   else: (llcorner b_--lrcorner b_--urcorner b_--ulcorner b_--cycle) fi
   rotated a_;
  za_:=point 0 of b_; zb_:=point 1 of b_;
  zc_:=point 2 of b_; zd_:=point 3 of b_;
  if hatch_match>0:
   n_:=round(length(zd_-za_)/l_); if n_<2: n_:=2; fi; l_:=length(zd_-za_)/n_;
  else: n_:=length(zd_-za_)/l_; fi
  % show (greenpart(c), l_);
  for i_:=if hatch_match>0: 1 else: 0 fi upto ceiling n_-1:
   draw_hatched_band((i_/n_)[zd_,za_],(i_/n_)[zc_,zb_],a_,l_,d_);
  endfor
 );
 clip r_ to o; r_
enddef;

def draw_hatched_band(expr za,zb,a,l,d) = % normally, |a| and |l| are ignored
 draw za--zb withpen pencircle scaled d _hop_;
enddef;

def hatchoptions(text t) = def _hop_ = t enddef enddef;

newinternal hatch_match; hatch_match:=1;
hatchoptions(); extra_beginfig:=extra_beginfig & ";hatchoptions();";

endinput
%%\end
