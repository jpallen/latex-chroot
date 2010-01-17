input metaobj

def show_standard_bb(suffix n_)=
  pickup pencircle scaled 2pt;
  draw n_.nw;draw n_.ne;
  draw n_.sw;draw n_.se;
  pickup pencircle scaled .5bp;
  label.ulft(btex nw etex,n_.nw);
  label.urt(btex ne etex,n_.ne);
  label.llft(btex sw etex,n_.sw);
  label.lrt(btex se etex,n_.se);
enddef;

def show_standard_ibb(suffix n_)=
  pickup pencircle scaled 2pt;
  draw n_.inw;draw n_.ine;
  draw n_.isw;draw n_.ise;
  pickup pencircle scaled .5bp;
  label.ulft(btex inw etex,n_.inw);
  label.urt(btex ine etex,n_.ine);
  label.llft(btex isw etex,n_.isw);
  label.lrt(btex ise etex,n_.ise);
enddef;



beginfig(1);
  show_empty_boxes:=true;
  newEmptyBox.a(2cm,1cm) "framed(true)";
  a.c=origin;
  drawObj(a);
endfig;

beginfig(2);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(3);
  newHRazor.a(3cm) "framed(true)";
  a.c=origin;
  drawObj(a);
endfig;

beginfig(4);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(5);
  show_empty_boxes:=true;
  newRandomBox.a(2cm,1cm,2mm,-1mm) "framed(true)";
  a.c=origin;
  drawObj(a);
endfig;

beginfig(6);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(7);
  newRandomBox.a(2cm,1cm,2mm,-1mm) "framed(true)", "framewidth(1mm)";
  a.c=origin;
  drawObj(a);

endfig;

clearObj a;

beginfig(8);
  newRandomBox.a(1cm,5mm,2mm,-1mm) "framed(true)", "filled(true)",
        "fillcolor(red)","framewidth(1mm)","framecolor(green)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(10);
  newBox.a(btex some text etex);
  a.c=origin;
  drawObj(a);
endfig;

beginfig(11);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(12);
  newBox.a(btex some text etex) "fit(false)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(13);
  newBox.a("") "filled(true)", "dx(2mm)", "dy(2mm)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(15);
  newBox.a(btex This is an ovalbox etex) "rbox_radius(2mm)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(17);
  newBox.a(btex This is a shadowbox etex) "shadow(true)";
  a.c=origin;
  drawObj(a);
endfig;


clearObj a;

beginfig(20);
  newPolygon.a(btex some text etex,5);
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(21);
  newPolygon.a(btex some text etex,5) "polymargin(3mm)";
  a.c=origin;
  drawObj(a);
endfig;

beginfig(22);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(23);
  newPolygon.a(btex some text etex,7) "fit(false)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(30);
  newEllipse.a(btex some text etex);
  a.c=origin;
  drawObj(a);
endfig;

beginfig(31);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(32);
  newEllipse.a(btex some text etex) "fit(false)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(33);
  newEllipse.a("") "filled(true)","circmargin(2mm)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(35);
  newCircle.a(btex some text etex);
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(40);
  newDBox.a(btex some text etex);
  a.c=origin;
  drawObj(a);
endfig;

beginfig(41);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(42);
  newDBox.a(btex some text etex) "fit(false)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(43);
  newDBox.a("") "dx(1cm)", "dy(1cm)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(50);
  newDEllipse.a(btex some text etex);
  a.c=origin;
  drawObj(a);
endfig;

beginfig(51);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(52);
  newDEllipse.a(btex some text etex) "fit(false)";
  a.c=origin;
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

beginfig(53);
  newDEllipse.a("") "filled(true)","circmargin(2mm)";
  a.c=origin;
  drawObj(a);
endfig;

clearObj a;

beginfig(55);
  newDEllipse.a(btex some text etex);
  scaleObj(a,2);
  rotateObj(a,45);
  a.c=origin;
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;


beginfig(61);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newHBox.h(a,b,c);
  h.c=origin;
  drawObj(h);
endfig;

beginfig(62);
  drawObj(h);
  show_standard_bb(h);
endfig;

clearObj a,b,c,h;

