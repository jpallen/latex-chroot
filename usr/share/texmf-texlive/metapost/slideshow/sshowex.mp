 input slideshow;
 pair points[];
 nextfig;
   points0 = (.5lawidth, .9laheight);
   ypart points1 = ypart points2 = .1laheight;
   xpart points1 = lawidth - xpart points2 = .3lawidth;

   pickup thin nib;

   draw points1..points0 withcolor textcolour;
   hyperdest("start");
 endfig;
 
 % build on previous slide for next few
 continue;
 nextfig;
   pickup thin nib;

   draw points0..points2 withcolor textcolour;
 endfig;
 nextfig;
   pickup thin nib;

   draw points2..points1 withcolor textcolour;
 endfig;

 nextfig;
   blabel.top("A", points0);
 endfig;
 nextfig;
   blabel.lft("B", points1);
 endfig;
 nextfig;
   blabel.rt("C", points2);
 endfig;

 % new sequence of slides ...
 discontinue;
 nextfig;
   hyperlabel("The End" infont defaultfont scaled magstep 2, (.5lawidth, .5laheight), "start");
 endfig;
 end
