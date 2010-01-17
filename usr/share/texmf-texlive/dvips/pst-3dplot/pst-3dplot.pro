%%
%% This is file `pst-3dplot.pro',
%%
%% IMPORTANT NOTICE:
%%
%% Package `pst-3dplot.tex'
%%
%% Herbert Voss <voss _at_ PSTricks.de>
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-3dplot' is a PSTricks package to draw 3d curves and graphical objects
%%
%%
%% version 0.23 / 2006-01-18  Herbert Voss <voss _at_ PSTricks.de>
%
/tx@3DPlotDict 50 dict def
tx@3DPlotDict begin
%
/saveCoor { 
  dzUnit mul /z exch def
  dyUnit mul /y exch def
  dxUnit mul /x exch def
} def
%
/ConvertTo2D {
  RotatePoint
%  /x2D y x Alpha sin mul sub def  %  |/_  co system
%  /y2D z x Alpha cos mul sub def 
  /x2D x leftHanded not { neg } if Alpha cos mul y Alpha sin mul add def
  /y2D x leftHanded { neg } if Alpha sin mul y Alpha cos mul add neg Beta sin mul z Beta cos mul add def
} def
%
/ConvertToCartesian {
  /latitude exch def
  /longitude exch def
  /Radius exch def
  /z { Radius latitude sin mul } def
  /x { Radius longitude cos mul latitude cos mul } def
  /y { Radius longitude sin mul latitude cos mul } def
} def
%
/SphericalTo2D {
  x y z ConvertToCartesian ConvertTo2D
} def
%
/convertStackTo2D {
  counttomark
  /n exch def /n3 n 3 div cvi def
  n3 {
    n -3 roll
    SphericalCoor { ConvertToCartesian } { saveCoor } ifelse
    ConvertTo2D
    x2D xUnit y2D yUnit
    /n n 1 sub def
  } repeat
} def
%
/CalcCoordinates {% from pst-vue3d
    formulesTroisD
    Xi 28.45 mul Yi 28.45 mul
} def
% pour la 3D conventionnelle
/DScreen 1 def
/Dobs 0 def
/formulesTroisD{%
  /xObservateur x Sin1 mul neg y Cos1 mul add def
  /yObservateur x Cos1Sin2 mul neg y Sin1Sin2 mul sub z Cos2 mul add def
  /zObservateur x neg Cos1Cos2 mul y Sin1Cos2 mul sub z Sin2 mul sub Dobs add def
  /Xi DScreen xObservateur mul zObservateur div def
  /Yi DScreen yObservateur mul zObservateur div def
} def
%
/RotatePointXYZ{% Mxx are defined in the TeX file
  /xi M11 x mul M12 y mul add M13 z mul add def
  /yi M21 x mul M22 y mul add M23 z mul add def
  /zi M31 x mul M32 y mul add M33 z mul add def
  /x xi def
  /y yi def
  /z zi def
} def
%
/RotXaxis { 
  /yTemp y RotX cos mul z RotX sin mul sub def
  /z  y RotX sin mul z RotX cos mul add def
  /y yTemp def
} def
/RotYaxis { 
  /xTemp x RotY cos mul z RotY sin mul add def
  /z  x RotY sin mul neg z RotY cos mul add def
  /x xTemp def
} def
/RotZaxis { 
  /xTemp x RotZ cos mul y RotZ sin mul sub def
  /y  x RotZ sin mul y RotZ cos mul add def
  /x xTemp def
} def
/xyz { RotXaxis RotYaxis RotZaxis } def
/yxz { RotYaxis RotXaxis RotZaxis } def
/yzx { RotYaxis RotZaxis RotXaxis } def
/xzy { RotXaxis RotZaxis RotYaxis } def
/zxy { RotZaxis RotXaxis RotYaxis } def
/zyx { RotZaxis RotYaxis RotXaxis } def
%
/RotatePoint { RotSequence cvx exec } def
%
/VecNorm { 0 exch { dup mul add } forall sqrt } def
/UnitVec {			% on stack is [a]; returns a vector with [a][a]/|a|=1 
  dup VecNorm /norm ED
  { norm div } forall 3 array astore } def
/AxB {				% on the stack are the two vectors [a][b]
    aload pop /b3 ED /b2 ED /b1 ED
    aload pop /a3 ED /a2 ED /a1 ED
    a2 b3 mul a3 b2 mul sub
    a3 b1 mul a1 b3 mul sub
    a1 b2 mul a2 b1 mul sub
    3 array astore } def
