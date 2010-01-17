% METAPLOT: primary plot routines for the METAPLOT package.
% Copyright(C) 2004-2005, Brooks Moses
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
% Version 0.91.
%
% The n < 1.0 release number indicates that this is a beta release;
% the author at present makes no assurances that the command syntax
% will remain unchanged between this and the final Version 1.0
% release.
%
% Bug reports, feature requests, and all other suggestions should
% be directed to Brooks Moses via metaplot@dpdx.net.


% Load MetaPlot axes macros
input axes

% plot_instantiate(suffix inst, suffix plot_object)
%
% Defines a page-instance of plot-object inst, and sets up the relevant
% correspondences between the page locations and the plot-object's scale
% locations.

def plot_instantiate(suffix inst)(suffix plot_object) =

  % Define (unknown) parameters for plot-instance location on page

  numeric inst.pagewidth, inst.pageheight;
  numeric inst.pageleft, inst.pageright, inst.pagetop, inst.pagebottom;
  pair inst.llft, inst.lrt, inst.ulft, inst.urt;

  inst.pageleft + inst.pagewidth = inst.pageright;
  inst.pagebottom + inst.pageheight = inst.pagetop;
  inst.llft = (inst.pageleft, inst.pagebottom);
  inst.lrt = (inst.pageright, inst.pagebottom);
  inst.ulft = (inst.pageleft, inst.pagetop);
  inst.urt = (inst.pageright, inst.pagetop);

  % Define (known) parameters for plot's scaling
  
  numeric inst.scalewidth, inst.scaleheight;
  numeric inst.scaleleft, inst.scaleright, inst.scaletop, inst.scalebottom;

  inst.scaleleft := plot_object.xleft;
  inst.scaleright := plot_object.xright;
  inst.scalebottom := plot_object.ybot;
  inst.scaletop := plot_object.ytop;

  inst.scalewidth := inst.scaleright - inst.scaleleft;
  inst.scaleheight := inst.scaletop - inst.scalebottom;

  % Pointer-function to plot_object's plots, scaled and positioned.
  
  vardef inst.plot(suffix name) =
    begingroup
      save xleft; save xright; save ybot; save ytop;
      xleft = min(xpart(llcorner plot_object.name), 0.0);
      xright = max(xpart(urcorner plot_object.name), 1.0);
      ybot = min(ypart(llcorner plot_object.name), 0.0);
      ytop = max(ypart(urcorner plot_object.name), 1.0);
      setbounds plot_object.name to
        (xleft,ybot)--(xright,ybot)--(xright,ytop)--(xleft,ytop)--cycle;
    endgroup;
    plot_object.name xscaled inst.pagewidth yscaled inst.pageheight
                     shifted inst.llft
  enddef;
  
enddef;

% plot_setequalaxes(suffix inst)
%
% Sets the axis-scales equal on plot inst.

def plot_setequalaxes(suffix inst) =
  inst.pagewidth = inst.pageheight * (inst.scalewidth/inst.scaleheight);
enddef;


% plot_[x | y | x]pageloc(suffix inst,
%                         numeric [scalex | scaley | scalex, scaley])
%
% Scale-to-page conversion functions, which produce the value (or pair)
% for the page location that corresponds to the given x location, y
% location, or pair in plot-object inst's coordinates.

def plot_xpageloc(suffix inst)(expr scalex) =
  inst.pageleft + (inst.pagewidth/inst.scalewidth) * (scalex - inst.scaleleft)
enddef;
  
def plot_ypageloc(suffix inst)(expr scaley) =
  inst.pagebottom + (inst.pageheight/inst.scaleheight) * (scaley - inst.scalebottom)
enddef;
  
def plot_zpageloc(suffix inst)(expr scalex)(expr scaley) =
  (plot_xpageloc(inst, scalex), plot_ypageloc(inst,scaley))
enddef;


% plot_[x | y]scaleloc(suffix inst,
%                      numeric [pagex | pagey])
%
% Page-to-scale conversion functions, which produce the value
% for the location in plot-object inst's coordinates that corresponds
% to the given x location or y location on the page.

def plot_xscaleloc(suffix inst)(expr pagex) =
  inst.scaleleft + (inst.scalewidth/inst.pagewidth) * (pagex - inst.pageleft)
enddef;

def plot_yscaleloc(suffix inst)(expr pagey) =
  inst.scalebottom + (inst.scaleheight/inst.pageheight) * (pagey - inst.pagebottom)
enddef;



% plot_xtickscale(suffix inst,
%                pair startpoint,
%                pair endpoint,
%                numeric ticklength,
%                numeric tickspace,
%                pair tickdir,
%                numeric tickzero,
%                numeric tickstep,
%                string ticklabelformat)
%
% Draws a row of x-axis grid ticks from startpoint to endpoint,
% with the values determined by the x-scale of plot-object inst,
% and the details of the tick location and format determined 
% according to the axes_tickscale parameters.

def plot_xtickscale(suffix inst)
                   (expr startpoint, endpoint,
                         ticklength, tickspace, tickdir,
                         tickzero, tickstep, ticklabelformat) =
  axes_tickscale(startpoint, endpoint,
                 ticklength, tickspace, tickdir,
                 plot_xscaleloc(inst)(xpart(startpoint)),
                 plot_xscaleloc(inst)(xpart(endpoint)),
                 tickzero, tickstep, ticklabelformat)
enddef;


% plot_ytickscale(suffix inst,
%                pair startpoint,
%                pair endpoint,
%                numeric ticklength,
%                numeric tickspace,
%                pair tickdir,
%                numeric tickzero,
%                numeric tickstep,
%                string ticklabelformat)
%
% Draws a row of y-axis grid ticks from startpoint to endpoint,
% with the values determined by the y-scale of plot-object inst,
% and the details of the tick location and format determined 
% according to the axes_tickscale parameters.

def plot_ytickscale(suffix inst)
                   (expr startpoint, endpoint,
                         ticklength, tickspace, tickdir,
                         tickzero, tickstep, ticklabelformat) =
  axes_tickscale(startpoint, endpoint,
                 ticklength, tickspace, tickdir,
                 plot_yscaleloc(inst)(ypart(startpoint)),
                 plot_yscaleloc(inst)(ypart(endpoint)),
                 tickzero, tickstep, ticklabelformat)
enddef;

