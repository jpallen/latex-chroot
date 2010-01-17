input splines;

numeric u; u:=1cm;

path xaxis, yaxis;
xaxis := (-2.5u,0)--(1.5u,0);
yaxis := (0,-.5u)--(0,1.5u);

def shiftit =
  currentpicture := currentpicture shifted -llcorner currentpicture;
enddef;

def dodots (text t) =
  for _loc = t:
    fill (fullcircle scaled 2pt) shifted (u*_loc);
  endfor
enddef;



beginfig(1);
  drawarrow xaxis;
  drawarrow yaxis;
  path p;
  p := dospline (true)
   ((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  draw p scaled u;
label(btex From {\tt dospline (true)}. etex,(.25u,-.75u));
dodots ((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
shiftit;
endfig;

beginfig(2);
  drawarrow xaxis;
  drawarrow yaxis;
  save A; pair A[];
  list_to_array (A)((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  path p;
  p := mkclosedspline (A);
  draw p scaled u;
label(btex From {\tt mkclosedspline}. etex,(.25u,-.75u));
dodots (A1, A2, A3, A4, A5, A6, A7);
shiftit;
endfig;

beginfig(3);
  drawarrow xaxis;
  drawarrow yaxis;
  path p;
  p := dospline (false)
   ((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  draw p scaled u;
label(btex From {\tt dospline (false)}. etex,(.25u,-.75u));
dodots ((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
shiftit;
endfig;

beginfig(4);
  drawarrow xaxis;
  drawarrow yaxis;
  save A; pair A[];
  list_to_array (A)((-1,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  path p;
  p := mkrelaxedspline (A);
  draw p scaled u;
label(btex From {\tt mkrelaxedspline}. etex,(.25u,-.75u));
dodots (A1, A2, A3, A4, A5, A6, A7);
shiftit;
endfig;

beginfig(5);
  drawarrow xaxis;
  drawarrow yaxis;
  path p;
  p := fcnspline (true)
   ((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  draw p scaled u;
label(btex From {\tt fcnspline (true)}. etex,(.25u,-.75u));
dodots ((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
shiftit;
endfig;

beginfig(6);
  drawarrow xaxis;
  drawarrow yaxis;
  save A; pair A[];
  list_to_array(A) ((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  path p;
  p := mkperiodicfcnspline (A);
  draw p scaled u;
label(btex From {\tt mkperiodicfcnspline}. etex,(.25u,-.75u));
dodots (A1, A2, A3, A4, A5, A6, A7);
shiftit;
endfig;

beginfig(7);
  drawarrow xaxis;
  drawarrow yaxis;
  path p;
  p := fcnspline (false)
   ((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  draw p scaled u;
label(btex From {\tt fcnspline (false)}. etex,(.25u,-.75u));
dodots((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
shiftit;
endfig;

beginfig(8);
  drawarrow xaxis;
  drawarrow yaxis;
  save A; pair A[];
  list_to_array(A) ((-2,0), (-1,1), (-.5,.8), (0,1),(.5,.4), (1,0), (1.5,1));
  path p;
  p := mkrelaxedfcnspline (A);
  draw p scaled u;
label(btex From {\tt mkrelaxedfcnspline}. etex,(.25u,-.75u));
dodots (A1, A2, A3, A4, A5, A6, A7);
shiftit;
endfig;

end.

