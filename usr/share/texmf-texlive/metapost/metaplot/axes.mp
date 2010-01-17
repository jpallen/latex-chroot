% AXES: Axis/grid-tick formatter, for the METAPLOT package.
% Copyright(C) 2004, Brooks Moses
% 
%   This work may be distributed and/or modified under the
%   conditions of the LaTeX Project Public License, either
%   version 1.3 of this license or (at your option) any
%   later version.
%   The latest version of the license is in
%      http://www.latex-project.org/lppl.txt
%   and version 1.3 or later is part of all distributions of
%   LaTeX version 2003/06/01 or later.
% 
%   This work has the LPPL maintenance status "author-maintained".
%
% Version 0.9.
%
% The n < 1.0 release number indicates that this is a beta release;
% the author at present makes no assurances that the command syntax
% will remain unchanged between this and the final Version 1.0
% release.
%
% Bug reports, feature requests, and all other suggestions should
% be directed to Brooks Moses, bmoses@stanford.edu.


input format

% axes_tick(pair tickorigin,
%           numeric ticklength,
%           pair tickdir)
%
% Draws a grid tick, located on tickorigin, in the direction indicated by
% tickdir, with length ticklength.

def axes_tick(expr tickorigin, ticklength, tickdir) =
  begingroup
  interim linecap := butt;
  save theaxistick; picture theaxistick; theaxistick := nullpicture;
  addto theaxistick doublepath ((0,0)--(ticklength * unitvector(tickdir)));

  theaxistick shifted tickorigin
  endgroup
enddef;


% axes_ticklabeled(pair tickorigin,
%                  numeric ticklength,
%                  numeric tickspace,
%                  pair tickdir,
%                  picture ticklabel)
%
% Draws a grid tick, located on tickorigin, in the direction indicated by
% tickdir, with length ticklength.  In addition, ticklabel is placed as
% a label such that its center is along the line of the tick, and the
% bounding box is a distance tickspace from the end of the tick.

def axes_ticklabeled(expr tickorigin, ticklength, tickspace, tickdir, ticklabel) =
  begingroup
  interim linecap := butt;
  save tickunitvector; pair tickunitvector;
  tickunitvector := unitvector(tickdir);
  
  % We calculate an intersection point between the bbox of ticklabel
  % and a ray extending from center(ticklabel) in the direction of 
  % tickdir (approximated by a line guaranteed to be long enough to 
  % exit the bbox), in the coordinates of ticklabel.  Thus, shifting
  % ticklabel by the negative of this amount will put this intersection
  % point at (0,0).
  
  save thelabelshift; pair thelabelshift;
  thelabelshift =
    (center(ticklabel) -- (center(ticklabel)
      - tickunitvector * (xpart(urcorner ticklabel - llcorner ticklabel)
                          + ypart(urcorner ticklabel - llcorner ticklabel))))
     intersectionpoint (llcorner ticklabel -- lrcorner ticklabel
                         -- urcorner ticklabel -- ulcorner ticklabel -- cycle);
  
  save thetick; picture thetick; thetick := nullpicture;
  addto thetick doublepath ((0,0)--(ticklength * tickunitvector));
  addto thetick also ticklabel
    shifted ((ticklength + tickspace)*tickunitvector - thelabelshift);

  thetick shifted tickorigin
  endgroup
enddef;


% axes_ticknumbered(pair tickorigin,
%                   numeric ticklength,
%                   numeric tickspace,
%                   pair tickdir,
%                   numeric tickvalue)
%                   string ticklabelformat)
%
% Draws a grid tick with a formatted number (tickvalue) as the label,
% according to the format given in ticklabelformat, with the remainder
% of the syntax identical to axes_ticklabeled.

def axes_ticknumbered(expr tickorigin, ticklength, tickspace, tickdir,
                      tickvalue, ticklabelformat) =
  axes_ticklabeled(tickorigin, ticklength, tickspace, tickdir,
                   format(ticklabelformat, tickvalue))    
enddef;


% axes_tickrow(pair startpoint,
%              pair endpoint,
%              numeric ticklength,
%              pair tickdir,
%              numeric ntickspaces)
%
% Draws a row of ntickspaces+1 grid ticks (that is, ticks with ntickspaces
% spaces between them) from startpoint to endpoint, with parameters given
% by ticklength and tickdir.

