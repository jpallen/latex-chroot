%!
% Aurora: Colour Separation for Level 1 PostScript.
% Copyright: Graham Freeman, 1994.
%  gfreeman@cs.adfa.oz.au
% All Rights Reserved.
% This program may not be used for commercial purposes without
%  the consent of the author.  It may be freely transmitted 
%  provided this authorship and copyright notice is retained 
%  unmodified.
   systemdict /setpacking known 
      {/SavePacking currentpacking def true setpacking}if
/_c+stat 29 dict def
_c+stat begin
/Colour [0 0 0 1] def
/RGB [0 0 0] def
/AllColour [1 1 1 1] def
/setcolour {this type /arraytype eq
   {true 0 1 3 {dup Colour exch get AllColour 3 -1 roll get eq and 
    dup not {exit}if} for  % Is current colour == 1,1,1,1 ?
      {1}
      {0 0 1 3{this exch get dup mul add}for 
       0 0 1 3{Colour exch get dup mul add}for 
       0 0 1 3{dup Colour exch get this 3 -1 roll get mul add}for
       3 copy 3 1 roll mul sqrt dup 0 gt 
        {div 0.98 lt 
          {3{pop}repeat 0}
          {exch pop exch div dup 1 gt {pop 1}if} ifelse}
        {5{pop}repeat 0} ifelse
       }ifelse }
   {Colour this get}ifelse 
   1 exch sub setgray} bind def
/this 3 def
/transfer [{} dup dup dup] def
/screen [4 {currentscreen 3 array astore}repeat ] def    
% {dup mul exch dup mul add 1 exch sub}
/blackgenerate {1 exch sub dup .25 gt {pop 0}{4 mul 1 exch sub}ifelse} def
/undercolourremove {pop 0} def
/bound {dup 0 lt{pop 0}if dup 1 gt{pop 1}if} def
/_c+image [/image load dup type /operatortype ne {/exec cvx}if] cvx def
/I 0 def
/J 0 def
/mask 255 def
/nbit 8 def
/buffer 1 string def
/gsavestack 31 array def
/gsavepointer -1 def
/bitandchpos {I nbit mul dup 8 mod nbit add 8 exch sub  exch 8 idiv}def
/storebitval {
   mask and bitandchpos  % val bitpos chpos
   buffer 1 index get mask 3 index bitshift not and  %val bitpos chpos otherbits
   4 -2 roll bitshift or buffer 3 1 roll put }def
/buffercheck {dup length buffer length gt
   {dup length string /buffer exch def}if }def
/cmyk2blackvalue {
   this 1 eq {4 -1 roll} if  
   this 2 eq {4 -2 roll} if
   this 3 eq {4 1 roll} if
   pop pop pop} def
/compl {
   dup type dup /integertype eq exch /booleantype eq or {not}{
   dup type /stringtype eq {dup dup length 1 sub 0 1 3 -1 roll 
      {/J exch def dup J get not 255 and J exch put dup}for pop }if 
   }ifelse  }def
/rgb2cmyk {3 {1 exch sub 3 1 roll}repeat 
   min3 dup undercolourremove exch blackgenerate 5 1 roll
   3{dup 3 1 roll sub bound 5 1 roll}repeat pop} def
/max3 {2 index 2 index lt{1 index}{2 index}ifelse dup 2 index lt{pop dup}if} def
/min3 {2 index 2 index lt{2 index}{1 index}ifelse dup 2 index gt{pop dup}if} def
/hsb2rgb {3 -1 roll 6 mul dup 6 eq {pop 0}if dup floor cvi
   2 index 4 index 1 exch sub mul exch dup 2 mod 0 eq 
   {dup 4 -1 roll sub 1 add 5 -1 roll mul 1 exch sub 3 index mul 3 1 roll
      dup 0 eq{pop}{2 eq {3 1 roll}{3 -1 roll}ifelse}ifelse }
   {dup 4 -1 roll exch sub 5 -1 roll mul 1 exch sub 3 index mul exch
      dup 1 eq{pop 3 1 roll}{3 eq {3 -1 roll}if}ifelse }
   ifelse} def
