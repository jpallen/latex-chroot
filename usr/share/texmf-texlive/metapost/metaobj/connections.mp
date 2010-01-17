input metaobj

beginfig(1);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b);
endfig;

clearObj a,b;

beginfig(2);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a.c)(b.c);
endfig;

clearObj a,b;

beginfig(3);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b) "linewidth(1mm)", "linestyle(dashed evenly)";
endfig;

clearObj a,b;

beginfig(4);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b) "posA(n)";
endfig;

clearObj a,b;

beginfig(5);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b) "offsetA((1cm,0))";
endfig;

clearObj a,b;

beginfig(6);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b) "doubleline(true)", "arrows(draw)";
endfig;

clearObj a,b;

beginfig(7);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncline(a)(b) "nodesepB(10mm)", "arrows(draw)";
endfig;

clearObj a,b;

beginfig(11);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccurve(a)(b) "angleA(0)";
endfig;

clearObj a,b;

beginfig(12);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccurve(a)(b) "angleA(-30)", "angleB(80)", "linecolor(red)",
    "linewidth(1mm)", "doubleline(true)", "linestyle(dashed withdots)";
endfig;

clearObj a,b;

beginfig(13);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccurve(a)(b) "angleA(-30)", "angleB(80)", "linecolor(red)",
  "linewidth(3pt)","linestyle(dashed withdots)",
  "linetension(2)";
endfig;

clearObj a,b;

beginfig(21);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncbar(a)(b) "angleA(-50)", "linecolor(blue)",
  "linewidth(1pt)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(22);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncbar(a)(b) "angleA(90)", "linecolor(blue)",
  "linewidth(1pt)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(31);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncangle(a)(b) "angleA(90)", "angleB(80)", "linecolor(blue)",
  "linewidth(1pt)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(32);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncangle(a)(b) "angleA(0)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(41);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncangles(a)(b) "angleA(0)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)","armB(2cm)";
endfig;

clearObj a,b;


beginfig(42);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncangles(a)(b) "angleA(0)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)","armB(2cm)","offsetA((0,1cm))";
endfig;

clearObj a,b;

beginfig(43);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncangles(a)(b) "angleA(90)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(51);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncdiag(a)(b) "angleA(90)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(52);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncdiag(a)(b) "angleA(0)", "angleB(90)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(61);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncdiagg(a)(b) "angleA(90)", "angleB(50)", "linecolor(blue)",
  "linewidth(1pt)","armA(3cm)";
endfig;

clearObj a,b;

beginfig(62);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncdiagg(a)(b) "angleA(0)", "angleB(90)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)";
endfig;

clearObj a,b;

beginfig(71);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(b) "angleA(0)", "angleB(90)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(72);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(a) "angleA(0)", "angleB(90)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(2cm)";
endfig;

clearObj a,b;

beginfig(73);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(b) "angleA(0)", "angleB(90)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(1cm)";
endfig;

clearObj a,b;

beginfig(74);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(b) "angleA(0)", "angleB(180)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(1cm)";
endfig;

clearObj a,b;

beginfig(75);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(b) "angleA(0)", "angleB(-100)", "linecolor(blue)",
  "linewidth(1pt)","armA(2cm)","armB(1cm)";
endfig;

clearObj a,b;

beginfig(76);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(a) "angleA(0)", "angleB(0)", "linecolor(blue)",
  "linewidth(1pt)","armA(1cm)","armB(1cm)","loopsize(1cm)";
endfig;

clearObj a,b;

beginfig(77);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncloop(a)(a) "angleA(0)", "angleB(0)", "linecolor(blue)",
  "linewidth(1pt)","armA(1cm)","armB(1cm)","loopsize(1cm)",
  "offsetA((0,2mm))","offsetB((0,-3mm))";
endfig;

clearObj a,b;

beginfig(81);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccircle(a) "angleA(0)", "linecolor(blue)","linewidth(1pt)";
endfig;

clearObj a,b;

beginfig(101);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncbox(a)(b) "linecolor(blue)",
         "linewidth(1pt)","nodesepA(1cm)","nodesepB(1cm)";
endfig;

clearObj a,b;

beginfig(102);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncbox(a)(b) "linecolor(blue)",
  "linewidth(1pt)","nodesepA(1cm)","nodesepB(1cm)",
  "boxsize(1cm)";
endfig;

clearObj a,b;

beginfig(103);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncbox(a)(b) "linecolor(blue)",
  "linewidth(1pt)","nodesepA(1cm)","nodesepB(1cm)",
  "boxsize(1cm)","linearc(3mm)";
endfig;

clearObj a,b;

beginfig(111);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncarcbox(a)(b) "arcangleA(0)", "linecolor(blue)",
         "linewidth(1pt)","nodesepA(1cm)","nodesepB(1cm)";
endfig;

clearObj a,b;

beginfig(112);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncarcbox(a)(b) "arcangleA(-30)", "linecolor(blue)",
         "linewidth(1pt)","nodesepA(1cm)","nodesepB(1cm)",
         "boxsize(1cm)";
endfig;

clearObj a,b;

beginfig(121);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncarc(a)(b);
endfig;

clearObj a,b;

beginfig(122);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncarc(a)(b);
  ncarc(b)(a);
endfig;

clearObj a,b;

beginfig(123);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  ncarc(a)(b) "arcangleA(50)";
  ncarc(b)(a);
endfig;

clearObj a,b;

beginfig(131);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nczigzag(a)(b); 
endfig;

clearObj a,b;

beginfig(132);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nczigzag(a)(b) "angleA(-90)","angleB(120)","linetension(0.8)",
                 "coilwidth(2mm)","linearc(.1mm)"; 
endfig;

clearObj a,b;

beginfig(141);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccoil(a)(b);
endfig;

clearObj a,b;

beginfig(142);
  newCircle.a(btex start etex);
  newCircle.b(btex end etex);
  a.c=origin;
  b.c-a.c=(3cm,2cm);
  drawObj(a,b);
  nccoil(a)(b) "doubleline(true)","coilwidth(2mm)",
               "angleA(0)", "arrows(-)","linewidth(1pt)";
endfig;

clearObj a,b;

beginfig(200);
  newBox.a("") "dx(3cm)", "dy(2cm)", "framecolor(blue)";
  addUserPath.a(a.nw--a.se);
  addUserPath.a(a.nw{right}..a.se) "linecolor(red)";
  addUserPath.a(fullcircle scaled 1cm shifted a.c) "arrows(-)";
  addUserPath.a(fullcircle scaled 1cm shifted a.ne) "arrows(-)",
     "pathfilled(true)","pathfillcolor((1,0,1))";
  addUserPath.a(fullcircle scaled 1cm shifted a.sw) "arrows(-)",
     "pathfilled(true)","pathfillcolor((1,0,1))",
     "linecolor((1,0,1))";  
  a.c=origin;
  drawObj(a);
endfig;

beginfig(201);
  xscaleObj(a,.5);
  a.c=origin-(0,6cm);
  drawObj(a);
endfig;

clearObj a;


end
