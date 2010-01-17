%%\input epsf
%%\def\newpage{\vfill\eject}
%%\advance\vsize1in
%%\let\ora\overrightarrow
%%\def\title#1{\hrule\vskip1mm#1\par\vskip1mm\hrule\vskip5mm}
%%\def\figure#1{\par\centerline{\epsfbox{#1}}}
%%\title{{\bf 3D.MP: 3-DIMENSIONAL REPRESENTATIONS IN METAPOST}}

%% version 1.34, 17 August 2003
%% {\bf Denis Roegel} ({\tt roegel@loria.fr}) 

%% This package provides definitions enabling the manipulation
%% and animation of 3-dimensional objects.
%% Such objects can be included in a \TeX{} file or used on web pages
%% for instance. See the documentation enclosed in the distribution for
%% more details.

%% Thanks to John Hobby and Ulrik Vieth for helpful hints.

%% PROJECTS FOR THE FUTURE:

%%   $-$ take light sources into account and show shadows and darker faces

%%   $-$ handle overlapping of objects ({\it obj\_name\/} can be used when
%%     going through all faces)

if known three_d_version: 
  expandafter endinput % avoids loading this package twice
fi;

message "*** 3d,          v1.34 (c) D. Roegel, 17 August 2003 ***";
numeric three_d_version;
three_d_version=1.34;

% This package needs |3dgeom| in a few places. |3dgeom| also loads |3d|
% but that's not a problem.
%
input 3dgeom; 

%%\newpage
%%\title{Vector operations}

% components of vector |i|
def xval(expr i)=vec[i]x enddef;
def yval(expr i)=vec[i]y enddef;
def zval(expr i)=vec[i]z enddef;

% vector (or point) equality (absolute version)
def vec_eq_(expr i,j)=
  ((xval(i)=xval(j)) and (yval(i)=yval(j)) and (zval(i)=zval(j)))
enddef;

% vector (or point) equality (local version)
def vec_eq(expr i,j)=vec_eq_(pnt(i),pnt(j)) enddef;

% vector inequality (absolute version)
def vec_neq_(expr i,j)=(not vec_eq_(i,j)) enddef;

% vector inequality (local version)
def vec_neq(expr i,j)=(not vec_eq(i,j)) enddef;

% definition of vector |i| by its coordinates (absolute version)
def vec_def_(expr i,xi,yi,zi)= vec[i]x:=xi;vec[i]y:=yi;vec[i]z:=zi; enddef;

% definition of vector |i| by its coordinates (local version)
def vec_def(expr i,xi,yi,zi)= vec_def_(pnt(i),xi,yi,zi) enddef;

% a point is stored as a vector (absolute version)
let set_point_ = vec_def_;

% a point is stored as a vector (local version)
let set_point = vec_def;

def set_point_vec_(expr i,v)=
  set_point_(i,xval(v),yval(v),zval(v))
enddef;

def set_point_vec(expr i,v)=set_point_vec_(pnt(i),v) enddef;

let vec_def_vec_=set_point_vec_;
let vec_def_vec=set_point_vec;

% vector sum: |vec[k]| $\leftarrow$ |vec[i]|$+$|vec[j]| (absolute version)
def vec_sum_(expr k,i,j)=
  vec[k]x:=vec[i]x+vec[j]x;
  vec[k]y:=vec[i]y+vec[j]y;
  vec[k]z:=vec[i]z+vec[j]z;
enddef;

% vector sum: |vec[k]| $\leftarrow$ |vec[i]|$+$|vec[j]| (local version)
def vec_sum(expr k,i,j)=vec_sum_(pnt(k),pnt(i),pnt(j)) enddef;

% vector translation: |vec[i]| $\leftarrow$ |vec[i]|$+$|vec[v]|
def vec_translate_(expr i,v)=vec_sum_(i,i,v) enddef;

% Here, the second parameter is absolute, because this is probably
% the most common case.
def vec_translate(expr i,v)=vec_translate_(pnt(i),v) enddef;

% vector difference: |vec[k]| $\leftarrow$ |vec[i]|$-$|vec[j]|
def vec_diff_(expr k,i,j)=
  vec[k]x:=vec[i]x-vec[j]x;
  vec[k]y:=vec[i]y-vec[j]y;
  vec[k]z:=vec[i]z-vec[j]z;
enddef;

def vec_diff(expr k,i,j)=vec_diff_(pnt(k),pnt(i),pnt(j)) enddef;

% dot product of |vec[i]| and |vec[j]|
vardef vec_dprod_(expr i,j)=
  (vec[i]x*vec[j]x+vec[i]y*vec[j]y+vec[i]z*vec[j]z)
enddef;

vardef vec_dprod(expr i,j)=vec_dprod_(pnt(i),pnt(j)) enddef;

% modulus of |vec[i]|, absolute version
% In the computation, we try to avoid overflows or underflows;
% we perform a scaling in order to avoid losing too much
% information in certain cases
vardef vec_mod_(expr i)=
  save prod,m_;
  hide(
    new_vec(v_a);
    m_=max(abs(xval(i)),abs(yval(i)),abs(zval(i)));
    if m_>0:vec_mult_(v_a,i,1/m_);else:vec_def_vec_(v_a,vec_null);fi;
    prod=m_*sqrt(vec_dprod_(v_a,v_a));
    free_vec(v_a);
  )
  prod      
enddef;

% modulus of |vec[i]|, local version
% If the return value must be compared to 0,
% use |vec_eq| with |vec_null| instead.
vardef vec_mod(expr i)= vec_mod_(pnt(i)) enddef;

% unit vector |vec[i]| corresponding to vector |vec[j]|
% only non-null vectors are changed
def vec_unit_(expr i,j)=
  if vec_mod_(j)>0: vec_mult_(i,j,1/vec_mod_(j));
  else:vec_def_vec_(i,j);
  fi;
enddef;

def vec_unit(expr i,j)=vec_unit_(pnt(i),pnt(j)) enddef;

% vector product: |vec[k]| $\leftarrow$ |vec[i]| $\land$ |vec[j]|
def vec_prod_(expr k,i,j)=
  vec[k]x:=vec[i]y*vec[j]z-vec[i]z*vec[j]y;
  vec[k]y:=vec[i]z*vec[j]x-vec[i]x*vec[j]z;
  vec[k]z:=vec[i]x*vec[j]y-vec[i]y*vec[j]x;
enddef;

def vec_prod(expr k,i,j)=vec_prod_(pnt(k),pnt(i),pnt(j)) enddef;

