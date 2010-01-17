% aam.mp    MetaPost for AAM figures
% Copyright 2000, 2004 Peter R Wilson
%           All rights reserved
input expressg

verbatimtex 
  \def\twolines#1#2{\vbox{\hbox{#1} \hbox{#2}}}
  \def\threelines#1#2#3{\vbox{\hbox{#1} \hbox{#2} \hbox{#3}}}
  \def\fourlines#1#2#3#4{\vbox{\hbox{#1} \hbox{#2} \hbox{#3} \hbox{#4}}} 
etex



beginfig(5)                 % FILES

numeric lb[]; numeric hb[];                %  box dimens
lb1 := namespace(btex Root etex)(nextra);  % leaf nodes
lb4 := namespace(btex Root etex)(nextra);  % root
hb1 := onelineh;

numeric upshift, sideshift;
upshift := 10u;
sideshift := 5u;

numeric cx[];
numeric lyc[];

cx1 := 0;
cx2 := cx1 + sideshift;
cx3 := cx2 + sideshift;
cx4 := cx2 + sideshift + lb1;
cx5 := cx4 + sideshift;
cx6 := cx4 + sideshift + lb1;
cx7 := cx6 + sideshift + lb1;
cx8 := cx7 + sideshift + lb1;
cx9 := cx8 + sideshift + lb1;

lb2 := (cx9-cx1);                    % FILES 1 length

cx11 := cx9 + sideshift;
cx12 := cx11 + sideshift;
cx13 := cx12 + sideshift + lb1;
cx14 := cx13 + 0.5*(sideshift + lb1);
cx15 := cx13 + sideshift + lb1;
cx16 := cx14 + sideshift + lb1;
cx17 := cx16 + sideshift + lb1;
cx18 := cx13 + sideshift;

lb3 := (cx17-cx11);                  % FILES 2 length

lyc1 := 0;
lyc2 := lyc1 + upshift;
lyc3 := lyc2 + upshift + hb1;
lyc4 := lyc3 + upshift + hb1;

hb3 := (lyc4 + upshift + hb1 -lyc1);  % FILES 2 height

lyc5 := lyc2 + hb1;
lyc6 := lyc5 + upshift + hb1;
lyc7 := lyc6 + upshift + hb1;
lyc8 := lyc7 + upshift + hb1;
lyc9 := lyc8 + upshift + hb1;

hb2 := (lyc9 - lyc5);                  % FILES 1 height

%% left FILE
z15=(cx1,lyc5);
drawENT(15, lb2, hb2)(" ");
label.top(btex FILE 1 etex, z15bm);

%% right file
z111=(cx11,lyc1);
drawENT(111, lb3, hb3)("");
label.top(btex FILE 2 etex, z111bm);

%% bottom row of left tree
z26=(cx2,lyc6); drawENT(26, lb1, hb1)(btex N3 etex);
z46=(cx4,lyc6); drawENT(46, lb1, hb1)(btex N4 etex);
z66=(cx6,lyc6); drawENT(66, lb1, hb1)(btex N5 etex);
z76=(cx7,lyc6); drawENT(76, lb1, hb1)(btex N6 etex);
z86=(cx8,lyc6); drawENT(86, lb1, hb1)(btex L2 etex);

%% middle row of left tree
z37=(cx3,lyc7); drawENT(37, lb1, hb1)(btex N1 etex);
z57=(cx5,lyc7); drawENT(57, lb1, hb1)(btex L1 etex);
z77=(cx7,lyc7); drawENT(77, lb1, hb1)(btex N2 etex);

%% top row of left tree
z68=(cx6,lyc8); drawENT(68, lb4, hb1)(btex Root etex);

%% bottom row right tree
z142=(cx14,lyc2); drawENT(142, lb1, hb1)(btex F4 etex);
z162=(cx16,lyc2); drawENT(162, lb1, hb1)(btex F5 etex);

%% middle row of right tree
z123=(cx12,lyc3); drawENT(123, lb1, hb1)(btex F1 etex);
z133=(cx13,lyc3); drawENT(133, lb1, hb1)(btex F2 etex);
z153=(cx15,lyc3); drawENT(153, lb1, hb1)(btex F3 etex);

%% top row of right tree
z184=(cx18,lyc4); drawENT(184, lb4, hb1)(btex Root etex);

%%%%%%%%%%%%%%%%%%% lines

%%% thick lines

%% Arrow L1 to N5 (57-66)
z66A=1/4[z66tl,z66tr];
pickup thickpen;
drawnormalCA(57bm,66A);
pickup normalpen;

%% Arrow L2 to F4 (86-142)
pickup thickpen;
drawnormalCA(86bm,142ml);
pickup normalpen;

