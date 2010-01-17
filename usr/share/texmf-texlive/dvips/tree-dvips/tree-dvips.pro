%!
TeXDict begin /@beginspec{gsave texpsmatrix setmatrix treedict begin}def
/@endspec{end grestore}def /texpsmatrix matrix defaultmatrix isls{dup[0.0 -1.0
1.0 0.0 0.0 0.0]exch concatmatrix}if def userdict begin /bop-hook{
/texpsmatrix matrix defaultmatrix isls{dup[0.0 -1.0 1.0 0.0 0.0 0.0]exch
concatmatrix}if def}B end /treedict 200 dict def treedict begin /pt{72 mul
72.07 div}def /nodemargin 2 def /nodes 100 dict def /node{/dpth exch def /hght
exch def /wdth exch def 4 dict dup begin /x /y currentpoint dpth sub
nodemargin sub exch 3 1 roll def nodemargin sub def /h hght dpth add
nodemargin dup add add def /w wdth nodemargin dup add add def end nodes 3 1
roll put}def /nodebottom{begin x w 2 div add y end}def /nodetop{begin x w 2
div add y h add end}def /nodeleft{begin x y h 2 div add end}def /noderight{
begin x w add y h 2 div add end}def /nodetopleft{begin x y h add end}def
/nodetopright{begin x w add y h add end}def /nodebottomleft{begin x y end}def
/nodebottomright{begin x w add y end}def /farright{begin x w add depth add h 2
div y add end}def /farleft{begin x depth sub h 2 div y add end}def /farbottom{
begin x w 2 div add y depth sub end}def /fartop{begin x w 2 div add y h add
depth add end}def /farbottomleft{begin x depth 45 cos mul sub y depth 45 sin
mul sub end}def /farbottomright{begin x w add depth 45 cos mul add y depth 45
sin mul sub end}def /fartopright{begin x w add depth 45 cos mul add y h add
depth 45 sin mul add end}def /fartopleft{begin x depth 45 cos mul sub y h add
depth 45 sin mul add end}def /alignpoint{2 copy sub abs 1 le{add 2 div round
dup}if}def /getnode{nodes exch get}def /nodeconnect{gsave transform 4 2 roll
transform exch 4 1 roll alignpoint 4 2 roll alignpoint 4 1 roll exch
itransform moveto itransform lineto stroke grestore}def /arrowdict 14 dict def
arrowdict begin /mtrx matrix def end /arrow{arrowdict begin /headlength exch
def /halfheadthickness exch 2 div def /tipy exch def /tipx exch def /taily
exch def /tailx exch def /dx tipx tailx sub def /dy tipy taily sub def /angle
dy dx atan def /savematrix mtrx currentmatrix def tipx tipy translate angle
rotate 0 0 moveto headlength neg halfheadthickness neg lineto headlength neg
halfheadthickness lineto closepath savematrix setmatrix end}def
/arrownodeconnect{gsave transform 4 2 roll transform exch 4 1 roll alignpoint
4 2 roll alignpoint 4 1 roll exch itransform 4 2 roll itransform 4 2 roll 4
copy moveto lineto gsave newpath 4 2 roll arrowwidth arrowlength arrow fill
grestore stroke grestore}def /barnodeconnect{4 2 roll 2 copy moveto 5 -1 roll
add dup 3 1 roll lineto 2 index exch lineto lineto stroke}def
/arrowbarnodeconnect{4 2 roll 2 copy moveto 5 -1 roll add dup 3 1 roll lineto
2 index exch 4 copy lineto lineto gsave newpath 4 2 roll arrowwidth
arrowlength arrow fill grestore stroke}def /nodetriangle{gsave exch nodes exch
get nodebottom moveto dup nodes exch get nodetopleft lineto nodes exch get
nodetopright lineto closepath stroke grestore}def /slope{/y1 exch def /x1 exch
def /y0 exch def /x0 exch def y1 y0 sub x1 x0 sub div}def /midpoint{/y1 exch
def /x1 exch def /y0 exch def /x0 exch def x1 x0 sub abs x1 x0 ge{x0 add}{x1
add}ifelse y1 y0 sub abs y1 y0 ge{y0 add}{y1 add}ifelse}def /tancurveto{1
index exch curveto}def /nodetancurve{/depth exch def /to exch def /from exch
def gsave nodes from get noderight moveto nodes to get noderight tancurveto
stroke grestore}def /rightcur{nodes exch get dup noderight 3 -1 roll farright}
def /leftcur{nodes exch get dup nodeleft 3 -1 roll farleft}def /topcur{nodes
exch get dup nodetop 3 -1 roll fartop}def /bottomcur{nodes exch get dup
nodebottom 3 -1 roll farbottom}def /topleftcur{nodes exch get dup nodetopleft
3 -1 roll fartopleft}def /toprightcur{nodes exch get dup nodetopright 3 -1
roll fartopright}def /bottomleftcur{nodes exch get dup nodebottomleft 3 -1
roll farbottomleft}def /bottomrightcur{nodes exch get dup nodebottomright 3 -1
roll farbottomright}def /nodecurve{gsave 4 2 roll moveto 6 2 roll 4 2 roll
curveto stroke grestore}def /arrownodecurve{gsave 4 2 roll moveto 6 2 roll 4 2
roll 4 copy 10 4 roll curveto gsave newpath arrowwidth arrowlength arrow fill
grestore stroke grestore}def /nodebox{nodes exch get begin gsave newpath x y
moveto h w dobox cleanup stroke grestore end}def /nodecircle{nodes exch get
begin gsave newpath w 2 div x add h 2 div y add w w mul h h mul add sqrt 2 div
4 -1 roll add 360 0 arcn cleanup stroke grestore end}def /nodecircletrans{
nodes exch get begin gsave newpath w 2 div x add h 2 div y add w w mul h h mul
add sqrt 2 div 4 -1 roll add 360 0 arcn stroke grestore end}def /nodeoval{
nodes exch get begin gsave newpath x 2 sub y 2 sub moveto h 4 add w 4 add
dooval cleanup stroke grestore end}def /testnodeoval{nodes exch get begin
gsave newpath h h mul w w mul add sqrt div dup dup dup w mul neg x add exch h
mul neg y add moveto dup h mul 2 mul h add exch w mul 2 mul w add testdooval
stroke grestore end}def /cleanup{gsave x y moveto h nodemargin sub .5 add w
nodemargin sub .5 add doccbox 1 setgray fill grestore}def /boxdict 4 dict def
boxdict /mtrx matrix put /dobox{boxdict begin /w exch def /h exch def
/savematrix mtrx currentmatrix def 0 h rlineto w 0 rlineto 0 h neg rlineto
closepath savematrix setmatrix end}def /doccbox{boxdict begin /w exch def /h
exch def /savematrix mtrx currentmatrix def w 0 rlineto 0 h rlineto w neg 0
rlineto closepath savematrix setmatrix end}def /ovaldict 6 dict def ovaldict
/mtrx matrix put /dooval{ovaldict begin /w exch def /h exch def /savematrix
mtrx currentmatrix def 0 h 2 div rmoveto 0 h 2 div nodemargin sub nodemargin h
2 div w 2 div h 2 div rcurveto w 2 div nodemargin sub 0 w 2 div nodemargin neg
w 2 div h 2 div neg rcurveto 0 h 2 div neg nodemargin add nodemargin neg h 2
div neg w 2 div neg h 2 div neg rcurveto w 2 div neg nodemargin add 0 w 2 div
neg nodemargin w 2 div neg h 2 div rcurveto savematrix setmatrix end}def
/testdooval{ovaldict begin /w exch def /h exch def /r exch def h 2 div neg r
mul dup h 2 div dup r mul 3 1 roll 2 r sub mul 0 h rcurveto w 2 div dup r mul
exch 2 r sub mul w 2 div r mul dup 3 1 roll w 0 rcurveto h 2 div r mul dup h 2
div neg dup r mul 3 1 roll 2 r sub mul 0 h neg rcurveto w 2 div neg dup r mul
exch 2 r sub mul w 2 div neg r mul dup 3 1 roll w neg 0 rcurveto end}def end
end