/rgb2hsb {max3 4 1 roll min3 4 index exch sub 
   dup 5 index 0 eq {pop 0}{5 index div}ifelse 6 1 roll  dup 0 eq 
   {6 1 roll pop pop pop}
   {3 index 1 index eq {2 index 2 index sub exch div}
      {2 index 1 index eq {1 index 4 index sub exch div 2 add}
         {3 index 3 index sub exch div 4 add}ifelse}ifelse}
   ifelse  6 div 6 1 roll pop pop pop} def
/saveproc {_c+stat begin 
   /gsavepointer gsavepointer 1 add def 
   gsavepointer gsavestack length ge 
    {/gsavestack gsavestack gsavepointer 2 mul array dup 3 1 roll copy pop def}
    if    gsavestack gsavepointer get
   type /arraytype ne {gsavestack gsavepointer 7 array dup 0 4 array put
   dup 1 3 array put dup 2 4 array put dup 3 4 array put put} if 
   gsavestack gsavepointer get 
   dup 0 get Colour exch copy pop  dup 1 get RGB exch copy pop 
   dup 2 get screen exch copy pop  dup 3 get transfer exch copy pop
   dup 4 /undercolourremove load put  dup 5 /blackgenerate load put
   6 false put  end } def
end

/currentgray {_c+stat /Colour get aload pop
      4 1 roll .11 mul 4 1 roll .59 mul 4 1 roll .3 mul add add add
      1 exch sub dup 0 lt {pop 0}if} bind def
/currentcmykcolor {_c+stat /Colour get aload pop} bind def
/setcmykcolor {_c+stat begin Colour astore 
   aload pop 4 1 roll 3{3 index add dup 1 gt{pop 1}if 1 exch sub 3 1 roll}repeat
   4 -1 roll pop RGB astore pop  setcolour end} bind def
/setrgbcolor {_c+stat begin 3{2 index}repeat RGB astore pop 
   rgb2cmyk Colour astore pop setcolour end} def
/currentrgbcolor {_c+stat /RGB get aload pop} bind def
/sethsbcolor {_c+stat begin hsb2rgb setrgbcolor end} def
/currenthsbcolor {_c+stat begin RGB aload pop rgb2hsb end} def
/setcolorscreen {_c+stat begin 3 -1 0{screen exch get astore pop}for 
   this type /arraytype ne 
   {screen this get aload pop setscreen}if end} bind def
/currentcolorscreen {_c+stat begin 0 1 3 {screen exch get aload pop}for end} 
   bind def
/setcolortransfer [{_c+stat begin transfer astore pop this type /arraytype ne}
   /exec load
   [{transfer this get} /exec load 
      /settransfer load dup type /operatortype ne {/exec cvx}if] cvx 
   /if load /end load] 
   cvx def
/settransfer [{ _c+stat begin 0 1 3 {transfer exch 2 index put}for end} 
   /exec load 
   [ /settransfer load dup type /operatortype ne {/exec cvx}if ] cvx 
   /exec load ] cvx   def
