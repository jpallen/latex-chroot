%%
%% This is file `expeg.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% expressg.dtx  (with options: `eg')
%% 
%%   Author: Peter Wilson (CUA) now at peter.r.wilson@boeing.com until June 2004
%%                              (or pandgwilson@earthlink.net)
%%   Copyright 1996, 2003 Peter R. Wilson
%% 
%%  v1.0 1996/05/09 (first release)
%%  v1.2 1999/11/15
%%  v1.3 2000/05/22
%%  v1.4 2000/07/10
%%  v1.5 2003/07/31
%%  v1.6 2004/02/29
%%  v1.61 2004/03/17
%% 
%%   This work may be distributed and/or modified under the
%%   conditions of the LaTeX Project Public License, either
%%   version 1.3 of this license or (at your option) any
%%   later version.
%%   The latest version of the license is in
%%      http://www.latex-project.org/lppl.txt
%%   and version 1.3 or later is part of all distributions of
%%   LaTeX version 2003/06/01 or later.
%% 
%%   This work has the LPPL maintenance status "author-maintained".
%% 
%%   This work consists of the files listed in the README file.
%%  This program is provided under the terms of the
%%  LaTeX Project Public License distributed from CTAN
%%  archives in directory macros/latex/base/lppl.txt.
%% 
%%% EXPEG.MP  Example MetaPost EXPRESS-G diagrams


verbatimtex \def\twolines#1#2{\vbox{\hbox{#1} \hbox{#2}}} etex

input expressg

beginfig(1)

z1=(0,0);
drawEXPRESSION(1);

z2bl=z1tr;
drawINTEGER(2);

z3bl=z2tr;
drawBOOLEAN(3);

z4bm=z3tm;
drawcirclebox(4, namespace(btex ABS etex)(nextra))(btex ABS etex);

numeric diam;
diam = namespace(btex ABS etex)(nextra);

z5bm=z4tm;
drawcirclebox(5, diam)(btex SAB etex);

x5ml-x5tl = x5tr-x6bl;
y6mr=y5tm;
drawENT(6, pconl, enth)(btex an\_ent etex);

z7bm=(x6tm,y6tm+u);
drawLEVENT(7, pconl, eventh)(btex levent etex);

z8=(x7tl, y7tr+u);
drawGEVENT(8, pconl, eventh)(btex gevent etex);

z9br=1/8[z3tl,z3tr];
drawSCHEMA(9, pconl, schemah)(btex a\_schema etex);

numeric xmid, len;
xmid = x8tr + diam;
len = 2diam;

z11=(xmid, y1ml); z111=z11 shifted (len, 0);
drawdashO(11, 111);

pair moveright;
moveright = (len, 0);

z12=(xmid, y2ml); z121=z12 shifted moveright;
drawnormalO(12, 121);

z13=(xmid, y3ml); z131=z13 shifted moveright;
drawthickO(13, 131);

pair moveup;
moveup = (0, y13-y12);

z14=z13 shifted moveup; z141=z14 shifted moveright;
drawnormalD(14, 141);

z15=z14 shifted moveup; z151=z15 shifted moveright;
drawnormalCA(15, 151);

z16=z15 shifted moveup; z161=z16 shifted moveright;
drawnormalOA(16, 161);

z17=z16 shifted moveup; z171=z17 shifted moveright;
drawnormalF(17, 171);

z300=(0,y8tm+diam); z301=(x111,y300);
draw z300--z301 dashes;

numeric mup; mup := onelineh;

z302=(0,y300+mup);
drawcardbox(302, pconl, onelineh, 1/4onelineh)("");

z303bm=(x302tm, y302tm+mup);
drawdiamondbox(303, pconl, 2onelineh)(btex jewel etex);

z304=(0, y303tm+mup);
drawdoublerectangle(304, pconl, 2onelineh, 3/4);
label(btex top etex, z304ct);

z305=(0, y304tm+mup);
drawtriplerectangle(305, pconl, 3onelineh, 2/5, 0.2);
label(btex top etex, z305ct);
label("middle", z305cm);

z306=(0,y305tm+mup);
drawindexbox(306, 2pconl, 3onelineh, 3/4pconl, onelineh)(btex pack etex);
z307=1/8[z306bl,z306tr];
drawENT(307, 1/4pconl, onelineh)(btex E etex);

z308=(0, y306P.tl+mup);
z309ml=z308c;
drawcardbox(308, pconl, 2onelineh, 1/4onelineh)(btex covered etex);
drawdashboxover(309, pconl, onelineh);

z310bm=(x306bm,y309tm+mup);
drawovalbox(310, 2pconl, 2onelineh)("");

z311ml=(x310mr+mup, y310ml);
drawroundedbox(311, 2pconl, 2onelineh, 1/2onelineh)("rounded");

z312ml=(x311mr+mup, y311mr);
drawroundedbox(312, 2pconl, 2onelineh, 3/2onelineh)(btex large radius etex);

z314=(x312bm-1/4pconl, y312bm-1/2mup);
hiderectangle(314, 1/2pconl, (3/2onelineh + mup));

z315tm=(x312bm, y312bm-mup);
drawdashellipse(315, 2pconl, 2onelineh);

z316tm=(x315bm, y315bm-mup);
drawdashcircle(316, diam);

z317bc=(x311bm,y304br);
drawdrum(317, pconl, 3onelineh)(btex drum etex);
z317A=(x317tc, y317tc+2onelineh);
drawnormalthree(317tml, 317A, 317tmr);
smooth(317tml, 317A, 317tmr);

z320bm = (x317bm, y302);
drawstickman(320, onelineh, 2onelineh);

z325bm = (x320bm, y306);
drawoutputbox(325, pconl, 2onelineh)(btex output etex);

