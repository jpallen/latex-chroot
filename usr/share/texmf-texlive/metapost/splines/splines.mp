%%
%% This is file `splines.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% splines.dtx  (with options: `package')
%% 
%% -------------------------------------------------------------------
%% 
%% Copyright 2002--2005, Daniel H. Luecking
%% 
%% Splines.mp may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3 of this license or (at
%% your option) any later version. The latest version of this license is in
%%    <http://www.latex-project.org/lppl.txt>
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% Splines has maintenance status "author-maintained". The Current Maintainer
%% is Daniel H. Luecking. The Base Interpreter is MetaPost (or Metafont).
%% 
if known splines_fileversion: endinput fi;
string splines_fileversion;
splines_fileversion := "2006/09/25, v0.2a";
message "Loading splines.mp " & splines_fileversion;

def list_to_array (suffix arr) (text list) =
  arr := 0;
  for _itm = list :
    arr[incr arr] := _itm;
  endfor
enddef;

def compute_spline (expr closed) (suffix points, pr, po) =
  % interior equations:
  for j= 2 upto points - 1 :
    % equate first derivatives:
    po[j] + pr[j] = 2 points[j];
    %   and second derivatives:
    pr[j+1] + 2 pr[j] = 2 po[j] + po[j-1];
  endfor
  % for a closed curve, the first and last are also interior:
  if closed:
   po 1 + pr 1 = 2 points 1;
   po[points] + pr[points] = 2 points[points];
   pr 2 + 2 pr 1 = 2 po 1 + po[points];
   pr 1 + 2 pr[points] = 2 po[points] + po[points-1];
  fi
enddef;

vardef mksplinepath (expr closed) (suffix points, pr, po) =
  points1..controls po1 and
  for j = 2 upto points if not closed: -1 fi:
    pr[j]..points[j]..controls po[j] and
  endfor
    if closed: pr 1..cycle else: pr[points]..points[points] fi
enddef;

vardef mkrelaxedspline (suffix pnts) =
  save rs_pr, rs_po;
  pair rs_po[], rs_pr[];
  % Equate second derivative to zero at both end points
  rs_pr 2 + pnts 1 = 2 rs_po 1 ;
  pnts[pnts] + rs_po[pnts-1] = 2 rs_pr[pnts];
  compute_spline (false) (pnts, rs_pr, rs_po);
  mksplinepath   (false) (pnts, rs_pr, rs_po)
enddef;

vardef mkclosedspline (suffix pnts) =
  save cs_pr, cs_po;
  pair cs_pr[], cs_po[];
  compute_spline (true) (pnts, cs_pr, cs_po);
  mksplinepath   (true) (pnts, cs_pr, cs_po)
enddef;

vardef dospline (expr closed) (text the_list) =
  save _sp; pair _sp[];
  list_to_array (_sp) (the_list);
  if closed :
    mkclosedspline (_sp)
  else:
    mkrelaxedspline (_sp)
  fi
enddef;

def compute_fcnspline (suffix points, dx, sl) =
  % Get delta_x:
  for j = 1 upto points - 1: dx[j] := xpart (points[j+1]-points[j]);
  endfor
  for j=2 upto points - 1:
    sl[j + 1] * dx[j] + 2sl[j]*(dx[j] + dx[j-1]) + sl[j-1]*dx[j-1]
        = 3*ypart(points[j+1] - points[j-1]);
  endfor
enddef;

vardef mkfcnsplinepath (suffix points, dx, sl) =
  points1..controls (points1 + (1, sl1)*dx1/3) and
    for j = 2 upto points - 1:
      (points[j] - (1, sl[j])*dx[j-1]/3) ..points[j]..
        controls (points[j] + (1,sl[j])*dx[j]/3) and
    endfor
    (points[points] - (1,sl[points])*dx[points-1]/3)..points[points]
enddef;

vardef mkperiodicfcnspline (suffix pnts) =
  save _sl, _dx; numeric _dx[], _sl[];
  compute_fcnspline (pnts, _dx, _sl);
  % periodicity equations:
  _sl 1 = _sl[pnts];
  _sl 2 * _dx 1 + 2 _sl 1 * _dx 1 + 2 _sl[pnts] * _dx[pnts-1]
      + _sl[pnts-1] * _dx[pnts-1]
          = 3 * ypart(pnts[2] - pnts[pnts-1]);
  mkfcnsplinepath  (pnts, _dx, _sl)
enddef;

vardef mkrelaxedfcnspline (suffix pnts) =
  save _sl, _dx; numeric _dx[], _sl[];
  compute_fcnspline (pnts, _dx, _sl);
  % relaxation equations.
  _sl 2 * _dx 1 + 2 _sl1 * _dx 1 = 3 * ypart(pnts2 - pnts1);
  _sl[pnts-1] * _dx[pnts-1] + 2 _sl[pnts] * _dx[pnts-1]
        = 3 * ypart(pnts[pnts] - pnts[pnts-1]);
  mkfcnsplinepath  (pnts, _dx, _sl)
enddef;

vardef fcnspline (expr periodic) (text the_list) =
  save _fs; pair _fs[];
  list_to_array (_fs) (the_list);
  if periodic:
    mkperiodicfcnspline (_fs)
  else:
    mkrelaxedfcnspline (_fs)
  fi
enddef;

endinput.
%%
%% End of file `splines.mp'.
