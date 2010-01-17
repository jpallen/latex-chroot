% venn.mp
%  MetaPost input file for venn diagrams.
%
% LICENSE
%  This is released under the LaTeX Project Public License. 
%
% HISTORY
% 2001-Apr-15 Jim Hefferon jim@joshua.smcvt.edu Written
%

%defaultscale := 9pt/fontsize defaultfont;

newinternal venn_width, venn_height;
venn_width := 100pt; venn_height := .618venn_width;
newinternal venn_circle_diameter;
venn_circle_diameter := .5venn_height;
newinternal venn_pen;
venn_pen := 0.4pt;
vardef venn_shade = .9white enddef;
vardef venn_unshade = white enddef;

path venn_box; % box that borders a Venn diagram; `U'
  venn_box = (0,0)--(venn_width,0)--(venn_width,venn_height)
                --(0,venn_height)--cycle;
newinternal venn_circle_left_shift,
            venn_circle_right_shift,
	    venn_circle_top_shift,
	    venn_circle_bottom_shift;
venn_circle_left_shift := .5venn_width;
venn_circle_right_shift := venn_width-venn_circle_left_shift;
venn_circle_top_shift := .5venn_height;
venn_circle_bottom_shift := venn_height-venn_circle_bottom_shift;


% ..... venn_color .......
%  Return either venn_shade or venn_unshade, as chosen.
% ARGS
%  b  A boolean
% RETURNS
%  a color
% USAGE
%  fill circle withcolor venn_color(true);
%
def venn_color(expr b) =
  if b: venn_shade else: venn_unshade fi
enddef;

% ...... draw_venn_none ...........
%  Draw a Venn diagram with no enclosed circles (just the universal set)
% ARGS
%  univ  A boolean; color the set or not?
% RETURNS
%  --
% USAGE
%  draw_venn_none(true); 
% draws a shaded set.
%
def draw_venn_none(expr univ)text t = 
  begingroup
    fill venn_box t withcolor venn_color(univ);    
    pickup pensquare scaled venn_pen; draw venn_box t;
  endgroup
enddef;

% ...... draw_venn_one ...........
%  Draw a Venn diagram with one enclosed circle
% ARGS
%  univ  A boolean; color the universal set or not?
%  cl  A boolean; color the circle?
% RETURNS
%  --
% USAGE
%  draw_venn_one(true,false); 
% draws a shaded set with the unshaded circle.
%
def draw_venn_one(expr univ, cl)text t = 
  begingroup
    venn_circle_left_shift := .5venn_width;
    venn_circle_right_shift := venn_width-venn_circle_left_shift;
    venn_circle_top_shift := .5venn_height;
    venn_circle_bottom_shift := venn_height-venn_circle_top_shift;

    fill venn_box t withcolor venn_color(univ);    
    pickup pensquare scaled venn_pen; draw venn_box t;

    save circle; path circle;
      circle = fullcircle scaled venn_circle_diameter
                 shifted (venn_circle_left_shift,venn_circle_top_shift) t;
    fill circle withcolor venn_color(cl);
    pickup pencircle scaled venn_pen; draw circle;
  endgroup
enddef;

% ...... draw_venn_two ...........
%  Draw a Venn diagram with two enclosed circles
% ARGS
%  univ  A boolean; color the universal set or not?
%  cl  A boolean; color the left circle?
%  lr  A boolean; color the intersection wedge?
%  cr  A boolean; color the right circle?
% RETURNS
%  --
% USAGE
%  draw_venn_two(true,false,true,false) shifted (2in,1in); 
% draws a diagram, shifted.
% NOTE 
%  The trick here is to use mpost's buildcycle to define the
% path `lr' outlining the intersection of the left and right
% circles.  Below the left circle is defined to be rotated -180.
% That's because otherwise the intersection with the right
% circle occurs on top early in the path, and on bottom late in
% the path, and so the left of the lr region crosses through the
% `point 0 of circle_left' boundary, which confuses buildcycle.
% So, it's a hack.
%
def draw_venn_two(expr univ, cl, lr, cr)text t = 
  begingroup
    venn_circle_left_shift := .4venn_width;
    venn_circle_right_shift := venn_width-venn_circle_left_shift;
    venn_circle_top_shift := .5venn_height;
    venn_circle_bottom_shift := venn_height-venn_circle_top_shift;

    fill venn_box t withcolor venn_color(univ);    
    pickup pensquare scaled venn_pen; draw venn_box t;

    save circle_left, circle_right; path circle_left, circle_right;
      circle_left = fullcircle rotated -180 scaled venn_circle_diameter
                     shifted (venn_circle_left_shift,venn_circle_top_shift) t;
      circle_right = fullcircle scaled venn_circle_diameter
                     shifted (venn_circle_right_shift,venn_circle_top_shift) t;
    save area_lr; path area_lr;
    area_lr = buildcycle(circle_left,circle_right);
  
    fill circle_left withcolor venn_color(cl);
    fill circle_right withcolor venn_color(cr);
    fill area_lr withcolor venn_color(lr);
    pickup pencircle scaled venn_pen;
    draw circle_left; draw circle_right;
  endgroup
enddef;



% ...... draw_venn_three ...........
%  Draw a Venn diagram with three enclosed circles
% ARGS
%  univ  A boolean; color the universal set or not?
%  cl  A boolean; color the left circle?
%  lr  A boolean; color the intersection wedge?
%  cr  A boolean; color the right circle?
%  lb  A boolean; color the intersection of left and bot right circles?
%  rb  A boolean; color the intersection of right and bot circles?
%  lrb  A boolean; color the intersection of all three circles?
%  cb  A boolean; color the bottom circle?
% RETURNS
%  --
% USAGE
%  draw_venn_three(true,false, ...) shifted (2in,1in); 
% draws a diagram, shifted.
% NOTE 
% The  trick here is to use mpost's buildcycle to define the
% paths `lr' (outlining the intersection of the left and right
% circles), `rb', `lb', and `lrb'.
% To do that I had to fiddle with the times along the circles.
% So, it's a hack.
%
def draw_venn_three(expr univ, cl, lr, cr, lb, rb, lrb, cb)text t = 
  begingroup
    venn_circle_left_shift := .4venn_width;
    venn_circle_right_shift := venn_width-venn_circle_left_shift;
    venn_circle_top_shift := .63venn_height;
    venn_circle_bottom_shift := venn_height-venn_circle_top_shift;

    fill venn_box t withcolor venn_color(univ);    
    pickup pensquare scaled venn_pen; draw venn_box t;

    save circle_left, circle_right, circle_bottom;
    path circle_left, circle_right, circle_bottom;
    circle_left = (reverse fullcircle) rotated -180 scaled venn_circle_diameter
                   shifted (venn_circle_left_shift,venn_circle_top_shift) t;
    circle_right = (reverse fullcircle) scaled venn_circle_diameter
                   shifted (venn_circle_right_shift,venn_circle_top_shift) t;
    circle_bottom = (reverse fullcircle) rotated -90 scaled venn_circle_diameter
                   shifted (.5venn_width,venn_circle_bottom_shift) t;
    save area_lr, area_lb, area_rb, area_lrb;
    path area_lr, area_lb, area_rb, area_lrb;
    area_lr = buildcycle(circle_left,circle_right);
    area_lb = buildcycle(circle_left,circle_bottom);
    area_rb = buildcycle(circle_right,circle_bottom);
    area_lrb = buildcycle(circle_left,circle_right,circle_bottom);

    fill circle_left withcolor venn_color(cl);
    fill circle_right withcolor venn_color(cr);
    fill circle_bottom withcolor venn_color(cb);
    fill area_lr withcolor venn_color(lr);
    fill area_lb withcolor venn_color(lb);
    fill area_rb withcolor venn_color(rb);
    fill area_lrb withcolor venn_color(lrb);
    pickup pencircle scaled venn_pen;
    draw circle_left; draw circle_right; draw circle_bottom;
  endgroup
enddef;


% test: This works for me under Linux (2001-Apr-15)
%  > mpost venn
%  > tex mproof venn.0
%  > dvips -Pwww -omproof.ps mproof
% results in a document mproof.ps in PostScript that I can see with
% > gv mproof.ps (type that from an XWindow xterm).

% To run the test, uncomment the next five lines (including the `end').
%beginfig(0);
%  draw_venn_three(false,true,false,true,false,true,true,false);
%  draw_venn_three(false,true,false,true,false,true,true,false) shifted (2in,3in);
%endfig;
%end