z330 = (x320bm, y309ml);
drawCircledDot(330, 3/2onelineh);

z401bm=(1/2[x11,x111], y301+mup);
drawcircleA(401, diam);

z402=(xmid, y401tm+mup); z502=(x111, y402);
drawdashA(402, 502);

z403=(xmid, y402+mup); z503=(x111, y403);
drawdashOA(403, 503);

z404=(xmid, y403+mup); z504=(x111, y404);
drawnormalOD(404, 504);

z405=(xmid, y404+mup); z505=(x111, y405);
drawnormalCD(405, 505);

z406=(xmid, y405+mup); z506=(x111, y406);
drawnormalDCA(406, 506);

numeric ang; ang = 180/7;
z600=(xmid, y406+2mup);
z699=(x600+len, y600);
z601=z699 rotatedaround(z600, ang);
z602=z699 rotatedaround(z600, 2ang);
z603=z699 rotatedaround(z600, 3ang);
z604=z699 rotatedaround(z600, 4ang);
z605=z699 rotatedaround(z600, 5ang);
z606=z699 rotatedaround(z600, 6ang);
z607=z699 rotatedaround(z600, 7ang);
drawnormalCA(600,601);
drawnormalOA(600,602);
drawnormalF(600,603);
drawdashA(600,604);
drawnormalOD(600,605);
drawnormalCD(600,606);

endfig;   % end figure 1

beginfig(2)                       % schema level model

numeric lb, hb;                 % length & height of boxes
lb=20u; hb=schemah;
numeric upshift;                % vertical distance between rows
upshift = 20u;
numeric sideshift;              % horizontal distance between boxes
sideshift = 10u;

%%% bottom row

z9=(lb+sideshift,0);
drawSCHEMA(9, lb, hb)("nine");

z11=(x9br+sideshift,y9);
drawSCHEMA(11, lb, hb)("eleven");

%%% middle row

z1=(0,y9tl+upshift);
drawSCHEMA(1, lb, hb)("one");

z3=(x1br+sideshift, y1);
drawSCHEMA(3, lb, hb)("three");

z5=(x3br+sideshift, y1);
drawSCHEMA(5, lb, hb)("five");

z7=(x5br+sideshift, y1);
drawSCHEMA(7, lb, hb)("seven");

%%% top row

x50 = 1/2[x3br,x5bl];
z31bm=(x50,y1tl+upshift);
drawSCHEMA(31, lb, hb)("thirtyone");

%%% connectors

drawdashOO(9tm, 3bm);   % three/nine
drawdashO(5bm, 11tm);   % five/eleven
drawdashO(3ml, 1mr);    % three/one
drawdashO(3mr, 5ml);    % three/five
drawdashOO(9mr, 11ml);  % nine/eleven

%%% thirtyone/nine
z90=((x1bl-sideshift), y9ml);
z31A=3/4[z31bl,z31tl];
VH(90, 31A);
drawdashO(90vh, 31A);
drawdashthreeO(90vh, 90, 9ml);
pickup thickpen;
draw z90;
pickup normalpen;
label.lft("z90", z90);

%%% one/eleven
z1A=1/3[z1bl,z1br];
z11A=(x11bm, (y11bm-sideshift));
VH(1A, 11A);
drawdashthree(1A, 1A.vh, 11A);   % note it is 1A.vh and not 1Avh
drawdashO(11A, 11bm);
dotlabel.rt("z11A", z11A);
dotlabel.lft("z1A.vh", z1A.vh);   % note it is z1A.vh and not z1Avh

%%% thirtyone/eleven
z31B=3/4[z31br,z31tr];
x31BC=x7br+sideshift;
HxH(31B, 31BC, 11mr);
drawdashfourO(31B, 31B.hxh, 11mr.hxh, 11mr);

%%% thirtyone/seven
z31D=1/4[z31br,z31tr];
VH(7tm, 31D);
drawnormalthreeO(31D, 7tm.vh, 7tm);

%%% thirtyone/one
z31C=1/4[z31bl,z31tl];
VH(1tm, 31C);
drawdashO(1tm.vh, 31C);
drawdashO(1tm.vh, 1tm);

%%% thirtyone/three
z31E=1/4[z31bl,z31br];
VhV(31E, 3tm);
drawnormalfourO(31E, 31E.vhv, 3tm.vhv, 3tm);

%%% thirtyone/five
z31F=3/4[z31bl,z31br];
VhV(31F, 5tm);
drawnormalfourO(31F, 31F.vhv, 5tm.vhv, 5tm);

%%% labeled arrow
z3111=1/4[z31B,z31B.hxh];
numeric arrowsize;
arrowsize := schemah;
z3112=(x3111, y3111+arrowsize);
drawnormalCA(3112, 3111);
label.rt(btex an\_import etex, 1/2[z3111, z3112]);

endfig;  % end fig 2


%%%% some commonly used variables & values

numeric pl, ph;           % length & height of numeric page connectors
pl:=pconl; ph:=pconh;     % for eg., 9,9 (9,9)
numeric plnamed;          % length of named page connector
numeric irh;              % height of interschema boxes
irh:=ish;                 % normally one line of text
numeric sdtl, sdth;       % length & height of SDT (e.g. INTEGER) boxes
sdtl:=sdtbl; sdth:=sdtbh;
numeric edtl, edth;       % length & height of enum boxes (inset is sdtbs)
edth:=sdtbh;              % normally one text line
numeric el, eh;           % length & height of entity boxes
eh:=enth;                 % normally one text line
numeric upshift;          % vertical space between rows of boxes
numeric nextup;           % vertical space between bases of rows of boxes
picture sindex, pindex;
sindex := btex eleven.Index etex;      % interschema reference text
pindex := btex 9,9 Index etex;         % page reference text
numeric slindex, plindex;
slindex := namespace(sindex)(nextra);  % length of Index interschema
plindex := namespace(pindex)(nextra);  % length of Index page reference
numeric hspace[];         % horizontal spaces
numeric lyc[];            % Y coords of box bases

