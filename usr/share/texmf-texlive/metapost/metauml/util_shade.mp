% MetaUtil, an easier MetaPost life
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

if known _metauml_shade_mp:
  expandafter endinput
fi;
_metauml_shade_mp:=1;

input util_log;

vardef ShadeInfo@#=
  _n_ := str @#;
  generic_declare(numeric) _n.shift;
  generic_declare(color) _n.background;

  @#shift := 1;
  @#background := .7white;
enddef;

vardef ShadeInfoCopy@#(text src)=
  ShadeInfo.@#;
  ShadeInfo_copy@#(src);
enddef;

vardef ShadeInfo_copy@#(text src)=
  @#shift := src.shift;
  @#background := src.background;
enddef;

vardef ShadeInfo_toString@#=
  save @#ret;
  string @#ret;
  @#ret := "Shade (shift: " & (decimal @#shift) & " back: (" &
    (decimal redpart @#background) & ", " &
    (decimal greenpart @#background) & ", " &
    (decimal bluepart @#background) & ")";

  @#ret
enddef;


