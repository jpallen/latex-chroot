input metaobj

% top of page 45 of beta manual

beginfig(30);
  t:=T_(Tc)(TC,TC,Tc)("treemode(R)","arrows(draw)","hsep(2cm)");
  Obj(t).c=origin;
  ObjLabel.Obj(t)(btex below etex) "labpathid(1)", "labdir(bot)";
  ObjLabel.Obj(t)(btex above etex) "labpathid(2)", "labdir(top)";
  ObjLabel.Obj(t)(btex above etex) "labpathid(3)", "labdir(top)";
  draw_Obj(t);
endfig;

beginfig(31);
  t:=T_(Tc)(TC,TC,Tc)("treemode(R)","arrows(draw)","hsep(2cm)");
  Obj(t).c=origin;
  ObjLabel.Obj(t)(btex below etex)
     "labpathid(1)", "labdir(bot)","labangle(0)","labpos(0.4)";
  ObjLabel.Obj(t)(btex above etex) "labpathid(2)", "labdir(top)","labpos(0.6)";
  ObjLabel.Obj(t)(btex above etex)
     "labpathid(3)", "labdir(top)","labangle(0)","labpos(0.3)";
  draw_Obj(t);
endfig;

end