%%%%%%%%%%% end commonly used variables & values

beginfig(3)                      % example fig 3
%%%drawgrid;

edtl := namespace(btex standard\_data\_name etex)(niextra);
upshift=2sdth;
nextup=sdth+upshift;
%%%        the y coords of box bases
lyc1:=0;
lyc2:=lyc1+nextup;
lyc3:=lyc2+nextup;
lyc4:=lyc3+nextup;
lyc5:=lyc4+nextup;
lyc6:=lyc5+nextup;
lyc7:=lyc6+nextup;
lyc8:=lyc7+nextup;
hspace1 := 1/3edtl;  % space between data enums
hspace2 := 2/3edtl;  % initial space at start of second row

%%% bottom two rows (1 & 2)

z11=(0,lyc1);
drawENUM(11, edtl, edth)(btex coordinates etex);

z22=(hspace2, lyc2);
drawENUM(22, edtl, edth)(btex solution\_data etex);

z31=(x11br+hspace1, lyc1);
drawENUM(31, edtl, edth)(btex pressure\_loads etex);

z42=(x22br+hspace1, lyc2);
drawENUM(42, edtl, edth)(btex nondimensional etex);

z51=(x31br+hspace1, lyc1);
drawENUM(51, edtl, edth)(btex temperature etex);

z62=(x42br+hspace1, lyc2);
drawENUM(62, edtl, edth)(btex force\_loads etex);

%%% third row (horizontal line between 2 & 4 row)

z13=(x11tm,lyc3);
VyV(11tm, 13, 62tm);
drawnormal(11tm.vyv, 62tm.vyv);
z23=(x22tm,lyc3); z33=(x31tm,lyc3); z43=(x42tm,lyc3); z53=(x51tm,lyc3);
drawnormalO(11tm.vyv,11tm);
drawnormalO(23,22tm);
drawnormalO(33,31tm);
drawnormalO(43,42tm);
drawnormalO(53,51tm);
drawnormalO(62tm.vyv,62tm);

%%% fourth row

z3224=1/3[z13,z62tm.vyv];
z3554=2/3[z13,z62tm.vyv];

%%% standard_data_name
z24bm=(x3224,lyc4);
drawSELECT(24, edtl, edth)(btex standard\_data\_name etex);
drawnormal(24bm,3224);

%%% adhoc_data_name
z54bm=(x3554,lyc4);
drawTYPE(54, edtl, edth)(btex adhoc\_data\_name etex);

%%% STRING
z64br=(x62br,lyc4);
drawSTRING(64);

%%% fifth row

z35=(1/2[x24tm,x54tm], lyc5);
VyV(24tm, 35, 54tm);
drawnormalthreeO(35, 24tm.vyv, 24tm);
drawnormalthreeO(35, 54tm.vyv, 54tm);

%%% sixth row

z36bm=(x35,lyc6);
drawSELECT(36,edtl, edth)(btex data\_name etex);
drawnormal(36bm,35);

%%% data_name
z66=(x62,lyc6);
drawPREF(66, sdtl, ph)(btex 3,1 (4) etex);

%%%% rest of the connectors

%%% adhoc/STRING (54, 64)
drawnormalO(54mr,64ml);

%%% PREF/data_name (36, 66)
drawdashO(66ml,36mr);

endfig;                         % end fig 3


beginfig(4)                     % example 4
%%%drawgrid;

%%% length of named page reference boxes
plnamed := namespace(btex 9,9 data\_name etex)(nextra);

%%% length of entity boxes
el := namespace(btex (ABS) Data\_t etex)(nextra);

upshift := 2sdth;         % vertical space between boxes
nextup := sdth+upshift;   % vertical space between bases of boxes
hspace1 := 1/2el;         % space between entity boxes

%%% the y coords of box bases
lyc1:=0;
lyc2:=lyc1+nextup;
lyc3:=lyc2+nextup;
lyc4:=lyc3+nextup;
lyc5:=lyc4+nextup;
lyc6:=lyc5+nextup;
lyc7:=lyc6+nextup;
lyc8:=lyc7+nextup;

%%%% 2nd row

%%% IntArray
z12=(0,lyc2);
drawENT(12, el, eh)(btex IntArray etex);

%%% RealArray
z22=(x12br+hspace1, lyc2);
drawENT(22, el, eh)(btex RealArray etex);

%%% CharArray
z42=(x22br+hspace1, lyc2);
drawENT(42, el, eh)(btex CharArray etex);

%%% BitArray
z52=(x42br+hspace1, lyc2);
drawENT(52, el, eh)(btex BitArray etex);

%%%% 1st row

z11bm=(x12bm,lyc1);
drawINTEGER(11);

z21bm=(x22bm,lyc1);
drawREAL(21);

z41bm=(x42bm,lyc1);
drawSTRING(41);

z51bm=(x52bm,lyc1);
drawBINARY(51);

%%% 3rd row

y13=       y23=       y43=       y53=lyc3;
x13=x12tm; x23=x22tm; x43=x42tm; x53=x52tm;
drawthick(13,53);      % horizontal line
%%% vertical connectors
drawthickO(13,12tm); drawthickO(23,22tm);
drawthickO(43, 42tm); drawthickO(53, 52tm);

z33=1/2[z13,z53];   % midpoint of horizontal line

%%% 4th row

%%% Data_t
z34bm=(x33,lyc4);
drawENT(34, el, 3eh)(btex \twolines{(ABS)}{Data\_t} etex);
drawthick(34bm,33);
label.urt("1", z33);   % label the connection point

