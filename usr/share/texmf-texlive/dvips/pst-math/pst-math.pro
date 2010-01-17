%!
%                           -*- Mode: Postscript -*-
% pst-math.pro --- PostScript header file pst-math.pro
%
% Author          : Christophe JORSSEN <christophe.jorssen@libre.fr.invalid>
%                   ('libre' is the french word for 'free' if you want to contact me ;-))
% Created the     : Sat 20 March 2004
% Last Mod        : $Date: 2004/05/08 13:40:15 $
% Version         : 1.0 $Revision: 1.1 $
%
/PI 3.14159265359 def
/ENeperian 2.71828182846 def

/DegToRad {PI mul 180 div} bind def
/RadToDeg {180 mul PI div} bind def

/COS {RadToDeg cos} bind def
/SIN {RadToDeg sin} bind def
/TAN {dup SIN exch COS Div} bind def
/tan {dup sin exch cos Div} bind def
/ATAN {neg -1 atan 180 sub DegToRad} bind def
/ACOS {dup dup mul neg 1 add sqrt exch atan DegToRad} bind def
/acos {dup dup mul neg 1 add sqrt exch atan} bind def
/ASIN {neg dup dup mul neg 1 add sqrt neg atan 180 sub DegToRad} bind def
/asin {neg dup dup mul neg 1 add sqrt neg atan 180 sub} bind def

/EXP {ENeperian exch exp} bind def

/COSH {dup EXP exch neg EXP add 2 div} bind def
/SINH {dup EXP exch neg EXP sub 2 div} bind def
/TANH {dup SINH exch COSH div} bind def
/ACOSH {dup dup mul 1 sub sqrt add ln} bind def
/ASINH {dup dup mul 1 add sqrt add ln} bind def
/ATANH {dup 1 add exch neg 1 add Div ln 2 div} bind def

/SINC {dup SIN exch Div} bind def

/GAUSS {dup mul 2 mul dup 4 -2 roll sub dup mul exch div neg EXP exch PI mul sqrt div} bind def

/GAMMALN {dup dup dup 5.5 add dup ln 3 -1 roll .5 add mul sub neg 1.000000000190015
    0 1 5 {
    [76.18009172947146 -86.50532032941677 24.0140982483091 -1.231739572450155
    .1208650973866179E-2 -.5395239384953E-5 2.5066282746310005] exch get
    4 -1 roll 1 add dup 5 1 roll div add} for
    4 -1 roll div 2.5066282746310005 mul ln add exch pop} bind def
    
/BETA {2 copy add GAMMALN neg exch GAMMALN 3 -1 roll GAMMALN EXP} bind def

/HORNER {aload length
    dup 2 add -1 roll
    exch 1 sub {
        dup 4 1 roll
        mul add exch
    } repeat
    pop
} bind def

/BESSEL_J0 {dup abs 8 lt {
    dup mul dup [57568490574 -13362590354 651619640.7 -11214424.18 77392.33017 -184.9052456] HORNER
    exch [57568490411 1029532985 9494680.718 59272.64853 267.8532712 1] HORNER
    Div}
    {abs dup .636619772 exch div sqrt exch dup .785398164 sub exch 8 exch div dup dup mul dup 
    [1 -1.098628627E-2 .2734510407E-4 -.2073370639E-5 .2093887211E-6] HORNER
    3 index COS mul
    exch [-.1562499995E-1 .1430488765E-3 -.6911147651E-5 .7621095161E-6 -.934945152E-7] HORNER
    4 -1 roll SIN mul 3 -1 roll mul neg add mul} 
    ifelse} bind def

/BESSEL_Y0 {dup 8 lt {
    dup dup mul dup [-2957821389 7062834065 -512359803.6 10879881.29 -86327.92757 228.4622733] HORNER
    exch [40076544269 745249964.8 7189466.438 47447.26470 226.1030244 1] HORNER
    Div exch dup ln exch BESSEL_J0 .636619772 mul mul add}
    {dup .636619772 exch div sqrt exch dup .785398164 sub exch 8 exch div dup dup mul dup 
    [1 -.1098628627E-2 .2734510407E-4 -.2073370639E-5 .2093887211E-6] HORNER
    3 index SIN mul
    exch [-.1562499995E-1 .1430488765E-3 -.6911147651E-5 .7621095161E-6 -.934945152E-7] HORNER
    4 -1 roll COS mul 3 -1 roll mul add mul} 
    ifelse} bind def

/BESSEL_J1 {dup abs 8 lt {
    dup dup mul dup 3 -2 roll [72362614232 -7895059235 242396853.1 -2972611.439 15704.48260 -30.16036606] HORNER mul
    exch [144725228442 2300535178 18583304.74 99447.43394 376.9991397 1] HORNER
    Div}
    {dup abs dup .636619772 exch div sqrt exch dup 2.356194491 sub exch 8 exch div dup dup mul dup 
    [1 .183105E-2 -.3516396496E-4 .2457520174E-5 -.240337019E-6] HORNER
    3 index COS mul
    exch [.04687499995 6.2002690873E-3 .8449199096E-5 -.88228987E-6 .105787412E-6] HORNER
    4 -1 roll SIN mul 3 -1 roll mul neg add mul exch dup abs Div mul} 
    ifelse} bind def

/BESSEL_Y1 {dup 8 lt {
    dup dup dup mul dup [-.4900604943E13 .1275274390E13 -.5153428139E11 .7349264551E9 -.4237922726E7 .8511937935E4] HORNER
    exch [.2499580570E14 .4244419664E12 .3733650367E10 .2245904002E8 .1020426050E6 .3549632885E3 1] HORNER
    Div mul exch dup dup ln exch BESSEL_J1 mul exch 1 exch div sub .636619772 mul add}
    {dup .636619772 exch div sqrt exch dup 2.356194491 sub exch 8 exch div dup dup mul dup 
    [1 .183105E-2 -.3516396496E-4 .2457520174E-5 -.240337019E-6] HORNER
    3 index SIN mul
    exch [.04687499995 -.2002690873E-3 .8449199096E-5 6.88228987E-6 .105787412E-6] HORNER
    4 -1 roll COS mul 3 -1 roll mul add mul} 
    ifelse} bind def

% En cours...
/BESSEL_Yn {dup 0 eq {pop BESSEL_Y0}{dup 1 eq {pop BESSEL_Y1}{
    exch dup BESSEL_Y0 exch dup BESSEL_Y1 exch 2 exch Div {
        mul 3 -1 roll mul 2 index sub pstack} for
    } ifelse } ifelse } bind def

% END pst-math.pro