def axes_tickrow(expr startpoint, endpoint,
                      ticklength, tickdir, ntickspaces) =
  begingroup
  save thetickrow; picture thetickrow; thetickrow := nullpicture;
  save tickpoint; pair tickpoint;
  for itick=0 upto ntickspaces:
    tickpoint := (itick/ntickspaces) * (endpoint - startpoint) + startpoint;
    addto thetickrow also
      axes_tick(tickpoint, ticklength, tickdir);
  endfor
  thetickrow
  endgroup
enddef;


% axes_tickrow_numbered(pair startpoint,
%                       pair endpoint,
%                       numeric ticklength,
%                       numeric tickspace,
%                       pair tickdir,
%                       numeric startvalue,
%                       numeric endvalue,
%                       numeric ntickspaces,
%                       string ticklabelformat)
%
% Draws a row of ntickspaces+1 labeled grid ticks (that is, ticks with
% ntickspaces spaces between them) from startpoint to endpoint, with
% parameters given by ticklength, tickspace, and tickdir.  These ticks
% are labeled with numeric values that range from startvalue (at'
% startpoint) to endvalue (at endpoint), according to the format given
% in ticklabelformat.

def axes_tickrow_numbered(expr startpoint, endpoint,
                               ticklength, tickspace, tickdir,
                               startvalue, endvalue, ntickspaces,
                               ticklabelformat) =
  begingroup
  save thetickrow; picture thetickrow; thetickrow := nullpicture;
  save tickpoint; pair tickpoint;
  save tickvalue; numeric tickvalue;
  for itick=0 upto ntickspaces:
    tickpoint := (itick/ntickspaces) * (endpoint - startpoint) + startpoint;
    tickvalue := (itick/ntickspaces) * (endvalue - startvalue) + startvalue;
    addto thetickrow also
      axes_ticknumbered(tickpoint, ticklength, tickspace, tickdir,
                        tickvalue, ticklabelformat);
  endfor
  thetickrow
  endgroup
enddef;


% axes_tickscale(pair startpoint,
%                pair endpoint,
%                numeric ticklength,
%                numeric tickspace,
%                pair tickdir,
%                numeric startvalue,
%                numeric endvalue,
%                numeric tickzero,
%                numeric tickstep,
%                string ticklabelformat)
%
% Draws a row of grid ticks from startpoint to endpoint, arranged
% such that their values increase in steps of size tickstep, and 
% located so that the sequence of grid ticks, if continued to 
% infinity, will include a tick with value tickzero.  The ticks
% will be labeled according to format ticklabelformat, or if 
% ticklabelformat is "", they will be unlabeled.

def axes_tickscale(expr startpoint, endpoint,
                        ticklength, tickspace, tickdir,
                        startvalue, endvalue, tickzero, tickstep,
                        ticklabelformat) =
  begingroup
  % tickepsilon is a small tolerance value to avoid roundoff errors.
  save tickepsilon; numeric tickepsilon;
  tickepsilon = 0.005 * min(1.0, abs(endvalue-startvalue)/tickstep);

  save firstticknumber; numeric firstticknumber;
  save lastticknumber; numeric lastticknumber;  
  firstticknumber = ceiling((min(startvalue,endvalue)-tickzero)/tickstep - tickepsilon);
  lastticknumber = floor((max(startvalue,endvalue)-tickzero)/tickstep + tickepsilon);

  save firsttickvalue; numeric firsttickvalue;
  save lasttickvalue; numeric lasttickvalue;  
  firsttickvalue = firstticknumber * tickstep + tickzero;
  lasttickvalue = lastticknumber * tickstep + tickzero;

  if ticklabelformat="":
    axes_tickrow( 
      ((firsttickvalue-startvalue)/(endvalue-startvalue))[startpoint, endpoint],
      ((lasttickvalue-startvalue)/(endvalue-startvalue))[startpoint, endpoint],
      ticklength, tickdir, lastticknumber - firstticknumber)
  else:
    axes_tickrow_numbered( 
      ((firsttickvalue-startvalue)/(endvalue-startvalue))[startpoint, endpoint],
      ((lasttickvalue-startvalue)/(endvalue-startvalue))[startpoint, endpoint],
      ticklength, tickspace, tickdir, 
      firsttickvalue, lasttickvalue, lastticknumber - firstticknumber,
      ticklabelformat)
  fi
  endgroup
enddef;