%%% Index
z14=(0,lyc4);
drawPREF(14, plindex, ph)(pindex);

%%% INTEGER
z54br=(x51br,lyc4);
drawINTEGER(54);

%%% 5th row

lyc5:=y34tm-ph;   % change the initial y coord value

%%% Index
z15=(0,lyc5);
drawPREF(15, plindex, ph)(pindex);

%%% DataType
z55=(x54,lyc5);
drawPREF(55, plnamed, ph)(btex 3,1 data\_name etex);

%%% 6th row

%%% PREF to Data_t
lyc6:=lyc5+nextup;
z36bm=(x34tm,lyc6);
drawPREF(36, pl, ph)(btex 7,5 (6) etex);

%%%% attributes

%%% Sizes  Data_t/Index (34, 14)
z3414=(x34,y14mr);
drawnormal(3414,14mr);
label.ulft(btex Sizes A[1:Limit] etex, z3414);

%%% num  Data_t/INTEGER (34, 54)
z3454=(x34mr,y54ml);
drawnormalO(3454,54ml);
label.urt(btex (DER) num etex, z3454);

%%% Limit Data_t/Index (34, 15)
z3415=(x34,y15mr);
drawnormal(3415,15mr);
label.ulft(btex Limit etex, z3415);

%%% Kind Data_t/data_name (34, 55)
z3455=(x34mr, y55ml);
drawnormal(3455, 55ml);
label.urt(btex Kind etex, z3455);

%%% PREF into Data_t (36, 34)
drawdashO(36bm, 34tm);

%%% Data IntArray/INTEGER (12, 11)
drawnormalO(12bm, 11tm);
label.lrt(btex Data A[1:num] etex, z12bm);

%%% Data RealArray/REAL (22, 21)
drawnormalO(22bm, 21tm);
label.lrt(btex Data A[1:num] etex, z22bm);

%%% Data CharArray/STRING (42, 41)
drawnormalO(42bm, 41tm);
label.lrt(btex Data A[1:num] etex, z42bm);

%%% Data BitArray/BINARY (52, 51)
drawnormalO(52bm, 51tm);
label.lrt(btex Data A[1:num] etex, z52bm);

endfig;                              % end fig 4

beginfig(5)                 % example 5
%%drawgrid;

plnamed := namespace(btex 7,4 Unstructured\_Donor etex)(nextra);

numeric irls, irll;             % length of short and long ISR boxes
irls = namespace(btex eleven.MeshLocation etex)(nextra);
irll = namespace(btex eleven.MeshConnectivityType etex)(nextra);

upshift := irh;
nextup := irh+upshift;

numeric maxrx;         % max x coordinate value of LH of right column boxes
maxrx := maxx-irrl;
numeric xmid;          % x coord of figure center
xmid := 1/2[irls, maxx-irll];

el := namespace(btex MeshConnectivity1\_1 etex)(nextra);
eh := irh;

%%% y coords
lyc1 := 0;
lyc2 := lyc1+nextup;
lyc3 := lyc2+nextup;
lyc4 := lyc3+nextup+irh;
lyc5 := lyc4+nextup;
lyc6 := lyc5+nextup;
lyc7 := lyc6+nextup;
lyc8 := lyc7+nextup;
lyc9 := lyc8+nextup;

%%% Zcol/row
%%% row 1

%%% PREF for Overlapping
z21bm=(xmid,lyc1);
drawPREF(21, pl, ph)(btex 5,3 (8) etex)

%%% row 2

%%% OverlappingArea
z22bm=(x21bm,lyc2);
drawENT(22, el, eh)(btex OverlappingArea etex);

%%% row 3

%%% IndexArray
z13=(pl,lyc3);
drawISR(13, irls, irh)(btex eleven.IndexArray etex);

%%% Index
z23bm=(x22bm,lyc3);
drawISR(23, slindex, irh)(sindex);

%%% MeshLocation
z33br=(maxx,lyc3);
drawISR(33, irls, irh)(btex eleven.MeshLocation etex);

%%% row 4

%%% MeshConnectivity
z24bm=(x23bm,lyc4);
drawENT(24, el, eh)(btex MeshConnectivity etex);

%%% PREF for MeshConnectivity
z14ml=(pl,y24ml);
drawPREF(14, pl, ph)(btex 5,2 (8) etex);

%%% Structured_Donor
z34br=(maxx,lyc4);
drawPREF(34, plnamed, ph)(btex 7,5 Structured\_Donor etex);

%%% row 5

%%% Unstructured_donor
z35br=(maxx,lyc5);
drawPREF(35, plnamed, ph)(btex 7,4 Unstructured\_Donor etex);

%%% row 6

%%% MeshConnType
z36br=(maxx,lyc6);
drawISR(36, irll, irh)(btex eleven.MeshConnectivityType etex);

%%% row 7

%%% IndexRange
z17=(0,lyc7);
drawISR(17, irls, irh)(btex eleven.IndexRange etex);

%%% INTEGER
x27bm=x24bm; y27ml=y17mr;
drawINTEGER(27);

%%% Zone
z37br=(maxx,lyc7);
drawISR(37, irls, irh)(btex seven.Zone etex);

%%% row 8

%%% 1to1
z28bm=(x24bm,lyc8);
drawENT(28, el, eh)(btex MeshConnectivity1\_1 etex);

%%% row 9

%%% PREF to 1to1
z29bm=(x28bm,lyc9);
drawPREF(29, pl, ph)(btex 5,1 (8) etex);

%%%% attributes, etc

drawthickO(21tm,22bm);   % PREF to Overlap (21, 22)
drawthickO(14mr,24ml);   % PREF to MeshConn (14, 24)
drawthickO(29bm,28tm);   % PREF to 1to1 (29, 28)

