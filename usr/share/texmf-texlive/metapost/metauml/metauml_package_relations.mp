% MetaUML, a MetaPost library for typesetting exquisite UML diagrams.
% Copyright (C) 2006 Radu-George Radulescu
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

if known _metauml_package_relations_mp:
  expandafter endinput
fi;
_metauml_package_relations_mp:=1;

defaultRelationHeadWidth  := 25;
defaultRelationHeadHeight := 10;

vardef NestInfo@# =
  LinkInfo@#;

  @#widthA      = 0;
  @#heightA     = 0;
  @#drawMethodA = "drawNothing";

  @#widthB      = defaultRelationHeadWidth;
  @#heightB     = defaultRelationHeadHeight;
  @#drawMethodB = "drawCrossedCircle";

  @#drawMethod = "drawLine";
enddef;

NestInfo.nest;

vardef drawRelation(text iLink)(expr myPath)=
  link(iLink)(myPath);
enddef;

vardef drawLine(expr my_path) =
  draw my_path;
enddef;

vardef drawNothing(text pA)(text pB)(text base) =
enddef;
