%%\input epsf
%%\def\newpage{\vfill\eject}
%%\advance\vsize1in
%%\let\ora\overrightarrow
%%\def\title#1{\hrule\vskip1mm#1\par\vskip1mm\hrule\vskip5mm}
%%\def\figure#1{\par\centerline{\epsfbox{#1}}}
%%\title{{\bf 3DGEOM.MP: 3D GEOMETRY IN METAPOST}}

%% version 1.34, 17 August 2003
%% {\bf Denis Roegel} ({\tt roegel@loria.fr}) 

% This package provides useful definitions for geometrical drawings.
% It contains functions dealing with lines, planes, etc.

if known three_d_geom_version: 
  expandafter endinput % avoids loading this package twice
fi;

% First, we load the 3D package
input 3d
% and some utilities
input 3dutil

message "*** 3dgeom,   v1.34 (c) D. Roegel 17 August 2003 ***";
numeric three_d_geom_version; three_d_geom_version:=1.34;

% WARNING:
%   Known bugs: unnecessary overflows can occur, especially when
%   computing the intersection of two planes.


% Among other things, this file defines so-called ``structures.''
% These structures are different from the ``objects'' manipulated
% by the main 3d package. For some explanations, see the article
%
%   Denis Roegel: La géométrie dans l'espace avec METAPOST,
%   Cahiers GUTenberg number 39-40, 2001, pages 107-138.
%   (in French, conference proceedings of GUT2001)
% 
%
%
% Future versions of this module will consider the following structures,
% not all of which are currently implemented:
%
%  structure name    standard abreviation
%      point           p
%      line            l
%      plane           pl
%      circle          c
%      triangle        tr
%      sphere          s
%      cone            co
%      cylinder        cy
%      tetrahedron     te
%
% These names are considered reserved and should not be used for classes.
% 
% The left column names are used when defining a structure with |def|,
% |set| or freeing it with |free|.
%
% When a function using parameters of these types is defined,
% the abreviations of the types are part of the function name.
% For instance, the function giving the intersection between a
% line and a plane is named |def_inter_l_pl|.
%
% Functions computing intersections should be named |def_inter|
% and should be followed by the resulting type. For instance,
% the intersection of two lines is |def_inter_p_l_l|,
% the intersection of two planes is |def_inter_l_pl_pl|
% 
% Functions computing inscriptions (like a circle inscribed
% in a triangle) should be named |def_ins|.
% For instance, |def_ins_c_tr|.
%
% Functions computing circumscriptions (like a circle circumscribing
% a triangle) should be named |def_circums|.
% For instance, |def_circums_c_tr|.
%
% Functions computing exinscriptions (like a circle exinscribed
% in a triangle) should be named |def_exins|.
% For instance, |def_exins_c_tr|.
%
% Functions computing tangencies (like a tangent to a circle)
% should be named |def_tang|.
% For instance, |def_tang_l_c|.
%
% Functions computing orthogonal planes, lines, etc. should
% be named |def_orth|.
%
% All these functions can have more parameters than what the name
% implies.
%
% These rules are guidelines, not a standard. If you have some idea
% on naming conventions, please let me know at roegel@loria.fr.
%
% Possibly, more thought should be given in
% order to distinguish pseudo-objects like ``circle''
% from the other objects of 3d.mp (like the polyhedra, etc.).


% Structures can be allocated, set and freed.

% Our first structure is the line. A line is defined by two points.
% This is not an object in the usual sense of the 3d package.
% It is just made of two points.
% |l| is the line name: it must be different from already known variables
% |i| and |j| are point numbers
% (absolute version)
def new_line_(text l)(expr i,j)=
  new_points(l)(2);
  set_line_(l)(i,j);
enddef;

% The following version takes local point numbers instead of absolute ones.
def new_line(text l)(expr i,j)=new_line_(l)(pnt(i),pnt(j)) enddef;

% This is used to set a line:
% (absolute version)
def set_line_(text l)(expr i,j)=
  vec_def_vec_(l1,i);
  vec_def_vec_(l2,j); % l[2]=l[1]+1 (this is assumed elsewhere,
                        %               so should never change)
enddef;

% (local version)
def set_line(text l)(expr i,j)=set_line_(l)(pnt(i),pnt(j)) enddef;

def free_line(text l)=
  free_points(l)(2);
enddef;

% A circle |c| of center |i|, radius |r| and in plane |p|.
% We store the center as a point, and (r,p[1]) in another point.
def new_circle(text c)(expr i,r)(text p)=
  new_points(c)(2);
  vec_def_vec(c1,i);
  vec_def(c2,r,p1,0);