%%% PointListSize (22, 23)
drawdashO(22tm,23bm);
label.llft(btex PointListSize etex, z23bm);

%%% PointRange (22, 17)
z22A=1/4[z22bl,z22tl]; z17A=(1/2[0,x13], y17);
VH(17A,22A);
drawdashthreeO(22A, 17A.vh, 17A);
label.ulft(btex PointRange etex, z22A);

%%% PointList (22, 13)
z22B=3/4[z22bl,z22tl];
VH(13bm,22B);
drawdashthreeO(22B, 13bm.vh, 13bm);
label.ulft(btex PointList etex, z22B);

%%% MeshLocation (22, 33)
z22C=1/4[z22br,z22tr];
z33B=2/3[z33bl,z33br];
VH(33B,22C);
drawnormalthreeO(22C, 33B.vh, 33B);
label.urt(btex (DER) Location etex, z22C);

%%% Meshloc (22, 33)
z22D=3/4[z22br,z22tr];
z33A=1/3[z33bl,z33br];
VH(33A,22D);
drawdashthreeO(22D, 33A.vh, 33A);
label.urt(btex Meshloc etex, z22D);

%%% PointListSize (24, 23)
drawnormalO(24bm, 23tm);
label.ulft(btex PointListSize etex, z23tm);

%%% StructuredDonor (24, 34)
z24A=(x24br,y34ml);
draw z24A--z34ml dashes;
label.lrt(btex StructuredDonor etex, z24A);

%%% UnstructuredDonor (24, 35)
z24B=3/4[z24br,z24tr];
HvH(24B,35ml);
drawdashfourO(24B, 24B.hvh, 35ml.hvh, 35ml);
label.urt(btex UnstructuredDonor etex, z24B.hvh);

%%% Meshloc (24, 33)
z24C=4/6[z24bl,z24br];
z33C=(x33A,y33tm);
y2433C=1/3[y33C,y24C];
VyV(24C, 2433C, 33C);
drawdashfourO(24C, 24C.vyv, 33C.vyv, 33C);
label.lrt(btex Meshloc etex, z24C.vyv);

%%% Location (24, 33)
z24D=5/6[z24bl,z24br];
z33D=(x33B,y33tm);
y2433D=2/3[y33D,y24D];
VyV(24D, 2433D, 33D);
drawnormalfourO(24D, 24D.vyv, 33D.vyv, 33D);
label.lrt(btex (DER) Location etex, z24D.vyv);

%%% ConnectivityType (24, 36)
z24H=(x24D,y24tr);
z36H=z36bm;
y2436H=1/2[y35tr,y36br];
VyV(24H, 2436H, 36H);
drawnormalfourO(24H, 24H.vyv, 36H.vyv, 36H);
label.urt(btex (DER) ConnectivityType etex, z24H.vyv);

%%% Meshcon (24, 36)
z24G=(x24C,y24tr);
z36G=z36ml;
VH(24G,36G);
drawdashthreeO(24G, 24G.vh, 36G);
label.urt(btex Meshcon etex, z24G.vh);

%%% K (24, 27)
drawnormalO(24tm, 27bm);
label.ulft(btex K etex, z24tm);

%%% PointRange (24, 17)
z24E=1/4[z24tl,z24tr];
x17br-x17E = x17A-x17bl;
y17E = y17A;
VhV(24E,17E);
drawdashfourO(24E, 24E.vhv, 17E.vhv, 17E);
label.ulft(btex PointRange etex, z24E);

%%% PointList (24, 13)
z24F=1/4[z24bl,z24br];
z13F=1/2[z13tl,z13tr];
VhV(24F,13F);
drawnormalfourO(24F, 24F.vhv, 13F.vhv, 13F);
label.llft(btex PointList etex, z24F);

%%% N (28, 27)
z27A=1/5[z27tl,z27tr];
z28A=(x27A,y28bl);
drawnormalO(28A,27A);
label.llft(btex N etex, z28A);

%%% trans (28, 27)
z27B=1/2[z27tl,z27tr];
z28B=(x27B,y28bl);
drawdashO(28B,27B);
label.lrt(btex \twolines{trans}{A[1:N]} etex, z28B);

%%% Transform (28, 27)
z27C=1/2[z27br,z27tr];
z28C=(1/2[x27C,x28br], y28br);
VH(28C,27C);
drawnormalthreeO(28C,28C.vh,27C);
label.lrt(btex (DER) Transform A[1:N] etex , z28C);

%%% DonorZone (28, 37)
z28D=1/2[z28br,z28tr];
z37D=z37tm;
VH(37D,28D);
drawdashthreeO(28D,37D.vh,37D);
label.urt(btex DonorZone etex, z28D);

%%% DonorPointRange (28, 17)
z28G=3/4[z28bl,z28tl];
z17G=(x17A,y17tl);
VH(17G,28G);
drawnormalthreeO(28G,17G.vh,17G);
label.ulft(btex DonorPointRange etex, z28G);

%%% PointRange (28, 17)
z28H=1/4[z28bl,z28tl];
z17H=(x17E,y17G);
VH(17H,28H);
drawnormalthreeO(28H,17H.vh,17H);
label.ulft(btex PointRange etex, z28H);

endfig;                             % end fig 5


beginfig(6)            % example 6  EXPRESS-G
%%%drawgrid;

upshift := 3/2onelineh;
nextup := onelineh+upshift;

el := namespace(btex manufacturer etex)(nextra);
eh := onelineh;

hspace1 := 1/2el;

%%% y coords
lyc1 := 0;
lyc2 := lyc1+nextup;
lyc3 := lyc2+nextup;
lyc4 := lyc3+nextup;
lyc5 := lyc4+nextup;

%%% Zcol/row

%%% rows 4 and 5
z14=(0,lyc4);
drawENT(14, el, eh)(btex manufacturer etex);

