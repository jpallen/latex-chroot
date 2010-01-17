input metaobj

% the black disk  is small, but its bounding box is extended so that we
% get a good alignment with the empty circles

% TCE=TC Extended
def TCE=
  rebindrelative_Obj(new_Circle_("")("filled(true)","circmargin(.5mm)"))
       (1.5mm,-1.5mm,1.5mm,-1.5mm)
enddef;

% 11-12/5/2001
beginfig(25);
  setCurveDefaultOption("arrows","draw");
  setObjectDefaultOption("Tree")("vsep")(2cm);
  setObjectDefaultOption("Tree")("hbsep")(2cm);
  setObjectDefaultOption("Tree")("treenodevsize")(5mm);
  t:=T_(Tn)(T_(Tr_(btex Player 1 etex))
              (T_(Tr_(btex Player 2 etex))
                 (Tr_(btex Player 3 etex))("edge(none)"))("edge(none)"),
      T_(Tc_(2mm))(
        _T(Tc_(2mm))(TCE,T_(Tc_(2mm))(TCE,TCE)("hideleaves(true)")),
        _T(Tc_(2mm))(TCE,T_(Tc_(2mm))(TCE,TCE)("hideleaves(true)"))
        )("hbsep(2cm)"),
      new_HRazor(-5cm),
      TCE)("edge(none)");
  Obj(t).c=origin;

  ncbox.Obj(t)(treeroot(Obj(t))(2,1))
              (treeroot(Obj(t))(2,2))
              "linestyle(dashed evenly)", "boxsize(3mm)",
              "nodesepA(5mm)", "nodesepB(5mm)", "linearc(3mm)";
  ncarcbox.Obj(t)(treeroot(Obj(t))(2,1,2))
                 (treeroot(Obj(t))(2,2,2))
                 "linestyle(dashed evenly)", "arcangleA(30)",
                 "nodesepA(5mm)", "nodesepB(5mm)","boxsize(3mm)";
  ncline.Obj(t)(treeroot(Obj(t))(2))(treeroot(Obj(t))(4)) "name(N)";
              
  ObjLabel.Obj(t)(btex N etex) "labpathname(N)", "labdir(top)";
  % we add labels on edges; the standard edges of a tree are numbered 1,2, ...
  % and we use |labpathid|; we must take care to give the correct objet
  % as first parameter of |ObjLabel|.
  ObjLabel.treepos(Obj(t))(2)(btex L etex) "labpathid(1)", "labdir(lft)";
  ObjLabel.treepos(Obj(t))(2)(btex R etex) "labpathid(2)", "labdir(rt)";

  ObjLabel.ntreepos(Obj(t))(2,1)(btex l etex) "labpathid(1)", "labdir(lft)";
  % The previous is a shorthand for
  %  ObjLabel.treepos(treepos(Obj(t))(2))(1)(btex l etex)
  %         "labpathid(1)", "labdir(lft)";
         
  ObjLabel.ntreepos(Obj(t))(2,1)(btex r etex) "labpathid(2)"
    %,"laberase(true)";
    , "labdir(rt)";
  ObjLabel.ntreepos(Obj(t))(2,2)(btex l etex) "labpathid(1)", "labdir(lft)";
  ObjLabel.ntreepos(Obj(t))(2,2)(btex r etex) "labpathid(2)", "labdir(rt)";

  ObjLabel.ntreepos(Obj(t))(2,1,2)(btex c etex) "labpathid(1)", "labdir(lft)";
  ObjLabel.ntreepos(Obj(t))(2,1,2)(btex d etex) "labpathid(2)", "labdir(rt)";
  ObjLabel.ntreepos(Obj(t))(2,2,2)(btex c etex) "labpathid(1)", "labdir(lft)";
  ObjLabel.ntreepos(Obj(t))(2,2,2)(btex d etex) "labpathid(2)", "labdir(rt)";

  % labels on nodes:
  ObjLabel.ntreepos(Obj(t))(2,1,1)(btex $(-10,10.-10)$ etex) "labcard(s)";
  % the distance between the node and the label is 1cm as defined in |ObjLabel|
  ObjLabel.ntreepos(Obj(t))(2,2,1)(btex $(10,-10.0)$ etex) "labcard(s)";
  ObjLabel.ntreepos(Obj(t))(2,1,2,1)(btex $(3,8,-4)$ etex) "labcard(s)";
  ObjLabel.ntreepos(Obj(t))(2,1,2,2)(btex $(-8,3,4)$ etex) "labcard(s)";
  ObjLabel.ntreepos(Obj(t))(2,2,2,1)(btex $(4,8,-3)$ etex) "labcard(s)";
  ObjLabel.ntreepos(Obj(t))(2,2,2,2)(btex $(0,-5,0)$ etex) "labcard(s)";

  ObjLabel.treepos(Obj(t))(4)(btex $(0,0,0)$ etex) "labcard(e)";
  % 4, because the HRazor counts for one subtree
  
  draw_Obj(t);
  
endfig;

% TCE=TC Extended
def TCE=
  rebindrelative_Obj(new_Circle_("")("filled(true)","circmargin(.5mm)"))
       (.5mm,-.5mm,.5mm,-.5mm)
enddef;

beginfig(27);
setCurveDefaultOption("arrows","draw");
  setObjectDefaultOption("Tree")("treemode")("R");
  setObjectDefaultOption("Tree")("vbsep")(5mm);
  setObjectDefaultOption("Tree")("treenodevsize")(-1);
  setObjectDefaultOption("Tree")("treenodehsize")(5mm);
  t:=T_(Tc)(
            T_(Tc)(
                  _T(Tc)(TCE,TCE),
                  T_(Tn)(T_(Tn)(TCE)("edge(none)"))("edge(none)"),
                  T_(Tn)(T_(Tn)(_T(Tc)(TCE,TCE))("edge(none)"))("edge(none)"),
                  TCE
                  )("edge(none)"),
            _T(Tn)(new_VFan_(2mm,1cm)("edge(none)"))
          )("edge(none)","pointedfan(false)");

  ncline.Obj(t)(treeroot(Obj(t))(1))(treeroot(Obj(t))(1,1));
  ncline.Obj(t)(treeroot(Obj(t))(1))(treeroot(Obj(t))(1,2,1,1));
  ncline.Obj(t)(treeroot(Obj(t))(1))(treeroot(Obj(t))(1,3,1,1));
  ncline.Obj(t)(treeroot(Obj(t))(1))(ntreepos(Obj(t))(1,4));
  ncline.Obj(t)(obj(Obj(t)root))    (treeroot(Obj(t))(1));

  % we call |ncfan| because we draw a non-standard fan
  ncfan.Obj(t)(obj(Obj(t)root))(ntreepos(Obj(t))(2,1))(2);
               
  Obj(t).c=origin;
    
  draw_Obj(t);

  % we call |drawfan| because we draw a non-standard fan
  drawfan.Obj(t)(ntreepos(Obj(t))(2,1))(2);
  
%  draw ntreepos(Obj(t))(1,2,1,1).nw--
%       ntreepos(Obj(t))(1,2,1,1).ne--
%       ntreepos(Obj(t))(1,2,1,1).se--
%       ntreepos(Obj(t))(1,2,1,1).sw--cycle withcolor red;
  
%  draw treeroot(Obj(t))(1,3,1,1).nw--
%       treeroot(Obj(t))(1,3,1,1).ne--
%       treeroot(Obj(t))(1,3,1,1).se--
%       treeroot(Obj(t))(1,3,1,1).sw--cycle withcolor red;
 
endfig;
end
