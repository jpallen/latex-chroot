%% simple metapost slide show
%%
%% Copyright 2001, Patrick TJ McPhee
%% everyone is welcome to use this code for any purpose, to modify it, and
%% to copy it in whole or in part for use in other macro sets, with the
%% conditions that this copyright notice be preserved with any significant
%% portion of the code, and that modifications to this file be clearly
%% marked.
%%
%% see the file slideshow.txt for documentation
%% $Header: /usr/home/ptjm/texmf/metapost/RCS/slideshow.mp 1.8 2001/08/06 18:48:17 pmcphee Exp $

newinternal slideshowversion;
slideshowversion := 1.0;

%%
%% basic figure handling
%%

picture lastpicture, background;

% set the aspect ratio of the picture to match a 640x480 screen
if not known lawidth:
  lawidth := 6.4in;
  laheight := 4.8in;
fi;

% make a sophisticated gradient background -- note that this can be done
% natively in pdf 1.3 if you know how....
def drawgradient(expr topcolour, botcolour) :=
  save pw,l,r,t,b,shade,grad;

  numeric l,r,t,b,pw;
  color shade, grad;

  % we will draw 100 coloured stripes across the screen
  pw = laheight/100;
  pickup pensquare scaled pw;
  lft l = 0 = bot b;
  rt r = lawidth;
  t = laheight; % don't say `top t' because I want to over-extend

  % shade is the colour of the current stripe, while grad
  % is the amount to change on each stripe
  shade := botcolour;
  grad := (1/100)*(topcolour - botcolour);

  for ypos := b step pw until t:
     draw (l, ypos)--(r, ypos) withcolor shade;
     shade := shade + grad;
     endfor;
enddef;

% draw the background -- we'll make it blue, just like power point
background := image(drawgradient((0,0,.3), (0,0,.5)););