z25=(x14br+hspace1, lyc5);
drawSTRING(25);

z34=(x25br+hspace1, lyc4);
drawENT(34, el, eh)(btex car\_model etex);

%%% row 3

z33bm=(x34bm, lyc3);
drawENT(33, el, eh)(btex car etex);

%%% row 2

z22=(x25, lyc2);
drawINTEGER(22);

%%% row 1

z21=(x22, lyc1);
drawSTRING(21);

%%% attributes

%%% manufacturer name (14, 25)
VH(14tm, 25ml);
drawnormalthreeO(14tm, 14tm.vh, 25ml);
label.urt(btex *name etex, z14tm.vh);

%%% model name (34, 25)
VH(34tm, 25mr);
drawnormalthreeO(34tm, 34tm.vh, 25mr);
label.ulft(btex *name etex, z34tm.vh);

%%% made_by (34, 14)
drawnormalO(34ml, 14mr);
label.ulft(btex made\_by etex, z34ml);

%%% model_type (33, 34)
drawnormalO(33tm, 34bm);
label.urt(btex model\_type etex, z33tm);

%%% DER made_by (33, 14)
VH(14bm, 33ml);
drawnormalthreeO(33ml, 14bm.vh, 14bm);
label.ulft(btex (DER) *made\_by etex, z33ml);

%%% year (33, 22)
z33A=1/3[z33bl, z33br];
VH(33A, 22mr);
drawnormalthreeO(33A, 33A.vh, 22mr);
label.ulft(btex year etex, z33A.vh);

%%% serial_no
z33B=2/3[z33bl, z33br];
VH(33B, 21mr);
drawnormalthreeO(33B, 33B.vh, 21mr);
label.ulft(btex *serial\_no etex, z33B.vh);

endfig;               % end fig 6


beginfig(7)            % example 7
%%%drawgrid;

el := namespace(btex MANUFACTURER etex)(niextra);
eh := onelineh;

hspace1 := namespace(btex made by maker of etex)(4ndextra);

hspace2 := 6onelineh;   % height of CAR
hspace3 := 5onelineh;   % space between rows
hspace4 := 3onelineh;   % height of MANUFACTURER

%%% y coords
lyc1 := 0;
lyc2 := lyc1+hspace2+hspace3;

%%% Zcol/row

%%% row 2

z12=(0, lyc2);
drawENT(12, el, hspace4)("");
x121=x12+sdtbs;
label.rt(btex MANUFACTURER etex, (x121, 2/3[y12bl, y12tl]));
label.rt(btex * manuf-name etex, (x121, 1/3[y12bl, y12tl]));

z22=(x12br+hspace1, lyc2);
drawENT(22, el, hspace4)("");
x221=x22+sdtbs;
label.rt(btex CAR-MODEL etex, (x221, 2/3[y12bl, y12tl]));
label.rt(btex * model-name etex, (x221, 1/3[y12bl, y12tl]));

%%% row 1

z21=(x22, lyc1);
drawENT(21, el, hspace2)("");
x211=x21+sdtbs;
label.rt(btex CAR etex,         (x211, 5/6[y21bl, y21tl]));
label.rt(btex o year etex,      (x211, 4/6[y21bl, y21tl]));
label.rt(btex o model (R) etex, (x211, 3/6[y21bl, y21tl]));
label.rt(btex * serial-no etex, (x211, 2/6[y21bl, y21tl]));
label.rt(btex * maker (R) etex, (x211, 1/6[y21bl, y21tl]));

%%%%% relationship lines

%%% MANUFACTURER / CAR-MODEL (12, 22)
drawnormalDCA(12mr, 22ml);
drawnormalCA(22ml, 12mr);
label.urt(btex { }{ }made by etex, z12mr);
label.llft(btex maker of{ }{ } etex, z22ml);

%%% MANUFACTURER / CAR (12, 21)
VH(12bm, 21ml);
drawnormalCA(12bm.vh, 12bm);
drawnormalDCA(12bm.vh, 21ml);
label.llft(btex { }{ }made by etex, z12bm);
label.ulft(btex maker of{ }{ }  etex, z21ml);

%%% CAR-MODEL / CAR (22, 21)
drawnormalDCA(22bm, 21tm);
drawnormalCA(21tm, 22bm);
label.lrt(btex { }one of etex, z22bm);
label.ulft(btex type of{ }  etex, z21tm);

endfig;               % end fig 7


beginfig(8)            % example 8  IDEF1X
%%%drawgrid;

el := namespace(btex MANUFACTURER etex)(niextra);
eh := onelineh;

hspace1 := namespace(btex made by maker of etex)(4ndextra);

hspace2 := 5onelineh;   % height of CAR
hspace3 := 5onelineh;   % space between rows
hspace4 := 3onelineh;   % height of MANUFACTURER

%%% y coords
lyc1 := 0;
lyc2 := lyc1+hspace2+hspace3;

%%% Zcol/row

%%% row 2

z12=(0, lyc2);
drawdoublerectangle(12, el, hspace4, 1/2);
label.urt(btex Manufacturer etex, z12tl);
x121=x12+sdtbs;
label.rt(btex manuf-name etex, (x121, 3/4[y12bl, y12tl]));

z22=(x12br+hspace1, lyc2);
drawdoublerectangle(22, el, hspace4, 1/2);
label.urt(btex Car-model etex, z22tl);
x221=x22+sdtbs;
label.rt(btex Model-name etex, (x221, 3/4[y12bl, y12tl]));
label.rt(btex Manuf-name (FK) etex, (x221, 1/4[y12bl, y12tl]));

%%% row 1

