%%% tabvar.mp
numeric w, h ;
w=24pt ; h=12pt ;
beginfig(1);
pickup pencircle scaled .2pt;
drawarrow (0,0) -- (w,h);
endfig;
beginfig(2);
pickup pencircle scaled .2pt;
drawarrow (0,h) -- (w,0);
endfig;
beginfig(3);
pickup pencircle scaled .2pt;
drawarrow (0,0) -- (w,0);
endfig;
end.
endinput;
