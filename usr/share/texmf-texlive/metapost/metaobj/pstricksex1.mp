% This file contains metaobj code for several figures of the pstricks manual,
% regarding connections, matrices and trees.

% D. Roegel, May 6-9, 2001

verbatimtex
%&latex
\documentclass{article}
\begin{document}
etex

def TCs=
  new_Circle_("")("filled(true)")
enddef;

def Tdot(expr p)=
  new_Circle_(p)("circmargin(-.2mm)")
enddef;

def Toplus=
  Tdot(btex $+$ etex)
enddef;

input metaobj

% page 26 of beta manual

beginfig(1);
  setObjectDefaultOption("Matrix")("hsep")(1cm);
  setObjectDefaultOption("Matrix")("vsep")(1cm);
  newBox.a(btex $U$ etex) "framed(false)";
  newBox.b(btex $X\times_Z Y$ etex) "framed(false)";
  newBox.c(btex $X$ etex) "framed(false)";
  newBox.d(btex $Y$ etex) "framed(false)";
  newBox.e(btex $Z$ etex) "framed(false)";
  newMatrix.mat(3,3)(a,nb,nb,nb,b,c,nb,d,e);
  mat.c=origin;

  mcline.mat(1,1,2,2) "name(a)";
  ObjLabel.mat(btex $y$ etex) "labpathname(a)","labdir(llft)";
  mcline.mat(1,1,2,3) "doubleline(true)",
    "arrows(draw)","linestyle(dashed evenly)", "name(b)";
  ObjLabel.mat(btex $x$ etex) "labpathname(b)","labdir(urt)";
  mcline.mat(2,2,2,3), "name(c)";
  ObjLabel.mat(btex $p$ etex) "labpathname(c)","labdir(bot)";
  mcline.mat(2,2,3,2), "name(d)";
  ObjLabel.mat(btex $q$ etex) "labpathname(d)","labdir(lft)";
  mcline.mat(3,2,3,3), "name(e)";
  ObjLabel.mat(btex $g$ etex) "labpathname(e)","labdir(bot)";  
  mcline.mat(2,3,3,3), "name(f)";
  ObjLabel.mat(btex $f$ etex) "labpathname(f)","labdir(rt)";
  
  drawObj(mat);
endfig;

clearObj a,b,c,d,e,mat;

% page 27 of beta manual

beginfig(3);
  newCircle.a(btex A etex);
  newCircle.b(btex B etex);
  newCircle.c(btex C etex);
  newCircle.d(btex D etex);
  newCircle.e(btex E etex);
  verbatimtex \small etex;
  newMatrix.mat(3,3)(nb,a,nb,b,e,c,nb,d,nb) "hsep(2cm)", "vsep(2cm)";
  mcline.mat(2,2,2,3) "name(a)";
  ObjLabel.mat(btex a etex) "labpathname(a)","labpos(0.75)", "labdir(top)";
  mcline.mat(2,2,2,1) "name(b)";
  ObjLabel.mat(btex b etex) "labpathname(b)","labdir(bot)";
  mcline.mat(3,2,2,1) "name(c)";
  ObjLabel.mat(btex c etex) "labpathname(c)","labdir(llft)";
  mcarc.mat(3,2,1,2)
  "arcangleA(-40)","arcangleB(-40)", "border(3pt)", "name(d)";%,
                   %"laberase(true)";
  ObjLabel.mat(btex d etex) "labpathname(d)","labdir(lrt)", "labpos(0.3)";
  ObjLabel.mat(btex e etex) "labpathname(d)","labdir(llft)", "labpos(0.7)";
  mcarc.mat(1,2,2,1) "arcangleA(12)","arcangleB(12)", "name(f)";
  ObjLabel.mat(btex f etex) "labpathname(f)","labdir(lrt)";
  mcarc.mat(2,1,1,2) "arcangleA(12)","arcangleB(12)", "name(g)";
  ObjLabel.mat(btex g etex) "labpathname(g)","labdir(ulft)";
  mat.c=origin;
  drawObj(mat);
endfig;

% page 28 of beta manual

clearObj a,b,c,d,e,mat;