z21=(x22, lyc1);
drawroundedbox(21, el, hspace2, 2sdtbs)("");
label.urt(btex Car etex, z21tl);
draw z21ml--z21mr;
x211=x21+sdtbs;
label.rt(btex Serial-no etex,       (x211, 5/6[y21bl, y21tl]));
label.rt(btex Manuf-name (FK) etex, (x211, 4/6[y21bl, y21tl]));
label.rt(btex Model-name (FK) etex, (x211, 2/6[y21bl, y21tl]));
label.rt(btex Year etex,            (x211, 1/6[y21bl, y21tl]));

%%%%% relationship lines

%%% MANUFACTURER / CAR-MODEL (12, 22)
drawnormalD(12mr, 22ml);
label.top(btex of etex, 1/2[z12mr, z22ml]);

%%% MANUFACTURER / CAR (12, 21)
VH(12bm, 21ml);
drawnormalthreeD(12bm, 12bm.vh, 21ml);
label.top(btex makes etex, 1/2[z12bm.vh, z21ml]);
label.ulft(btex P{ }  etex, z21ml);

%%% CAR-MODEL / CAR (22, 21)
drawnormalD(22bm, 21tm);
label.lft(btex of etex, 1/2[z21tm,z22bm]);
label.urt(btex { }P etex, z21tm);

endfig;               % end fig 8


beginfig(9)            % example 9  OMT
%%%drawgrid;

el := namespace(btex {\bf MANUFACTURER} etex)(niextra);
eh := onelineh;

hspace1 := namespace(btex made by maker of etex)(4ndextra);

hspace2 := 4onelineh;   % height of CAR
hspace3 := 4onelineh;   % space between rows
hspace4 := 3onelineh;   % height of MANUFACTURER

%%% y coords
lyc1 := 0;
lyc2 := lyc1+hspace2+hspace3;

%%% Zcol/row

%%% row 2

z12=(0, lyc2);
drawdoublerectangle(12, el, hspace4, 1/2);
x121=x12+sdtbs;
label.rt(btex {\bf Manufacturer} etex, (x121, 3/4[y12bl, y12tl]));
label.rt(btex name : String etex,      (x121, 1/4[y12bl, y12tl]));

z22=(x12br+hspace1, lyc2);
drawdoublerectangle(22, el, hspace4, 1/2);
x221=x22+sdtbs;
label.rt(btex {\bf Car Model} etex, (x221, 3/4[y22bl, y22tl]));
label.rt(btex name: String etex,    (x221, 1/4[y22bl, y22tl]));

%%% row 1

z21=(x22, lyc1);
drawdoublerectangle(21, el, hspace2, 1/3);
x211=x21+sdtbs;
label.rt(btex {\bf Car} etex,          (x211, 5/6[y21bl, y21tl]));
label.rt(btex serial-no : String etex, (x211, 4/9[y21bl, y21tl]));
label.rt(btex year : Integer etex,     (x211, 2/9[y21bl, y21tl]));

%%%%% relationship lines

%%% MANUFACTURER / CAR-MODEL (12, 22)
drawnormalD(12mr, 22ml);
label.top(btex {\it makes} etex, 1/2[z12mr, z22ml]);
label.ulft(btex 1+{ } etex, z22ml);

%%% MANUFACTURER / CAR (12, 21)
VH(12bm, 21ml);
drawnormalthreeD(12bm, 12bm.vh, 21ml);
label.top(btex {\it makes} etex, 1/2[z12bm.vh, z21ml]);
label.ulft(btex 1+{ }  etex, z21ml);

%%% CAR-MODEL / CAR (22, 21)
drawnormalD(22bm, 21tm);
label.lft(btex {\it produced as} etex, 1/2[z21tm,z22bm]);

endfig;               % end fig 9


beginfig(10)            % example 10 E-R
%%%drawgrid;

numeric diam; diam := 2onelineh;

upshift := diam;            % circle diameter
nextup := diam+upshift;

el := namespace(btex MANUFACTURER etex)(niextra);
eh := onelineh;

numeric dl, dh;             % length and height of diamond boxes
dl := 1/2el; dh := 2eh;

numeric marg; marg := 4u;   % double the seperation between parallel lines

hspace1 := 1/2el;

%%% y coords
lyc1 := 0;
lyc2 := lyc1+nextup;
lyc3 := lyc2+nextup;
lyc4 := lyc3+nextup;
lyc5 := lyc4+nextup;

%%% Zcol/row
%%% row 4

z14=(0,lyc4);
drawENT(14, el, eh)(btex manufacturer etex);

z34ml=(x14br+hspace1, y14mr);
drawdiamondbox(34, dl, dh)(btex has etex);

z54ml=(x34mr+hspace1, y34mr);
drawENT(54, el, eh)(btex car\_model etex);

%%% row 5

z15bm=(x14bm, lyc5);
drawcirclebox(15, diam)(btex Name etex);

z55bm=(x54bm, lyc5);
drawcirclebox(55, diam)(btex Name etex);

%%% row 3

z53bm=(x54bm, lyc3);
drawdiamondbox(53, dl, dh)(btex of etex);

z13c=(x14bm, y53c);
drawtwodiamondbox(13, dl+marg, dh+marg, 2/5marg)(btex Makes etex);

%%% row 2

z32bm=(x34bm, lyc2);
drawENT(32, el, eh)(btex car etex);
z31c=z32c;
drawENT(31, el+marg, eh+marg)("");

%%% row 1

z21bm=(x32bl, lyc1);
drawcirclebox(21, 5/4diam)(btex \twolines{Serial}{No} etex);

z41bm=(x32br, lyc1);
drawcirclebox(41, diam)(btex Year etex);

%%%%%% lines

%%% Name / manufacturer (15, 14)
drawnormal(15bm, 14tm);

%%% Name / model (55, 54)
drawnormal(55bm, 54tm);