/currentcolortransfer {_c+stat /transfer get aload pop} bind def
/setblackgeneration {_c+stat /blackgenerate 3 -1 roll put} bind def
/currentblackgeneration {_c+stat /blackgenerate get} bind def
/setundercolorremoval {_c+stat /undercolourremove 3 -1 roll put} bind def
/currentundercolorremoval {_c+stat /undercolourremove get} bind def
/colorimage {_c+stat begin dup 1 eq 
                                             % 1
   {pop pop this type /arraytype eq
      {(Compound colour cannot be handled with "colorimage"\n)print stop}if 
      this 3 ne 
      {4 array dup 0 4 -1 roll put dup 1 /exec load put dup
         2 {_c+stat begin buffercheck dup length 1 sub 0 1 3 -1 roll
            {buffer exch 255 put}for length buffer exch 0 exch getinterval end} 
         bind put 
         dup 3 /exec load put cvx} if
   }{3 eq
                                             % 3
   {{this type /arraytype eq                 % true 3
      {(Compound colour cannot be handled with "colorimage"\n)print stop}if 
      4 index 8 ne                                    % not 8 bits
      {4 index {dup 1 eq {exit}if dup 2 mod 0 ne 
          {(Only 1,2,4 or 8-bit images can be handled\n)print stop}if 2 idiv}
        loop pop
       4 index 1 sub 1 exch {1 bitshift 1 or}repeat _c+stat /mask 3 -1 roll put
       4 index _c+stat /nbit 3 -1 roll put
       8 array dup 
       2 -1 0 {2 mul dup 2 index exch 6 -1 roll put 1 add /exec load put dup}for
       6 {_c+stat begin buffercheck 0 1 2 index length 8 mul nbit idiv 1 sub 
          {/I exch def I nbit mul dup 8 mod nbit add 8 sub exch 8 idiv 
           3{4 index 1 index get 2 index bitshift mask and mask div 3 1 roll}
           repeat                                          % RGB values found
           pop pop rgb2cmyk cmyk2blackvalue mask mul round cvi not mask and
           storebitval}for 
          pop pop pop buffer 0 I 1 add nbit mul 8 idiv getinterval end} bind put
       dup 7 /exec load put cvx}
      {8 array dup                                    % 8 bits
       2 -1 0 {2 mul dup 2 index exch 6 -1 roll put 1 add /exec load put dup}for
       6 {_c+stat begin buffercheck 0 1 2 index length 1 sub 
         {/I exch def 3{2 index I get 255 div}repeat 
          rgb2cmyk  cmyk2blackvalue 255 mul round cvi not 255 and
          buffer I 3 -1 roll put}for 
         pop pop pop buffer 0 I 1 add getinterval end} bind put 
      dup 7 /exec load put cvx}ifelse}
                                             % false 3
    {this type /arraytype eq
      {(Compound colour cannot be handled with "colorimage"\n)print stop}if 
      2 index 8 ne                                    % not 8 bits
      {2 index {dup 1 eq {exit}if dup 2 mod 0 ne 
          {(Only 1,2,4 or 8-bit images can be handled\n)print stop}if 2 idiv}
        loop pop
       2 index 1 sub 1 exch {1 bitshift 1 or}repeat _c+stat /mask 3 -1 roll put
       2 index _c+stat /nbit 3 -1 roll put
       4 array dup 0 4 -1 roll put dup 1 /exec load put dup
       2 {_c+stat begin buffercheck dup length 8 mul nbit idiv 3 idiv  /I 0 def 
          {dup 0 1 2{I 3 mul add nbit mul dup 8 mod nbit add 8 sub 
           exch 8 idiv 2 index exch get exch bitshift mask and mask div exch}for 
                                                           % RGB values found
           pop rgb2cmyk cmyk2blackvalue mask mul round cvi not mask and storebitval 
           /I I 1 add def}repeat 
          pop buffer 0 I nbit mul 8 idiv getinterval end} bind put 
       dup 3 /exec load put cvx}
      {4 array dup 0 4 -1 roll put dup 1 /exec load put dup  % 8 bits
       2 {_c+stat begin buffercheck dup length 3 idiv  /I 0 def /J 0 def
         {dup J get 255 div 1 index J 1 add get 255 div 
          2 index J 2 add get 255 div rgb2cmyk cmyk2blackvalue 255 mul round cvi
          not 255 and buffer I 3 -1 roll put    /I I 1 add def /J J 3 add def}repeat
         pop buffer 0 I getinterval end} 
       bind put dup 3 /exec load put cvx}ifelse}ifelse}
                                             % 4
   {{this type /arraytype eq                 % true 4
      {(Compound colour cannot be handled with "colorimage"\n)print stop}if 
       5 index {dup 1 eq {exit}if dup 2 mod 0 ne 
          {(Only 1,2,4 or 8-bit images can be handled\n)print stop}if 2 idiv}
        loop pop
       10 array dup 0 7 -1 roll put dup 1 /exec load put
       dup 2 6 -1 roll put dup 3 /exec load put dup 4 5 -1 roll put
       dup 5 /exec load put dup 6 4 -1 roll put dup 7 /exec load put
       dup 8 {_c+stat begin cmyk2blackvalue buffercheck buffer copy compl end} 
          bind put 
       dup 9 /exec load put cvx}
                                             % false 4
    {this type /arraytype eq 
      {(Compound colour cannot be handled with "colorimage"\n)print stop}if 
      2 index 8 ne                                    % not 8 bits
      {2 index {dup 1 eq {exit}if dup 2 mod 0 ne 
          {(Only 1,2,4 or 8-bit images can be handled\n)print stop}if 2 idiv}
        loop pop
       2 index 1 sub 1 exch {1 bitshift 1 or}repeat _c+stat /mask 3 -1 roll put
       2 index _c+stat /nbit 3 -1 roll put
       4 array dup 0 4 -1 roll put dup 1 /exec load put dup
       2 {_c+stat begin buffercheck dup length 8 mul nbit idiv 4 idiv  /I 0 def 
          {dup 0 1 3{I 4 mul add nbit mul dup 8 mod nbit add 8 sub 
           exch 8 idiv 2 index exch get exch bitshift mask and exch}for 
          pop cmyk2blackvalue not  storebitval    /I I 1 add def}repeat
          pop buffer 0 I nbit mul 8 idiv getinterval end} bind put 
       dup 3 /exec load put cvx}
      {4 array dup 0 4 -1 roll put dup 1 /exec load put dup  % 8 bits
       2 {_c+stat begin buffercheck dup length 4 idiv  /I this def /J 0 def
         {dup I get not 255 and buffer J 3 -1 roll put /I I 4 add def /J J 1 add def}repeat
         pop buffer 0 J getinterval end} bind put 
       dup 3 /exec load put cvx}ifelse}
    ifelse}ifelse}ifelse           
   end _c+stat /_c+image get exec} def
