% MetaUML, a MetaPost library for typesetting exquisite UML diagrams.
% Copyright (C) 2005 Ovidiu Gheorghies
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

if known _metauml_paths_mp: 
  expandafter endinput 
fi;
_metauml_paths_mp:=1;

def pathDirect(expr pA,pB) =
  pA--pB
enddef;

vardef pathManhattanX(expr pA,pB) =
  pA--(xpart(pB), ypart(pA))--pB
enddef;

vardef rpathManhattanX(expr pA,pB) =
  pB--(xpart(pB), ypart(pA))--pA
enddef;

vardef pathManhattanY(expr pA,pB) =
  pA--(xpart(pA), ypart(pB))--pB
enddef;

vardef rpathManhattanY(expr pA,pB) =
  pB--(xpart(pA), ypart(pB))--pA
enddef;

vardef pathStepX(expr pA,pB, deltax) =
  pA--(pA+(deltax, 0))--(((xpart pA)+deltax), ypart(pB))--pB
enddef;

vardef rpathStepX(expr pA,pB, deltax) =
  pB--(((xpart pA)+deltax), ypart(pB))--(pA+(deltax, 0))--pA
enddef;

vardef pathStepY(expr pA,pB, deltay) =
  pA--(pA+(0, deltay))--(xpart(pB), ((ypart pA)+deltay))--pB
enddef;

vardef rpathStepY(expr pA,pB, deltay) =
  pB--(xpart(pB), ((ypart pA)+deltay))--(pA+(0, deltay))--pA
enddef;

vardef pathHorizontal(expr pA, untilX) =
  pA--(untilX,ypart(pA))
enddef;

vardef rpathHorizontal(expr pA, untilX) =
  (untilX,ypart(pA))--pA
enddef;

vardef pathVertical(expr pA, untilY) =
  pA--(xpart(pA), untilY)
enddef;

vardef rpathVertical(expr pA, untilY) =
  (xpart(pA), untilY)--pA
enddef;

% Cuts path thePath so that it won't intersect the objects
% objectA and objectB. The border of the objects is obtained
% by invoking the method "_border".
% 
vardef pathCut(suffix objectA, objectB)(expr thePath)=
  save timeA, timeB;
  
  timeA = xpart (thePath intersectiontimes objectBorder(objectA));
  timeB = xpart (thePath intersectiontimes objectBorder(objectB));

  subpath (timeA, timeB) of thePath
enddef;
