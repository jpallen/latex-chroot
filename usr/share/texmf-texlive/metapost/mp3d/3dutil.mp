%%\input epsf
%%\def\newpage{\vfill\eject}
%%\advance\vsize1in
%%\let\ora\overrightarrow
%%\def\title#1{\hrule\vskip1mm#1\par\vskip1mm\hrule\vskip5mm}
%%\def\figure#1{\par\centerline{\epsfbox{#1}}}
%%\title{{\bf 3DUTIL.MP: 3D UTILITIES IN METAPOST}}

%% version 1.34, 17 August 2003
%% {\bf Denis Roegel} ({\tt roegel@loria.fr}) 

% This package provides some basic functions used in certain
% files of the 3d package.

if known three_d_util_version: 
  expandafter endinput % avoids loading this package twice
fi;

message "*** 3dutil,   v1.34 (c) D. Roegel 17 August 2003 ***";
numeric three_d_util_version; three_d_util_version:=1.34;

% maybe this exists?
def sign(expr n)=
  (if n>=0: 1 else: -1 fi)
enddef;

%
def absmin(expr v,w)=
  (if abs(v)<=abs(w):abs(v) else: abs(w) fi)
enddef;

%
def absmax(expr v,w)=
  (if abs(v)>abs(w):abs(v) else: abs(w) fi)
enddef;

endinput
