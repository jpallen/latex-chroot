%%
%% This is file `pst-func.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-func'
%%
%% Herbert Voss <voss _at_ pstricks.de>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-func' is a PSTricks package to plot special math functions
%%
%%
%% version 0.06 / 2006-04-16  Herbert Voss <voss _at_ pstricks.de>
%
/tx@FuncDict 100 dict def
tx@FuncDict begin
%
/eps1 1.0e-05 def
/eps2 1.0e-04 def
/eps8 1.0e-08 def
/Pi2 1.57079632679489661925640 def
/CEuler 0.5772156649 def % Euler-Mascheroni constant
%
/factorial { % n on stack, returns n! 
  dup 0 eq { 1 }{ 
    dup 1 gt { dup 1 sub factorial mul } if }
  ifelse } def 
%
/MoverN { % m n on stack, returns the binomial coefficient m over n
  /n exch def /m exch def
  n 0 eq { 1 }{
    m n eq { 1 }{
      m factorial n factorial m n sub factorial mul div } ifelse } ifelse 
} def
%
/Si { % integral sin from 0 to x (arg on stack)
  /arg exch def
  /Sum arg def
  /sign -1 def
  /index 3 def
  { 
    arg index exp index div index factorial div sign mul 
    dup abs eps8 lt { pop exit } if 
    Sum add /Sum exch def
    /sign sign neg def
    /index index 2 add def
  } loop
  Sum
} def
/si { % integral sin from x to infty -> si(x)=Si(x)-pi/2
  Si Pi2 sub
} def
/Ci { % integral cosin from x to infty (arg on stack)
  abs /arg exch def
  arg 0 eq { 0 } { 
    /argExp 1 def
    /fact 1 def
    /Sum CEuler arg ln add def
    /sign -1 def
    /index 2 def
    { 
      /argExp argExp arg arg mul mul def
      /fact fact index 1 sub index mul mul def
      argExp index div fact div sign mul 
      dup abs exch Sum add /Sum exch def
      eps8 lt { exit } if
      /sign sign neg def
      /index index 2 add def
    } loop
    Sum
  } ifelse
} def
/ci { % integral cosin from x to infty -> ci(x)=-Ci(x)+ln(x)+CEuler
  dup Ci neg exch abs ln add CEuler add
} def
%
/MaxIter 255 def
/func { coeff Derivation FuncValue } def
/func' { coeff Derivation 1 add FuncValue } def
/func'' { coeff Derivation 2 add FuncValue } def
%
/NewtonMehrfach {% the start value must be on top of the stack
  /Nx exch def 
  /Iter 0 def
  {
    /Iter Iter 1 add def
    Nx func /F exch def % f(Nx)
    F abs eps2 lt { exit } if
    Nx func' /FS exch def % f'(Nx) 
    FS 0 eq { /FS 1.0e-06 def } if
    Nx func'' /F2S exch def % f''(Nx)
    1.0 1.0 F F2S mul FS dup mul div sub div /J exch def
    J F mul FS div /Diff exch def 
    /Nx Nx Diff sub def
    Diff abs eps1 lt Iter MaxIter gt or { exit } if 
  } loop 
  Nx % the returned value ist the zero point
} def

/Steffensen {% the start value must be on top of the stack
  /y0 exch def % the start value
  /Iter 0 def
  {
    y0 func /F exch def
    F abs eps2 lt { exit } if
    y0 F sub /Phi exch def
    Phi func /F2 exch def
    F2 abs eps2 le { exit }{
      Phi y0 sub dup mul Phi F2 sub 2 Phi mul sub y0 add Div /Diff exch def
      y0 Diff sub /y0 exch def
      Diff abs eps1 le { exit } if
    } ifelse
    /Iter Iter 1 add def
    Iter MaxIter gt { exit } if
  } loop
  y0 % the returned value ist the zero point
} def 
%
/Horner {% x [coeff] must be on top of the stack
  aload length
  dup 2 add -1 roll
  exch 1 sub {
    dup 4 1 roll
    mul add exch
  } repeat
  pop % the y value is on top of the stack
} def
%
/FuncValue {% x [coeff] Derivation must be on top of the stack
  {
    aload 			% a0 a1 a2 ... a(n-1) [array]
    length                      % a0 a1 a2 ... a(n-1) n
    1 sub /grad exch def        % a0 a1 a2 ... a(n-1) 
    grad -1 1 {                 % for n=grad step -1 until 1
      /n exch def               % Laufvariable speichern
      n                         % a0 a1 a2 ... a(n-1) n
      mul                       % a0 a1 a2 ... a(n-1)*n 
      grad 1 add                % a0 a1 a2 ... a(n-1)*n grad+1 
      1 roll                    % an*na0 a1 a2 ... a(n-2)
    } for
    pop                         % loesche a0
    grad array astore           % [ a1 a2 ... a(n-2)]
  } repeat
  Horner
} def
%
/FindZeros { % dxN dxZ must be on top of the stack (x0..x1 the intervall)
  /dxZ exch def /dxN exch def
  /pstZeros [] def 
  x0 dxZ x1 { % suche Nullstellen
    /xWert exch def
    xWert NewtonMehrfach 
    %xWert Steffensen 
    /xNull exch def 
    pstZeros aload length /Laenge exch def % now test if value is a new one
    Laenge 0 eq 
      { xNull 1 }
      { /newZero true def
        Laenge {
	  xNull sub abs dxN lt { /newZero false def } if
        } repeat
	pstZeros aload pop
        newZero { xNull Laenge 1 add } { Laenge } ifelse } ifelse
    array astore /pstZeros exch def
  } for
} def
%
/Simpson { % on stack must be a b M 
% /SFunc must be defined 
  /M ED /b ED /a ED
  /h b a sub M 2 mul div def
  /s1 0 def
  /s2 0 def
  1 1 M {
    /k exch def
    /x k 2 mul 1 sub h mul a add def
    /s1 s1 x SFunc add def
  } for
  1 1 M 1 sub {
    /k exch def
    /x k 2 mul h mul a add def
    /s2 s2 x SFunc add def
  } for
  /I a SFunc b SFunc add s1 4 mul add s2 2 mul add 3 div h mul def
} def

%
% subroutines for complex numbers, given as an array [a b] 
% which is a+bi = Real+i Imag
%
/cxadd {		% [a1 b1] [a2 b2] = [a1+a2 b1+b2]
  dup 0 get		% [a1 b1] [a2 b2] a2
  3 -1 roll		% [a2 b2] a2 [a1 b1]
  dup 0 get		% [a2 b2] a2 [a1 b1] a1
  3 -1 roll		% [a2 b2] [a1 b1] a1 a2
  add			% [a2 b2] [a1 b1] a1+a2
  3 1 roll		% a1+a2 [a2 b2] [a1 b1]
  1 get			% a1+a2 [a2 b2] b1
  exch 1 get		% a1+a2 b1 b2
  add 2 array astore
} def
%
/cxneg {		% [a b]
  dup 1 get		% [a b] b
  exch 0 get		% b a
  neg exch neg		% -a -b
  2 array astore
} def
%
/cxsub { cxneg cxadd } def  % same as negative addition
%
% [a1 b1][a2 b2] = [a1a2-b1b2 a1b2+b1a2] = [a3 b3]
/cxmul {		% [a1 b1] [a2 b2]
  dup 0 get		% [a1 b1] [a2 b2] a2
  exch 1 get		% [a1 b1] a2 b2
  3 -1 roll		% a2 b2 [a1 b1]
  dup 0 get		% a2 b2 [a1 b1] a1
  exch 1 get		% a2 b2 a1 b1
  dup			% a2 b2 a1 b1 b1
  5 -1 roll dup		% b2 a1 b1 b1 a2 a2
  3 1 roll mul		% b2 a1 b1 a2 b1a2
  5 -2 roll dup		% b1 a2 b1a2 b2 a1 a1
  3 -1 roll dup		% b1 a2 b1a2 a1 a1 b2 b2
  3 1 roll mul		% b1 a2 b1a2 a1 b2 a1b2
  4 -1 roll add		% b1 a2 a1 b2 b3
  4 2 roll mul		% b1 b2 b3 a1a2
  4 2 roll mul sub	% b3 a3
  exch 2 array astore
} def
%
% [a b]^2 = [a^2-b^2 2ab] = [a2 b2]
/cxsqr {		% [a b]   square root
  dup 0 get exch 1 get	% a b
  dup dup mul		% a b b^2
  3 -1 roll		% b b^2 a
  dup dup mul 		% b b^2 a a^2
  3 -1 roll sub		% b a a2
  3 1 roll mul 2 mul	% a2 b2	
  2 array astore
} def
%
/cxsqrt {		% [a b]
%  dup cxnorm sqrt /r exch def
%  cxarg 2 div RadtoDeg dup cos r mul exch sin r mul cxmake2 
  cxlog 		% log[a b]
  2 cxrdiv 		% log[a b]/2
  aload pop exch	% b a
  2.781 exch exp	% b exp(a)
  exch cxconv exch	% [Re +iIm] exp(a)
  cxrmul		%
} def
%
/cxarg { 		% [a b] 
  aload pop 		% a b
  exch atan 		% arctan b/a
  DegtoRad 		% arg(z)=atan(b/a)
} def
%
% log[a b] = [a^2-b^2 2ab] = [a2 b2]
/cxlog {		% [a b]
  dup 			% [a b][a b]
  cxnorm 		% [a b] |z|
  log 			% [a b] log|z|
  exch 			% log|z|[a b]
  cxarg 		% log|z| Theta
  cxmake2 		% [log|z| Theta]
} def
%
% square of magnitude of complex number
/cxnorm2 {		% [a b]
  dup 0 get exch 1 get	% a b
  dup mul			% a b^2
  exch dup mul add	% a^2+b^2
} def
%
/cxnorm {		% [a b]
  cxnorm2 sqrt
} def
%
/cxconj {		% conjugent complex
  dup 0 get exch 1 get	% a b
  neg 2 array astore	% [a -b]
} def
%
/cxre { 0 get } def	% real value
/cxim { 1 get } def	% imag value
%
% 1/[a b] = ([a -b]/(a^2+b^2)
/cxrecip {		% [a b]
  dup cxnorm2 exch	% n2 [a b]
  dup 0 get exch 1 get	% n2 a b
  3 -1 roll		% a b n2
  dup			% a b n2 n2
  4 -1 roll exch div	% b n2 a/n2
  3 1 roll div		% a/n2 b/n2
  neg 2 array astore
} def
%
/cxmake1 { 0 2 array astore } def % make a complex number, real given
/cxmake2 { 2 array astore } def	  % dito, both given
%
/cxdiv { cxrecip cxmul } def
%
% multiplikation by a real number
/cxrmul {		% [a b] r
  exch aload pop	% r a b
  3 -1 roll dup		% a b r r
  3 1 roll mul		% a r b*r
  3 1 roll mul		% b*r a*r
  exch 2 array astore   % [a*r b*r]
} def
%
% division by a real number
/cxrdiv {		% [a b] r
  1 exch div		% [a b] 1/r
  cxrmul
} def
%
% exp(i theta) = cos(theta)+i sin(theta) polar<->cartesian
/cxconv {		% theta
  RadtoDeg dup sin exch cos cxmake2
} def
end