beginfig(64);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newHBox.h(a,b,c) "align(top)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(65);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newHBox.h(a,b,c) "align(center)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(67);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newHBox.h(a,b,c) "align(center)","hbsep(3mm)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(68);
  newPolygon.a(btex Box A etex,5) "fit(false)","polymargin(5mm)";
  newBox.b(btex Box B etex scaled \magstep3);
  newHRazor.ba(1cm);
  newPolygon.c(btex Box C etex scaled \magstep2,11) "polymargin(3mm)";
  newHBox.h(a,b,ba,c) "align(center)","hbsep(3mm)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,ba,c,h;


beginfig(71);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newVBox.h(a,b,c);
  h.c=origin;
  drawObj(h);
endfig;

beginfig(72);
  drawObj(h);
  show_standard_bb(h);
endfig;

clearObj a,b,c,h;

beginfig(74);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newVBox.h(a,b,c) "align(right)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(75);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newVBox.h(a,b,c) "align(center)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(77);
  newBox.a(btex Box A etex);
  newBox.b(btex Box B etex scaled \magstep3);
  newBox.c(btex Box C etex scaled \magstep2);
  newVBox.h(a,b,c) "align(center)","vbsep(3mm)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,c,h;

beginfig(78);
  newPolygon.a(btex Box A etex,5) "fit(false)","polymargin(5mm)";
  newBox.b(btex Box B etex scaled \magstep3);
  newVRazor.ba(1cm);
  newPolygon.c(btex Box C etex scaled \magstep2,11) "polymargin(3mm)";
  newVBox.h(a,b,ba,c) "align(center)","vbsep(3mm)";
  h.c=origin;
  drawObj(h);
endfig;

clearObj a,b,ba,c,h;

beginfig(101);
  newRecursiveBox.a(10);
  scaleObj(a,.3);
  a.c=origin;
  drawObj(a);
endfig;

beginfig(102);
  drawObj(a);
  show_standard_bb(a);
endfig;

clearObj a;

% beginfig(104);
%   newRecursiveBox.a(20);
%   a.c=origin;
%   drawObj(a);
% endfig;


% beginfig(111);
%   newVonKochFlake.a(3);
%   scaleObj(a,.5);
%   a.c=origin;
%   drawObj(a);
% endfig;

%clearObj a;


beginfig(121);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c);
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e);
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables);
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

