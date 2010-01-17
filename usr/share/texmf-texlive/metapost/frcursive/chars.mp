%&mfplain

% The resolution tu use for rounding.

pixel = 1in/300;

% The rounding primitives, adapted from plain.mf.

vardef round primary u =
 if numeric u: floor(u+.5)
 elseif pair u: (hround xpart u, vround ypart u)
 else: u fi enddef;
vardef hround primary x = (floor(x/pixel+.5)*pixel) enddef;
vardef vround primary y = (floor(y/pixel.o_+.5)_o_*pixel) enddef;

def define_pixels(text t) =
 forsuffixes $=t: $:=$.#*hppp; endfor enddef;
def define_whole_pixels(text t) =
 forsuffixes $=t: $:=hround($.#*hppp); endfor enddef;
def define_whole_vertical_pixels(text t) =
 forsuffixes $=t: $:=vround($.#*hppp); endfor enddef;
def define_good_x_pixels(text t) =
 forsuffixes $=t: $:=good.x($.#*hppp); endfor enddef;
def define_good_y_pixels(text t) =
 forsuffixes $=t: $:=good.y($.#*hppp); endfor enddef;
def define_blacker_pixels(text t) =
 forsuffixes $=t: $:=$.#*hppp+blacker; endfor enddef;
def define_whole_blacker_pixels(text t) =
 forsuffixes $=t: $:=hround($.#*hppp+blacker);
  if $<=0: $:=1; fi endfor enddef;
def define_whole_vertical_blacker_pixels(text t) =
 forsuffixes $=t: $:=vround($.#*hppp+blacker);
  if $<=0: $:=1_o_; fi endfor enddef;
def define_corrected_pixels(text t) =
 forsuffixes $=t: $:=vround($.#*hppp*o_correction)+eps; endfor enddef;
def define_horizontal_corrected_pixels(text t) =
 forsuffixes $=t: $:=hround($.#*hppp*o_correction)+eps; endfor enddef;

vardef good.x primary x = hround(x+pen_lft)-pen_lft enddef;
vardef good.y primary y = vround(y+pen_top)-pen_top enddef;
vardef good.lft primary z = save z_; pair z_;
  (z_+(pen_lft,0))t_=round((z+(pen_lft,0))t_); z_ enddef;
vardef good.rt primary z = save z_; pair z_;
  (z_+(pen_rt,0))t_=round((z+(pen_rt,0))t_); z_ enddef;
vardef good.top primary z = save z_; pair z_;
  (z_+(0,pen_top))t_=round((z+(0,pen_top))t_); z_ enddef;
vardef good.bot primary z = save z_; pair z_;
  (z_+(0,pen_bot))t_=round((z+(0,pen_bot))t_); z_ enddef;


% We change the stroke routine a bit and we save some character shapes.

let saved_beginchar = beginchar;
let saved_endchar = endchar;

picture pic[];

def penstroke text t =
 forsuffixes e = l,r: path_.e:=t; endfor
 fill path_.l -- reverse path_.r -- cycle;
 draw path_.l -- reverse path_.r -- cycle
   withpen pencircle scaled 1 withcolor black enddef;

def beginchar (expr c,w,h,d) =
if (byte c) >= 128:
  proofcolor := .3[white,red];
else:
  proofcolor :=.3[white,black];
fi
saved_beginchar(c,w,h,d)
enddef;

def endchar = ;
%if charcode = 97:
  for pos = 0 step pixel until w: proofrule((pos,-d), (pos,h)); endfor
  for pos = 0 step pixel until h: proofrule((0,pos), (w,pos)); endfor
  for pos = -pixel step -pixel until -d: proofrule((0,pos), (w,pos)); endfor
%fi
%if save_char(charcode):
%  pic[charcode] = currentpicture;
%  wid[charcode] = w
%fi;
%if make_char(charcode):
  saved_endchar
%else: endgroup fi
enddef;


% We build a figure with a string, using saved characters.

def txt =
  128, "a", 132, "b", 143, "j", 129, "e", 129, "c", 137, "t"
enddef;

def make_char (expr c) =
  for cc = "A", "a", "b", "j": (c = byte cc) or endfor false enddef;
def save_char (expr c) =
  for cc = txt: (c = byte cc) or endfor false enddef;


% Here we read the actual font, providing an explicit driver (this is frcr10).

proofing := -1;

mode_setup;

ex# := 155.0/36 pt#;
med# := .400 pt#;
thin# := .200 pt#;
thick# := .610 pt#;
dot_size# := .800 pt#;

base_width := .800;
slant := 0;
accent_wd := 0.7;
link_width := 0.13;
straight_ascend := 2;
loop_ascend := 2.5;
uc_ascend := 2.5;
straight_descend := 1.2;
loop_descend := 1.5;
dot_height := 1.4;
accent_bot := 1.2;
accent_top := 1.6;
cedilla_dp = 0.2;

input frcursive


% Here is the word built as one figure.

let beginchar = saved_beginchar;
let endchar = saved_endchar;

beginchar(0,0,0,0)
  xpos := 0;
  for c = txt:
	addto currentpicture also pic[byte c] shifted (xpos,0);
	xpos := xpos + wid[byte c];
  endfor;
endchar;

end