%%% thin lines
pickup thinpen;

%%% file 1

%% N1 to N3 & N4 (37, 26, 46)
x36=x37bm; y36=1/2[y26tm,y37bm];
VyV(26tm, 36, 46tm);
drawnormalfour(26tm, 26tm.vyv, 46tm.vyv, 46tm);
drawnormal(37bm,36);

%% N2 to N5, N6 & L2 (77, 66, 76, 86)
x76A=x76tm; y76A=1/2[y76tm,y77bm];
VyV(66tm, 76A, 86tm);
drawnormalfour(66tm, 66tm.vyv, 86tm.vyv, 86tm);
drawnormal(77bm, 76tm);

%% Root to N1, L1 and N2 (68, 37, 57, 77)
x68A=x68bm; y68A=1/2[y57tm,y68bm];
VyV(37tm, 68A, 77tm);
drawnormalfour(37tm, 37tm.vyv, 77tm.vyv, 77tm);
drawnormal(68bm,68A);
z57A=(x57tm,y68A);
drawnormal(57A, 57tm);

%%% file 2

%% F3 to F4 and F5 (153, 142, 162)
x153A=x153bm; y153A=1/2[y142tm,y153bm];
VyV(142tm, 153A, 162tm);
drawnormalfour(142tm, 142tm.vyv, 162tm.vyv, 162tm);
drawnormal(153bm, 153A);

%% Root to F1, F2 and F3 (184, 123, 133, 153)
x184A=x184bm; y184A=1/2[y184bm,y133tm];
VyV(123tm, 184A, 153tm);
drawnormalfour(123tm, 123tm.vyv, 153tm.vyv, 153tm);
drawnormal(184bm,184A);
z133A=(x133tm,y184A);
drawnormal(133tm,133A);



pickup normalpen;

endfig;

%%end



beginfig(3)                 % DATA FLOW


smoothrad := 2u;

numeric lb, hb;                 % length & height of boxes
lb := namespace(btex Analysis Process A0 etex)(nextra);
hb := 5onelineh;

numeric hspace[];
hspace1 := namespace(btex Geometry (ISO 10303-203, or other source) etc etex)(ndextra);

numeric upshift;                % vertical distance between rows
upshift = 5u; % 20u
numeric sideshift;              % horizontal distance between boxes
sideshift = 5u; % 10u;

numeric lb[];

%lb5 := namespace(btex to Model and etex)(nextra);
lb5 := namespace(btex Computational etex)(nextra);
lb1 := lb5;
lb2 := lb5;
lb3 := lb5;
lb4 := lb5;
lb6 := lb5;
lb25 := lb5;
lb41 := lb5;
lb65 := lb5;
lb84 := lb1;

numeric hb[];

hb1 := 4onelineh;
hb2 := hb1;
hb3 := hb1;
hb4 := hb1;
hb5 := 4onelineh;
hb6 := hb5;
hb25 := 4onelineh;
hb41 := hb25;
hb65 := hb25;
hb84 := 3/2hb1;

numeric lyc[];
lyc1 := 0;
lyc2 := lyc1 + hb41;
lyc3 := lyc2 + upshift + hb6;
lyc5 := lyc3 + hb5;
lyc4 := 1/2[lyc3,lyc5];
lyc6 := lyc5 + upshift;
lyc7 := lyc5 + 4upshift + hb25;
lyc8 := lyc7 + 1/2hb1;
lyc9 := lyc8 + upshift;

numeric cx[];
cx1 := 0;
cx2 := cx1 + sideshift;
cx3 := cx2 + sideshift + lb25;
cx4 := cx3 + sideshift + lb1;
cx5 := cx4 + sideshift + lb41;
cx6 := cx5 + sideshift + lb5;
cx7 := cx6 + sideshift + lb65;
cx8 := cx7 + lb4;
cx9 := cx8 + sideshift;

%%% Modified geometry
z41=(cx4,lyc1);
drawdrum(41, lb41, hb41)(btex \threelines{Modified}{Geometry}{Data} etex);
%%dotlabel.llft("41", z41);

%%% Optimize Geometry (A6)
z52=(cx5,lyc2);
drawENT(52, lb6, hb6)(btex \threelines{Optimize}{Geometry}{(A6)} etex);
%%dotlabel.llft("52", z52);

%%% Adaptive Modification (A5)
z53=(cx5,lyc3);
drawENT(53, lb5, hb5)(btex \fourlines{Adaptive}{Modification}{to Model and}{Process (A5)} etex);
%%dotlabel.llft("53", z53);