enddef;

% should |set_circle| be defined?

def free_circle(text c)=
  free_points(c)(2);
enddef;

% Planes are similar to lines. A plane is just a triple of points.
% (absolute version)
def new_plane_(text p)(expr i,j,k)=
  new_points(p)(3);
  set_plane_(p)(i,j,k);
enddef;

% (local version)
def new_plane(text p)(expr i,j,k)=new_plane_(p)(pnt(i),pnt(j),pnt(k)) enddef;

% (absolute version)
def set_plane_(text p)(expr i,j,k)=
  vec_def_vec_(p1,i);
  vec_def_vec_(p2,j); % p[2]=p[1]+1 (this is assumed elsewhere,
                      %               so should never change)
  vec_def_vec_(p3,k); % p[3]=p[3]+1 (this is assumed elsewhere,
                      %               so should never change)
enddef;

% (local version)
def set_plane(text p)(expr i,j,k)=set_plane_(p)(pnt(i),pnt(j),pnt(k)) enddef;

def free_plane(text p)=
  free_points(p)(3);
enddef;

% Spheres are not yet used, but here is how they will be allocated and freed.

% A sphere is defined with a center |c| and a radius |r|.
% We store it using two points.
def new_sphere(text s)(expr c,r)=
  new_points(s)(2);
  vec_def_vec(s1,c);
  vec_def(s2,r,0,0);
enddef;

% Should |set_sphere| be defined?

def free_sphere(text s)=
  free_points(s)(2);
enddef;

% Lines and planes may be used locally or globally to define
% new points or new lines.

% In order to define a line which is given by a point and a vector,
% compute a second point before defining the line.
% In order to define a line which is given by two planes,
% define the planes and compute the intersection.

% If a plane is given by a parametric equation (1 point, 2 vectors),
% compute two additional points and define the plane.
% If a plane is given by an equation ax+by+cz+d=0, compute three
% points and define the plane.

% Currently, plane equations are not handled separately.

% Projection of a vector |j| on a plane |p|, along a line |l|.
% The projection, if it exists, is vector |i|.
% Returns |true| is there is a projection, and |false| if there is none.
vardef proj_v_v_l_pl_(expr i,j)(text l)(text p)=
  save pa,pb,int; boolean int;
  hide(
    new_point(pa);new_point(pb);
    % we project two points: the origin, and origin+v(j):
    if def_proj_pl_(pa)(p)(point_null)(l):
      if def_proj_pl_(pb)(p)(j)(l):
        vec_diff_(i,pb,pa);
        int=true;
      else:
        message "Second point can not be projected";
        int=false;
      fi;
    else: int=false;
      message "Origin can not be projected";
    fi;
    free_point(pb);free_point(pa);
  )
  int
enddef;

% The next function checks if a point is part of a plane.
% Returns |true| is point |i| is in the plane |p|.
vardef point_in_plane_p_pl_(expr i)(text p)=
  save v_a;boolean res;
  hide(
    new_vec(v_a);new_vec(v_b);
    def_normal_p_(v_a)(p);
    vec_diff_(v_b,p1,i);
    if vec_dprod_(v_a,v_b)=0: res=true;else: res=false;fi;
    free_vec(v_b);free_vec(v_a);
  )
  res
enddef;

% The next function finds the angle of a vector with respect to a plane.
% Returns the angle of a vector |v| with respect to a plane |p|.
vardef vangle_v_pl_(expr v)(text p)=
  save v_a,an_;
  hide(
    new_vec(v_a);
    % we compute a vector normal to the plane:
    def_normal_p_(v_a)(p);
    an_=90-vangle_v_v_(v,v_a);
    free_vec(v_a);
  )
  an_
enddef;

% Compute the angle between two vectors
% The angle is always between 0 and 180,
% since this is the best one can do with two vectors.
% If we had a third vector, we could be more accurate.
vardef vangle_v_v_(expr va,vb)=
  save cosa_,sina_;
  hide(
    cosa_=vec_dprod_(va,vb)/vec_mod_(va)/vec_mod_(vb);
    if cosa_>1: % sometimes, this happens with rounding errors
      sina_=0;
    else:
      sina_= 1 +-+ cosa_; % sqrt(1-cosa_**2)
    fi;
  )
  angle((cosa_,sina_))  
enddef;

% Define a plane with two lines:
def def_plane_pl_l_l(text p)(text l)(text m)=
  set_plane_(p)(l1,l2,1); % the last value is irrelevant
  vec_diff_(p3,m2,m1);vec_sum_(p3,p3,l1);