beginfig(4);
  newCircle.x(btex X etex);
  newCircle.y(btex Y etex) "framed(false)";
  newCircle.Z(btex Z etex) "framed(false)"; % |z| is reserved
  newMatrix.mat(2,2)(nb,x,y,Z) "hsep(1cm)", "vsep(2cm)";
  mcline.mat(1,2,2,1) "nodesepA(3pt)";
  mcline.mat(1,2,2,2) "nodesepA(3pt)";
  mcline.mat(2,1,2,2) "linestyle(dashed withdots)";
  mat.c=origin;
  drawObj(mat);
endfig;

clearObj x,y,Z,mat;

% page 33 of beta manual

beginfig(5);
  setCurveDefaultOption("arrows")("draw"); % works
  t=_T(new_Ellipse(btex root etex))(TCs,TCs,TCs,TCs);
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(55);
setCurveDefaultOption("arrows")("draw"); 
  u=T_(Tn)(TCs,
           T_(Tc)(TCs,TCs)("hbsep(5mm)","hideleaves(true)"),
           TCs)("hbsep(5mm)");

  Obj(u).c=origin;
  draw_Obj(u);
endfig;


% page 34 of beta manual

beginfig(6);
setCurveDefaultOption("arrows")("draw"); 
  t:=_T(new_Circle(btex $X$ etex))
  (new_Box_(btex $\tilde{\tilde{X}}$ etex)("framed(false)"),
    new_Box_(btex $x$ etex)("framed(false)"),
    new_Box_(btex $y$ etex)("framed(false)"));
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(66);
setCurveDefaultOption("arrows")("draw"); 
  % in the next example, we align the baselines, by adding \strut s:
  t:=_T(new_Circle(btex $X$ etex))
  (new_Box_(btex \strut $\smash{\tilde{\tilde{X}}}$ etex)("framed(false)"),
    new_Box_(btex \strut $x$ etex)("framed(false)"),
    new_Box_(btex \strut $y$ etex)("framed(false)"));
  Obj(t).c=origin;
  draw_Obj(t);
endfig;



% page 35 of beta manual


beginfig(7);
setCurveDefaultOption("arrows")("draw"); 
  setCurveDefaultOption("nodesepA")(3pt); % works
  setCurveDefaultOption("nodesepB")(3pt); % works
  setObjectDefaultOption("Tree")("hideleaves")(true);  % works
  
  t:=_T(TCs)
       (_T(TCs)(TCs,Tn),
        _T(TCs)(TCs,_T(TCs)(Tn,TCs))
       );
  Obj(t).c=origin;
  draw_Obj(t);
  setCurveDefaultOption("nodesepA")(0); % works
  setCurveDefaultOption("nodesepB")(0); % works
endfig;

% page 36 of beta manual

beginfig(8);
  setObjectDefaultOption("Tree")("hideleaves")(true);
  t:=T_(new_Circle(btex foo etex))
        (new_HFan_(1cm,0)("filled(true)"),
          Tf,
          _T(new_RBox(btex bar etex))(new_HFan(1cm,0))
        )
       ("Dalign(center)");
  Obj(t).c=origin;
  draw_Obj(t);
  setObjectDefaultOption("Tree")("hideleaves")(false);
endfig;

beginfig(88);
  setObjectDefaultOption("Tree")("hideleaves")(true);
  t:=_T(new_Circle(btex foo etex))
  (_T(new_HFan_(1cm,0)("filled(true)","fillcolor(red)","fanlinearc(1mm)"
        %,"pointedfan(false)"
        ))
          (TCs,new_HFan_(1cm,0)("fanlinestyle(dashed evenly)")));
  Obj(t).c=origin;
  draw_Obj(t);
  setObjectDefaultOption("Tree")("hideleaves")(false);
endfig;

% page 37 of beta manual

