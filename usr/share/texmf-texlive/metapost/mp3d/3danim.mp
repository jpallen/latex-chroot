%%\input epsf
%%\def\newpage{\vfill\eject}
%%\advance\vsize1in
%%\let\ora\overrightarrow
%%\def\title#1{\hrule\vskip1mm#1\par\vskip1mm\hrule\vskip5mm}
%%\def\figure#1{\par\centerline{\epsfbox{#1}}}
%%\title{{\bf 3DANIM.MP: STANDARD ANIMATION DEFINITIONS IN METAPOST}}

%% version 1.34, 17 August 2003
%% {\bf Denis Roegel} ({\tt roegel@loria.fr})
%%
%%This package provides standard animation definitions and
%%must be used with the {\bf 3d} package.

if known three_d_anim_version: 
  expandafter endinput % avoids loading this package twice
fi;

% First, we load the 3D package
input 3d

message "*** 3danim,      v1.34 (c) D. Roegel, 17 August 2003 ***";
numeric three_d_anim_version;
three_d_anim_version=1.34;

%%\newpage
%%\title{Computation of field parameters of an animation}
numeric xmin_,ymin_,xmax_,ymax_;

def compute_bbox=
  if known xmin_:
    xmin_:=min(xmin_,xpart(llcorner(currentpicture)));
    ymin_:=min(ymin_,ypart(llcorner(currentpicture)));
    xmax_:=max(xmax_,xpart(urcorner(currentpicture)));
    ymax_:=max(ymax_,ypart(urcorner(currentpicture)));
  else:
    xmin_=xpart(llcorner(currentpicture));
    ymin_=ypart(llcorner(currentpicture));
    xmax_=xpart(urcorner(currentpicture));
    ymax_=ypart(urcorner(currentpicture));
  fi;
enddef;

extra_endfig:=extra_endfig & "compute_bbox;";

boolean show_animation_parameters;
show_animation_parameters=false;
% The paper height is purely virtual; it is a paper size
% such that the full animation can rest on it.
% It must be compatible with the |PAPERSIZE| option
% of |gs| in |write_script|.
% If the size (i.e. the bounding box) of the animation is too large,
% you may have to change the |paper_height| and the |gs| parameter.
% The ratio between the paper height and width is assumed to be sqrt(2).
numeric paper_height;
paper_height=29.7; % A4 paper height in cm
numeric output_res;
output_res=36; % default output resolution of bitmap: 36 dots per inch

% show bounding box of an animation, in PostScript points
% and parameters for animation script
vardef show_animation_bbox=
  save trx,try,h,w,delta,pnmx,pnmy,pnmw,pnmh,phbp,pwbp;
  w=xmax_-xmin_;h=ymax_-ymin_;
  if show_animation_parameters:
    message "animation bbox: (llx=" & decimal round(xmin_) 
      & ",lly=" & decimal round(ymin_)
      & ",w=" & decimal round(w) & ",h=" & decimal round(h) & ")";
  fi;
  % the lower left corner is put at position (20,20)
  trx=20-xmin_;
  try=20-ymin_;
  if show_animation_parameters:
    message "translate parameters: " 
    & decimal round(trx) & " " & decimal round(try);
  fi;
  xmin_:=xmin_+trx;ymin_:=ymin_+try;
  delta=10; % extra space
  phbp=paper_height/2.54*72; % paper height in PostScript points
  pwbp=phbp/sqrt(2); % paper width in PostScript points
                     % (assuming a sqrt(2) ratio)
  pnmx=round(xmin_*(output_res/72)-delta);
  pnmy=round((paper_height/2.54*72-ymin_-h)*(output_res/72)-delta);
  pnmw=round(w*(output_res/72)+2*delta);
  pnmh=round(h*(output_res/72)+2*delta);
  if show_animation_parameters:
    message "pnmcut parameters (with -r" & decimal output_res & "): " 
    & decimal pnmx & " " & decimal pnmy & " " 
    & decimal pnmw & " " & decimal pnmh;
  fi;
  if (pnmx<0) or (pnmy<0) or (pnmx+pnmw>=pwbp) or (pnmy+pnmh>=phbp):
    message "!! paper size overflow: you may need to reduce the size of";
    message "!! the animation, or to change the paper size";
  fi;
  write_script(round(trx),round(try),
    pnmx,pnmy,pnmw,pnmh,output_res,jobname,"create_animation.sh");    