enddef;

% Define the plane orthogonal to a line and going through a point
% (not necessarily belonging to the plane):
% the plane must already have been defined
% |p|=plane, |l|=line, |i|=point
%...
% (absolute version)
vardef def_orth_pl_l_p_(text p)(text l)(expr i)=
  new_vec(va);new_vec(vb);new_vec(vc);new_vec(h);
  vec_def_vec_(p1,i); % this is the first point of the plane
  vec_diff_(va,l2,l1);
  vec_def_vec_(vb,i);
  if abs(xval(va))<absmin(yval(va),zval(va)):
    vec_sum_(vb,vb,vec_I);
  elseif abs(yval(va))<absmin(xval(va),zval(va)):
    vec_sum_(vb,vb,vec_J);
  else:vec_sum_(vb,vb,vec_K);
  fi;
  % now, |vb| is a point not on the line and not too close to it
  % we compute a vertical to the line
  def_vert_l_(h,vb)(l);
  vec_diff_(vb,vb,h);vec_unit_(vb,vb);
  vec_sum_(p2,vb,p1);
  % |p[2]| is now a point of the plane 
  % a third point is obtained by cross product
  vec_prod_(vc,va,vb);vec_unit_(vc,vc);vec_sum_(p3,vc,p1);
  free_vec(h);free_vec(vc);free_vec(vb);free_vec(va);
enddef;

% (local version)
vardef def_orth_pl_l_p(text p)(text l)(expr i)=
  def_orth_pl_l_p_(p)(l)(pnt(i))
enddef;

% Line orthogonal to a plane and going through a point
% (not necessarily belonging to the plane);
% from the three points defining the plane, compute a normal,
% and add it to the point, this gives a second point,
% and make a line out of it
% (absolute version)
vardef def_orth_l_pl_p_(text l)(text p)(expr i)=
  new_vec(va);new_vec(vb);
  vec_def_vec_(l1,i);
  def_normal_p_(l2)(p);
  vec_sum_(l2,l2,l1);
  free_vec(vb);free_vec(va);
enddef;

% (local version)
vardef def_orth_l_pl_p(text l)(text p)(expr i)=
  def_orth_l_pl_p_(l)(p)(pnt(i))
enddef;

% Unitary vector normal to a plane.
% |v| is a vector that must have been defined
% (absolute version)
vardef def_normal_p_(expr v)(text p)=
  new_vec(va);new_vec(vb);
  vec_diff_(va,p2,p1);vec_diff_(vb,p3,p1);vec_prod_(v,va,vb);
  vec_unit_(v,v);
  free_vec(vb);free_vec(va);
enddef;

% Unitary vector normal to a plane (local version)
vardef def_normal_p(expr v)(text p)=def_normal_p_(pnt(v))(p) enddef;

% The following two functions are old versions of the
% line/plane intersection. They are not used anymore.
%
% Intersection line/plane
% Point |i| is the intersection
% The return value is |true| if the intersection is a point,
% |false| otherwise
% (absolute version)
vardef old_def_inter_p_l_pl_(expr i)(text l)(text p)=
  save d,t,int;boolean int;
  hide(
    new_vec(va);new_vec(vb);new_vec(vc);
    % first, we compute a vector normal to the plane
    vec_diff_(va,p2,p1);
    vec_diff_(vb,p3,p2);
    vec_prod_(vc,va,vb);
    % we want the plane equation as ax+by+cz+d=0
    % the normal vector gives us (a,b,c)
    % d is then easy to compute
    d=-xval(vc)*xval(p1)-yval(vc)*yval(p1)-zval(vc)*zval(p1);
    vec_diff_(i,l2,l1);
    if vec_dprod_(i,vc)=0: % the line is parallel to the plane
      int:=false;
    else:
      int:=true;
      t=-(d+xval(vc)*xval(l1)+yval(vc)*yval(l1)+zval(vc)*zval(l1))
      /vec_dprod_(i,vc);
      vec_mult_(i,i,t);vec_sum_(i,i,l1);
    fi;
    free_vec(vc);free_vec(vb);free_vec(va);
  )
  int
enddef;

% same (local version)
vardef old_def_inter_p_l_pl(expr i)(text l)(text p)=
  def_inter_p_l_pl_(pnt(i))(l)(p)
enddef;

