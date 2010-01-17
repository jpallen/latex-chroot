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

if known _util_picture_mp:
  expandafter endinput
fi;
_util_picture_mp:=1;

input util_log;

input util_margins;
if not known _n_cur_:input boxes;fi;

vardef FontInfo@#(expr tname, tscale)=
  attributes(@#);
  var(string) className;
  var(string) name;
  var(numeric) scale;

  @#className := "FontInfo";

  @#name := tname;
  @#scale := tscale;
enddef;

vardef FontInfoCopy@#(text fontInfo)=
  FontInfo@#(fontInfo.name, fontInfo.scale);
  @#ignoreNegativeBase := fontInfo.ignoreNegativeBase;
enddef;

vardef FontInfo_toString@#=
  save ret; string ret;
  ret := "FontInfo(" & (str @#) & "): {" & (@#name) & ", " & (decimal @#scale) & "}";
  ret
enddef;

log "()()() Creating iFont";
FontInfo.iFont(defaultfont, defaultscale);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                 %
%                         PICTURE                                 %
%                                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef PictureInfo@#(expr pleft, pright, ptop, pbottom)(text pfont)=
  attributes(@#);
  var(string) className;
  @#className := "PictureInfo";

  var(color)   borderColor;
  var(numeric) boxed;

  var(numeric) ignoreNegativeBase;

  @#boxed := 0;
  @#borderColor := blue;

  @#ignoreNegativeBase := 0;

  Margins.@#(pleft, pright, ptop, pbottom);

  FontInfoCopy.@#iFont(pfont);
enddef;

vardef PictureInfoCopy@#(text src)=
  PictureInfo@#(src.left, src.right, src.top, src.bottom)(src.iFont);

  @#boxed := src.boxed;
  @#borderColor := src.borderColor;
  @#ignoreNegativeBase := src.ignoreNegativeBase;
enddef;

vardef PictureInfo_toString@#=
  save ret; string ret;
  ret := "PictureInfo(" & (str @#) & "): {" & (decimal @#left) & ", " & (decimal @#right) & ", " & (decimal @#top) & ", " & (decimal @#bottom) & "}" & " boxed: " & (decimal @#boxed);
  ret := ret & " Font: " & toString(@#iFont);
  ret
enddef;

PictureInfo.iPict(2, 2, 2, 2)(iFont);

PictureInfoCopy.iPictBoxed(iPict);
iPictBoxed.boxed := 1;

%%
%% Contructs a Picture object by wrapping around the
%% low-level picture thePict.
%%
vardef EPicture@#(text iPict)(expr thePict) =
  ObjectEquations(@#);
  @#className := "Picture";

  var(pair)    contentShift;
  var(picture) pict;
  var(numeric) negativeBase;
  var(string)  contentAsString;
  var(picture) contentAsPicture;

  PictureInfoCopy.@#info(iPict);

  if string thePict:
    log "Picture " & (str @#) & " is a text";
    @#contentAsString := thePict;
    log @#contentAsString;
  elseif picture thePict:
    log "Picture " & (str @#) & " is a native pict";
    @#contentAsPicture := thePict;
    log @#contentAsPicture;
  else:
    log "Picture " & (str @#) & " [error]";
  fi;

enddef;

%%
%% Contructs a Picture object by wrapping around the
%% low-level picture thePict.
%%
vardef Picture@#(expr thePict) =
  EPicture@#(iPict)(thePict);
enddef;

%%
%% Lays out the Picture.
%%
vardef Picture_layout@# =
  if @#layedout = 0:
    log "Laying out " & (str @#);

    @#layedout := 1;

    if known @#contentAsPicture:
      log "Content is known to be a picture";
      @#pict = @#contentAsPicture;
    elseif known @#contentAsString:
      log "Content is known to be a string";
      log @#contentAsString;
      @#pict = @#contentAsString infont @#info.iFont.name scaled @#info.iFont.scale;
    else:
      log "Show unknown parameter type in picture layout";
      2 = 3;
    fi;

    @#negativeBase = ypart llcorner @#pict;

    @#width = pictWidth(@#pict) + @#info.left + @#info.right;

    if @#info.ignoreNegativeBase = 0:
      @#height = pictHeight(@#pict) + @#info.top + @#info.bottom;
      @#contentShift = @#sw + (@#info.left, @#info.bottom - @#negativeBase) ;
    else:
      @#height = pictHeight(@#pict) + @#info.top + @#info.bottom + @#negativeBase;
      @#contentShift = @#sw + (@#info.left, @#info.bottom);
    fi;

  else:
    log "Picture " & str @# & " already layed out.";
  fi;
enddef;

%%
%% Draws the Picture.
%%
vardef Picture_draw@# =
  Picture_layout@#;
  objectEnsurePositioning.@#;
  
  draw @#pict shifted @#contentShift;

  if (@#info.boxed = 1):
    draw objectBox(@#) withcolor @#info.borderColor;
  fi;
enddef;

vardef Picture_border@#=
    objectBox(@#)
enddef;

vardef aitem(text pictInfo)(text thePict)(text equation)=
  save obj;
  EPicture.obj(pictInfo)(thePict);
  equation;
  drawObject(obj);
enddef;

vardef item@#(text iPict)(text thePict)(text equation)=
  save itemName;
  string itemName;
  itemName := str @#;

  log "Creating an item with name: '" & itemName & "'";

  if itemName = "":
    log "Name is empty, creating an anonymous item!";
    aitem(iPict)(thePict)(equation);
  else:
    EPicture@#(iPict)(thePict);
    equation;
    drawObject(@#);
  fi;
enddef;

