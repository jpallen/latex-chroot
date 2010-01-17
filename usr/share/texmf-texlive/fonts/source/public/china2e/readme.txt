================================================
#######  China2e -- a short font report  #######
================================================

(Chinese calendar symbols - by UDO HEYL, July 14th, 1997

Error Reports in case of UNCHANGED versions to
   Udo Heyl,
   Stregdaer Allee 7,
   99817 Eisenach,
   Federal Republic of Germany
or
   DANTE, Deutschsprachige Anwendervereinigung TeX e.V., 
   Postfach 10 18 40,
   69008 Heidelberg, 
   Federal Republic of Germany, 
   Email: dante@dante.de 

What is China2e ?
_________________

It is a LaTeX2e - package to produce Chinese calendar symbols
of the old Chinese lunisolar calendar. In addition you can use
a new fontshape {\BLOCK}, symbolic letters 
\symA ... \symZ , the phases of the Moon
\MoonPha{1}\MoonPha{2}\MoonPha{3}\MoonPha{4}
and some special symbols (\Greenpoint\Telephone...).

How to use the China2e package?
_______________________________

First and foremost you've got to copy the following files

--- china10.mf, chinasym.add, chinasym.alf, chinasym.ele, 
      chinasym.num, chinasym.sbl and chinasym.sta 
      into your Metafont-directory  (\EMTEX\MFINPUT\CHINA)

--- china2e.sty into your Style-directory  (\EMTEX\TEXINPUT\CHINA)

--- china10.tfm into your Tfm-directory  (\EMTEX\TFM\CHINA

Note, however, that the paths may be different in your 
         LaTeX2e implementation 
         (EmTeX for MS-DOS, web2c for UNIX etc.).

LaTeX2e is absolutely required, if you want to use China2e, 
which doesn't run with the ANCIENT LaTeX209.

Now you can call this package like seen in the example:

   \documentclass[12pt]{article}
   \usepackage{china2e} %%% to include china2e.sty
   \begin{document} ... \end{document}

Chinese characters and symbols will appear now in the current size
and won't change the current shape. Of course you can input
   
   {\Huge Chinese symbol} 

to manage a greater Chinese calendar symbol.

!!!!! Please consult CHINADOC.TEX or CHINADOC.PS for further infos !!!!!



