%%% textpath.mp
%%% Copyright 2007 Stephan Hennig <stephanhennig@arcor.de>
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3 of this license
% or (at your option) any later version.  The latest version of this
% license is in http://www.latex-project.org/lppl.txt
%

if known textpath_fileversion: endinput fi;
string textpath_fileversion;
textpath_fileversion := "v1.6 (2007/02/11)";
message "Loading textpath " & textpath_fileversion;


%%% Global variables.

%%% Global variable.
%%% Character coordinates that lay outside path boundaries after
%%% transformation are clipped to the boundaries.
%%% Variable textpathClip determines if such characters should be
%%% output at path boundaries, thereby acting as a visual indicator
%%% that something went wrong, or if text outside path boundaries
%%% should be omitted. Variable textpathClip can be either one (omit)
%%% or zero (don't omit).
newinternal textpathClip;
textpathClip := 0;

%%% Global variable.
%%% Variable textpathLetterSpace determines the amount of space that
%%% is additionally inserted between all characters.  This can be
%%% useful, when drawing text along a concacve shape or in general
%%% along paths with a high curvature.  Variable textpathLetterSpace
%%% can contain positive or negative values.
newinternal textpathLetterSpace;
textpathLetterSpace := 0bp;

%%% Global variable.
newinternal textpathRotation;
textpathRotation := 0;

%%% Global variable.
newinternal textpathAbsRotation;
textpathAbsRotation := 0;

newinternal textpathRepeat;
textpathRepeat := 1;

newinternal textpathStretch;
textpathStretch := 1;

newinternal textpathHSpace;
textpathHSpace := 0;

newinternal textpathShift;
textpathShift := 0;

newinternal textpathSoulLetterSpace;
textpathSoulLetterSpace := 10bp;

newinternal textpathFancyStrokes;
textpathFancyStrokes := 1;

newinternal textpathStrokePrecision;
textpathStrokePrecision := 10;

newinternal textpathCureSqrt;
textpathCureSqrt := 1;

newinternal textpathAutoScale;
textpathAutoScale := 0;

newinternal textpathDraft;
textpathDraft := 0;

newinternal textpathDebug;
textpathDebug := 1;

pair textpathHookCoord, textpathHookPoint;
newinternal textpathHookRot;
textpathHookCoord := origin;
textpathHookPoint := origin;
textpathHookRot := 0;



%%% User Macros.

%%% User macro.
%%% Set text along a path.
%%% Parameters:
%%%  * a text string t that is fed into TeX through latexmp,
%%%  * a path p the text should follow.
%%%  * a numeric variable j that controls justification:
%%%    j=0:   text is left aligned on the path,
%%%    j=0.5: text is centered on the path,
%%%    j=1:   text is right aligned on the path,
%%%    The general rule is the character at fraction j of the total
%%%    text width is transformed to the point at fraction j of the total
%%%    path width.  j should be from the interval [0, 1].
%%% Return value:
%%%  * a picture variable containing text following a path.
def textpath(expr t, p, j)=
  textpathFont("", t, p, j)
enddef;


%%% User macro.
%%% Set text in arbitrary font along a path.
%%% Parameters:
%%%  * a string f that is a valid LaTeX font selection command, e.g., \itshape,
%%%  * a text string t that is fed into TeX through latexmp,
%%%  * a path p the text should follow.
%%%  * a numeric variable j that controls justification:
%%%    j=0:   text is left aligned on the path,
%%%    j=0.5: text is centered on the path,
%%%    j=1:   text is right aligned on the path,
%%%    The general rule is the character at fraction j of the total
%%%    text width is transformed to the point at fraction j of the total
%%%    path width.  j should be from the interval [0, 1].
%%% Return value:
%%%  * a picture variable containing text following a path.
vardef textpathFont(expr f, t, p, j)=
save pre, post;
string pre, post;
  pre := f & "\spaced{";
  post := "}";
  textpathToPic(strToPic(pre & t & post), p, j)
enddef;


%%% User macro.
%%% Set text along a path.
%%% Parameters:
%%%  * a text string t that is fed into TeX through latexmp,
%%%  * a path p the text should follow.
%%%  * a numeric variable j that controls justification:
%%%    j=0:   text is left aligned on the path,
%%%    j=0.5: text is centered on the path,
%%%    j=1:   text is right aligned on the path,
%%%    The general rule is the character at fraction j of the total
%%%    text width is transformed to the point at fraction j of the total
%%%    path width.  j should be from the interval [0, 1].
%%% Return value:
%%%  * a picture variable containing text following a path.
vardef textpathRaw(expr t, p, j)=
save pre, post;
string pre, post;
  pre := "\rule[-30bp]{0pt}{30bp}";
  post := "";
  textpathRawToPic(strToPic(pre & t & post), p, j)
enddef;



%%% Internal Macros.

%%% Internal macro.
%%% Convert a string into a picture using TeX via latexmp package.
%%% Parameters:
%%%  * a string.
%%% Return value:
%%%  * a picture variable.
vardef strToPic(expr s)=
interim labeloffset := 0bp;
  thelabel.urt(textext(s), origin)
enddef;


%%% Internal macro.
%%% Computes the length of a textual picture, thereby correcting
%%% for textpathSoulLetterSpace and textpathLetterSpace
vardef getPictureWidth(expr textpic, scale)=
save lenpic, k, w;
numeric lenpic, k, w;
  lenpic := 0;
  k := 0;
  for item within textpic:
    if textual item:
      w := xpart lrcorner ( item shifted (scale*k*(textpathLetterSpace-textpathSoulLetterSpace), 0bp) );
      if w > lenpic:
        lenpic := w;
      fi
      k := k + 1;
    fi
  endfor
  lenpic
enddef;


%%% Internal macro.
%%% Does pre-processing for macros textpath(Raw)ToPic, such as
%%% calculating variables startOffset, autoScale, ltextpathHSpace etc.
def preprocessTextPic(expr rawMode, atextpic, p, j)=
  save textpic, pic, lenp, lenpic, startOffset, ltextpathHSpace, autoScale, overfullPath;
  interim bboxmargin := 0bp;
  numeric lenp, lenpic, startOffset, ltextpathHSpace, autoScale;
  picture textpic, pic;
  boolean overfullPath;

  textpic := atextpic;
  pic := nullpicture;
%%% Compute path length.
  lenp := arclength(p);
%%% Compute picture length, i.e., correct plain picture dimensions
%%% for soul and textpath letter spacing.
  if rawMode:%%% Called from textpathRawToPic.
    lenpic := xpart (lrcorner textpic - llcorner textpic);
  else:%%% Called from textpathToPic.
    lenpic := getPictureWidth(textpic, 1);%%% Get corrected picture with scale = 1.
  fi
%%% Compute inter-copy space (for textpathRepeat > 1).
  if textpathStretch = 0:
    ltextpathHSpace := textpathHSpace;
  else:
    ltextpathHSpace := lenp/textpathRepeat - lenpic;
  fi
%%% Compute startOffset as j * remaining space.
  startOffset := j * (lenp - textpathRepeat*lenpic - (textpathRepeat-1)*ltextpathHSpace);
%%% By default, assume path isn't overfull.
  overfullPath := false;
  autoScale := 1;
%%% Overfull path?
  if startOffset < 0:
    overfullPath := true;
    if textpathAutoScale <> 0:%%% Calculate scaling factor.
      if textpathStretch <> 0:
	ltextpathHSpace := 0;%%% No inter-copy space when stretching allowed.
      fi
      autoScale := lenp/(textpathRepeat*lenpic + (textpathRepeat-1)*ltextpathHSpace1);
      startOffset := 0;
      if textpathDraft = 0:
	textpic := atextpic scaled autoScale;
      else:
	textpic := atextpic xscaled autoScale;%%% Don't scale y in draft mode.
      fi
      lenpic := getPictureWidth(textpic, autoScale);
%%% Compute inter-copy space (for textpathRepeat > 1).
      if textpathStretch = 0:
	ltextpathHSpace := textpathHSpace*autoScale;
      else:
	ltextpathHSpace := lenp/textpathRepeat - lenpic;%%% Should be equal to zero.
      fi
%%% Finally, output a warning.
      message "Package textpath warning:  Overfull path!  Scaled to " & decimal autoScale & ".";
    else:%%% No scaling.
      autoScale := 1;
      if textpathClip = 0:%%% Warn the user about overfull paths.
	message "Package textpath warning:  Overfull path!  Not clipped.";
      else:
	message "Package textpath warning:  Overfull path!  Clipped.";
      fi
    fi
  fi
enddef;



%%% Internal macro.
def transformSimpleItem(expr rawMode, item, p)=
%%% bitem is a character or straight rule to transform.
%%% banker is its original anchor position.
  if rawMode:
    bitem := item;
    banker := (xpart center bitem, autoScale*30bp);%%% Why 30bp?
  else:
    bitem := item shifted (k*autoScale*(textpathLetterSpace-textpathSoulLetterSpace), 0bp);
    banker := (xpart center bitem, ypart item);
  fi
%%% bx is the anchor position of a first item copy.
  bx := (xpart banker) + startOffset;
%%% Shift anchor to origin and raise baseline.
  bitem := bitem shifted -banker shifted (0bp, textpathShift);
%%% Iterate over all copies of an item.
  for i=1 upto textpathRepeat:
%%% cx is the anchor position of an item copy.
    cx := (i-1)*(lenpic + ltextpathHSpace) + bx;
%%% Draw items with valid positions or if no clipping.
    if ((cx>=0) and (cx<=lenp)) or (textpathClip=0):
%%% Compute path time value.
      tb := arctime cx of p;
%%% Compute rotation angle.
      if textpathAbsRotation=0:
	db := textpathRotation + angle direction tb of p;
      else:
	db := textpathRotation;
      fi
%%% Draw item's bounding box?
      if odd (textpathDebug div 2):
	addto pic doublepath bbox bitem rotated db shifted point tb of p withpen currentpen;
      fi
%%% Draw item?
      if odd (textpathDebug div 1):
%%% In draft mode fill bounding box if path is overfull.
	if overfullPath and (textpathDraft<>0):
	  addto pic contour bbox bitem rotated db shifted point tb of p;
	else:
	  addto pic also bitem rotated db shifted point tb of p;
	fi
      fi
%%% Draw item's anchor point?
      if odd (textpathDebug div 4):
	addto pic contour fullcircle scaled 3bp shifted point tb of p;
      fi
    fi
  endfor
%%% Save top right corner of supported square root glyphs in variable textpathHookCoord.
  if rawMode and (textpathCureSqrt <> 0):
    if ((fontpart item="cmex10")      and ((ASCII textpart item>=112) and (ASCII textpart item<=116))) or
      ((fontpart item="cmsy5")       and (ASCII textpart item=112)) or
      ((fontpart item="cmsy6")       and (ASCII textpart item=112)) or
      ((fontpart item="cmsy7")       and (ASCII textpart item=112)) or
      ((fontpart item="cmsy8")       and (ASCII textpart item=112)) or
      ((fontpart item="cmsy9")       and (ASCII textpart item=112)) or
      ((fontpart item="cmsy10")      and (ASCII textpart item=112)) or
      ((fontpart item="cmbsy10")     and (ASCII textpart item=112)) or
      ((fontpart item="fourier-mex") and (ASCII textpart item=114)) or
      ((fontpart item="fourier-ms")  and (ASCII textpart item=112)) or
      ((fontpart item="MnSymbolE5")  and (ASCII textpart item=186)) or
      ((fontpart item="MnSymbolE5")  and (ASCII textpart item=189)) or
      ((fontpart item="MnSymbolE10")  and (ASCII textpart item=186)):%%% \sqrt glyph?
      textpathHookCoord := urcorner item shifted (-xpart center item, -autoScale*30bp + textpathShift);
      textpathHookRot := db;
      textpathHookPoint := point tb of p;
%       addto pic contour fullcircle scaled 2bp shifted textpathHookCoord rotated db shifted point tb of p withcolor green;
    else:
      textpathHookCoord := origin;
    fi
  fi
enddef;


%%% Internal macro.
def transformStrokedItem(expr rawMode, item, p)=
  if textpathFancyStrokes = 0:
    transformSimpleItem(true, item, p);
  else:
    pp := pathpart item;
    for i=1 upto textpathRepeat:
      if (textpathHookCoord=origin) or (textpathCureSqrt=0):
	banker := (0, ypart point 0 of pp - autoScale*30bp + textpathShift);
	bx := (xpart point 0 of pp) + startOffset;
	dpp := angle direction 0 of pp;
	cx := (i-1)*(lenpic + ltextpathHSpace) + bx;
	tb := arctime cx of p;
	if textpathAbsRotation=0:
	  db := textpathRotation + angle direction tb of p;
	else:
	  db := textpathRotation;
	fi
	np := banker rotated db shifted point tb of p%{dir (dpp+db)}
      elseif textpathCureSqrt=1:
	np := textpathHookCoord shifted (dir(-90)*xpart point 0 of makepath penpart item);
	np := np rotated textpathHookRot shifted textpathHookPoint%{dir textpathHookRot}
      fi
      for h=1 upto textpathStrokePrecision:
	hide(
	  banker := (0, ypart point (h/textpathStrokePrecision) of pp - autoScale*30bp + textpathShift);
	  bx := (xpart point (h/textpathStrokePrecision) of pp) + startOffset;
	  cx := (i-1)*(lenpic + ltextpathHSpace) + bx;
	  dpp := angle direction (h/textpathStrokePrecision) of pp;
	  tb := arctime cx of p;
	  if textpathAbsRotation=0:
	    db := textpathRotation + angle direction tb of p;
	  else:
	    db := textpathRotation;
	  fi
	  )
	..banker rotated db shifted point tb of p%{dir (dpp+db)}
      endfor;
      if odd (textpathDebug div 2):
	addto pic doublepath bbox np withpen currentpen;
      fi
      if odd (textpathDebug div 1):
	addto pic doublepath np withpen penpart item;
      fi
      if odd (textpathDebug div 4):
%%% Doesn't work.
%	addto pic contour fullcircle scaled 3bp shifted point tb of p;
      fi
    endfor
  fi
enddef;




%%% Internal working macro.
%%% Set text from picture variable along a path with justification j.
%%% Parameters:
%%%  * a picture that contains the text that has to be transformed onto a path,
%%%  * a path p the text should follow,
%%%  * a numeric variable that controls justification,
%%% Return value:
%%%  * a picture variable containing text following a path.
vardef textpathToPic(expr atextpic, p, j)=
  save bitem, banker, k, bx, cx, tb, db;
  numeric k, bx, cx, tb, db;
  picture bitem;
  pair banker;

  %%% Calculate variables such as startOffset, autoScale, ltextpathHSpace etc.
  preprocessTextPic(false, atextpic, p, j);
  %%%
  %%% Now iterate over all picture elements.
  %%%
  k := 0;
  for item within textpic:
    if textual item:%%% Process textual elements.
      transformSimpleItem(false, item, p);
      k := k + 1;
    else:
      message "Package textpath warning:  Unsupported picture element found!";
    fi
  endfor
  %%% Return pic.
  pic
enddef;



%%% Internal working macro.
%%% Set text from picture variable along a path with justification j.
%%% Parameters:
%%%  * a picture that contains the text that has to be transformed onto a path,
%%%  * a path p the text should follow,
%%%  * a numeric variable that controls justification,
%%% Return value:
%%%  * a picture variable containing text following a path.
vardef textpathRawToPic(expr atextpic, p, j)=
  save bitem, banker, bx, cx, tb, db, pp, np, dpp;
  numeric bx, cx, tb, db, dpp;
  picture bitem;
  pair banker;
  path pp, np;

  %%% Calculate variables such as startOffset, autoScale, ltextpathHSpace etc.
  preprocessTextPic(true, atextpic, p, j);
%%% Reset last sqrt glyph's top right bounding box corner.
  textpathHookCoord := origin;
  %%%
  %%% Now iterate over all picture elements.
  %%%
  for item within textpic:
    if textual item:%%% Process textual elements.
      transformSimpleItem(true, item, p);
    elseif stroked item:%%% Process stroked elements.
      transformStrokedItem(true, item, p);
    else:
      message "Package textpath warning:  Unsupported picture element found!";
    fi
  endfor
  pic
enddef;