enddef;

%%\newpage
%%\title{Creation of a shell script to automate the animation}
% This is UNIX targetted and may need to be customized.

vardef write_script(expr trx,try,xmin,ymin,w,h,res,output,file)=
  save s;
  string s;
  def write_to_file(text arg)=write arg to file; enddef;
  write_to_file("#! /bin/sh");
  write_to_file("");
  write_to_file("/bin/rm -f "&output&".log");
  write_to_file("for i in `ls "&output&".*| grep '"&output&".[0-9]'`;do");
    if false: "endfor" fi % indentation hack for meta-mode.el
  write_to_file("echo $i");
  write_to_file("echo '=============='");
  s:="awk  < $i '{print} /^%%Page: /{print "&ditto;
  s:=s&decimal trx&" "&decimal try&" translate\n"&ditto&"}' > $i.ps";
  write_to_file(s);
    % ghostscript PostScript into ppm
    % (the paper size must be compatible with the definition of |paper_height|)
  s:="gs -sDEVICE=ppmraw -sPAPERSIZE=a4 -dNOPAUSE ";
  s:=s&"-r"&decimal res &" -sOutputFile=$i.ppm -q -- $i.ps";
  write_to_file(s);
  write_to_file("/bin/rm -f $i.ps");
    % possible alternative:
    %    |s:="mogrify -compress -crop " & decimal(w) & "x" & decimal(h);|
    %    |s:=s&"+"& decimal(xmin) &"+"&decimal(ymin);|
    %    |s:=s&" -colors 32 -format gif $i.ppm";|
  s:="ppmquant 32 $i.ppm | pnmcut "& decimal(xmin) &" "&decimal(ymin);
  s:=s&" "&decimal(w)&" "&decimal(h) &" | ";
  s:=s&"ppmtogif > `expr $i.ppm : '\(.*\)ppm'`gif";
  write_to_file(s);
  write_to_file("/bin/rm -f $i.ppm");
  write_to_file("done");
  write_to_file("/bin/rm -f "&output&".gif");
  s:="gifmerge -10 -l1000 ";
  s:=s&output&".*.gif > "&output&".gif";
  write_to_file(s);
  write_to_file("/bin/rm -f "&output&".*.gif");
  write_to_file(EOF);% end of file
enddef;

% These definitions produce {\it one\/} image of some kind.

% In the standard animations, the observer follows a circle, shown below:
%%\figure{vect-fig.17}

% Standard image 1: this is an example and may be adapted.
% |name| is an object instance
def one_image(expr name,i,a,rd,ang)=
  beginfig(i);
    set_point_(Obs,-rd*cosd(a*ang),-rd*sind(a*ang),1);
    Obs_phi:=90;Obs_dist:=2;
    point_of_view_obj(name,1,Obs_phi);% fix point 1 of object |name|
    draw_obj(name);
    rotate_obj_pv(name,1,vec_I,ang);
    draw_point(name,1);% show the rotation point
    draw_axes(red,green,blue);
  endfig;
enddef;

% Standard image 2: this is an example and may be adapted.
% |name_a| and |name_b| are object instances.
def one_image_two_objects(expr name_a,name_b,i,a,rd,ang)=
  beginfig(i);
    set_point_(Obs,-rd*cosd(a*ang),-rd*sind(a*ang),1);
    Obs_phi:=90;Obs_dist:=2;
    point_of_view_obj(name_a,1,Obs_phi);% fix point 1 of object |name_a|
    draw_obj(name_a);draw_obj(name_b);
    rotate_obj_pv(name_a,1,vec_I,ang);
    rotate_obj_pv(name_b,13,vec_J,-ang);
      %|rotate_obj_pp(name_b,13,7,-ang);|
    draw_point(name_a,1);% show the rotation point
    draw_axes(red,green,blue);
  endfig;
enddef;

