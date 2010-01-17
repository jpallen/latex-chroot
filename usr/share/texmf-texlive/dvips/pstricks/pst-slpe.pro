%%
%% This is file `pst-slpe.pro',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pst-slpe.dtx  (with options: `prolog')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% You are *not* allowed to modify this file.
%% 
%% You are *not* allowed to distribute this file.
%% For distribution of the original source see the terms
%% for copying and modification in the file pst-slpe.dtx.
%% 
/tx@PstSlopeDict 60 dict def tx@PstSlopeDict begin
/max {2 copy lt {exch} if pop} bind def
/Iterate {
  1 sub /NumSegs ED
  dup mul 3 1 roll dup mul 3 1 roll dup mul 3 1 roll
  setrgbcolor currenthsbcolor
  /ThisB ED
  /ThisS ED
  /ThisH ED
  /ThisPt ED
  gsave fill grestore
  NumSegs {
    dup mul 3 1 roll dup mul 3 1 roll dup mul 3 1 roll
    setrgbcolor currenthsbcolor
    /NextB ED
    /NextS ED
    /NextH ED
    /NextPt ED
    ThisPt NextPt sub ThisPt div NumSteps mul cvi /SegSteps exch def
    /NumSteps NumSteps SegSteps sub def
    SegSteps 0 eq not {
      ThisS 0 eq {/ThisH NextH def} if
      NextS 0 eq {/NextH ThisH def} if
      ThisH NextH sub 0.5 gt
        {/NextH NextH 1.0 add def}
        { NextH ThisH sub 0.5 ge {/ThisH ThisH 1.0 add def} if }
      ifelse
      /B ThisB def
      /S ThisS def
      /H ThisH def
      /BInc NextB ThisB sub SegSteps div def
      /SInc NextS ThisS sub SegSteps div def
      /HInc NextH ThisH sub SegSteps div def
      SegSteps {
        H dup 1. gt {1. sub} if S B sethsbcolor
        currentrgbcolor
        sqrt 3 1 roll sqrt 3 1 roll sqrt 3 1 roll
        setrgbcolor
        DrawStep
        /H H HInc add def
        /S S SInc add def
        /B B BInc add def
      } bind repeat
      /ThisH NextH def
      /ThisS NextS def
      /ThisB NextB def
      /ThisPt NextPt def
    } if
  } bind repeat
} def
/PatchRadius {
  Radius 0 eq {
    /UpdRR { dup mul exch dup mul add RR max /RR ED } bind def
    gsave
    flattenpath
    /RR 0 def
    {UpdRR} {UpdRR} {} {} pathforall
    grestore
    /Radius RR sqrt def
  } if
} def
/SlopesFill {
  gsave
  180 add rotate
  /NumSteps ED
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  /XInc w NumSteps div def
  /DrawStep {
    0 0 XInc h rectfill
    XInc 0 translate
  } bind def
  Iterate
  grestore
} def
/CcSlopesFill {
  gsave
  /Radius ED
  /CenterY ED
  /CenterX ED
  /NumSteps ED
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  w CenterX mul h CenterY mul translate
  PatchRadius
  /RadPerStep Radius NumSteps div neg def
  /Rad Radius def
  /DrawStep {
    0 0 Rad 0 360 arc
    closepath fill
    /Rad Rad RadPerStep add def
  } bind def
  Iterate
  grestore
} def
/RadSlopesFill {
  gsave
  rotate
  /Radius ED
  /CenterY ED
  /CenterX ED
  /NumSteps ED
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  w CenterX mul h CenterY mul translate
  PatchRadius
  /AngleIncrement 360 NumSteps div neg def
  /dY AngleIncrement sin AngleIncrement cos div Radius mul def
  /DrawStep {
    0 0 moveto
    Radius 0 rlineto
    0 dY rlineto
    closepath fill
    AngleIncrement rotate
  } bind def
  Iterate
  grestore
} def
end