%%% Initial Geometry
z25=(cx2,lyc5);
drawdrum(25, lb25, hb25)(btex \twolines{Geometry}{Data} etex);
%%dotlabel.llft("25", z25);

%%% Aerodynamic data
z65=(cx6,lyc5);
drawdrum(65, lb65, hb65)(btex \twolines{Aerodynamic}{Data} etex);
%%dotlabel.llft("65", z65);


%%% Acquire & Modify Geometery (A1)
z37=(cx3,lyc7);
drawENT(37, lb1, hb1)(btex \fourlines{Acquire and}{Modify}{Geometry}{(A1)} etex);
%%dotlabel.llft("37", z37);


%%% Extract Engineering Data (A4)
z77=(cx7,lyc7);
drawENT(77, lb4, hb4)(btex \threelines{Extract}{Engineering}{Data (A4)} etex);
%%dotlabel.llft("77", z77);

%%% Build Computational Model (A2)
z57=(cx5,lyc7);
drawENT(57, lb2, hb2)(btex \threelines{Build}{Computational}{Model (A2)} etex);
%%dotlabel.llft("57", z57);

%%% Compute Flowfield (A3)
z67=(cx6,lyc7);
drawENT(67, lb3, hb3)(btex \threelines{Compute}{Flowfield}{(A3)} etex);
%%dotlabel.llft("67", z67);

%%% End Users
z84=(cx8,lyc4);
drawASDT(84, lb84, hb84)(btex \twolines{END}{USERS} etex);
%%dotlabel.llft("84", z84);


%%%%%%%%%%%%%%%%%%%%%%% lines

%%% Geometry INPUT
z18=(cx1,lyc8);
VH(25tml,18);
drawnormal(18, 25tml.vh);
drawnormalCA(25tml.vh, 25tml);
smooth(18, 25tml.vh, 25tml);
label.top(btex Geometry etex, z18);

%%% Geom -> A1 (25-37)
VH(25tmr, 37ml);
drawnormal(25tmr, 25tmr.vh);
drawnormalCA(25tmr.vh, 37ml);
smooth(25tmr, 25tmr.vh, 37ml);

%%% A1 -> Modified Geom (37-41)
VH(41tml, 37mr);
drawnormalthreeCA(37mr, 41tml.vh, 41tml);
smooth(37mr, 41tml.vh, 41tml);

%%% Modified Geom -> A2 (41-57)
VH(41tm, 57ml);
drawnormalthreeCA(41tm, 41tm.vh, 57ml);
smooth(41tm, 41tm.vh, 57ml);

%%% Adaptive A5  -> Mod Geom (53-41) & A6 -> Mod Geom (52-41)
VH(41tmr, 53ml);
drawnormalthreeCA(53ml, 41tmr.vh, 41tmr);
z42=(x41tmr, y52ml);
drawnormal(52ml,42);
smooth(53ml, 41tmr.vh, 41tmr);
smooth(52ml, 42, 41tmr);

%% Aero Data -> Adapt mod (A5) & Opt Geom (A6) (65-53,52)
VH(65bm, 52mr);
drawnormalthreeCA(65bm, 65bm.vh, 52mr);
z63=(x65bm, y53mr);
drawnormalCA(63, 53mr);
smooth(65bm, 65bm.vh, 52mr);
smooth(65bm, 63, 53mr);

%% Mod Geom -> USERS (41-84)
z84A=1/4[z84bl,z84tl];
%%HvH(41mr, 84A);
HxH(41mr, 77bm, 84A)
drawnormalfourCA(41mr, 41mr.hxh, 84A.hxh, 84A);
smoothtwo(41mr, 41mr.hxh, 84A.hxh, 84A);

%% Aero -> Model (65-57)
VhV(65tml, 57bm);
drawnormalthreeCA(65tml.vhv, 57bm.vhv, 57bm);
drawnormalCA(65tml.vhv, 65tml);
smoothtwo(65tml, 65tml.vhv, 57bm.vhv, 57bm);

%% Aero -> Flowfield (65-67)
drawnormalCA(65tm,67bm);
drawnormalCA(67bm,65tm);

%% Aero -> Data (65-77)
VhV(65tmr, 77bm);
drawnormalthreeCA(65tmr.vhv, 77bm.vhv, 77bm);
drawnormalCA(65tmr.vhv, 65tmr);
smoothtwo(65tmr, 65tmr.vhv, 77bm.vhv, 77bm);

%% Aero -> USERS (65-84)
z84B=(x84bl, y65mr);
drawnormalCA(65mr, 84B);

%% Data -> USERS (77-84)
VH(84tm,77mr);
drawnormalthreeCA(77mr, 84tm.vh, 84tm);
smooth(77mr, 84tm.vh, 84tm);