%%\newpage
% Standard image 3: this is an example and may be adapted.
% |name_a|, |name_b| and |name_c| are object instances.
def one_image_three_objects(expr name_a,name_b,name_c,i,a,rd,ang)=
  beginfig(i);
    set_point_(Obs,-rd*cosd(a*ang),-rd*sind(a*ang),1);
    Obs_phi:=90;Obs_dist:=2;h_field:=100;v_field:=150;
    point_of_view_obj(name_a,1,Obs_phi);% fix point 1 of object |name_a|
    draw_obj(name_a);draw_obj(name_b);draw_obj(name_c);
    new_vec(v_a);
    vec_def_(v_a,.03*cosd(-a*ang+90),.03*sind(-a*ang+90),0);
    translate_obj(name_c,v_a);
    free_vec(v_a);
    rotate_obj_pv(name_a,1,vec_I,ang);
    rotate_obj_pv(name_b,13,vec_J,-ang);
      %|rotate_obj_pp(name_b,13,7,-ang);|
    draw_point(name_a,1);% show the rotation point
    draw_axes(red,green,blue);
  endfig;
enddef;

% Standard image 4: this is an example and may be adapted.
% |name_a| and |name_b| are object instances.
def one_image_two_identical_objects(expr name_a,name_b,i,a,rd,ang)=
  beginfig(i);
    set_point_(Obs,-rd*cosd(a*ang),-rd*sind(a*ang),2);
    Obs_phi:=90;Obs_dist:=2;
    point_of_view_obj(name_a,1,Obs_phi);% fix point 1 of object |name_a|
    draw_obj(name_a);draw_obj(name_b);
    rotate_obj_pv(name_a,1,vec_I,ang);
    rotate_obj_pv(name_b,13,vec_J,-ang);
      %|rotate_obj_pp(name_a,13,7,-ang);|
    draw_point(name_a,1);% show the rotation point
    draw_axes(red,green,blue);
  endfig;
enddef;


%%\newpage
% An animation is a series of images, and these series are produced here.

% Standard animation 1
% |name| is a class name
def animate_object(expr name,imin,imax,index)=
  numeric ang;ang=360/(imax-imin+1);
  assign_obj("obj",name);
  for i:=imin upto imax:one_image("obj",i+index,i,5,ang);endfor;
  show_animation_bbox;
enddef;

% Standard animation 2
% |name_a| and |name_b| are class names
def animate_two_objects(expr name_a,name_b,imin,imax,index)=
  numeric ang;ang=360/(imax-imin+1);
  assign_obj("obja",name_a);assign_obj("objb",name_b);
  translate_obj("objb",vec_K);translate_obj("objb",vec_K);
  for i:=imin upto imax:
    one_image_two_objects("obja","objb",i+index,i,10,ang);
  endfor;
  show_animation_bbox;
enddef;

% Standard animation 3
% |name_a|, |name_b| and |name_c| are class names
vardef animate_three_objects(expr name_a,name_b,name_c,imin,imax,index)=
  numeric ang;ang=360/(imax-imin+1);
  assign_obj("obja",name_a);assign_obj("objb",name_b);
  assign_obj("objc",name_c);
  scale_obj("objb",.7);
  new_vec(v_a);
  vec_def_vec_(v_a,vec_K);vec_mult_(v_a,v_a,4);put_obj("objb",v_a,1,0,0,0);
  free_vec(v_a);
  scale_obj("objc",.5);
  translate_obj("objc",vec_K);translate_obj("objc",vec_K);
  for i:=imin upto imax:
    one_image_three_objects("obja","objb","objc",i+index,i,7,ang);
  endfor;
  show_animation_bbox;
enddef;

% Standard animation 4
% |name| is a class name
def animate_two_identical_objects(expr name,imin,imax,index)=
  numeric ang;ang=360/(imax-imin+1);
  assign_obj("obja",name);assign_obj("objb",name);
  translate_obj("objb",vec_K);translate_obj("objb",vec_K);
  for i:=imin upto imax:
    one_image_two_identical_objects("obja","objb",i+index,i,10,ang);
  endfor;
  show_animation_bbox;
enddef;

endinput