% Intersection line/plane (absolute version)
% Point |i| is the intersection.
% The return value is |true| if the intersection is a point,
% |false| otherwise
vardef def_inter_p_l_pl_(expr i)(text l)(text p)=
  save int;boolean int;
  hide(
    new_points(loc)(3);
    vec_diff_(loc1,p2,p1);vec_diff_(loc2,p3,p1);vec_prod_(loc3,loc1,loc2);
    vec_diff_(loc1,p1,l1);vec_diff_(loc2,l2,l1);
    if vec_dprod_(loc2,loc3)<>0:
      vec_mult_(loc2,loc2,vec_dprod_(loc1,loc3)/vec_dprod_(loc2,loc3));
      vec_sum_(i,l1,loc2);
      int:=true;
      % Remark: in order to prove that point |i| is on the plane, it
      % suffices to compute vec(ci).(vec(cd) /\ vec(ce))
      %   =(-vec(ac)+vec(ai)).(vec(cd) /\ vec(ce))
      %   =-vec(ac).(vec(cd) /\ vec(ce))
      %      +(vec(ab).(vec(cd) /\ vec(ce))) vec(ac).(vec(cd) /\ vec(ce))
      %                                      ----------------------------
      %                                      vec(ab).(vec(cd) /\ vec(ce))
      %   =0
    else: % the line is parallel to the plane
      int:=false;
    fi;
    free_points(loc)(3);      
  )
  int
enddef;

% Intersection line/plane (local version)
vardef def_inter_p_l_pl(expr i)(text l)(text p)=
  def_inter_p_l_pl_(pnt(i))(l)(p)
enddef;

% The following function is used in |def_inter_l_pl_pl|.
% We could simplify it by breaking it in two.
vardef def_inter_l_pl_pl_base_case_(text l)(expr pa,pb,pc)(text q)=
  save trial;
    new_line_(trial)(pa,pb);
    if def_inter_p_l_pl_(l1)(trial)(q):
    else: % there is no intersection or the intersection is the line
      vec_def_vec_(trial1,pa);
      mid_point_(trial2,pb,pc);
      if def_inter_p_l_pl_(l1)(trial)(q):
      else:
        message "THIS SHOULD NOT HAPPEN, PLEASE REPORT THIS PROBLEM";
      fi;
    fi;
    set_line_(trial)(pa,pc);
    if def_inter_p_l_pl_(l2)(trial)(q):
    else: % there is no intersection or the intersection is the line
      vec_def_vec_(trial1,pa);
      mid_point_(trial2,pb,pc);
      if def_inter_p_l_pl_(l2)(trial)(q):
      else:
        message "THIS SHOULD NOT HAPPEN, PLEASE REPORT THIS PROBLEM";
      fi;
    fi;
    free_line(trial);
enddef;

% Intersection of two planes.
% TO DO: this function is not yet robust enough, because
% unnecessary overflows can occur.
% A boolean is set if there is no intersection.
% The line |l| must already have been defined.
vardef def_inter_l_pl_pl(text l)(text p)(text q)=
  save trial,da,db,dc,int;boolean int;
  hide(
    % we first search the point of p1, p2, p3 which is the farthest
    % from q; 
    da=dist_pl_(p1)(q);db=dist_pl_(p2)(q);dc=dist_pl_(p3)(q);
    if (da=db) and (db=dc): % the two planes are parallel
      int:=false;
    else:
      int:=true;
      if (da>=db) and (da>=dc):
        def_inter_l_pl_pl_base_case_(l)(p1,p2,p3)(q);
      elseif (db>=da) and (db>=dc):
        def_inter_l_pl_pl_base_case_(l)(p2,p1,p3)(q);
      else:
        def_inter_l_pl_pl_base_case_(l)(p3,p1,p2)(q);
      fi;
    fi;
  )
  int
enddef;

% Visual intersection between lines (jk) and (lm).
% The computed intersection lies on (jk).
% Returns true if there is an intersection, false otherwise.
% (absolute version)  
vardef def_visual_inter_(expr i)(expr j,k,l,m)=
  save pla,plb,la,lb,d,int;boolean int;
  hide(
    new_plane_(pla)(Obs,l,m);new_plane_(plb)(Obs,j,k);
    new_line_(la)(0,0);new_line_(lb)(j,k);
    if def_inter_l_pl_pl(la)(pla)(plb):
      int:=true;
      % |d| is the closest distance between lines |la| and |lb|
      % We don't use |d| here, and are only interested in point |i|.
      d=def_inter_p_l_l_(i)(la)(lb);
    else:
      int:=false;
    fi;
    free_line(lb);free_line(la);free_plane(plb);free_plane(pla);
  ) int
