%%
%% A quick presentation about the macros
%%

input pathalong;
input slideshow;

author("Patrick TJ McPhee");
title("Introducing slide-show macros");
keywords("presentations metapost");
copyright("Copyright 2001 Patrick TJ McPhee. You may redistribute and modify for any purpose, but must acknowledge significant quotation.");

continue;

nextfig;
  defaultscale := 2;
  draw textunder((0,.5in){up}..{right}(2in,1in), "Introducing") shifted (1in,3in) withcolor textcolour;
endfig;

nextfig;
  blabel.rt("Slide Show Macros", (2in,2in));
endfig;

defaultscale := 1;

nextfig;
  draw pathalong((0,.5in){up}..{right}(2in,1in), "by Patrick TJ McPhee") shifted (1in,3in) withcolor textcolour;
  hyperdest("Start");
endfig;

discontinue;

header("Rationale");

bpoint("Primarily an intellectual exercise");
bpoint("But may be useful for graphics-intensive presentations which don't use much text");
bpoint("Slideshow provides support for this irritating style of bullet presentation");
bpoint("And writes out some pdfmarks, which you would otherwise have to look up yourself");

picture dimtieb;
dimtieb := image(draw pathalong((0,.5in){up}..(.5in,1in){right}..(.5in, 0in){-1,-1}..{.1,-1}(.5in,-.5in),
       "Did I mention the intellectual exercise bit?") withcolor textcolour;);
dimtieb := dimtieb rotatedaround(center dimtieb, 90);
dimtieb := dimtieb shifted - llcorner dimtieb;

bpoint(dimtieb);

discontinue;

header("Current practice");

bpoint("A presentation might have several components:");

vardef procbox(expr s) =
  save p;
  picture p;

  p := s infont defaultfont scaled defaultscale;
  pickup thin nib;
  addto p doublepath bbox p withpen currentpen;
  p
enddef;

vardef resultbox(expr s) =
  save p;
  picture p;

  p := s infont defaultfont scaled defaultscale;
  pickup thin nib;
  addto p doublepath (ulcorner p)..tension 2..(urcorner p)..(lrcorner p)..
          tension 2..(llcorner p)..cycle
          withpen currentpen;
  p
enddef;

picture lt, mp, dvi, gs, postp, vres, pres, fpres;

lt := procbox("laTeX") shifted (.05 lawidth, .2laheight);
mp := procbox("metapost") shifted (.05 lawidth, .1laheight);
dvi := procbox("DVI processor") shifted (.2 lawidth, .15laheight);
vres := resultbox("viewable result") shifted (.4 lawidth, .15 laheight);
gs := procbox("distiller") shifted (.65 lawidth, .15laheight);
pres := resultbox("presentation") shifted (.8 lawidth, .15laheight);
postp := procbox("post-processor") shifted (.7 lawidth, .3laheight);
fpres := resultbox("final presentation") shifted (.45 lawidth, .3laheight);

nextfig;
  bullet.in("text prepared with laTeX");
  draw lt withcolor white;
endfig;

nextfig;
  bullet.in("graphics prepared with metapost (okay, 2 components)");
  draw mp withcolor red;
endfig;

nextfig;
  bullet.in("which are combined with dvi processing software");
  pickup thin nib;
  drawarrow (.5[lrcorner mp,urcorner mp]){right}..{right}(.5[llcorner dvi,ulcorner dvi])
            withcolor .25[red,white];
  drawarrow (.5[lrcorner lt,urcorner lt]){right}..{right}(.5[llcorner dvi,ulcorner dvi])
            withcolor .25[white,red];

  draw dvi withcolor .5[white,red];
endfig;

nextfig;
  bullet.in("the resulting postscript is viewable, but must be distilled into the presentation");
  pickup thin nib;
  drawarrow (.5[lrcorner dvi,urcorner dvi])..(.5[llcorner vres,ulcorner vres])
            withcolor .1[.5[red,white],green];
  draw vres withcolor .5[.5[white,red],green];
endfig;

nextfig;
  pickup thin nib;
  drawarrow (.5[lrcorner vres,urcorner vres])..(.5[llcorner gs,ulcorner gs])
            withcolor .6[.5[red,white],green];
  draw gs withcolor .75[.5[white,red],green];
endfig;

nextfig;
  pickup thin nib;
  drawarrow (.5[lrcorner gs,urcorner gs])..(.5[llcorner pres,ulcorner pres])
            withcolor .75[.5[white,red],green];
  draw pres withcolor green;
endfig;

nextfig;
  pickup thin nib;
  bullet.in("and it's often post-processed to make it slick and professional-looking like this one");
  pickup thin nib;
  drawarrow (.5[lrcorner pres,urcorner pres]){right}..{left}(.5[lrcorner postp,urcorner postp])
            withcolor .5[green,white];
  draw postp withcolor .75[green,white];
endfig;

nextfig;
  pickup thin nib;
  drawarrow (.5[llcorner postp,ulcorner postp])..(.5[lrcorner fpres,urcorner fpres])
            withcolor .95[green,white];
  draw fpres withcolor white;
endfig;

discontinue;

header("The slideshow advantage");
bpoint("With the slideshow macros:");

nextfig;
  bullet.in("Only one input format is possible");
  draw mp withcolor red;
endfig;

nextfig;
  bullet.in("Which converts rapidly into viewable output");
  pickup thick nib;
  drawarrow (.5[lrcorner mp,urcorner mp]){right}..{right}(.5[llcorner vres,ulcorner vres])
            withcolor .5[red,.5[.5[white,red],green]];
  % I hope it's clear by this point that I'm playing this for laughs
  draw vres withcolor .5[.5[white,red],green];
endfig;

nextfig;
  bullet.in("And then distills into the presentation");
  pickup thick nib;
  drawarrow (.5[lrcorner vres,urcorner vres]){right}
            ..{right}(.5[llcorner fpres,ulcorner fpres])
            withcolor .5[.5[.5[white,red],green],white];
  draw fpres withcolor white;
endfig;

nextfig;
  bullet.in("From which no post-processing is needed, since there are no post-processors supporting these macros");
endfig;

discontinue;
header("Limitations");

bpoint("Metapost doesn't handle text very well");
bpoint("It's difficult to include non-metapost graphics (e.g., bit-maps)");
bpoint("There's no provision for producing print-only versions of the information");
bpoint("There's no concept of presentation styles");
bpoint("It generally requires some configuration of ghostscript and metapost, especially if you use math");
bpoint("The other methods for producing presentations using TeX-family tools aren't as complicated as I suggested");
bpoint.in("I personally use my own plain-TeX style with just TeX, metapost, and dvipdfm");

discontinue;
header("Strengths");

bpoint("Measurably less complex than metaobj");
bpoint("Small and simple, so shouldn't conflict with too many truly useful metapost packages");
bpoint("The ability to build up drawings can be helpful");
bpoint("And so are the pdfmarks");
bpoint("It's useful for cases where laTeX is used as a framework for a bunch of metapost slides");
bpoint("So it was worth uploading to CTAN, but it's not going to change the world");

discontinue;
header(nullpicture);

nextfig;
  hyperlabel(breaktowidth("Thanks for sticking to the end. Click on this text to start over.", .5lawidth)(ignore), (.5lawidth, .5laheight), "Start");
endfig;

end
