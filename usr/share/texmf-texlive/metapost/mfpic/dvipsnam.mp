%%
%% This is file `dvipsnam.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% grafbase.dtx  (with options: `dvips')
%% 
%% -------------------------------------------------------------------
%% 
%% Copyright 2002--2006, Daniel H. Luecking
%% 
%% Mfpic may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3b of this license or (at
%% your option) any later version. The latest version of this license is in
%%    <http://www.latex-project.org/lppl.txt>
%% and version 1.3b or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%% 
%% Mfpic has maintenance status "author-maintained". The Current Maintainer
%% is Daniel H. Luecking. There are several Base Interpreters associated
%% with mfpic: plain TeX, LaTeX, plain Metafont and plain MetaPost.
%% 
if unknown grafbaseversion:
  vardef snapto expr t =
    if unknown t:            0
    elseif not (numeric t):  0
    elseif t < 0:            0
    elseif t > 1:            1
    else:                    t
    fi
  enddef;
  vardef cmyk (expr c, m, y, k) =
    (snapto 1-c-k, snapto 1-m-k, snapto1-y-k)
  enddef;
fi

color Apricot, Aquamarine, Bittersweet, Black, Blue, BlueGreen,
BlueViolet, BrickRed, Brown, BurntOrange, CadetBlue, CarnationPink,
Cerulean, CornflowerBlue, Cyan, Dandelion, DarkOrchid, Emerald,
ForestGreen, Fuchsia, Goldenrod, Gray, Green, GreenYellow, JungleGreen,
Lavender, LimeGreen, Magenta, Mahogany, Maroon, Melon, MidnightBlue,
Mulberry, NavyBlue, OliveGreen, Orange, OrangeRed, Orchid, Peach,
Periwinkle, PineGreen, Plum, ProcessBlue, Purple, RawSienna, Red,
RedOrange, RedViolet, Rhodamine, RoyalBlue, RoyalPurple, RubineRed,
Salmon, SeaGreen, Sepia, SkyBlue, SpringGreen, Tan, TealBlue, Thistle,
Turquoise, Violet, VioletRed, White, WildStrawberry, Yellow,
YellowGreen, YellowOrange;

Apricot        := cmyk(0,0.32,0.52,0);
Aquamarine     := cmyk(0.82,0,0.30,0);
Bittersweet    := cmyk(0,0.75,1,0.24);
Black          := cmyk(0,0,0,1);
Blue           := cmyk(1,1,0,0);
BlueGreen      := cmyk(0.85,0,0.33,0);
BlueViolet     := cmyk(0.86,0.91,0,0.04);
BrickRed       := cmyk(0,0.89,0.94,0.28);
Brown          := cmyk(0,0.81,1,0.60);
BurntOrange    := cmyk(0,0.51,1,0);
CadetBlue      := cmyk(0.62,0.57,0.23,0);
CarnationPink  := cmyk(0,0.63,0,0);
Cerulean       := cmyk(0.94,0.11,0,0);
CornflowerBlue := cmyk(0.65,0.13,0,0);
Cyan           := cmyk(1,0,0,0);
Dandelion      := cmyk(0,0.29,0.84,0);
DarkOrchid     := cmyk(0.40,0.80,0.20,0);
Emerald        := cmyk(1,0,0.50,0);
ForestGreen    := cmyk(0.91,0,0.88,0.12);
Fuchsia        := cmyk(0.47,0.91,0,0.08);
Goldenrod      := cmyk(0,0.10,0.84,0);
Gray           := cmyk(0,0,0,0.50);
Green          := cmyk(1,0,1,0);
GreenYellow    := cmyk(0.15,0,0.69,0);
JungleGreen    := cmyk(0.99,0,0.52,0);
Lavender       := cmyk(0,0.48,0,0);
LimeGreen      := cmyk(0.50,0,1,0);
Magenta        := cmyk(0,1,0,0);
Mahogany       := cmyk(0,0.85,0.87,0.35);
Maroon         := cmyk(0,0.87,0.68,0.32);
Melon          := cmyk(0,0.46,0.50,0);
MidnightBlue   := cmyk(0.98,0.13,0,0.43);
Mulberry       := cmyk(0.34,0.90,0,0.02);
NavyBlue       := cmyk(0.94,0.54,0,0);
OliveGreen     := cmyk(0.64,0,0.95,0.40);
Orange         := cmyk(0,0.61,0.87,0);
OrangeRed      := cmyk(0,1,0.50,0);
Orchid         := cmyk(0.32,0.64,0,0);
Peach          := cmyk(0,0.50,0.70,0);
Periwinkle     := cmyk(0.57,0.55,0,0);
PineGreen      := cmyk(0.92,0,0.59,0.25);
Plum           := cmyk(0.50,1,0,0);
ProcessBlue    := cmyk(0.96,0,0,0);
Purple         := cmyk(0.45,0.86,0,0);
RawSienna      := cmyk(0,0.72,1,0.45);
Red            := cmyk(0,1,1,0);
RedOrange      := cmyk(0,0.77,0.87,0);
RedViolet      := cmyk(0.07,0.90,0,0.34);
Rhodamine      := cmyk(0,0.82,0,0);
RoyalBlue      := cmyk(1,0.50,0,0);
RoyalPurple    := cmyk(0.75,0.90,0,0);
RubineRed      := cmyk(0,1,0.13,0);
Salmon         := cmyk(0,0.53,0.38,0);
SeaGreen       := cmyk(0.69,0,0.50,0);
Sepia          := cmyk(0,0.83,1,0.70);
SkyBlue        := cmyk(0.62,0,0.12,0);
SpringGreen    := cmyk(0.26,0,0.76,0);
Tan            := cmyk(0.14,0.42,0.56,0);
TealBlue       := cmyk(0.86,0,0.34,0.02);
Thistle        := cmyk(0.12,0.59,0,0);
Turquoise      := cmyk(0.85,0,0.20,0);
Violet         := cmyk(0.79,0.88,0,0);
VioletRed      := cmyk(0,0.81,0,0);
White          := cmyk(0,0,0,0);
WildStrawberry := cmyk(0,0.96,0.39,0);
Yellow         := cmyk(0,0,1,0);
YellowGreen    := cmyk(0.44,0,0.74,0);
YellowOrange   := cmyk(0,0.42,1,0);

endinput.
%%
%% End of file `dvipsnam.mp'.