enddef;
  
% same (local version)  
vardef def_visual_inter(expr i)(expr j,k,l,m)=
  def_visual_inter_(pnt(i),pnt(j),pnt(k),pnt(l),pnt(m))
enddef;

% Point of a line at a given distance from a given point.
% |i| = new point |d|=distance |j|=point |l|=line
% $|d|>0$ or $|d|<0$ give two different points.
% If there is an intersection, the function returns |true|;
% otherwise it returns |false|.
% (absolute version)
vardef def_point_at_(expr i)(expr d)(expr j)(text l)=
  save dj,ld,int;boolean int;
  hide(
    new_point(h);new_point(hc);
    def_vert_l_(h,j)(l);
    vec_diff_(hc,j,h);
    if d*d-vec_dprod_(hc,hc)>=0: int:=true;
      ld=sign(d)*sqrt(d*d-vec_dprod_(hc,hc));
      vec_diff_(i,l1,l2);
      vec_unit_(i,i);
      vec_mult_(i,i,ld);
      vec_sum_(i,i,h);
    else: int:=false;
    fi;
    free_point(hc);
    free_point(h);
  )
  int
enddef;

% same (local version)
vardef def_point_at(expr i)(expr d)(expr j)(text l)=
  def_point_at_(pnt(i))(d)(pnt(j))(l)
enddef;

% Define a vertical of a line.
% Point |i| is obtained as the intersection of a vertical
% starting from point |j| and reaching the line |l|.
vardef def_vert_l_(expr i,j)(text l)=
  new_points(loc)(3);            
  vec_diff_(loc1,j,l1);vec_diff_(loc2,l2,l1);
  vec_mult_(loc3,loc2,vec_dprod_(loc1,loc2)/vec_dprod_(loc2,loc2));
  vec_sum_(i,loc3,l1); 
  free_points(loc)(3);                   
enddef;

% Define a vertical. (local version)
vardef def_vert_l(expr i,j)(text l)=
  def_vert_l_(pnt(i),pnt(j))(l);
enddef;

% Vertical falling on a plane.
% Point |j| falls on plane |p| at point |i| (absolute version)
vardef def_vert_pl_(expr i)(expr j)(text p)=
  save d;
  new_vec(va);new_vec(vb);
  def_normal_p_(va)(p);
  vec_diff_(vb,j,p1);
  d=-vec_dprod_(vb,va);
  vec_mult_(va,va,d);
  vec_sum_(vb,vb,va);
  vec_sum_(i,p1,vb);
  free_vec(vb);free_vec(va);
enddef;

% same (local version)
vardef def_vert_pl(expr i)(expr j)(text p)=
  def_vert_pl_(pnt(i))(pnt(j))(p)
enddef;

% Distance to a plane.
% (absolute version)
vardef dist_pl_(expr i)(text p)=
  save d;
  hide(
    new_vec(va);
    def_vert_pl_(va)(i)(p);
    vec_diff_(va,va,i);
    d=vec_mod_(va);
    free_vec(va);
  )
  d
enddef;

% (local version)
def dist_pl(expr i)(text p)=dist_pl_(pnt(i))(p) enddef;

% Projections on planes or lines, according to a direction.
% This one is very hazardous: use epsilon
% Find point |i| on |l| from point |j| using direction |d|

def def_proj_l_(expr i)(text l)(expr j)(text d)=
  NOT YET IMPLEMENTED
enddef;

def def_proj_l(expr i)(text l)(expr j)(text d)=
  def_proj_l_(pnt(i))(l)(pnt(j))(d)
enddef;

% Find point |i| on |p| from point |j| using direction |d|.
vardef def_proj_pl_(expr i)(text p)(expr j)(text d)=
  save l_,int; boolean int;
  hide(
    % we compute the intersection between line (|j|+|d|) and plane |p|
    new_line_(l_)(1,1); % we must take a name that cannot
                        % conflict with the text replacement of |d|
    vec_diff_(l_2,d2,d1);vec_sum_(l_2,l_2,j);
    vec_def_vec_(l_1,j);
    if def_inter_p_l_pl_(i)(l_)(p):int=true;
    else: int=false;
    fi;
    free_line(l_);
  )
  int  
enddef;

def def_proj_pl(expr i)(text p)(expr j)(text d)=
  def_proj_pl_(pnt(i))(p)(pnt(j))(d)
enddef;

% Central projection on a plane.
def def_cproj_pl_(expr i)(text p)(expr j)(expr k)=
% use |def_proj_p|
  NOT YET IMPLEMENTED