/setgray {_c+stat begin dup dup dup RGB astore pop
   1 exch sub 0 0 0 4 -1 roll Colour astore pop setcolour    end} bind def
/image [{_c+stat begin 
   this type /arraytype eq
    %  {(Compound colour cannot be handled with "image"\n)print stop}if 
   this 3 ne   or
   { 4 array dup 0 4 -1 roll put dup 1 /exec load put dup
      2 {_c+stat begin buffercheck dup length 1 sub 0 1 3 -1 roll
         {buffer exch 255 put}for length buffer exch 0 exch getinterval end} bind put 
      dup 3 /exec load put cvx} if 
   end} /exec load /image load dup type /operatortype ne {/exec cvx}if] cvx def
/gsave [_c+stat /saveproc get  /exec load
   /gsave load dup type /operatortype ne {/exec load}if ] cvx def
/grestore [/grestore load dup type /operatortype ne {/exec cvx}if
   {_c+stat begin   gsavepointer 0 ge 
         dup {gsavestack gsavepointer get 6 get and}if
      {gsavestack gsavepointer get
      dup 0 get Colour copy pop  dup 1 get RGB copy pop  
      dup 2 get screen copy pop  dup 3 get transfer copy pop  
      dup 4 get /undercolourremove exch def  5 get /blackgenerate exch def
      /gsavepointer gsavepointer 1 sub def} if  end} 
   /exec load   ] cvx def
/grestoreall [/grestoreall load dup type /operatortype ne {/exec cvx}if
   {_c+stat begin   gsavepointer -1 0 
      {/gsavepointer exch def gsavestack gsavepointer get 6 get {exit}if}for
      gsavepointer 0 ge 
      { gsavestack gsavepointer get      dup 0 get Colour copy pop  
         dup 1 get RGB copy pop  dup 2 get screen copy pop
         dup 3 get transfer copy pop  dup 4 get /undercolourremove exch def
         dup 5 get /blackgenerate exch def  
         6 get not {/gsavepointer -1 def}if  } if
    end} 
   /exec load   ] cvx def
/save [_c+stat /saveproc get   /exec load
   {_c+stat begin gsavestack gsavepointer get 6 true put end} /exec load
   /save load dup type /operatortype ne {/exec cvx}if] cvx def
/restore [/restore load dup type /operatortype ne {/exec cvx}if 
   {_c+stat begin   gsavepointer 0 ge 
      {gsavestack gsavepointer get
      dup 0 get Colour copy pop  dup 1 get RGB copy pop  
      dup 2 get screen copy pop  dup 3 get transfer copy pop  
      dup 4 get /undercolourremove exch def  5 get /blackgenerate exch def
      /gsavepointer gsavepointer 1 sub def} if  end} /exec load
   ]cvx def
/initgraphics [/initgraphics load dup type /operatortype ne {/exec cvx}if
   {0 setgray} /exec load   ] cvx def

systemdict /setpacking known {SavePacking setpacking}if
% End of Aurora: colour separation prelude