/AaddB {			% on the stack are the two vectors [a][b]
    aload pop /b3 ED /b2 ED /b1 ED
    aload pop /a3 ED /a2 ED /a1 ED
    a1 b1 add a2 b2 add a3 b3 add
    3 array astore } def
/AmulC {			% on stack is [a] and c; returns [a] mul c
    /factor ED { factor mul } forall 3 array astore } def
%
%
% 3D objects
/tx@ProjThreeD {% adopted from pst-3d
  /z ED /y ED /x ED
  Matrix3D aload pop
  z mul exch y mul add exch x mul add
  4 1 roll
  z mul exch y mul add exch x mul add
  exch} def
%
/setColorLight { % expects 7 values on stack C M Y K xL yL zL
% les rayons de lumière
  /zLight exch def 
  /yLight exch def
  /xLight exch def
% the color values
  /K exch def
  /Yellow exch def
  /Magenta exch def
  /Cyan exch def
%
  /NormeLight {xLight dup mul yLight dup mul zLight dup mul add add
            sqrt} bind def 
} def
/facetteSphere {
  newpath
  /Xpoint Rsphere theta cos mul phi cos mul CX add def
  /Ypoint Rsphere theta sin mul phi cos mul CY add def
  /Zpoint Rsphere phi sin mul CZ add def
  Xpoint Ypoint Zpoint tx@ProjThreeD moveto
  theta 1 theta increment add {%
    /theta1 exch def
    /Xpoint Rsphere theta1 cos mul phi cos mul CX add def
    /Ypoint Rsphere theta1 sin mul phi cos mul CY add def
    /Zpoint Rsphere phi sin mul CZ add def
    Xpoint Ypoint Zpoint tx@ProjThreeD  lineto
  } for
  phi 1 phi increment add {
    /phi1 exch def
    /Xpoint Rsphere theta increment add cos mul phi1 cos mul CX add def
    /Ypoint Rsphere theta increment add sin mul phi1 cos mul CY add def
    /Zpoint Rsphere phi1 sin mul CZ add def
    Xpoint Ypoint Zpoint tx@ProjThreeD lineto
  } for
  theta increment add -1 theta {%
    /theta1 exch def
    /Xpoint Rsphere theta1 cos mul phi increment add cos mul CX add def
    /Ypoint Rsphere theta1 sin mul phi increment add cos mul CY add def
    /Zpoint Rsphere phi increment add sin mul CZ add def
    Xpoint Ypoint Zpoint tx@ProjThreeD lineto
  } for
  phi increment add -1 phi {
    /phi1 exch def
    /Xpoint Rsphere theta cos mul phi1 cos mul CX add def
    /Ypoint Rsphere theta sin mul phi1 cos mul CY add def
    /Zpoint Rsphere phi1 sin mul CZ add def
    Xpoint Ypoint Zpoint tx@ProjThreeD lineto
  } for
  closepath 
} def
%
/condition { PSfacette 0 ge } def
/MaillageSphere { 
% on stack must be
% x y z Radius increment C M Y K x y zLIGHT
  setColorLight
  /increment exch def
  /Rsphere exch def
  /CZ exch def
  /CY exch def
  /CX exch def
  /StartTheta 0 def
  -90 increment 90 increment sub {%
    /phi exch def
    StartTheta increment 360 StartTheta add increment sub {%
      /theta exch def
      % Centre de la facette
      /Xpoint Rsphere theta increment 2 div add cos mul phi increment 2 div add cos mul CX add def
      /Ypoint Rsphere theta increment 2 div add sin mul phi increment 2 div add cos mul CY add def
      /Zpoint Rsphere phi increment 2 div add sin mul CZ add def
      % normale à la facette
      /nXfacette Xpoint CX sub def
      /nYfacette Ypoint CY sub def
      /nZfacette Zpoint CZ sub def
      % test de visibilité
      /PSfacette vX nXfacette mul
        vY nYfacette mul add
        vZ nZfacette mul add
      def
      condition {
        gsave
        facetteSphere
        /cosV { 1 xLight nXfacette mul
          yLight nYfacette mul
          zLight nZfacette mul
          add add
          NormeLight
          nXfacette dup mul
          nYfacette dup mul
          nZfacette dup mul
          add add sqrt mul div sub } bind def
        Cyan cosV mul Magenta cosV mul Yellow cosV mul K cosV mul setcmykcolor fill 
	grestore
%	0 setgray
        facetteSphere stroke	
      } if 
    } for
    % /StartTheta StartTheta increment 2 div add def
  } for
} def

end