enddef;

% Central projection on a plane.
def def_cproj_pl(expr i)(text p)(expr j)(expr k)=
  def_cproj_pl_(pnt(i))(p)(pnt(j))(pnt(k))
enddef;


% Intersection of two lines (hazardous).
% Due to rounding errors, two lines that should intersect
% may not do so in reality. Therefore,
% we compute the point which is the middle of the two
% closest points between the lines and return the distance
% between the two lines. If the lines are parallel (possibly
% identical), we return -1.
vardef def_inter_p_l_l_(expr i)(text l)(text m)=
  save ga,gb,gc,gd,ge,gf,t,u,d,mx;
  hide(
    new_point(va);new_point(vb);new_point(vc);new_point(h);new_point(k);
    vec_diff_(va,m1,l1);
    vec_diff_(vb,l2,l1);
    vec_diff_(vc,m2,m1);
    ga=vec_dprod_(vc,vb);gb=-vec_dprod_(vb,vb);
    gc=vec_dprod_(va,vb);gd=vec_dprod_(vc,vc);
    ge=-ga;gf=vec_dprod_(va,vc);
    % compute the max of ga,gb,...
    mx:=absmax(ga,gb);mx:=absmax(mx,gc);mx:=absmax(mx,gd);mx:=absmax(mx,ge);
    mx:=absmax(mx,gf);
    ga:=ga/mx;gb:=gb/mx;gc:=gc/mx;gd:=gd/mx;ge:=ge/mx;gf:=gf/mx;
    if ga*ge=gb*gd: % the lines are parallel
      % we return -1
      d=-1;
    else:
      t=(gc*gd-ga*gf)/(ga*ge-gb*gd);u=(gb*gf-gc*ge)/(ga*ge-gb*gd);
      vec_diff_(h,l2,l1);vec_mult_(h,h,t);vec_sum_(h,h,l1);
      vec_diff_(k,m2,m1);vec_mult_(k,k,u);vec_sum_(k,k,m1);
      % |h| and |k| are now the closest points
      % we set |i| to the middle of |h| and |k| and return the distance |hk|
      mid_point_(i,h,k);
      vec_diff_(h,h,k);d=vec_mod_(h);
    fi;
    free_point(k);free_point(h);free_point(vc);free_point(vb);free_point(va);
  )
  d
enddef;

def def_inter_p_l_l(expr i)(text l)(text m)=
  def_inter_p_l_l_(pnt(i))(l)(m)
enddef;

% Find point |i| symmetric of point |j| with respect to point |k|
def def_sym_(expr i)(expr j)(expr k)=
   NOT YET IMPLEMENTED 
enddef;

def def_sym(expr i)(expr j)(expr k)=
  def_sym_(pnt(i))(pnt(j))(pnt(k))
enddef;

% Find point |i| symmetric of point |j| with respect to plane |p|
def def_sym_pl_(expr i)(expr j)(text p)=
  NOT YET IMPLEMENTED
enddef;

def def_sym_pl(expr i)(expr j)(text p)=
  def_sym_pl_(pnt(i))(pnt(j))(p)
enddef;

% Find point |i| symmetric of point |j| with respect to line |l|.
% That's a mere 180 degrees rotation around the line.
def def_sym_l_(expr i)(expr j)(text l)=
  NOT YET IMPLEMENTED  
enddef;

def def_sym_l(expr i)(expr j)(text l)=
  def_sym_l_(pnt(i))(pnt(j))(l)
enddef;


% Intersection circle/line (hazardous).
% If some intersection does not exist, |infty| is put for its values
def def_inter_p_p_c_l_(expr i,j)(text c)(text l)=
  NOT YET IMPLEMENTED
enddef;

def def_inter_p_p_c_l(expr i,j)(text c)(text l)=
  def_inter_p_p_c_l_(pnt(i),pnt(j))(c)(l)
enddef;

% circle/plane
% A similar coding will distinguish the four cases:
% one point, two points, the full circle, nothing
def def_inter_p_p_c_pl_(expr i,j)(text c)(text p)=
  NOT YET IMPLEMENTED
enddef;

def def_inter_p_p_c_pl(expr i,j)(text c)(text p)=
  def_inter_p_p_c_pl_(pnt(i),pnt(j))(c)(p)
enddef;

% circle/circle
% A similar coding will distinguish the four cases:
% one point, two points, the full circle, nothing
def def_inter_p_p_c_c_(expr i,j)(text ca)(text cb)=
  NOT YET IMPLEMENTED