%%% Mnf / has (14, 34)
drawnormal(14mr, 34ml);
label.top(btex 1 etex, 1/2[z14mr,z34ml]);

%%% has/ model (34, 54)
drawnormal(34mr, 54ml);
label.top(btex N etex, 1/2[z34mr,z54ml]);

%%% Mnf / makes (14, 13)
drawnormal(14bm, 13tm);
label.rt(btex 1 etex, 1/2[z14bm,z13tm]);

%%% model / of (54, 53)
drawnormal(54bm, 53tm);
label.rt(btex 1 etex, 1/2[z54bm,z53tm]);

%%% makes / car (13, 31)
drawnormal(13bm, 31ml);
z31A=(x31ml, y31ml+1/2marg);
z13U-z31A = z13bm-z31ml;
z13A = whatever[z13U,z31A] = whatever[z13bm,z13mr];
draw z13A--z31A;
label.urt(btex N etex, 1/2[z13A,z31A]);

%%% of / car (53, 31)
drawnormal(53bm, 31mr);
z31B=(x31mr, y31mr+1/2marg);
z53U - z31B = z53bm - z31mr;
z53B = whatever[z53U,z31B] = whatever[z53bm,z53ml];
draw z53B--z31B;
label.ulft(btex N etex, 1/2[z53B,z31B]);

%%% car / serial no (31, 21)
z31C=(x21tm, y31bl);
drawnormal(31C, 21tm);

%%% car / year (31, 41)
z31D=(x41tm, y31br);
drawnormal(31D, 41tm);

endfig;               % end fig 10


beginfig(11)            % example 11  NIAM
%%%drawgrid;

numeric diam; diam := 2onelineh;    % circle diameter

upshift := diam;
nextup := diam+upshift;

numeric hel, vel;        % length of horizontal and vertical box pairs
eh := onelineh;
hel = namespace(btex made by etex)(nextra);
vel = namespace(btex of prod etex)(nextra);

numeric del, deh;        % horizontal & vertical diameters of oval boxes
del := namespace(btex MANUFACTURER etex)(niextra);
deh := 2eh;

numeric marg; marg := 2u;       % margin for doubly enclosed oval boxes
numeric lmarg; lmarg := marg;   % gap for short lines

numeric dashel, dasheh;         % diameters of dashed ellipses
dashel := del+2marg;
dasheh := deh+2marg;

hspace1 := diam;

%%% y coords
lyc1 := 0;
lyc2 := lyc1+nextup;
lyc3 := lyc2+nextup;

%%% Zcol/row

%%% row 3

x13ml=0; y13bm=lyc3;
drawovalbox(13, del, deh)(btex manufacturer etex);
z14=z13c;
drawdashellipse(14, dashel, dasheh);

z23ml=(x14mr+hspace1, y14mr);
drawENT(23, hel, eh)(btex of etex);

z33bl=z23br;
drawENT(33, hel, eh)(btex made by etex);

z44ml=(x33mr+hspace1, y33mr);
drawdashellipse(44, dashel, dasheh);
z43=z44c;
drawovalbox(43, del, deh)(btex car model etex);

z53ml=(x44mr+hspace1, y44mr);
drawdashcircle(53, diam);
label(btex year etex, z53c);

%%% row 2

z22c=(x23bm,lyc2);
drawcirclebox(22, namespace(btex U etex)(2nextra))(btex U etex);

x42tm=x43bm; y42ml=lyc2;
drawdoublerectangle(42, vel, 2eh, 1/2);
label(btex of etex, z42ct);
label(btex is of etex, z42cb);

%%z52c=(x53x,lyc2);
x52tm=x53bm; y52ml=lyc2;
drawdoublerectangle(52, vel, 2eh, 1/2);
label(btex of prod etex, z52ct);
label(btex prod in etex, z52cb);

%%% row 1

z11ml=(x13ml,lyc1);
drawdashellipse(11, del, deh);
label(btex serial no etex, z11c);

z21ml=(x23ml,lyc1);
drawENT(21, hel, eh)(btex of etex);

z31bl=z21br;
drawENT(31, hel, eh)(btex has etex);

z41c=(x43c,lyc1);
drawcirclebox(41, diam)(btex car etex);

%%%%%% lines

%%% manufacturer / of (14, 23)
drawnormal(14mr, 23ml);

%%% made by / car model (33, 44)
drawnormal(33mr, 44ml);
draw (x33tl, y33tl+lmarg)--(x33tr, y33tl+lmarg);
draw (x33mr, y33mr+lmarg)--(x33mr+eh, y33mr+lmarg);

%%% serial no / of (11, 21)
drawnormal(11mr, 21ml);

%%% of / of (23, 22, 21)
drawnormal(23bm, 22tm); drawnormal(22bm, 21tm);
label.rt(btex id etex, z22mr);

%%% has / car (31, 41)
drawnormal(31mr, 41ml);
draw (x31tl, y31tl+lmarg)--(x31tr, y31tl+lmarg);
draw (x31mr, y31mr+lmarg)--(x33mr+eh, y31mr+lmarg);

%%% model / of (44, 42)
drawnormal(43bm, 42tm);

%%% is of / car (42, 41)
drawnormal(42bm, 41tm);
draw (x42tfr+lmarg, y42tfr)--(x42tfr+lmarg, y42br);
draw (x42bm+lmarg, y42bm)--(x42bm+lmarg, y42bm-eh);

%%% year / of prod (53, 52)
drawnormal(53bm, 52tm);

%%% prod in / car (52, 41)
VH(52bm,41mr);
drawnormalthree(52bm, 52bm.vh, 41mr);
draw (x52tfr+lmarg, y52tfr)--(x52tfr+lmarg, y52br);
draw (x52bm+lmarg, y52bm)--(x52bm+lmarg, y52bm-eh);

endfig;               % end fig 11

end