%%%%%%%%% test smoothed dashed/dotted line
VH(25bm,41ml);
%%drawdashthree(25bm, 25bm.vh, 41ml);
%%smoothdash(25bm, 25bm.vh, 41ml);
drawdotsthree(25bm, 25bm.vh, 41ml);
smoothdots(25bm, 25bm.vh, 41ml);

endfig;  % end fig 3

%%%%%%%%%%%%%%%%%%%%%%%
%%end
%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(1)              % IDEF A0  model

%%%%drawgrid;

smoothrad := 2u;

numeric lb, hb;                 % length & height of boxes
lb := namespace(btex Analysis Process A0 etex)(nextra);
hb := 5onelineh;

numeric hspace[];
hspace1 := namespace(btex Geometry (ISO 10303-203, or other source) etc etex)(ndextra);

numeric upshift;                % vertical distance between rows
upshift = 20u;
numeric sideshift;              % horizontal distance between boxes
sideshift = 10u;

numeric lyc[];
lyc1 := 0;
lyc2 := lyc1;% +upshift;
lyc3 := lyc2+upshift;
lyc4 := lyc3+upshift+hb;
lyc5 := lyc4;% +upshift;

%%%%%%%%%%%%%%%%%%%% A0 box
z33=(hspace1,lyc3);
drawENT(33, lb, hb)(btex \threelines{Computational}{Fluid Dynamics}{Analysis Process} etex);
label.ulft(btex A0 etex, z33br);

%%%%%%%%%%%%%%%%%%%%%%%%% Inputs
z33A=1/8[z33bl,z33tl];
z33B=z33ml;
z33C=7/8[z33bl,z33tl];
z13=(0,y33A); z14=(0,y33B); z15=(0,y33C);
drawnormalCA(13,33A);
label.urt(btex Analysis Objectives etex, z13);
drawnormalCA(14,33B);
label.urt(btex Definition of Expected Flow Physics etex, z14);
drawnormalCA(15,33C);
label.urt(btex Geometry (ISO 10303-203, or other source) etex, z15);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Outputs
z33D=1/8[z33br,z33tr];
z33E=z33mr;
z33F=7/8[z33br,z33tr];

hspace2 := x33br+namespace(btex Flowfield Data etex)(ndextra);
z63=(hspace2,y33D); z64=(hspace2,y33E); z65=(hspace2,y33F);
drawnormalCA(33D,63);
label.rt(btex Flowfield Data etex, z63);
drawnormalCA(33E,64);
label.rt(btex Optimized Geometry etex, z64);
drawnormalCA(33F,65);
label.rt(btex \twolines{Information to Analysis}{Customer} etex, z65);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Resources
hspace3 := namespace(btex Organizational etex)(ndextra);
z33G=1/5[z33bl,z33br];
z33H=2/5[z33bl,z33br];
z33I=3/5[z33bl,z33br];
z33J=4/5[z33bl,z33br];
hspace4 :=1/5lb;

x41=x33bm + 1/2hspace4 + 1/2hspace3; 
x51=x41+hspace3+hspace4;
x31=x41-hspace3-hspace4;
x21=x31-hspace3-hspace4;
y21=y31=y41=-y51=lyc1;
label.bot(btex \twolines{Trained}{Staff} etex, z21);
label.bot(btex \twolines{Computing}{Practices} etex, z31);
label.bot(btex \twolines{Organizational}{Best Practices} etex, z41);
label.bot(btex \twolines{Support}{Infrastructure} etex, z51);

y1=1/3[lyc1,lyc3]; y2=2/3[lyc1,lyc3];