enddef;

def def_inter_p_p_c_c(expr i,j)(text ca)(text cb)=
  def_inter_p_p_c_c_(pnt(i),pnt(j))(ca)(cb)
enddef;

% Computation of tangent lines and planes.

% Tangent line to a circle at a given point.
def def_tang_l_c_p_(text l)(text c)(expr i)=
  NOT YET IMPLEMENTED
enddef;

def def_tang_l_c_p(text l)(text c)(expr i)=
  def_tang_l_c_p_(l)(c)(pnt(i))
enddef;

% Tangent plane to a sphere at a given point.
def def_tang_pl_s_p_(text p)(text s)(expr i)=
  NOT YET IMPLEMENTED
enddef;

def def_tang_pl_s_p(text p)(text s)(expr i)=
  def_tang_pl_s_p_(p)(s)(pnt(i))
enddef;

% Sphere defined by four non-coplanar points.
def def_sphere_through_(text s)(expr i,j,k,l)=
  NOT YET IMPLEMENTED
enddef;

def def_sphere_through(text s)(expr i,j,k,l)=
  def_sphere_through_(s)(pnt(i),pnt(j),pnt(k),pnt(l))
enddef;

% Line going through a point and parallel to another line.
def def_parallel_l_p_pl_(text l)(expr i)(text m)=
  NOT YET IMPLEMENTED
enddef;

def def_parallel_l_p_pl(text l)(expr i)(text m)=
  def_parallel_l_p_pl_(l)(pnt(i))(m)
enddef;

% Plane going through a point and parallel to another plane.
def def_parallel_pl_p_pl_(text p)(expr i)(text q)=
  NOT YET IMPLEMENTED
enddef;

def def_parallel_pl_p_pl(text p)(expr i)(text q)=
  def_parallel_pl_p_pl_(p)(pnt(i))(q)
enddef;

def def_rectangle_one_side_(expr p)(text l)(text pa)(text pb)(text pc)=
  if def_inter_l_pl_pl(l)(pb)(pc):
  else:
    message "YOUR PLANES ARE NOT WELL SPECIFIED 1";
  fi;
  if def_inter_p_l_pl_(p)(l)(pa):
  else:
    message "YOUR PLANES ARE NOT WELL SPECIFIED 2";
  fi;
enddef;

% A rectangle (for instance representing a plane) can be defined
% from five planes; the rectangle is made of four points (corners)
% |pa| is the plane containing the rectangle
vardef def_rectangle_pl_pl_pl_pl_pl_(expr ca,cb,cc,cd)
  (text pa)(text pb)(text pc)(text pd)(text pe)=
  save l;
  new_line_(l)(1,1);
  def_rectangle_one_side_(ca)(l)(pa)(pb)(pc);
  def_rectangle_one_side_(cb)(l)(pa)(pc)(pd);
  def_rectangle_one_side_(cc)(l)(pa)(pd)(pe);
  def_rectangle_one_side_(cd)(l)(pa)(pe)(pb);
  free_line(l);
enddef;

% Instead of using four additional planes, one can also use eight points:
% the order of the point is important.
vardef def_rectangle_pl_(expr ca,cb,cc,cd)
  (text pa)(expr pta,ptb,ptc,ptd,pte,ptf,ptg,pth)=
  save pb,pc,pd,pe;
  % we create the four additionnal planes
  new_plane_(pb)(pta,ptb,pte);new_plane_(pc)(ptb,ptc,ptf);
  new_plane_(pd)(ptc,ptd,ptg);new_plane_(pe)(ptd,pta,pth);
  def_rectangle_pl_pl_pl_pl_pl_(ca,cb,cc,cd)(pa)(pb)(pc)(pd)(pe);
  free_plane(pe);free_plane(pd);free_plane(pc);free_plane(pb);
enddef;

def draw_rectangle(expr i,j,k,l)=
  draw_line(i,j);draw_line(j,k);draw_line(k,l);draw_line(l,i);
enddef;

numeric mark_h,mark_l;mark_h=2mm;mark_l=1mm;

def draw_one_mark(expr p,a)=
  draw (p+unitvector(dir(a))*mark_h/2)--(p-unitvector(dir(a))*mark_h/2);
enddef;