beginfig(122);
  drawObj(food);
  show_standard_bb(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(124);
  newBox.a(btex apples\strut etex);
  newBox.b(btex oranges\strut etex);
  newBox.c(btex bananas\strut etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Dalign(bot)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Dalign(center)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hbsep(1cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(134);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Lalign(left)", "treemode(L)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Lalign(center)", "treemode(L)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(L)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(135);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  extendObjRight.a(3cm);
  extendObjRight.b(3cm);
  extendObjRight.c(3cm);
  extendObjRight.d(3cm);
  extendObjRight.e(3cm);
  
  newBox.f(btex fruits etex);
  newBox.v(btex vegetables etex);
  rebindrelativeObj(f)(0,0,0,-xpart(v.e-v.w-f.e+f.w));
  newTree.fruits(f)(a,b,c) "Lalign(left)", "treemode(L)";
  newTree.vegetables(v)(d,e) "Lalign(center)", "treemode(L)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(L)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;


clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(136);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Ralign(right)", "treemode(R)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Ralign(center)", "treemode(R)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(R)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(137);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  rebindrelativeObj(f)(0,0,xpart(v.e-v.w-f.e+f.w),0);
  newTree.fruits(f)(a,b,c) "Ralign(right)", "treemode(R)";
  newTree.vegetables(v)(d,e) "Ralign(center)", "treemode(R)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(R)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;


clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(138);
  newBox.a(btex apples\strut etex);
  newBox.b(btex oranges\strut etex);
  newBox.c(btex bananas\strut etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Ualign(bot)", "treemode(U)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Ualign(center)", "treemode(U)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(U)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(139);
  setObjectDefaultOption("Tree")("treeflip")(true);
  newBox.a(btex apples\strut etex);
  newBox.b(btex oranges\strut etex);
  newBox.c(btex bananas\strut etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Ualign(bot)", "treemode(U)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Ualign(center)", "treemode(U)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)", "treemode(U)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
  setObjectDefaultOption("Tree")("treeflip")(false);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(140);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Dalign(bot)", "hideleaves(true)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Dalign(center)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(142);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Dalign(bot)", "hideleaves(true)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Dalign(center)", "hideleaves(true)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hbsep(5cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(144);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Dalign(bot)", "hideleaves(true)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Ralign(center)", "hideleaves(true)", "treemode(R)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hbsep(1cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(146);
  newBox.a(btex apples etex);
  newBox.b(btex oranges etex);
  newBox.c(btex bananas etex);
  newBox.f(btex fruits etex);
  newTree.fruits(f)(a,b,c) "Lalign(left)", "hideleaves(true)", "treemode(L)",
                            "vsep(3mm)";
  newBox.d(btex potatoes etex);
  newBox.e(btex peas etex);
  newBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "align(center)", "hideleaves(true)", "treemode(R)";
  newBox.fo(btex food etex);
  newTree.food(fo)(fruits,vegetables) "hbsep(1cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

clearObj a,b,c,f,fruits,d,e,v,vegetables,fo,food;

beginfig(148);
  newPolygon.a(btex apples etex,5);
  newPolygon.b(btex oranges etex,6);
  newPolygon.c(btex bananas etex,7);
  newPolygon.f(btex fruits etex,8);
  newTree.fruits(f)(a,b,c) "Lalign(left)", "hideleaves(true)", "treemode(L)",
                            "vsep(3mm)";
  newEllipse.d(btex potatoes etex);
  newDEllipse.e(btex peas etex);
  newDBox.v(btex vegetables etex);
  newTree.vegetables(v)(d,e) "Ralign(center)", "hideleaves(true)", "treemode(R)";
  newPolygon.fo(btex food etex,12);
  newTree.food(fo)(fruits,vegetables) "hsep(1cm)";
  scaleObj(food,.5);
  food.c=origin;
  drawObj(food);
endfig;

beginfig(149);
  newDEllipse.ff(food);
  ff.c=origin;
  drawObj(ff);
endfig;

clearObj ff;

beginfig(150);
  rebindVisibleObj(food);
  newDEllipse.ff(food);
  drawObj(ff);
endfig;

beginfig(151);
  newEllipse.xx(btex This is a new root etex);
  newTree.x(xx)(ff);
  drawObj(x);
endfig;

clearObj x,xx,food,ff,a,b,c,f,fruits,d,e,v,vegetables,fo;

% fans

beginfig(160);
newBox.a(btex root etex);
newBox.leaf1(btex leaf 1 etex);
newBox.leaf2(btex leaf 2 etex);
newHFan.f(1cm,0);
newTree.t(a)(leaf1,leaf2,f) "hsep(5mm)","Dalign(center)";
t.c=origin;
drawObj(t);
endfig;

clearObj a,leaf,f,t;

beginfig(161);
newBox.a(btex root etex);
newBox.leaf1(btex leaf 1 etex);
newBox.leaf2(btex leaf 2 etex);
newHFan.f(2cm,0);
newTree.t(a)(leaf1,leaf2,f) "hsep(5mm)","Dalign(center)";
t.c=origin;
drawObj(t);
endfig;

clearObj a,leaf,f,t;

beginfig(162);
newBox.a(btex root etex);
newBox.leaf1(btex leaf 1 etex);
newBox.leaf2(btex leaf 2 etex);
newVFan.f(0,1.5cm);
newTree.t(a)(leaf1,leaf2,f) "vsep(5mm)","Ralign(right)","treemode(R)";
t.c=origin;
drawObj(t);
endfig;

clearObj a,leaf,f,t;


beginfig(201);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newPTree.proof(c)(a,b)("")("");
  proof.c=origin;
  drawObj(proof);
endfig;

clearObj a,b,c,proof;

beginfig(202);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newPTree.proof(c)(a,b)("")("") "treemode(U)";
  proof.c=origin;
  drawObj(proof);
endfig;


clearObj a,b,c,proof;

beginfig(203);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newPTree.proof(c)(a,b)(btex (left rule) etex)(btex (right rule) etex);
  proof.c=origin;
  drawObj(proof);
endfig;

clearObj a,b,c,proof;

beginfig(204);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newPTree.proof(c)(a,b)("")(btex (MP) etex);
  proof.c=origin;
  drawObj(proof);
endfig;

clearObj a,b,c,proof;

beginfig(205);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newPTreeR.proof(c)(a,b)(btex (MP) etex) "lenddx(1cm)";
  proof.c=origin;
  drawObj(proof);
endfig;

beginfig(206);
  scaleObj(proof,2);
  slantObj(proof,1);
  proof.c=origin;
  drawObj(proof);
endfig;

clearObj a,b,c,proof;

beginfig(220);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $B$ etex);
  newAssumption.d(btex $D$ etex);
  newAssumption.e(btex $E$ etex);
  newPTreeR.proof1(c)(a,b)(btex (MP) etex);
  newPTreeR.proof2(proof1)(d,e)("") "treemode(U)";
  proof2.c=origin;
  drawObj(proof2);
endfig;

clearObj a,b,c,d,e,proof;

beginfig(221);
  newAssumption.a(btex $A$ etex);
  newAssumption.b(btex $A\rightarrow B$ etex);
  newConclusion.c(btex $BBBBBBBBBBBBBB$ etex);
  newAssumption.d(btex $D$ etex);
  newAssumption.e(btex $E$ etex);
  newPTreeR.proof1(c)(a,b)(btex (MP) etex);
  newPTreeR.proof2(proof1)(d,e)("") "treemode(U)";
  proof2.c=origin;
  drawObj(proof2);
endfig;

clearObj a,b,c,d,e,proof;

beginfig(300);

  newBox.mela(btex A etex);
  newMatrix.mat(1,1)(mela);
  mat.c=origin;
  drawObj(mat);
endfig;

clearObj mat,mela;

beginfig(302);

  newBox.melb(btex B etex) "dx(1cm)";
  newBox.melc(btex C etex) "dy(1cm)";
  newMatrix.mata(2,1)(melb,melc);
  
  mata.c=origin;

  drawObj(mata);

endfig;

beginfig(304);
  newBox.melba(btex melba etex);
  newBox.melda(btex D$\displaystyle\int_0^\infty{1\over 1+x^2}dx$ etex);
  newBox.melbb(btex Bb etex);
  newBox.melcb(btex C etex);
  newBox.meldb(btex D etex);
 
  newMatrix.matc(3,2)(melba,nb,melda,melbb,melcb,meldb)
      "halign(ew)", "valign(sns)";
  
  matc.c=origin-(0,10cm);
  drawObj(matc);

endfig;

beginfig(306);
 
  
  duplicateObj(matd,matc); % the holes get duplicated
  scaleObj(matd,2);
  matd.c=origin-(0,15cm);
  drawObj(matd);

endfig;

beginfig(308);
 
  
  newBox.rep(btex Very Long Replacement etex);

  replaceMatrixElement.exp.matd(1,1)(rep);
  newBox.repc(btex court etex);
  replaceMatrixElement.exp.matd(1,1)(repc);
  newBox.repd(btex D etex yscaled 3 rotated 30);
  replaceMatrixElement.exp.matd(3,2)(repd);
  newBox.repe(btex 00000000000000000 etex yscaled 3 rotated 30);
  replaceMatrixElement.exp.matd(1,1)(repe);
  newBox.repf(btex new line etex);
  replaceMatrixElement.exp.matd(4,2)(repf);
  matd.c=origin;
  drawObj(matd);

endfig;

beginfig(320);
 
  
  newBox.repg(btex new corner etex);
  replaceMatrixElement.exp.matd(4,3)(repg);
  matd.c=origin;
  drawObj(matd);


endfig;

beginfig(330);
 
  
  deleteMatrixElement.exp.matd(2,2);
  deleteMatrixElement.exp.matd(4,2);
  deleteMatrixElement.exp.matd(3,1);
  deleteMatrixElement.exp.matd(3,2);
  deleteMatrixElement.exp.matd(3,2);
  deleteMatrixElement.exp.matd(1,1);
  matd.c=origin;
  drawObj(matd);

  
endfig;

end
