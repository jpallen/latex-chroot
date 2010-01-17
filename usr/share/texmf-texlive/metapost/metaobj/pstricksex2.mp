input metaobj

% page 41 of beta manual

beginfig(15);
  setObjectDefaultOption("Tree")("treemode")("R");
  t:=T_(new_Circle_("")("circmargin(3mm)"))
  (Tcircle_(btex L etex),Tcircle_(btex H etex),
    Tcircle_(btex K etex),Tcircle_(btex N etex))("edge(ncdiag)", "angleB(0)",
    "armA(0)","armB(1cm)","hsep(3.5cm)","posA(e)","arrows(draw)");
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

% page 42 of beta manual

beginfig(16);
  setObjectDefaultOption("Tree")("treemode")("R");
  setObjectDefaultOption("Tree")("Ralign")("center");
  t:=T_(new_Circle_("")("circmargin(1mm)","framewidth(1pt)"))
  (Tr_(btex $x<y$ etex),Tr_(btex $z_2 < y\leq x$ etex),
    Tr_(btex $z_1<y\leq z_2$ etex),Tr_(btex $z_1\leq y$ etex))
  ("edge(ncdiag)", "nodesepA(2mm)","angleB(0)",
    "armA(0)","armB(3cm)","hsep(3.5cm)","arrows(draw)","vbsep(5mm)",
    "linewidth(1pt)");
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(17);
  setObjectDefaultOption("Tree")("treemode")("U");
  setObjectDefaultOption("Tree")("hbsep")(5mm);
  setObjectDefaultOption("Tree")("hideleaves")(true);  % works
  setCurveDefaultOption("arrows")("draw");

  t:=_T(Tc)(TCs,_T(Tc)(TCs,TCs),TCs);

  % changes to the edges:
  setTreeEdge(Obj(t))(1)(linestyle)("dashed evenly");
  setTreeEdge(treepos(Obj(t))(2))(1)(linestyle)("dashed evenly");

  Obj(t).c=origin;
  draw_Obj(t);
  setObjectDefaultOption("Tree")("treemode")("D");
  setObjectDefaultOption("Tree")("hideleaves")(false);
endfig;

% page 43 of beta manual

beginfig(18);
  setCurveDefaultOption("arrows")("draw"); 
  setCurveDefaultOption("nodesepA")(2mm);
  setCurveDefaultOption("nodesepB")(2mm);
  
  t:=_T(Toval_(btex nature etex))
      (_T(new_Circle_("")("circmargin(1mm)","name(top)"))(TCs,TCs),
       _T(new_Circle_("")("circmargin(1mm)","name(bot)"))(TCs,TCs));
  Obj(t).c=origin;
     
  ncline.Obj(t)("top")("bot")
      "nodesepA(0)","nodesepB(0)","linestyle(dashed evenly)";
  
  draw_Obj(t);
  setCurveDefaultOption("nodesepA")(0);
  setCurveDefaultOption("nodesepB")(0);
endfig;

beginfig(19);
  setCurveDefaultOption("arrows")("draw"); 
  setObjectDefaultOption("Tree")("treemode")("R");
  t:=T_(Toval_(btex root etex))
       (Tr_(btex Z etex),Tr_(btex Y etex),Tr_(btex X etex))
       ("edge(nccurve)","angleA(0)","angleB(0)","hsep(3.5cm)",
         "posA(e)");
  Obj(t).c=origin;
  draw_Obj(t);
  setObjectDefaultOption("Tree")("treemode")("D");
endfig;

beginfig(20);
  setCurveDefaultOption("arrows")("drawarrow");
  t:=T_(new_Polygon_(btex root etex)(4)("name(top)"))
         (new_Box_(btex x etex)("framed(false)","name(lx)"),
          new_Box_(btex y etex)("framed(false)","name(ly)"),
          new_Box_(btex z etex)("framed(false)","name(lz)"))
         ("edge(none)","vsep(1.5cm)");
  ncbar.Obj(t)("top")("lx") "angleA(180)","armA(1cm)";
  ncline.Obj(t)("top")("ly");
  ncbar.Obj(t)("top")("lz") "angleA(0)","armA(1cm)";
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(21);
  setObjectDefaultOption("Tree")("treemode")("D");
  setCurveDefaultOption("nodesepA")(2mm);
  setCurveDefaultOption("nodesepB")(0);
  setCurveDefaultOption("arrows")("rdrawarrow");
  
  t:=T_(new_Polygon_(btex root etex,3)("angle(90)","polymargin(4mm)"))
       (TCs,TCs,TCs,TCs)
       ("edge(rncangle)","angleA(90)","angleB(90)","armB(1cm)","vsep(2.5cm)");
  Obj(t).c=origin;
  draw_Obj(t);
endfig;

beginfig(22);
  newBox.a(btex Idea1 etex);
  newBox.b(btex Idea2 etex);
  b.c-a.c=(5cm,3cm);
  a.c=origin;
  ncbox(a)(b) "linearc(1mm)","linestyle(dashed evenly)",
              "boxsize(1cm)","nodesepA(1cm)","nodesepB(1cm)";
  drawObj(a,b);
endfig;

clearObj a,b;

beginfig(23);
  newBox.a(btex Idea1 etex);
  newBox.b(btex Idea2 etex);
  b.c-a.c=(5cm,3cm);
  a.c=origin;
  ncarcbox(a)(b) "doubleline(true)",
              %"doublesep(5mm)",
              "linestyle(dashed evenly)",
              "boxsize(7mm)","nodesepA(1cm)","nodesepB(1cm)","arcangleA(-50)";
  drawObj(a,b);
endfig;



end