% Draw |n| marks between points |i| and |j|.
% |i| and |j| are local points and there is no absolute version
% since this is a drawing function.
vardef draw_equal_marks(expr i,j,n)=
  save a,k,l,start;
  a=angle(z[ipnt_(j)]-z[ipnt_(i)])+90;
  l=(x[ipnt_(j)]-x[ipnt_(i)])++(y[ipnt_(j)]-y[ipnt_(i)]);
  if n=1:
    draw_one_mark(.5[z[ipnt_(i)],z[ipnt_(j)]],a);
  elseif n>1:
    start=0.5-(n-1)*mark_l/(2*l);
    for k:=0 upto n-1:
      draw_one_mark((start+k*mark_l/l)[z[ipnt_(i)],z[ipnt_(j)]],a);
    endfor;
  else: message "parameter " & decimal n & " should be positive";
  fi;  
enddef;

numeric square_angle_size;
square_angle_size=0.2;

% (absolute version)
def def_right_angle_(expr pi,pj,pk,i,j,k)=
  vec_diff_(pj,j,i);vec_diff_(pk,k,i);
  if vec_mod_(pj)>0:
    vec_mult_(pj,pj,square_angle_size/vec_mod_(pj)); 
  fi;
  if vec_mod_(pk)>0:
    vec_mult_(pk,pk,square_angle_size/vec_mod_(pk));
  fi;
  vec_sum_(pi,i,pj);vec_sum_(pi,pi,pk);
  vec_sum_(pj,pj,i);vec_sum_(pk,pk,i);
enddef;

% (local version)
def def_right_angle(expr pi,pj,pk,i,j,k)=
  def_right_angle_(pnt(pi),pnt(pj),pnt(pk),pnt(i),pnt(j),pnt(k));
enddef;

% Right angle on a plane projection.
% Similar to |def_right_angle_|.
% This also defines the vertical projection as |vp|.
vardef def_right_angle_p_(expr pi,pj,pk,vp)(expr i)(text p)=
  def_vert_pl_(vp)(i)(p);
  new_vec(va);
  vec_diff_(va,p1,p2);
  vec_sum_(va,va,vp); % va is now a second point on the plane,
                      % different from the projection
  def_right_angle_(pi,pj,pk,vp,va,i);
  free_vec(va);
enddef;

def draw_right_angle(expr pi,pj,pk)=
  draw z[ipnt_(pj)]--z[ipnt_(pi)]--z[ipnt_(pk)];
enddef;

def draw_double_right_angle(expr pi,pj,pk,pl)=
  draw z[ipnt_(pj)]--z[ipnt_(pi)]--z[ipnt_(pk)]--z[ipnt_(pl)]--cycle;
enddef;

% |draw_line| with extra drawing in either directions 
def draw_line_extra(expr i,j)(expr exi,exj)=
  draw exi[z[ipnt_(i)],z[ipnt_(j)]]--exj[z[ipnt_(i)],z[ipnt_(j)]];
enddef;

% defines point |i| at position |t| on segment |a|-|b| (absolute version)
def set_extra_point_(expr i,a,b,t)=
  vec_diff_(i,b,a);vec_mult_(i,i,t);vec_sum_(i,i,a); 
enddef;

% defines point |i| at position |t| on segment |a|-|b| (local version)
def set_extra_point(expr i,a,b,t)=
  set_extra_point_(pnt(i),pnt(a),pnt(b),t);
enddef;

% labels with local points
vardef thelabel_obj@#(expr s,n) =
  thelabel.@#(s,z[ipnt_(n)])
enddef;

def label_obj = draw thelabel_obj enddef;

% The plane |p| (which must have been initialized) is defined
% as the screen plane. This is useful for computing vanishing points
def def_screen_pl(text p)=
  vec_mult_(p1,ObsI_,Obs_dist);vec_sum_(p1,p1,Obs); % center of screen
  vec_sum_(p2,p1,ObsJ_);vec_sum_(p3,p1,ObsK_);
enddef;  

% |i| is the resulting point, |l| defines a line in space,
% |s| is the screen plane
% Returns |true| is there is a vanishing point, otherwise |false|.
vardef def_vanishing_point_p_l_pl_(expr i)(text l)(text s)=
  save vp;boolean vp;
  hide(
    new_vec(v);
    vec_diff_(v,l2,l1);vec_sum_(v,Obs,v);
    new_line_(obsl)(Obs,v);
    if def_inter_p_l_pl_(i)(obsl)(s):vp=true;else:vp=false;fi;
    free_line(obsl);
    free_vec(v);
  )
  vp
enddef;

def def_vanishing_point_p_l_pl(expr i)(text l)(text s)=
  def_vanishing_point_p_l_pl_(pnt(i))(l)(s)
enddef;

endinput