% `keep track' of figure numbers
def nextfig := beginfig(charcode+1) enddef;

% always save the current picture at the end of each figure,
% so it can be used in the next one
extra_endfig := extra_endfig & "lastpicture := currentpicture; currentpicture := background; if known lastpicture: draw lastpicture; fi;";

% continue overlays the current picture with the last picture shipped out
% this allows slides to be built up
newinternal continuations;
continuations := 0;
def docontinue = if known lastpicture and (continuations = 1): currentpicture := lastpicture; bpos := bpos.prev; else: bpos := 0; fi; enddef;
extra_beginfig := extra_beginfig & "docontinue;";

% one might want to do that by default
def continue = continuations := 1; enddef;
% or not
def endcontinue = continuations := 0; enddef;

% break in continuation
def discontinue = clearit; lastpicture := nullpicture; bpos := 0; bpos.prev := 0; enddef;


%%
%% drawing assists
%%


% we'll use two pens to draw figures
pickup pencircle xscaled 5 pt yscaled 4 pt rotated 20;
thick nib := savepen;

pickup pencircle xscaled 2 pt yscaled 1 pt rotated 20;
thin nib := savepen;

%%
%% text manipulation assists
%%


% and we'll make the text yellow, just like power-point
color textcolour;
textcolour := red+green;
defaultfont := "phvr8r";


% this is the thing we use as a bullet
picture bulletpic;
bulletpic := image(draw char(226) infont "pzdr" withcolor textcolour;);

pair headerpos, footerpos, boff, borigin, borigin.in, blimit;
numeric baselineskip, parskip, parskip.in, bpos;

% positions of the bottom left corner of the header, and the bottom right
% corner of the footer
headerpos = (1in, 4in);
footerpos = (6in, .2in);

% offset of text from the bullet
boff = (20bp, 0);

% upper-left start position for bulletted text
borigin = (1.5in,3.4in);

% upper-left start position for indented bulletted text
borigin.in = borigin + boff;

% lower-right limit of bulletted text
blimit = (4.4in,1in);

% distance between baselines in bulletted text
baselineskip = 11bp;

% distance between bullet points for normal bullets
parskip = 5 pt;

% distance between bullet points for indented bullets
parskip.in = 1pt;

% current bullet position
bpos = 0;

% internal use - bullet position at the end of the last slide
bpos.prev = 0;

vardef breaktowidth(expr s, w)(text sheight) =
    save p;
    picture p;

    p := s infont defaultfont scaled defaultscale;
    % if the string is too long to fit within bounds, we break it up on
    % word boundaries.
    if xpart(lrcorner p - llcorner p) > w:
       save q, offs, len, goodlen; picture q; numeric offs, len, goodlen;
       picture q;
       p := nullpicture;
       offs := 0;
       len := 1;
       goodlen := 0;
       forever:
         exitunless len < length(s);
         q := (substring(offs, len) of s) infont defaultfont scaled defaultscale;
	 if xpart (lrcorner q - llcorner q) > w:
           sheight := sheight + baselineskip;
           p := image(draw p shifted (0, baselineskip);
                      draw (substring(offs, goodlen) of s) infont defaultfont
                           scaled defaultscale;);
           offs := goodlen + 1;
           len := offs + 1;
         fi;
         if substring(len, len+1) of s = " ": goodlen := len; fi;
         len := len + 1;
       endfor;

       p := image(draw p shifted (0, baselineskip);
                  draw (substring(offs, length s) of s) infont defaultfont
                        scaled defaultscale;);
    fi;
    p
enddef;

% bullet(text) or bullet(picture) writes bulletpic and text or picture
% in the next bullet position on the screen
% bullet.in(text) does the same thing, but indented. This can be
% extended for arbitrary suffix tag by defining a pair called borigin.tag,
% and a numeric called parskip.tag. Note that bpos is shared, so this really
% only works for additional levels of indentation
vardef bullet@#(expr s) =
  save p, sheight;
  numeric sheight;
  picture p;

  % add the parskip for this bullet type, unless we're at the top
  if bpos > 0: bpos := bpos + parskip@#; fi

  if picture s:
    p := s;
    sheight := ypart(ulcorner p - llcorner p) - baselineskip;
  else:
    sheight := 0;
    p := image(draw breaktowidth(s, xpart(blimit - borigin@#))(sheight)
              withcolor textcolour;);
  fi;

  % start a new slide if this bullet won't fit. If we're in continuation mode,
  % the previous slide already has the previous bullets, so just clear this
  % slide and put the bullet at the top. In discontinous mode, we need to end
  % the figure, but this causes some problems as it ends the group started by
  % vardef, so we lose p and sheight (which were saved).
  if ypart borigin@# - sheight - bpos < ypart blimit:
    if continuations = 1: discontinue;
    else:
      begingroup;
      endfig;
      bpos.prev := 0;
      nextfig;
      endgroup;
    fi;
  fi;
  draw bulletpic shifted (borigin@# - (0, bpos));
  draw p shifted (borigin@# + boff - (0, bpos+sheight));
  bpos := bpos + sheight + baselineskip;
  bpos.prev := bpos;
enddef;

% handy abbreviation for a common paradigm
vardef bpoint@#(expr s) = nextfig; bullet@#(s); endfig; enddef;

% the same as the plain metapost label, but using textcolour
vardef blabel@#(expr s,z) = draw thelabel@#(s,z) withcolor textcolour; enddef;

vardef dotblabel@#(expr s,z) =
  blabel@#(s,z);
  interim linecap:=rounded;
  draw z withpen pencircle scaled dotlabeldiam withcolor textcolour;
enddef;

% a label which is also a hyperlink
def dolink(expr p, n) =
  special "[ /Rect [ " & decimal xpart llcorner p & " " &
          decimal ypart llcorner p & " " &
          decimal xpart urcorner p & " " &
          decimal ypart urcorner p & " ] /Dest /" & n &
          " /Border [ 0 0 0 ] /Subtype /Link /ANN pdfmark";
enddef;

vardef hyperlabel@#(expr s,z, n) =
  save p;
  picture p;
  p := thelabel@#(s,z);
  dolink(p, n);
  draw p withcolor textcolour;
enddef;

vardef hyperbullet@#(expr s, n) =
  save p;
  picture p;
  p := image(bullet@#(s););
  dolink(p, n);
  draw p;
enddef;  

def hyperdest(expr n) = special "[ /Dest /" & n & " /View [ /Fit ] /DEST pdfmark"; enddef;


picture headerpic, footerpic;

% header saves a string or picture which will be displayed at headerpos
% on each slide. The header is added after the slide is saved to lastpicture
def header(expr s) =
  if picture s: headerpic := s;
  else: headerpic := image(
     draw s infont defaultfont scaled (defaultscale*magstep1)
     shifted headerpos
     withcolor textcolour;);
  fi;
enddef;

def drawheader = if known headerpic: draw headerpic; fi; enddef;

% header saves a string or picture which will be displayed to the left of
% footerpos on each slide. The footer is added after the slide is saved
% to lastpicture
def footer(expr s) =
  if picture s: footerpic := s;
  else: footerpic := s infont defaultfont scaled defaultscale;
    footerpic := image(
     draw footerpic
     shifted (footerpos - (lrcorner footerpic - llcorner footerpic))
     withcolor textcolour;);
  fi;
enddef;

def drawfooter = if known footerpic: draw footerpic; fi; enddef;
extra_endfig := extra_endfig & "drawheader; drawfooter;";

% current slide number
def folio = decimal charcode enddef;

%%
%% font encoding -- currently, only to 8r (I just couldn't bear putting this in
%%                  a source file)
%%
def encodefont(expr tfm, fn) =
  special "/" & tfm & " /" & fn & "8r def";
  special "/" & fn & " findfont dup length dict copy dup /Encoding";
  special "[ /.notdef /dotaccent /fi /fl /fraction /hungarumlaut /Lslash /lslash";
  special "/ogonek /ring /.notdef /breve /minus /.notdef /Zcaron /zcaron /caron /dotlessi";
  special "/dotlessj /ff /ffi /ffl /.notdef /.notdef /.notdef /.notdef";
  special "/.notdef /.notdef /.notdef /.notdef /grave /quotesingle /space /exclam /quotedbl /numbersign";
  special "/dollar /percent /ampersand /quoteright /parenleft /parenright /asterisk /plus /comma /hyphen /period /slash";
  special "/zero /one /two /three /four /five /six /seven /eight /nine /colon /semicolon /less /equal /greater /question";
  special "/at /A /B /C /D /E /F /G /H /I /J /K /L /M /N /O /P /Q /R /S /T /U /V /W /X /Y /Z";
  special "/bracketleft /backslash /bracketright /asciicircum /underscore /quoteleft";
  special "/a /b /c /d /e /f /g /h /i /j /k /l /m /n /o /p /q /r /s /t /u /v /w /x /y /z";
  special "/braceleft /bar /braceright /asciitilde /.notdef /.notdef /.notdef /quotesinglbase /florin";
  special "/quotedblbase /ellipsis /dagger /daggerdbl /circumflex /perthousand /Scaron /guilsinglleft";
  special "/OE /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /quotedblleft /quotedblright /bullet /endash /emdash";
  special "/tilde /trademark /scaron /guilsinglright /oe /.notdef /.notdef /Ydieresis /.notdef";
  special "/exclamdown /cent /sterling /currency /yen /brokenbar /section /dieresis /copyright /ordfeminine /guillemotleft";
  special "/logicalnot /hyphen /registered /macron /degree /plusminus /twosuperior /threesuperior";
  special "/acute /mu /paragraph /periodcentered /cedilla /onesuperior /ordmasculine /guillemotright";
  special "/onequarter /onehalf /threequarters /questiondown /Agrave /Aacute /Acircumflex /Atilde /Adieresis /Aring /AE /Ccedilla";
  special "/Egrave /Eacute /Ecircumflex /Edieresis /Igrave /Iacute /Icircumflex /Idieresis";
  special "/Eth /Ntilde /Ograve /Oacute /Ocircumflex /Otilde /Odieresis /multiply /Oslash /Ugrave /Uacute /Ucircumflex";
  special "/Udieresis /Yacute /Thorn /germandbls /agrave /aacute /acircumflex /atilde /adieresis /aring /ae /ccedilla";
  special "/egrave /eacute /ecircumflex /edieresis /igrave /iacute /icircumflex /idieresis";
  special "/eth /ntilde /ograve /oacute /ocircumflex /otilde /odieresis /divide /oslash /ugrave /uacute /ucircumflex";
  special "/udieresis /yacute /thorn /ydieresis ] put /" & fn & "8r exch definefont pop";
enddef;

%%
%% pdf macros and assists
%%


% maintain a ps file which loads all the slides in order
% this is specific to gs
string psfile;
psfile := jobname & ".ps";

extra_endfig := extra_endfig & "write " & ditto & "(" & ditto & "& jobname &"
                & ditto & "." & ditto
                & "& folio &" & ditto &  ") run" & ditto & " to psfile;";

% put the viewer into full screen mode by default, and define a document-default
% page transition (I'm using the random transition with 1/2 second duration)
% since there is no way to specify a document-default, the transition has to be
% added to each page dictionary
special "[ /PageMode /FullScreen /DOCVIEW pdfmark";

special "[ /_objdef {mytrans} /type /dict /OBJ pdfmark";
special "[ {mytrans} << /Type /Trans /D .5 /S /Random /Dm /H /M /O /Di 315  >> /PUT pdfmark ";

extra_endfig := extra_endfig & "special " & ditto
                & "[ {ThisPage} << /Trans {mytrans} >> /PUT pdfmark" & ditto & ";";

special "[ /CropBox [ 0 0 " & decimal(lawidth) & " " & decimal(laheight) & " ] /PAGES pdfmark";

% allow the user to specify document info
def author(expr s) :=
  special "[ /Author (" & s & ") /DOCINFO pdfmark";
enddef;
def title(expr s) :=
  special "[ /Title (" & s & ") /DOCINFO pdfmark";
enddef;
def subject(expr s) :=
  special "[ /Subject (" & s & ") /DOCINFO pdfmark";
enddef;
def keywords(expr s) :=
  special "[ /Keywords (" & s & ") /DOCINFO pdfmark";
enddef;
def copyright(expr s) :=
  special "[ /Copyright (" & s & ") /DOCINFO pdfmark";
enddef;

def moddate(expr s) :=
  special "[ /ModificationDate (" & s & ") /DOCINFO pdfmark";
enddef;

def createdate(expr s) :=
  special "[ /CreationDate (" & s & ") /DOCINFO pdfmark";
enddef;

% except for the document info we specify ourselves
createdate("D:" & decimal year & decimal month & if day < 10: "0" fi & decimal(day) & decimal time);
special "[ /Creator (Metapost " & base_name & " base, version " & base_version & ") /DOCINFO pdfmark";

% gs will need this
prologues:=2;