VyV(21,2,33G);
drawnormalthree(21, 21vyv, 33G.vyv);
drawnormalCA(33G.vyv, 33G);
smooth(21, 21vyv, 33G.vyv); %smooth(21vyv, 33G.vyv, 33G);
smooth(33G, 33G.vyv, 21vyv);
VyV(31,1,33H);
drawnormalthree(31, 31vyv, 33H.vyv);
drawnormalCA(33H.vyv, 33H);
smoothtwo(31, 31vyv, 33H.vyv, 33H);
VyV(41,1,33I);
drawnormalthree(41, 41vyv, 33I.vyv);
drawnormalCA(33I.vyv, 33I);
smoothtwo(41, 41vyv, 33I.vyv, 33I);
VyV(51,2,33J);
drawnormalthree(51, 51vyv, 33J.vyv);
drawnormalCA(33J.vyv, 33J);
smooth(51, 51vyv, 33J.vyv); smooth(51vyv, 33J.vyv, 33J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Controls
z33M=1/4[z33tl,z33tr];
z33N=3/4[z33tl,z33tr];

z35=(x31,lyc5); z45=(x41,lyc5);
label.top(btex \threelines{Mathematical}{Model of Fluid}{Dynamics} etex, z35);
label.top(btex \twolines{Computing}{Implementation} etex, z45);
VhV(33M,35);
drawnormalthree(35, 35vhv, 33M.vhv);
drawnormalCA(33M.vhv, 33M);
smoothtwo(35, 35vhv, 33M.vhv, 33M);
VhV(33N,45);
drawnormalthree(45, 45vhv, 33N.vhv);
drawnormalCA(33N.vhv, 33N);
smoothtwo(45, 45vhv, 33N.vhv, 33N);

endfig;  % end fig 1



beginfig(2)              % IDEF A1+  model

%%%%drawgrid;

numeric lb[];
numeric hb;                 % length & height of boxes
lb1 := namespace(btex Acquire and etex)(nextra);
lb2 := namespace(btex Computational etex)(nextra);
lb3 := namespace(btex Flow Field etex)(nextra);
lb4 := namespace(btex Engineering etex)(nextra);
lb5 := namespace(btex Modification to etex)(nextra);
lb6 := lb5;
hb := 4onelineh;

numeric hspace[];
hspace1 := namespace(btex Geometry (ISO 10303-203, or other source) etc etex)(ndextra);

numeric upshift;                % vertical distance between rows
upshift = 12u;
numeric sideshift;              % horizontal distance between boxes
sideshift = 10u;

numeric lyc[];
lyc1 := 0;
lyc2 := lyc1+1/2upshift;
lyc3 := lyc2+upshift;
lyc4 := lyc3+1/2upshift+hb;
lyc5 := lyc4+1/2upshift+hb;
lyc6 := lyc5+1/2upshift+hb;
lyc7 := lyc6 + 1/2upshift + hb;
lyc8 := lyc7 + 1/2upshift;
lyc9 := lyc8 + 1/2upshift;
lyc10 := lyc9+upshift;
lyc11 := lyc10+upshift;

numeric cx[];
cx1 := 0;
cx2 := cx1+sideshift;
cx3 := cx2+sideshift;
%%cx4 := cx3+sideshift;
cx5 := cx3 + 5/4sideshift + lb1;
%%cx6 := cx5+sideshift;
cx7 := cx5+sideshift+lb2;
%%cx8 := cx7+sideshift;
cx9 := cx7 + 3/4sideshift + lb3;
%%cx10 := cx9+sideshift;
cx11 := cx9 + 3/4sideshift + lb4;
cx12 := cx11+sideshift;

%%%%%%%%%%%%%%%%%%%% A1 box
z36=(cx3,lyc6);
drawENT(36, lb1, hb)(btex \threelines{Acquire and}{Modify}{Geometry} etex);
label.ulft(btex A1 etex, z36br);
%%dotlabel.urt("z36", z36);

%%%%%%%%%%%%%%%%%%%% A2 box
z55=(cx5,lyc5);
drawENT(55, lb2, hb)(btex \threelines{Build}{Computational}{Model (Grid)} etex);
label.ulft(btex A2 etex, z55br);
%%dotlabel.urt("z55", z55);

%%%%%%%%%%%%%%%%%%%% A3 box
z74=(cx7,lyc4);
drawENT(74, lb3, hb)(btex \twolines{Compute}{Flowfield} etex);
label.ulft(btex A3 etex, z74br);
%%dotlabel.urt("z74", z74);

%%%%%%%%%%%%%%%%%%%% A4 box
z93=(cx9,lyc3);
drawENT(93, lb4, hb)(btex \threelines{Extract}{Engineering}{Data} etex);
label.ulft(btex A4 etex, z93br);
%%dotlabel.urt("z93", z93);

%%%%%%%%%%%%%%%%%%%% A5 box
z116=(cx11,lyc6);
drawENT(116, lb5, hb)(btex \fourlines{Adaptive}{Modification to}{Model and}{Process} etex);
label.ulft(btex A5 etex, z116br);
%%dotlabel.urt("z116", z116);

%%%%%%%%%%%%%%%%%%%% A6 box
z114=(cx11+1/2sideshift,lyc4);
drawENT(114, lb6, hb)(btex \twolines{Optimize}{Geometry} etex);
label.ulft(btex A6 etex, z114br);
%%dotlabel.urt("z114", z114);

%%%%%%%%%% Computing Implementation CONTROL

z36A=z36tm; z55A=z55tm; z74A=1/4[z74tl,z74tr]; z93A=z93tm; z116A=z116tm;
x114A=1/2[x116br,x114br]; y114A=y114tr;

x38=x36A; x58=x55A; x78=x74A; x98=x93A; x1168=x116A; x1148=x114A;
y38=y58=y78=y98=y1168=y1148=lyc8;

drawnormal(38,1148);
drawnormalCA(38,36A);
drawnormalCA(58,55A);
drawnormalCA(78,74A);
drawnormalCA(98,93A);
drawnormalCA(1168,116A);
drawnormalCA(1148,114A);
%%dotlabel.lft("z38", z38);
%%dotlabel.rt("z1148", z1148);
smooth(36A, 38, 58);
smooth(55A, 58, 78);
smooth(58, 78, 74A);
smooth(78, 98, 93A);
smooth(98, 1168, 116A);
smooth(1168, 1148, 114A);

z55B=3/4[z55tl,z55tr];
z59=(x55B,lyc9); z58B=(x55B,lyc8);
drawnormal(59,58B);
label.top(btex \twolines{Computing}{Implementation} etex, z59);
smooth(59, 58B, 58);
smooth(59, 58B, 78);

drawnormal(1168,58);

%%%%%%%%%%%%%%%%% Math Model CONTROL

z74B=3/4[z74tl,z74tr];
z79=(x74B,lyc9);

drawnormalCA(79,74B);
label.top(btex \twolines{Mathematical Model}{of Fluid Dynamics} etex, z79);


%%%%%%%%%%%%%%%%%%%% Support Infrastructure RESOURCE

z93F=4/5[z93bl,z93br];
z74F=4/5[z74bl,z74br];
z55F=4/5[z55bl,z55br];
z36F=4/5[z36bl,z36br];
x92F=x93F; x72F=x74F; x52F=x55F; x32F=x36F;
y92F=y72F=y52F=y32F=lyc2;

drawnormal(32F,92F);

x82F=1/2[x74br,x93bl];
y82F=y92F;
z81F=(x82F,lyc1);
drawnormal(81F,82F);
label.bot(btex \twolines{Support}{Infrastructure} etex, z81F);

drawnormalCA(92F,93F);
drawnormalCA(72F,74F);
drawnormalCA(52F,55F);
drawnormalCA(32F,36F);
smooth(93F, 92F, 72F);
smooth(92F, 72F, 74F);
smooth(72F, 52F, 55F);
smooth(52F, 32F, 36F);

smooth(81F, 82F, 92F);
smooth(81F, 82F, 72F);

drawnormal(52F,72F);

%%%%%%%%%%%%%%%%%%%%%%% Practices RESOURCE

z93E=3/5[z93bl,z93br];
z74E=3/5[z74bl,z74br];
z55E=3/5[z55bl,z55br];
z36E=3/5[z36bl,z36br];
x92E=x93E; x72E=x74E; x52E=x55E; x32E=x36E;
y92E=y72E=y52E=y32E=1/4[lyc2,lyc3];

drawnormal(32E,92E);

x62E=1/2[x55br,x74bl];
y62E=y92E;
z61E=(x62E,lyc1);
drawnormal(61E,62E);
label.bot(btex \twolines{Organizational}{Best Practices} etex, z61E);

drawnormalCA(92E,93E);
drawnormalCA(72E,74E);
drawnormalCA(52E,55E);
drawnormalCA(32E,36E);
smoothtwo(61E, 62E, 92E, 93E);
smoothtwo(61E, 62E, 32E, 36E);
smooth(62E, 72E, 74E);
smooth(62E, 52E, 55E);

%%%%%%%%%%%%%%%%%%%%%%% Computing Assets RESOURCE

z93D=2/5[z93bl,z93br];
z74D=2/5[z74bl,z74br];
z55D=2/5[z55bl,z55br];
z36D=2/5[z36bl,z36br];
x92D=x93D; x72D=x74D; x52D=x55D; x32D=x36D;
y92D=y72D=y52D=y32D=2/4[lyc2,lyc3];

drawnormal(32D,92D);

x42D=1/2[x36br,x55bl];
y42D=y92D;
z41D=(x42D,lyc1);
drawnormal(41D,42D);
label.bot(btex \twolines{Computing}{Assets} etex, z41D);

drawnormalCA(92D,93D);
drawnormalCA(72D,74D);
drawnormalCA(52D,55D);
drawnormalCA(32D,36D);

smoothtwo(41D, 42D, 92D, 93D);
smoothtwo(41D, 42D, 32D, 36D);
smooth(42D, 72D, 74D);
smooth(42D, 52D, 55D);


%%%%%%%%%%%%%%%%%%%%%%% Staff RESOURCE

z93C=1/5[z93bl,z93br];
z74C=1/5[z74bl,z74br];
z55C=1/5[z55bl,z55br];
z36C=1/5[z36bl,z36br];
x92C=x93C; x72C=x74C; x52C=x55C; x32C=x36C;
y92C=y72C=y52C=y32C=3/4[lyc2,lyc3];

drawnormal(32C,92C);

x42C=1/2[x36br,x55bl];
y42C=y92C;
z41C=(x62C,lyc1);
z31C=(x36C,lyc1);
drawnormal(31C,32C);
label.bot(btex \twolines{Trained}{Staff} etex, z31C);

drawnormalCA(92C,93C);
drawnormalCA(72C,74C);
drawnormalCA(52C,55C);
drawnormalCA(32C,36C);

smooth(93C, 92C, 72C);
smooth(74C, 72C, 52C);
smooth(55C, 52C, 32C);
smooth(31C, 32C, 52C);

drawnormal(72C,32C);
drawnormal(31C,32C);

%%%%%%%%%%%%%%%%% Geometry INPUT

x36G=x36; y36G=2/3[y36bl, y36tl];
z16G=(cx1, y36G);
drawnormalCA(16G, 36G);
label.ulft(btex Geometry etex, z36G);

%%%%%%%%%%%%%%%%%% Optimized Geometry OUTPUT

x114P=x114br; y114P=1/3[y114br,y114tr];
z124P=(x114P+sideshift, y114P);
drawnormalCA(114P,124P);
label.lrt(btex \twolines{Optimized}{Geometry} etex, z114P);

%%%%%%%%%%%%%%%%%%%%  A6 -> A2

x114L=x114br; y114L=2/3[y114br,y114tr];
z124L=(x114L+sideshift, y114L);
drawnormal(114L,124L);

x55H=x55bl; y55H=4/6[y55bl,y55tl];
x45H=2/4[x36br,x55H]; y45H=y55H;
drawnormalCA(45H,55H);

y97A=2/3[y116tl,lyc8];
VyV(45H, 97A, 124L);
drawnormalfour(45H, 45H.vyv, 124L.vyv, 124L);
smoothtwo(114L, 124L, 124L.vyv, 45H.vyv);
smoothtwo(124L.vyv, 45H.vyv, 45H, 55H);

%%%%%%%%%%%%%%%%%%%%%%%% A1 -> A2

x36M=x36br; y36M=y36mr;
x55I=x55bl; y55I=3/6[y55bl,y55tl];
x45I=1/4[x36M,x55I];
HxH(36M, 45I, 55I);
drawnormalthree(36M, 36M.hxh, 55I.hxh);
drawnormalCA(55I.hxh, 55I);
smoothtwo(36M, 36M.hxh, 55I.hxh, 55I);

%%%%%%%%%%%%%%%%%%%%%%% A2 -> A3

x55M=x55br; y55M=y55mr;
x74H=x74bl; y74H=3/5[y74bl,y74tl];
x64H=1/3[x55M,x74H];
HxH(55M, 64H, 74H);
drawnormalthree(55M, 55M.hxh, 74H.hxh);
drawnormalCA(74H.hxh, 74H);
smoothtwo(55M, 55M.hxh, 74H.hxh, 74H);


%%%%%%%%%%%%%%%%%%%%%% A3 -> A4

x74N=x74br; y74N=1/3[y74br,y74tr];
x93G=x93bl; y93G=3/4[y93bl,y93tl];
x83G=1/2[x74N,x93G];
HxH(74N, 83G, 93G);
drawnormalthree(74N, 74N.hxh, 93G.hxh);
drawnormalCA(93G.hxh,93G);
smoothtwo(74N, 74N.hxh, 93G.hxh, 93G);

%%%%%%%%%%%%%%%%%%%%%% A4 -> A5

x93L=x93br; y93L=4/5[y93br,y93tr];
x116H=x116bl; y116H=1/3[y116bl,y116tl];
x106H=1/3[x93L,x116H];
HxH(93L, 106H, 116H);
drawnormalthree(93L, 93L.hxh, 116H.hxh);
drawnormalCA(116H.hxh, 116H);
smoothtwo(93L, 93L.hxh, 116H.hxh, 116H);

%%%%%%%%%%%%%%%%%%%%%%% A4 -> A6

x93M=x93br; y93M=3/5[y93br,y93tr];
x114H=x114bl; y114H=1/2[y114bl,y114tl];
x104H=1/2[x93M,x114H];
HxH(93M, 104H, 114H);
drawnormalthree(93M, 93M.hxh, 114H.hxh);
drawnormalCA(114H.hxh, 114H);
smoothtwo(93M, 93M.hxh, 114H.hxh, 114H);

%%%%%%%%%%%%%%%%%%%%%% A3 -> A5

x74M=x74br; y74M=2/3[y74br,y74tr];
x116J=x116bl; y116J=2/3[y116bl,y116tl];
x106J=2/3[x74N,x116J];
HxH(74M, 106J, 116J);
drawnormalthree(74M, 74M.hxh, 116J.hxh);
drawnormalCA(116J.hxh,116J);
smoothtwo(74M, 74M.hxh, 116J.hxh, 116J);

%%%%%%%%%%%%%%%%%%%%  A5 -> A2

x116N=x116br; y116N=1/3[y116br,y116tr];
x126N=2/3[x114L,x124L]; y126N=y116N;
drawnormal(116N,126N);

x55G=x55bl; y55G=5/6[y55bl,y55tl];
x45G=3/4[x36br,x55G]; y45G=y55G;
drawnormalCA(45G,55G);

y97B=2/3[y116tl,y97A];
VyV(45G, 97B, 126N);
drawnormalfour(45G, 45G.vyv, 126N.vyv, 126N);
smoothtwo(116N, 126N, 126N.vyv, 45G.vyv);
smoothtwo(126N.vyv, 45G.vyv, 45G, 55G);

%%%%%%%%%%%%%%%%%%%%  A5 -> A3

x116M=x116br; y116M=2/3[y116br,y116tr];
x126M=1/3[x114L,x124L]; y126M=y116M;
drawnormal(116M,126M);

x74G=x74bl; y74G=4/5[y74bl,y74tl];
x64G=2/3[x55br,x74G]; y64G=y74G;
drawnormalCA(64G,74G);

y97C=1/3[y116tl,y97A];
VyV(64G, 97C, 126M);
drawnormalfour(64G, 64G.vyv, 126M.vyv, 126M);
smoothtwo(116M, 126M, 126M.vyv, 64G.vyv);
smoothtwo(126M.vyv, 64G.vyv, 64G, 74G);


%%%%%%%%%%%%%%%%%%%%%% Analysis Objectives INPUT

x36J=x36bl; y36J=1/3[y36bl, y36tl];  
x93I=x93bl; y93I=2/4[y93bl, y93tl];
x25=cx2; y25=1/2[y55,y36];
z15=(cx1,y25);
label.ulft(btex \twolines{Analysis}{Objectives} etex, z25);
HxH(36J, 25, 93I);
drawnormalCA(36J.hxh, 36J);        % to A1
drawnormalCA(93I.hxh, 93I);        % to A4
drawnormal(15,25);
drawnormal(36J.hxh,93I.hxh);
smoothtwo(15, 25, 36J.hxh, 36J);
smoothtwo(15, 25, 93I.hxh, 93I);

x55J=x55bl; y55J=2/6[y55bl,y55tl];  % to A2
z25J=(x25,y55J);
drawnormalCA(25J,55J);
smooth(25, 25J, 55J);

x74J=x74bl; y74J=2/5[y74bl,y74tl];  % to A3
z24J=(x25,y74J);
drawnormalCA(24J,74J);
smooth(25, 24J, 74J);

%%%%%%%%%%%%%%%%%%%%%% Flow Physics INPUT


x55K=x55bl; y55K=1/6[y55bl,y55tl];      % to A2
x93J=x93bl; y93J=1/4[y93bl, y93tl];     % to A4
x25B=1/3[cx2,cx3]; y25B=1/2[y93,y74];
z15B=(cx1,y25B);
z25C=(x25,y25B);
label.ulft(btex \threelines{Definition of}{Expected Flow}{Physics} etex, z25C);
HxH(55K, 25B, 93J);
drawnormalCA(55K.hxh, 55K);        % to A2
drawnormalCA(93J.hxh, 93J);        % to A4
drawnormal(15B,25B);
drawnormal(55K.hxh, 93J.hxh);
smoothtwo(15B, 25B, 55K.hxh, 55K);
smoothtwo(15B, 25B, 93J.hxh, 93J);

x74K=x74bl; y74K=1/5[y74bl,y74tl];  % to A3
z24K=(x25B,y74K);
drawnormalCA(24K,74K);
smooth(25B, 24K, 74K);

%%%%%%%%%%%%%%%%%%%%%% Flowfield & Customer OUTPUT

x93N=x93br; y93N=2/5[y93br,y93tr];
z103N=(x114, y93N);
drawnormalCA(93N,103N);
label.urt(btex Flowfield Data etex, z103N);

x93P=x93br; y93P=1/5[y93br,y93tr];
z103P=(x103N,y93P);
drawnormalCA(93P,103P);
label.lrt(btex \twolines{Information to}{Analysis Customer} etex, z103P);



endfig;  % end fig 2

end