% scalar multiplication: |vec[j]| $\leftarrow$ |vec[i]*v| (absolute version)
def vec_mult_(expr j,i,v)=
  vec[j]x:=v*vec[i]x;vec[j]y:=v*vec[i]y;vec[j]z:=v*vec[i]z;
enddef;

% scalar multiplication: |vec[j]| $\leftarrow$ |vec[i]*v| (local version)
def vec_mult(expr j,i,v)=vec_mult_(pnt(j),pnt(i),v) enddef;

% middle of two points (absolute version)
def mid_point_(expr k,i,j)= vec_sum_(k,i,j);vec_mult_(k,k,.5); enddef;

% middle of two points (local version)
def mid_point(expr k,i,j)= mid_point_(pnt(k),pnt(i),pnt(j)); enddef;

%%\newpage
%%\title{Vector rotation}
% Rotation of |vec[v]| around |vec[axis]| by an angle |alpha|

%% The vector $\vec{v}$ is first projected on the axis
%% giving vectors $\vec{a}$ and $\vec{h}$:
%%\figure{vect-fig.9}
%% If we set 
%% $\vec{b}={\ora{axis}\over \left\Vert\vcenter{\ora{axis}}\right\Vert}$,
%% the rotated vector $\vec{v'}$ is equal to $\vec{h}+\vec{f}$
%% where $\vec{f}=\cos\alpha \cdot \vec{a} + \sin\alpha\cdot \vec{c}$.
%% and $\vec{h}=(\vec{v}\cdot\vec{b})\vec{b}$ 
%%\figure{vect-fig.10}

% The rotation is independent of |vec[axis]|'s module.
% |v| = old and new vector
% |axis| = rotation axis
% |alpha| = rotation angle
%
vardef vec_rotate_(expr v,axis,alpha)=
  new_vec(v_a);new_vec(v_b);new_vec(v_c);
  new_vec(v_d);new_vec(v_e);new_vec(v_f);
  new_vec(v_g);new_vec(v_h);
  vec_mult_(v_b,axis,1/vec_mod_(axis));
  vec_mult_(v_h,v_b,vec_dprod_(v_b,v)); % projection of |v| on |axis|
  vec_diff_(v_a,v,v_h);
  vec_prod_(v_c,v_b,v_a);
  vec_mult_(v_d,v_a,cosd(alpha));
  vec_mult_(v_e,v_c,sind(alpha));
  vec_sum_(v_f,v_d,v_e);
  vec_sum_(v,v_f,v_h);
  free_vec(v_h);free_vec(v_g);
  free_vec(v_f);free_vec(v_e);free_vec(v_d);
  free_vec(v_c);free_vec(v_b);free_vec(v_a);
enddef;

% The second parameter is left absolute because this is probably the most
% common case.
vardef vec_rotate(expr v,axis,alpha)=vec_rotate_(pnt(v),axis,alpha) enddef;

%%\newpage
%%\title{Operations on objects}
% |iname| is the handler for an instance of an object of class |name|
% |iname| must be a letter string
% |vardef| is not used because at some point we give other names
% to |assign_obj| with |let| and this cannot be done with |vardef|.
% (see MFbook for details)
def assign_obj(expr iname,name)=
  begingroup 
  save tmpdef;
  string tmpdef; % we need to add double quotes (char 34)
  tmpdef="def " & iname & "_class=" & ditto & name & ditto & " enddef";
  scantokens tmpdef;
  def_obj(iname);
  endgroup
enddef;

% |name| is the the name of an object instance
% It must be made only of letters (or underscores), but no digits.
def def_obj(expr name)=
  scantokens begingroup 
    save tmpdef;string tmpdef;
    tmpdef="def_" & obj_class_(name) & "(" & ditto & name & ditto & ")";
    tmpdef
  endgroup
enddef;

% This macro puts an object back where it was right at the beginning,
% or rather, where the |set| definition puts it (which may be different
% than the initial position, in case it depends on parameters).
% |iname| is the name of an object instance.
vardef reset_obj(expr iname)=
  save tmpdef;
  string tmpdef;
  define_current_point_offset_(iname);
  tmpdef="set_" & obj_class_(iname) & "_points";
  scantokens tmpdef(iname);
enddef;

% Put an object at position given by |pos| (a vector) and
% with orientations given by angles |psi|, |theta|, |phi|.
% The object is scaled by |scale|.
% |iname| is the name of an object instance.
% If the shape of the object has been changed since it was
% created, these changes are lost.
vardef put_obj(expr iname,pos,scale,psi,theta,phi)=
  reset_obj(iname);scale_obj(iname,scale);
  new_vec(v_x);new_vec(v_y);new_vec(v_z);
  vec_def_vec_(v_x,vec_I);
  vec_def_vec_(v_y,vec_J);
  vec_def_vec_(v_z,vec_K);
  rotate_obj_abs_pv(iname,point_null,v_z,psi);
  vec_rotate_(v_x,v_z,psi);vec_rotate_(v_y,v_z,psi);
  rotate_obj_abs_pv(iname,point_null,v_y,theta);
  vec_rotate_(v_x,v_y,theta);vec_rotate_(v_z,v_y,theta);
  rotate_obj_abs_pv(iname,point_null,v_x,phi);
  vec_rotate_(v_y,v_x,phi);vec_rotate_(v_z,v_x,phi);
  free_vec(v_z);free_vec(v_y);free_vec(v_x);    
  translate_obj(iname,pos);
enddef;

%%\newpage
%%\title{Rotation, translation and scaling of objects}
% Rotation of an object instance |name| around an axis 
% going through a point |p| (local to the object)
% and directed by vector |vec[v]|. The angle of rotation is |a|.
vardef rotate_obj_pv(expr name,p,v,a)=
  define_current_point_offset_(name);
  rotate_obj_abs_pv(name,pnt(p),v,a);
enddef;

vardef rotate_obj_abs_pv(expr name,p,v,a)=
  define_current_point_offset_(name);
  new_vec(v_a);
  for i:=1 upto obj_points_(name):
    vec_diff_(v_a,pnt(i),p);
    vec_rotate_(v_a,v,a);
    vec_sum_(pnt(i),v_a,p);
  endfor;
  free_vec(v_a);
enddef;

% Rotation of an object instance |name| around an axis 
% going through a point |p| (local to the object)
% and directed by vector $\ora{pq}$. The angle of rotation is |a|.
vardef rotate_obj_pp(expr name,p,q,a)=
  define_current_point_offset_(name);
  new_vec(v_a);new_vec(axis);
  vec_diff_(axis,pnt(q),pnt(p));
  for i:=1 upto obj_points_(name):
    vec_diff_(v_a,pnt(i),pnt(p));
    vec_rotate_(v_a,axis,a);
    vec_sum_(pnt(i),v_a,pnt(p));
  endfor;
  free_vec(axis);free_vec(v_a);
enddef;

% Translation of an object instance |name| by a vector |vec[v]|.
vardef translate_obj(expr name,v)=
  define_current_point_offset_(name);
  for i:=1 upto obj_points_(name):
    vec_sum_(pnt(i),pnt(i),v);
  endfor;
enddef;

% Scalar multiplication of an object instance |name| by a scalar |v|.
vardef scale_obj(expr name,v)=
  define_current_point_offset_(name);
  for i:=1 upto obj_points_(name):
    vec_mult(i,i,v);
  endfor;
enddef;


%%\newpage
%%\title{Functions to build new points in space}
% Rotation in a plane: this is useful to define a regular polygon.
% |k| is a new point obtained from point |j| by rotation around |o|
% by a angle $\alpha$ equal to the angle from |i| to |j|.
%%\figure{vect-fig.11}
vardef rotate_in_plane_(expr k,o,i,j)=
  save cosalpha,sinalpha,alpha;
  new_vec(v_a);new_vec(v_b);new_vec(v_c);
  vec_diff_(v_a,i,o);vec_diff_(v_b,j,o);vec_prod_(v_c,v_a,v_b);
  cosalpha=vec_dprod_(v_a,v_b)/vec_mod_(v_a)/vec_mod_(v_b);
  sinalpha=sqrt(1-cosalpha**2);
  alpha=angle((cosalpha,sinalpha));
  vec_rotate_(v_b,v_c,alpha);
  vec_sum_(k,o,v_b);
  free_vec(v_c);free_vec(v_b);free_vec(v_a);
enddef;

vardef rotate_in_plane(expr k,o,i,j)=
  rotate_in_plane_(pnt(k),o,pnt(i),pnt(j)) 
enddef;

% Build a point on a adjacent face.
%% The middle $m$ of points $i$ and $j$ is such that
%% $\widehat{(\ora{om},\ora{mc})}=\alpha$ 
%% This is useful to define regular polyhedra
%%\figure{vect-fig.7}
vardef new_face_point_(expr c,o,i,j,alpha)=
  new_vec(v_a);new_vec(v_b);new_vec(v_c);new_vec(v_d);new_vec(v_e);
  vec_diff_(v_a,i,o);vec_diff_(v_b,j,o);
  vec_sum_(v_c,v_a,v_b);
  vec_mult_(v_d,v_c,.5);
  vec_diff_(v_e,i,j);
  vec_sum_(c,v_d,o);
  vec_rotate_(v_d,v_e,alpha);
  vec_sum_(c,v_d,c);
  free_vec(v_e);free_vec(v_d);free_vec(v_c);free_vec(v_b);free_vec(v_a);
enddef;

vardef new_face_point(expr c,o,i,j,alpha)=
  new_face_point_(pnt(c),pnt(o),pnt(i),pnt(j),alpha)
enddef;

vardef new_abs_face_point(expr c,o,i,j,alpha)=
  new_face_point_(c,o,pnt(i),pnt(j),alpha)
enddef;

%%\newpage
%%\title{Computation of the projection of a point on the ``screen''}
% |p| is the projection of |m|
% |m| = point in space (3 coordinates)
% |p| = point of the intersection plane 
%%\figure{vect-fig.8}
vardef project_point(expr p,m)=
  save tmpalpha;
  new_vec(v_a);new_vec(v_b);
  if projection_type=2: % oblique
    if point_in_plane_p_pl_(m)(projection_plane):
      % |m| is on the projection plane
      vec_diff_(v_a,m,ObliqueCenter_);
      y[p]:=drawing_scale*vec_dprod_(v_a,ProjJ_);
      x[p]:=drawing_scale*vec_dprod_(v_a,ProjK_);
    else: % |m| is not on the projection plane
      new_line_(l)(m,ObliqueCenter_);
      vec_diff_(l2,l2,Obs);
      vec_sum_(l2,l2,m);
      % (the direction does not depend on Obs)
      if def_inter_p_l_pl_(v_a)(l)(projection_plane):
        vec_diff_(v_a,v_a,ObliqueCenter_);
        y[p]:=drawing_scale*vec_dprod_(v_a,ProjJ_);
        x[p]:=drawing_scale*vec_dprod_(v_a,ProjK_);
      else: message "Point " & decimal m & " cannot be projected";
        x[p]:=too_big_;y[p]=too_big_;
      fi;
      free_line(l);
    fi;
  else:
    vec_diff_(v_b,m,Obs); % vector |Obs|-|m|
      % |vec[v_a]| is |vec[v_b]| expressed in (|ObsI_|,|ObsJ_|,|ObsK_|)
      % coordinates.
    vec[v_a]x:=vec[IObsI_]x*vec[v_b]x
    +vec[IObsJ_]x*vec[v_b]y+vec[IObsK_]x*vec[v_b]z;
    vec[v_a]y:=vec[IObsI_]y*vec[v_b]x
    +vec[IObsJ_]y*vec[v_b]y+vec[IObsK_]y*vec[v_b]z;
    vec[v_a]z:=vec[IObsI_]z*vec[v_b]x
    +vec[IObsJ_]z*vec[v_b]y+vec[IObsK_]z*vec[v_b]z;
    if vec[v_a]x<Obs_dist: % then, point |m| is too close
      message "Point " & decimal m & " too close -> not drawn";
      x[p]:=too_big_;y[p]=too_big_;
    else:
      if (angle(vec[v_a]x,vec[v_a]z)>h_field/2)
        or (angle(vec[v_a]x,vec[v_a]y)>v_field/2):
        message "Point " & decimal m & " out of screen -> not drawn";
        x[p]:=too_big_;y[p]=too_big_;
      else:
        if projection_type=0: % central perspective
	  tmpalpha:=Obs_dist/vec[v_a]x;
        else:
	  tmpalpha:=1; % parallel
        fi;
        y[p]:=drawing_scale*tmpalpha*vec[v_a]y;
        x[p]:=drawing_scale*tmpalpha*vec[v_a]z;
      fi;
    fi;
  fi;
  free_vec(v_b);free_vec(v_a);
enddef;

% At some point, we may need to do an oblique projection
% of vectors |ObsK_| and |ObsI_| on a plane, and to normalize
% and orthogonalize the projections (with the projection of |ObsK_|
% keeping the same direction). This is done here,
% where we take two vectors, a direction (line) and
% a plane, and return two vectors. This function assumes
% there is an intersection between line |l| and plane |p|.
% We do not test it here.

vardef project_vectors(expr va,vb)(expr k,i)(text l)(text p)=
  save vc;new_vec(vc);
  if proj_v_v_l_pl_(va,k)(l)(p): % |va| is the projection of vector |k|
  else: message "THIS SHOULD NOT HAPPEN";
  fi;
  if proj_v_v_l_pl_(vb,i)(l)(p): % |vb| is the projection of vector |i|
  else: message "THIS SHOULD NOT HAPPEN";
  fi;
  % now, we orthonormalize these vectors:
  vec_prod_(vc,va,vb);
  vec_unit_(va,va);vec_unit_(vc,vc);vec_prod_(vb,vc,va);
  free_vec(vc);
enddef;

% Object projection
% This is a mere iteration on |project_point|
def project_obj(expr name)=
  define_current_point_offset_(name);
  for i:=1 upto obj_points_(name):
    project_point(ipnt_(i),pnt(i));endfor;
enddef;

% Projection screen
vardef show_projection_screen=
  save dx,dy;
  dx=Obs_dist*sind(h_field/2)/cosd(h_field/2);
  dy=Obs_dist*sind(v_field/2)/cosd(v_field/2);
  new_vec(pa);new_vec(pb);new_vec(pc);new_vec(pd);new_vec(op);
  new_vec(w);new_vec(h);
  vec_mult_(op,ObsI_,Obs_dist);vec_sum_(op,op,Obs); % center of screen
  vec_mult_(w,ObsK_,dx);vec_mult_(h,ObsJ_,dy);
  vec_sum_(pa,op,w);vec_sum_(pa,pa,h); % upper right corner
  vec_mult_(w,w,-2);vec_mult_(h,h,-2);
  vec_sum_(pb,pa,w);vec_sum_(pc,pb,h);vec_sum_(pd,pa,h);
  message "Screen at corners:";
  show_point("urcorner: ",pa);
  show_point("ulcorner: ",pb);
  show_point("llcorner: ",pc);
  show_point("lrcorner: ",pd);
  show_point("Obs:",Obs);
  free_vec(h);free_vec(w);
  free_vec(op);free_vec(pd);free_vec(pc);free_vec(pb);free_vec(pa);
enddef;


%%\newpage
%%\title{Draw one face, hiding it if it is hidden}
% The order of the vertices determines what is the visible side
% of the face. The order must be clockwise when the face is seen.
% |drawhidden| is a boolean; if |true| only hidden faces are drawn; if |false|,
% only visible faces are drawn. Therefore, |draw_face| is called twice
% by |draw_faces|.
vardef draw_face(text vertices)(expr col,drawhidden)=
  save p,num,overflow,i,j,k,nv;
  path p;boolean overflow;
  overflow=false;
  forsuffixes $=vertices:
    if z[ipnt_($)]=(too_big_,too_big_):overflow:=true; fi;
    exitif overflow;
  endfor;
  if overflow: message "Face can not be drawn, due to overflow";
  else:
    p=forsuffixes $=vertices:z[ipnt_($)]--endfor cycle;
    % we do now search for three distinct and non-aligned suffixes:
    % usually, the first three suffixes do
    new_vec(normal_vec);new_vec(v_a);new_vec(v_b);new_vec(v_c);
    % first, we copy all the indexes in an array, so that
    % it is easier to go through them
    i=1; % num0 is not used
    forsuffixes $=vertices:num[i]=$;i:=i+1;endfor;
    nv=i-1;
    for $:=1 upto nv:
      for $$:=$+1 upto nv:
	for $$$:=$$+1 upto nv:
	  vec_diff_(v_a,pnt(num[$$]),pnt(num[$]));
          vec_diff_(v_b,pnt(num[$$$]),pnt(num[$$]));
          vec_prod_(normal_vec,v_a,v_b);
          exitif vec_neq_(normal_vec,vec_null);
	      % |vec_mod_| must not be used for such a test
	endfor;
	exitif vec_neq_(normal_vec,vec_null);
      endfor;
      exitif vec_neq_(normal_vec,vec_null);
    endfor;
    if projection_type=0: % perspective
      vec_diff_(v_c,pnt(num1),Obs);
    else: % parallel
      vec_def_vec_(v_c,ObsI_); 
    fi;
    if filled_faces:
      if vec_dprod_(normal_vec,v_c)<0:
        fill p withcolor col;drawcontour(p,contour_width,contour_color)();
      else: % |draw p dashed evenly;| if this is done, you must ensure
              % that hidden faces are (re)drawn at the end    
      fi;
    else:
      if vec_dprod_(normal_vec,v_c)<0:%visible
        if not drawhidden:drawcontour(p,contour_width,contour_color)();fi;
      else: % hidden
        if drawhidden:
	  drawcontour(p,contour_width,contour_color)(dashed evenly);
        fi;
      fi;
    fi;
    free_vec(v_c);free_vec(v_b);free_vec(v_a);free_vec(normal_vec);
  fi;
enddef;

% |p| is the path to draw (a face contour), |thickness| is the pen width
% |col| is the color and |type| is a line modifier.
def drawcontour(expr p,thickness,col)(text type)=
  if draw_contours and (thickness>0):
    pickup pencircle scaled thickness;
    draw p withcolor background; % avoid strange overlapping dashes
    draw p type withcolor col;
    pickup pencircle scaled .4pt;
  fi;
enddef;

%%\newpage
% Variables for face handling. First, we have an array for lists of vertices
% corresponding to faces. 
string face_points_[];% analogous to |vec| arrays

% Then, we have an array of colors. A color needs to be a string
% representing an hexadecimal RGB coding of a color.
string face_color_[];

% |name| is the name of an object instance
vardef draw_faces(expr name)=
  save tmpdef;string tmpdef;
  define_current_face_offset_(name);
    % first the hidden faces (dashes must be drawn first):
  for i:=1 upto obj_faces_(name):
    tmpdef:="draw_face(" & face_points_[face(i)] 
      & ")(hexcolor(" & ditto & face_color_[face(i)] & ditto 
      & "),true)";scantokens tmpdef;
  endfor;
    % then, the visible faces:
  for i:=1 upto obj_faces_(name):
    tmpdef:="draw_face(" & face_points_[face(i)] 
      & ")(hexcolor(" & ditto & face_color_[face(i)] & ditto 
      & "),false)";scantokens tmpdef;
  endfor;
enddef;

% Draw point |n| of object instance |name|
vardef draw_point(expr name,n)=
  define_current_point_offset_(name);
  project_point(ipnt_(n),pnt(n));
  if z[ipnt_(n)] <> (too_big_,too_big_):
    pickup pencircle scaled 5pt;
    drawdot(z[ipnt_(n)]);
    pickup pencircle scaled .4pt;
  fi;
enddef;

vardef draw_axes(expr r,g,b)=
  project_point(1,vec_null);
  project_point(2,vec_I);
  project_point(3,vec_J);
  project_point(4,vec_K);
  if (z1<>(too_big_,too_big_)):
    if (z2<>(too_big_,too_big_)):
      drawarrow z1--z2 dashed evenly withcolor r;
    fi;
    if (z3<>(too_big_,too_big_)):
      drawarrow z1--z3 dashed evenly withcolor g;
    fi;
    if (z4<>(too_big_,too_big_)):
      drawarrow z1--z4 dashed evenly withcolor b;
    fi;
  fi;
enddef;

% Draw a polygonal line through the list of points
% This implementation does not work if you call
% |draw_lines(i,i+4)| because \MP{} adds parentheses around
% the value of |i|.
def draw_lines(text vertices)=
  begingroup % so that we can |let| |draw_lines|
  save j,num,np;
  % first, we copy all the indexes in an array, so that
  % it is easier to go through them
  j=1;
  for $=vertices:num[j]=$;j:=j+1;endfor;
  np=j-1;
  for j:=1 upto np-1:
    draw z[ipnt_(num[j])]--z[ipnt_(num[j+1])];
  endfor;
  endgroup
enddef;

let draw_line=draw_lines;

% Draw an arrow between points |i| and |j| of current object
% This is used from the |draw| definition of an object.
def draw_arrow(expr i,j)=
  drawarrow z[ipnt_(i)]--z[ipnt_(j)];
enddef;

% Draw a line between points |i| of object |obja| and |j| of |objb|
% This is used when outside an object (i.e., we can't presuppose
% any object offset)
vardef draw_line_inter(expr obja, i, objb, j)=
  project_point(1,pnt_obj(obja,i));
  project_point(2,pnt_obj(objb,j));
  draw z1--z2;
enddef;

% Draw an arrow between points |i| of object |obja| and |j| of |objb|
% This is used when outside an object (i.e., we can't presuppose
% any object offset)
vardef draw_arrow_inter(expr obja, i, objb, j)=
  project_point(1,pnt_obj(obja,i));
  project_point(2,pnt_obj(objb,j));
  draw z1--z2;
enddef;

%%\newpage
% Definition of a macro |obj_name| returning an object name 
% when given an absolute
% face number. This definition is built incrementally through a string, 
% everytime a new object is defined.
% |obj_name| is defined by |redefine_obj_name_|.

% Initial definition
string index_to_name_;
index_to_name_="def obj_name(expr i)=if i<1:";

% |name| is the name of an object instance
% |n| is the absolute index of its last face
def redefine_obj_name_(expr name,n)=
  index_to_name_:=index_to_name_ & "elseif i<=" & decimal n & ":" & ditto
      & name & ditto;
  scantokens begingroup index_to_name_ & "fi;enddef;" endgroup;
enddef;

% |i| is an absolute face number
% |vertices| is a string representing a list of vertices
% |rgbcolor| is a string representing a color in rgb hexadecimal
def set_face(expr i,vertices,rgbcolor)=
  face_points_[i]:=vertices;face_color_[i]:=rgbcolor;
enddef;

% |i| is a local face number
% |vertices| is a string representing a list of vertices
% |rgbcolor| is a string representing a color in rgb hexadecimal
def set_obj_face(expr i,vertices,rgbcolor)=set_face(face(i),vertices,rgbcolor)
enddef;

% |i| is a local face number of object |inst|
% |rgbcolor| is a string representing a color in rgb hexadecimal
def set_obj_face_color(expr inst,i,rgbcolor)=
  face_color_[face_obj(inst,i)]:=rgbcolor;
enddef;


%%\newpage
%%\title{Compute the vectors corresponding to the observer's viewpoint}
% (vectors |ObsI_|,|ObsJ_| and |ObsK_| in the |vec_I|,|vec_J|,
% |vec_K| reference; and vectors |IObsI_|,|IObsJ_| and |IObsK_| 
% which are |vec_I|,|vec_J|,|vec_K| 
% in the |ObsI_|,|ObsJ_|,|ObsK_| reference)
%%\figure{vect-fig.16}
%% (here, $\psi>0$, $\theta<0$ and $\phi>0$; moreover, 
%% $\vert\theta\vert \leq 90^\circ$)

def compute_reference(expr psi,theta,phi)=
   % |ObsI_| defines the direction of observation; 
   % |ObsJ_| and |ObsK_| the orientation
   % (but one of these two vectors is enough,
   % since |ObsK_| = |ObsI_| $\land$ |ObsJ_|)
   % The vectors are found by rotations of |vec_I|,|vec_J|,|vec_K|.
  vec_def_vec_(ObsI_,vec_I);vec_def_vec_(ObsJ_,vec_J);
  vec_def_vec_(ObsK_,vec_K);
  vec_rotate_(ObsI_,ObsK_,psi);
  vec_rotate_(ObsJ_,ObsK_,psi);% gives ($u$,$v$,$z$)
  vec_rotate_(ObsI_,ObsJ_,theta);
  vec_rotate_(ObsK_,ObsJ_,theta);% gives ($Obs_x$,$v$,$w$)
  vec_rotate_(ObsJ_,ObsI_,phi);
  vec_rotate_(ObsK_,ObsI_,phi);% gives ($Obs_x$,$Obs_y$,$Obs_z$)
   % The passage matrix $P$ from |vec_I|,|vec_J|,|vec_K| 
   % to |ObsI_|,|ObsJ_|,|ObsK_| is the matrix
   % composed of the vectors |ObsI_|,|ObsJ_| and |ObsK_| expressed 
   % in the base |vec_I|,|vec_J|,|vec_K|.
   % We have $X=P X'$ where $X$ are the coordinates of a point 
   % in |vec_I|,|vec_J|,|vec_K|
   % and $X'$ the coordinates of the same point in |ObsI_|,|ObsJ_|,|ObsK_|.
   % In order to get $P^{-1}$, it suffices to build vectors using
   % the previous rotations in the inverse order.
  vec_def_vec_(IObsI_,vec_I);vec_def_vec_(IObsJ_,vec_J);
  vec_def_vec_(IObsK_,vec_K);
  vec_rotate_(IObsK_,IObsI_,-phi);vec_rotate_(IObsJ_,IObsI_,-phi);
  vec_rotate_(IObsK_,IObsJ_,-theta);vec_rotate_(IObsI_,IObsJ_,-theta);
  vec_rotate_(IObsJ_,IObsK_,-psi);vec_rotate_(IObsI_,IObsK_,-psi);
enddef;

%%\newpage
%%\title{Point of view}
% This macro computes the three angles necessary for |compute_reference|
% |name| =  name of an instance of an object 
% |target| = target point (local to object |name|)
% |phi| = angle
vardef point_of_view_obj(expr name,target,phi)=
  define_current_point_offset_(name);% enables |pnt|
  point_of_view_abs(pnt(target),phi);
enddef;

% Compute absolute perspective. |target| is an absolute point number
% |phi| = angle
% This function also computes two vectors needed in case
% of an oblique projection.
vardef point_of_view_abs(expr target,phi)=
  save psi,theta;
  new_vec(v_a);
  vec_diff_(v_a,target,Obs);
  vec_mult_(v_a,v_a,1/vec_mod_(v_a));
  psi=angle((vec[v_a]x,vec[v_a]y));
  theta=-angle((vec[v_a]x++vec[v_a]y,vec[v_a]z));
  compute_reference(psi,theta,phi);
  if projection_type=2: % oblique
    % we start by checking that at a minimum the three points defining
    % the projection plane have different indexes; it doesn't mean
    % the plane if well defined, but if two values are identical,
    % the plane can't be well defined.
    if ((projection_plane1<>projection_plane2) and
      (projection_plane1<>projection_plane3) and
      (projection_plane2<>projection_plane3)):
      new_line_(l)(Obs,Obs);
      vec_sum_(l2,ObsI_,Obs);
      if def_inter_p_l_pl_(ObliqueCenter_)(l)(projection_plane):
        project_vectors(ProjK_,ProjJ_)(ObsK_,ObsJ_)(l)(projection_plane);
	% define the projection direction
	set_line_(projection_direction)(Obs,ObliqueCenter_);
      else:
	message "Anomalous oblique projection:";
	message "  the observer is watching parallely to the plane";
      fi;
      free_line(l);
    else:
      message "Anomalous projection plane; did you define it?";
    fi;
  fi;
  free_vec(v_a);
enddef;


% Distance between the observer and point |n| of object |name|
% Result is put in |dist|
vardef obs_distance(text dist)(expr name,n)=
  new_vec(v_a);
  define_current_point_offset_(name);% enables |pnt|
  dist:=vec_mod_(v_a,pnt(n),Obs);
  free_vec(v_a);
enddef;

%%\newpage
%%\title{Vector and point allocation}
% Allocation is done through a stack of vectors
numeric last_vec_;
last_vec_=0;

% vector allocation
% (this must not be a |vardef| because the vector |v| saved is not saved
% in this macro, but in the calling context)
def new_vec(text v)=
  save v;
  new_vec_(v);
enddef;

def new_vec_(text v)=
  v:=incr(last_vec_);
       %|message "Vector " & decimal (last_vec_+1) & " allocated";|
enddef;

let new_point = new_vec;
let new_point_ = new_vec_;

def new_points(text p)(expr n)=
  save p;
  numeric p[];
  for i:=1 upto n:new_point_(p[i]);endfor;
enddef;

% Free a vector
% A vector can only be freed safely when it was the last vector created.
def free_vec(expr i)=
  if i=last_vec_: last_vec_:=last_vec_-1;
     %|message "Vector " & decimal i & " freed";|
  else: errmessage("Vector " & decimal i & " can't be freed!");
  fi;
enddef;

let free_point = free_vec;

def free_points(text p)(expr n)=
  for i:=n step-1 until 1:free_point(p[i]);endfor;
enddef;

%%\title{Debugging}

def show_vec(expr t,i)=
  message "Vector " & t & "="
  & "(" & decimal vec[i]x & "," & decimal vec[i]y & ","
    & decimal vec[i]z & ")";
enddef;

% One can write |show_point("2",pnt_obj("obj",2));|
let show_point=show_vec;

def show_pair(expr t,zz)=
  message t & "=(" & decimal xpart(zz) & "," & decimal ypart(zz) & ")";
enddef;

%%\newpage
%%\title{Access to object features}
% |a| must be a string representing a class name, such as |"dodecahedron"|.
% |b| is the tail of a macro name.

def obj_(expr a,b,i)=
  scantokens
  begingroup save n;string n;n=a & b & i;n
  endgroup
enddef;

def obj_points_(expr name)=
  obj_(obj_class_(name),"_points",name)
enddef;

def obj_faces_(expr name)=
  obj_(obj_class_(name),"_faces",name)
enddef;

vardef obj_point_offset_(expr name)=
  obj_(obj_class_(name),"_point_offset",name)
enddef;

vardef obj_face_offset_(expr name)=
  obj_(obj_class_(name),"_face_offset",name)
enddef;

def obj_class_(expr name)=obj_(name,"_class","") enddef;

%%\newpage
def define_point_offset_(expr name,o)=
  begingroup save n,tmpdef;
    string n,tmpdef;
    n=obj_class_(name) & "_point_offset" & name;
    expandafter numeric scantokens n;
    scantokens n:=last_point_offset_;
    last_point_offset_:=last_point_offset_+o;
    tmpdef="def " & obj_class_(name) & "_points" & name & 
      "=" & decimal o & " enddef";
    scantokens tmpdef;
  endgroup
enddef;

def define_face_offset_(expr name,o)=
  begingroup save n,tmpdef;
    string n,tmpdef;
    n=obj_class_(name) & "_face_offset" & name;
    expandafter numeric scantokens n;
    scantokens n:=last_face_offset_;
    last_face_offset_:=last_face_offset_+o;
    tmpdef="def " & obj_class_(name) & "_faces" & name & 
      "=" & decimal o & " enddef";
    scantokens tmpdef;
  endgroup
enddef;

def define_current_point_offset_(expr name)=
  save current_point_offset_;
  numeric current_point_offset_;
  current_point_offset_:=obj_point_offset_(name);
enddef;

def define_current_face_offset_(expr name)=
  save current_face_offset_;
  numeric current_face_offset_;
  current_face_offset_:=obj_face_offset_(name);
enddef;


%%\newpage
%%\title{Drawing an object}
% |name| is an object instance
vardef draw_obj(expr name)=
  save tmpdef;
  string tmpdef;
  current_obj:=name; 
  tmpdef="draw_" & obj_class_(name);
  project_obj(name);% compute screen coordinates
  save overflow; boolean overflow; overflow=false;
  for $:=1 upto obj_points_(name): 
    if z[ipnt_($)]=(too_big_,too_big_):overflow:=true;
      x[ipnt_($)] := 10; % so that the figure can be drawn anyway
      y[ipnt_($)] := 10;
      % why can't I write z[ipnt_($)]:=(10,10); ?
    fi;
    exitif overflow;
  endfor;
  if overflow:
    message "Figure has overflows";
    message "  (at least one point is not visible ";
    message "   and had to be drawn at a wrong place)";
  fi;
  scantokens tmpdef(name);
enddef;

%%\title{Normalization of an object}
% This macro translates an object so that a list of vertices is centered
% on the origin, and the last vertex is put on a sphere whose radius is 1.
% |name| is the name of the object and |vertices| is a list
% of points whose barycenter will define the center of the object.
% (|vertices| need not be the list of all vertices)
vardef normalize_obj(expr name)(text vertices)=
  save nvertices,last;
  nvertices=0;
  new_vec(v_a);vec_def_(v_a,0,0,0)
  forsuffixes $=vertices:
    vec_sum_(v_a,v_a,pnt($));
    nvertices:=nvertices+1;
    last:=$;
  endfor;
  vec_mult_(v_a,v_a,-1/nvertices);
  translate_obj(name,v_a);% object centered on the origin
  scale_obj(name,1/vec_mod(last));
  free_vec(v_a);
enddef;


%%\newpage
%%\title{General definitions}
% Vector arrays
numeric vec[]x,vec[]y,vec[]z;

% Reference vectors $\vec{0}$, $\vec{\imath}$, $\vec{\jmath}$ and $\vec{k}$ 
% and their definition
new_vec(vec_null);new_vec(vec_I);new_vec(vec_J);new_vec(vec_K);
vec_def_(vec_null,0,0,0);
vec_def_(vec_I,1,0,0);vec_def_(vec_J,0,1,0);vec_def_(vec_K,0,0,1);
numeric point_null;
point_null=vec_null;

% Observer 
new_point(Obs);
% default value:
set_point_(Obs,0,0,20); 

% Observer's vectors
new_vec(ObsI_);new_vec(ObsJ_);new_vec(ObsK_);
% default values: 
vec_def_vec_(ObsI_,vec_I);
vec_def_vec_(ObsJ_,vec_J);
vec_def_vec_(ObsK_,vec_K);

new_vec(IObsI_);new_vec(IObsJ_);new_vec(IObsK_);

% These vectors will be vectors of the projection plane,
% in case of oblique projections:
new_vec(ProjK_);new_vec(ProjJ_); % there is no |ProjI_|

% This will be the center of the projection plane, in oblique projections
new_point(ObliqueCenter_);


% distance observer/plane (must be $>0$)
numeric Obs_dist; % represents |Obs_dist| $\times$ |drawing_scale|
% default value:
Obs_dist=2; % means |Obs_dist| $\times$ |drawing_scale|

% current object being drawn
string current_obj;

% kind of projection: 0 for linear (or central) perspective, 1 for parallel,
% 2 for oblique projection
% (default is 0)
numeric projection_type;
projection_type:=0;

% Definition of a projection plane (only used in oblique projections)
%
new_plane_(projection_plane)(1,1,1); % the initial value is irrelevant

% Definition of a projection direction (only used in oblique projections)
new_line_(projection_direction)(1,1);  % the initial value is irrelevant

% this positions the observer at vector |p| (the point observed)
% + |d| (distance) * (k-(i+j))
def isometric_projection(expr i,j,k,p,d,phi)=
  trimetric_projection(i,j,k,1,1,1,p,d,phi);
enddef;

% this positions the observer at vector |p| (the point observed)
% + |d| (distance) * (ak-(i+j))
def dimetric_projection(expr i,j,k,a,p,d,phi)=
  trimetric_projection(i,j,k,1,1,a,p,d,phi);
enddef;

% this positions the observer at vector |p| (the point observed)
% + |d| (distance) * (k-(i+j))
% |a|, |b| and |c| are multiplicative factors to vectors |i|, |j| and |k|
vardef trimetric_projection(expr i,j,k,a,b,c,p,d,phi)=
  save v_a,v_b,v_c;
  new_vec(v_a);new_vec(v_b);new_vec(v_c);
  vec_mult_(v_a,i,a);vec_mult_(v_b,j,b);vec_mult_(v_c,k,c);
  vec_sum_(Obs,v_a,v_b);
  vec_diff_(Obs,v_c,Obs);
  vec_mult_(Obs,Obs,d);
  vec_sum_(Obs,Obs,p);
  point_of_view_abs(p,phi);
  projection_type:=1;
  free_vec(v_c);free_vec(v_b);free_vec(v_a);
enddef;

% |hor| is an horizontal plane (in the sense that it will represent
% the horizontal for the observer)
% |p| is the point in space that the observer targets (center of screen)
% |a| is an angle (45 degrees corresponds to cavalier drawing)
% |b| is an angle (see examples defined below)
% |d| is the distance of the observer
vardef oblique_projection(text hor)(expr p,a,b,d)=
  save _l,v_a,v_b,v_c,xxx_,obsJangle_;
  new_vec(v_a);new_vec(v_b);new_vec(v_c);
  % we first compute a horizontal line:
  new_line_(_l)(1,1);
  if def_inter_l_pl_pl(_l)(hor)(projection_plane):
    vec_diff_(v_a,_l2,_l1); % horizontal vector
    % then, we find a normal to the projection plane:
    def_normal_p_(v_b)(projection_plane);
    % complete the line and the vector by a third vector (=vertical)
    vec_prod_(v_c,v_a,v_b);
    % we make |v_a| a copy of |v_b| since we no longer need |v_b|
    vec_def_vec_(v_a,v_b);
    % we rotate |v_b| by an angle |a| around |v_c|
    vec_rotate_(v_b,v_c,a);
    % we rotate |v_b| by an angle |b| around |v_a|
    vec_rotate_(v_b,v_a,b);
    % we put the observer at the distance |d| of |p| in
    % the direction of |v_b|:
    vec_unit_(v_b,v_b);
    vec_mult_(v_b,v_b,d);vec_sum_(Obs,p,v_b);
    % We now have to make sure that point |p| and point |Obs|
    % are on different sides of the projection plane. For this,
    % we compute two dot products:
    new_vec(v_d);new_vec(v_e);
    vec_diff_(v_d,p,_l1);vec_diff_(v_e,Obs,_l1);
    if vec_dprod_(v_d,v_a)*vec_dprod_(v_e,v_a)>=0:
      % |p| and |Obs| are on the same side of the projection plane
      % |Obs| needs to be recomputed.
      vec_mult_(v_b,v_b,-1);
      vec_sum_(Obs,p,v_b);
    fi;
    free_vec(v_e);free_vec(v_d);
    projection_type:=2;    % needs to be set before |point_of_view_abs|
    point_of_view_abs(p,90); % this computes |ObliqueCenter_|
    % and now, make sure the vectors defining the observer are right:
    % Create the plane containing lines _l and projection_direction
    %  (defined by point_of_view_abs):
    new_plane_(xxx_)(1,1,1);
    def_plane_pl_l_l(xxx_)(_l)(projection_direction);
    % Compute the angle of |ObsK_| with this plane:
    obsJangle_=vangle_v_pl_(ObsK_)(xxx_);
    % rotate |ObsJ_| and |ObsK_| by |obsJangle_| around |ObsI_|
    vec_rotate_(ObsJ_,ObsI_,obsJangle_);
    vec_rotate_(ObsK_,ObsI_,obsJangle_);
    if abs(vangle_v_pl_(ObsK_)(xxx_))>1: % the rotation was done
                                         % in the wrong direction
      vec_rotate_(ObsJ_,ObsI_,-2obsJangle_);
      vec_rotate_(ObsK_,ObsI_,-2obsJangle_);
    fi;
    % |vec_rotate_(ObsJ_,ObsI_,45);| % planometric test
    % |vec_rotate_(ObsK_,ObsI_,45);| % planometric test
    free_plane(xxx_);
    % and now, |ProjJ_| and |ProjK_| must be recomputed:
    project_vectors(ProjK_,ProjJ_)(ObsK_,ObsJ_)%
               (projection_direction)(projection_plane);
  else:
    message "Error: the ``horizontal plane'' cannot be";
    message "  parallel to the projection plane.";
  fi;
  free_line(_l);
  free_vec(v_c);free_vec(v_b);free_vec(v_a);
enddef;

% These two are the most common values for the third parameter
% of |oblique_projection|
numeric CAVALIER;CAVALIER=45;
numeric CABINET;CABINET=angle((1,.5)); % atn(.5)

% Screen Size
% The screen size is defined through two angles: the horizontal field
% and the vertical field
numeric h_field,v_field;
h_field=100; % degrees 
v_field=70; % degrees

% Observer's orientation, defined by three angles
numeric Obs_psi,Obs_theta,Obs_phi; 
% default value:
Obs_psi=0;Obs_theta=90;Obs_phi=0;

% This array relates an absolute object point number to the
% absolute point number (that is, to the |vec| array).
% The absolute object point number is the rank of a point
% with respect to all object points. The absolute point number
% considers in addition the extra points, such as |Obs|, which do
% not belong to an object.
% If |i| is an absolute object point number, |points_[i]|
% is the absolute point number.
numeric points_[]; 

% |name| is the name of an object instance
% |npoints| is its number of defining points
def new_obj_points(expr name,npoints)= 
  define_point_offset_(name,npoints);define_current_point_offset_(name);
  for i:=1 upto obj_points_(name):new_point_(pnt(i));endfor;
enddef;

% |name| is the name of an object instance
% |nfaces| is its number of defining faces
def new_obj_faces(expr name,nfaces)= 
  define_face_offset_(name,nfaces);define_current_face_offset_(name);
  redefine_obj_name_(name,current_face_offset_+nfaces);
enddef;

%%\newpage
% Absolute point number corresponding to object point number |i|
% This macro must only be used within the function defining an object
% (such as |def_cube|) or the function drawing an object (such as
% |draw_cube|).
def ipnt_(expr i)=i+current_point_offset_ enddef;
def pnt(expr i)=points_[ipnt_(i)] enddef;

def face(expr i)=(i+current_face_offset_) enddef;

% Absolute point number corresponding to local point |n|
% in object instance |name|
vardef pnt_obj(expr name,n)=
  points_[n+obj_point_offset_(name)]
  %hide(define_current_point_offset_(name);) pnt(n) % HAS SIDE EFFECTS
enddef;

% Absolute face number corresponding to local face |n|
% in object instance |name|
vardef face_obj(expr name,n)=
  (n+obj_face_offset_(name))
  %hide(define_current_face_offset_(name);) face(n) % HAS SIDE EFFECTS
enddef;


% Scale
numeric drawing_scale;
drawing_scale=2cm;

% Color
% This function is useful when a color is expressed in hexadecimal.
% This does the opposite from |tohexcolor|
def hexcolor(expr s)=
  (hex(substring (0,2) of s)/255,hex(substring (2,4) of s)/255,
    hex(substring (4,6) of s)/255)
enddef;

% Convert a color triple into a hexadecimal color string.
% |rv|, |gv| and |bv| are values between 0 and 1.
% This does the opposite from |hexcolor|
vardef tohexcolor(expr rv,gv,bv)=
  save dig;numeric dig[];
  hide(
    dig2=floor(rv*255);dig1=floor((dig2)/16);dig2:=dig2-16*dig1;
    dig4=floor(gv*255);dig3=floor((dig4)/16);dig4:=dig4-16*dig3;
    dig6=floor(bv*255);dig5=floor((dig6)/16);dig6:=dig6-16*dig5;
    for i:=1 upto 6:
      if dig[i]<10:dig[i]:=dig[i]+48;
      else:dig[i]:=dig[i]+87;
      fi;
    endfor;
  )
  char(dig1)&char(dig2)&char(dig3)&char(dig4)&char(dig5)&char(dig6)
enddef;

% Conversions

% Returns a string encoding the integer |n| as follows:
% if $n=10*a+b$ with $b<10$,
%   |alphabetize|(|n|)=|alphabetize|(|a|) |&| |char (65+b)|
% For instance, alphabetize(3835) returns "DIDF"
% This function is useful in places where digits are not allowed.
def alphabetize(expr n)=
  if (n>9):
    alphabetize(floor(n/10)) & fi
  char(65+n-10*floor(n/10))
enddef;

% Filling and contours
boolean filled_faces,draw_contours;
filled_faces=true;
draw_contours=true;
numeric contour_width; % thickness of contours
contour_width=1pt;
color contour_color; % face contours
contour_color=black;

% Overflow control
% An overflow can occur when an object is too close from the observer
% or if an object is out of sight. We use a special value to mark
% coordinates which would lead to an overflow.
numeric too_big_;
too_big_=4000;


% Object offset (the points defining an object are arranged
% in a single array, and the objects are easier to manipulate
% if the point numbers are divided into a number and an offset).
numeric last_point_offset_,last_face_offset_;
last_point_offset_=0;last_face_offset_=0;

endinput