beginfig(9);
setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("hideleaves")(true);  % works
  setCurveDefaultOption("nodesepA")(3pt); % works
  setCurveDefaultOption("nodesepB")(3pt); % works
  setObjectDefaultOption("Tree")("Ualign")("center");
  setObjectDefaultOption("Tree")("Lalign")("center");
  setObjectDefaultOption("Tree")("hbsep")(5mm);
  setObjectDefaultOption("Tree")("vbsep")(5mm);
  setObjectDefaultOption("Tree")("hsep")(2cm);
  setObjectDefaultOption("Tree")("vsep")(2cm);
  
  t:=T_(Tc_(1.5mm))(T_(Tc_(1.5mm))(Toplus,Toplus)("treemode(L)"),Toplus,Toplus)("treemode(U)");
  Obj(t).c=origin;
  draw_Obj(t);
  setCurveDefaultOption("nodesepA")(0pt); % works
  setCurveDefaultOption("nodesepB")(0pt); % works
endfig;

beginfig(10);
setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("hsep")(1cm);
  setObjectDefaultOption("Tree")("vsep")(1cm);
  % we draw two trees which share a root node:
  t:=T_(new_Circle(btex root etex))(Tr_(btex B etex))("treemode(L)");
  Obj(t).c=origin;
  u:=_T(obj(Obj(t).root))(Tr_(btex A1 etex),Tr_(btex A2 etex));
  draw_Obj(t);
  draw_Obj(u);
endfig;

% page 38 of beta manual

beginfig(11);
setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("Dalign")("center");
  setObjectDefaultOption("Tree")("hbsep")(5mm);

  t:=_T(Tc)(TCs,
            T_(Tc)(new_Circle_("")("filled(true)","circmargin(15pt)"),TCs)
                      ("treenodehsize(1cm)"),
            TCs);
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(110);
  setCurveDefaultOption("arrows")("draw");
  t:=_T(Tc)(Tr_(btex $j$ etex),Tr_(btex $K_4$ etex),Tr_(btex $x>y$ etex));
  Obj(t).c=origin;
  draw_Obj(t);
endfig;
  
beginfig(111);
  setCurveDefaultOption("arrows")("draw"); 
  t:=T_(Tc)(Tr_(btex $j$ etex),Tr_(btex $K_4$ etex),Tr_(btex $x>y$ etex))
        ("treenodehsize(5mm)");
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

  setObjectDefaultOption("Tree")("Dalign")("top");
  setObjectDefaultOption("Tree")("hideleaves")(false);  % works

% page 39 of beta manual

beginfig(12);
  setCurveDefaultOption("arrows")("draw"); 
  t:=_T(TCs)(Tc,_T(TCs)(_T(Tc)(Tc,Tc,Tc),TCs,TCs,TCs));
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(120);
  setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("hideleaves")(true);  
  t:=_T(TCs)(Tc,_T(TCs)(_T(Tc)(Tc,Tc,Tc),TCs,TCs,TCs));
  Obj(t).c=origin;
  draw_Obj(t);
  setObjectDefaultOption("Tree")("hideleaves")(false);  
endfig;

beginfig(121);
  setCurveDefaultOption("arrows")("draw"); 
  t:=T_(TCs)(_T(TCs)(TCs,TCs),_T(TCs)(TCs,TCs))("vsep(.5cm)","hbsep(2cm)");
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

% page 40 of beta manual

beginfig(13);
  % We don't have a hook for a given level as PSTricks does,
  % so we have to give the hsep option several times;
  % however, we could avoid it by building the tree in a non-streamlined way.
  % Also, the labels must be given in the opposite order.
  setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("treemode")("R");
  %setObjectDefaultOption("Tree")("treeflip")(true);
  t:=_T(Tc)(
        _T(TCs)(T_(TCs)(Tr_(btex $J_1$ etex),Tr_(btex $J_2$ etex))("hsep(3cm)"),
               T_(TCs)(Tr_(btex $K_1$ etex),Tr_(btex $K_2$ etex))("hsep(3cm)")
              ),
        _T(TCs)(T_(TCs)(Tr_(btex $Y_1$ etex),Tr_(btex $Y_2$ etex))("hsep(3cm)"),
               T_(TCs)(Tr_(btex $X_1$ etex),Tr_(btex $X_2$ etex))("hsep(3cm)")
              )
        );
  Obj(t).c=origin; 
  draw_Obj(t);
endfig;


end

