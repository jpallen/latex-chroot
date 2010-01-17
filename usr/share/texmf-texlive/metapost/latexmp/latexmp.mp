%D \module
%D   [       file=latexmp.mp,
%D         system={latexMP},
%D        version=1.1.0,
%D          title=latexMP,
%D       subtitle=LaTeX typesetting in \METAPOST, 
%D         author=Jens-Uwe Morawski,
%D           date={2003/10/02},
%D      copyright={none; this module is Public Domain}]
%D
%C - all variables start with prefix "latexmp_"
%C - all internal macros have suffix "_latexmp"
%C - macros without "_latexmp" suffix are:
%C    textext, setupLaTeXMP

%D \section{Initialisation}
if known latexmp_module: message(" not loaded again"); endinput ; fi ;
boolean latexmp_module ; latexmp_module := true ;

%D set the name of the temporary file
string latexmp_lmpfile ; latexmp_lmpfile := "ltx-" & jobname & ".tmp" ;

%D since {\LaTeX} will be used a different \type{prologues} setting
%D makes not much sense
prologues:=2 ;

%D save some original \METAPOST\ definitions
inner end ; inner bye ;
let origEnd_latexmp=end ;
let origBye_latexmp=bye ;
let origShipit_latexmp=shipit ;
string latexmp_extrabeginfig, latexmp_extraendfig ;
latexmp_extrabeginfig := extra_beginfig ;
latexmp_extraendfig := extra_endfig ;
color latexmp_background ;
latexmp_background := background ;

%D The runtime control of latexMP states:
%D (1) is this the second run in \type{rerun} mode ; (2) has the temporary
%D mp file already been read; (3) is the LaTeX preamble already
%D been written to the temporary file
boolean latexmp_secondrun, latexmp_lmploaded, latexmp_texinit ;
latexmp_secondrun := false ;
latexmp_lmploaded := false ;
latexmp_texinit := false ;

%D The current number of \type{textext()} in the input file. The counter
%D is incremented at every \type{textext} call. It is used to assign the
%D pictures from the temporary file.
numeric latexmp_counter ; latexmp_counter := 0 ;

%D \section{Setup}
%D LaTeX preamble variables
string latexmp_docclass, latexmp_classoptions,
latexmp_inputenc, latexmp_fontenc, latexmp_babellang,
latexmp_packages, latexmp_preamble, latexmp_lmpprefix,
latexmp_preamblefile ;

latexmp_docclass := "article" ;
latexmp_classoptions := "" ;
latexmp_inputenc := "" ;
latexmp_fontenc := "" ;
latexmp_babellang := "" ;
latexmp_packages := "" ;
latexmp_preamble := "" ;
latexmp_preamblefile := "" ;

%D The setup variables that control activation of the specials:
numeric latexmp_mode ;       latexmp_mode := 1 ;
boolean latexmp_subsinfont ; latexmp_subsinfont := false ;
boolean latexmp_multicolor ; latexmp_multicolor := false ;
boolean latexmp_debug ;      latexmp_debug := false ;

%D The setup command:
def setupLaTeXMP(text kvps) =
  if not latexmp_secondrun:
    if latexmp_texinit:
      message("LaTeXMP: setupLaTeXMP cannot be used if textext" &
	"has already been used; set-up ignored.");
    else:
    begingroup;
%D declaration of key-value parameters for LaTeX preamble
    save class, options, inputencoding, fontencoding, language,
    packages, preamble, preamblefile ;
    string class, options, inputencoding, fontencoding, language,
    packages, preamble, preamblefile;
%D declaration of key and synonyms for \type{mode}
    save mode, normal, rerun ;
    numeric mode, normal, rerun ;
    normal:=1 ; rerun := 2 ;
%D declaration of keys and synonyms for the specials
    save textextlabel, multicolor, debug ;
    boolean textextlabel, multicolor, debug, enable, disable ;
    enable:=true ; disable := false ;
    
    processKeyvals_latexmp(kvps) ;

    if known class:
      if (length class) >0: latexmp_docclass:=class ;
      else: latex_docclass:="article";
      fi;
    fi;
    if known options: latexmp_classoptions:=options ; fi;
    if known inputencoding: latexmp_inputenc:=inputencoding ; fi;
    if known fontencoding: latexmp_fontenc:=fontencoding ; fi;
    if known language: latexmp_babellang:=language ; fi;
    if known preamble:latexmp_preamble:=preamble ; fi;
    if known preamblefile: latexmp_preamblefile:=preamblefile ; fi;
    if known packages: latexmp_packages:=packages ; fi;
    if known mode:
      if (mode=normal) or (mode=rerun): latexmp_mode:=mode ;
      else:
	errmessage("latexMP error: set mode either to 'normal' or 'rerun'.") ;
	latexmp_mode := 1 ;
      fi;
    fi;
    if known textextlabel: latexmp_subsinfont:=textextlabel ; fi;
    if known multicolor: latexmp_multicolor:=multicolor ; fi;
    if known debug: latexmp_debug:=debug ; fi;
  endgroup;
  
%D overwrite the default definition of \type{thelabel} if user has specified
%D \type{textextlabel=enable}:
  if latexmp_subsinfont:
    vardef thelabel@#(expr s,z) =
      save p; picture p;
      if picture s: p=s
      else: p = textext(s)
      fi;
      p shifted (z + labeloffset*laboff@# -
	(labxf@#*lrcorner p + labyf@#*ulcorner p
	  + (1-labxf@#-labyf@#)*llcorner p ))
    enddef;
  fi;

%D In \type{rerun} mode for the first run own definitions for \type{end}
%D and \type{bye} are used; output is disabled for first run.
  if latexmp_mode=2:
    let end=end_latexmp ;
    let bye=end_latexmp ;
    let shipit=relax ;
%D Since in the first run the temporary file will not contain
%D correct definitions automatic loading of that file by \type{textext}
%D is disabled (we fake here that it is already loaded). Loading of the
%D temporary file in \type{end_latexmp}.
    latexmp_lmploaded := true ;
  fi;
  fi;fi;
enddef;

%D used in \type{writeLaTeXpreamble_latexmp}
%D to generate \type{\usepackage} statements
def writepackages_latexmp=
  begingroup;
    save inoptions, currentpackage, currentoptions, s ;
    boolean inoptions ; inoptions:=false;
    string currentpackage, currentoptions, s ;
    currentpackage:=""; currentoptions:="" ;

    for c=0 upto ((length latexmp_packages)-1):
      s := substring (c,c+1) of latexmp_packages ;
      if s="[":	    inoptions := true ;
      elseif s="]": inoptions := false;
      elseif s=",":
	if inoptions: currentoptions:= currentoptions & s ;
	else:
	  if (length currentpackage)>0:
	    s:="{" & currentpackage & "}" ;
	    if (length currentoptions)>0:
	      s:="[" & currentoptions & "]" & s ;
	    fi;
	    write ("\usepackage" & s) to latexmp_lmpfile ;
	    currentpackage:=""; currentoptions:="" ;
	  fi;
	fi;
      else:
	if inoptions: currentoptions:= currentoptions & s ;
	else: currentpackage:= currentpackage & s ;
	fi;
      fi;
    endfor;
    if (length currentpackage)>0: s:="{" & currentpackage & "}" ;
      if (length currentoptions)>0: s:="[" & currentoptions & "]" & s ; fi;
      write ("\usepackage" & s) to latexmp_lmpfile ;
    fi;
  endgroup;
enddef;

%D \section{LaTeX preamble}

def writeLaTeXpreamble_latexmp =
  write "verbatimtex" to latexmp_lmpfile ;
  write "%&latex" to latexmp_lmpfile ;
  if latexmp_multicolor:
    write ("\makeatletter") to latexmp_lmpfile ;
    write ("\font\latexmp@special=cmtt8 scaled 250") to latexmp_lmpfile ;
    write ("\def\reset@color{" &
      "\parbox[t][0pt][t]{0pt}{\makebox[0pt][l]{\latexmp@special ecolorxxx}}}")
      to latexmp_lmpfile ;
    write ("\newcommand*{\color}[2][named]{\parbox[t][0pt][t]{0pt}{" &
      "\makebox[0pt][l]{\latexmp@special bcolorxxx:#1:#2}}" &
      "\aftergroup\reset@color\ignorespaces}") to latexmp_lmpfile ;
    write ("\def\textcolor#1#{\@textcolor{#1}}") to latexmp_lmpfile ;
    write ("\def\@textcolor#1#2#3{\protect\leavevmode{\color#1{#2}#3}}")
      to latexmp_lmpfile ;
    write ("\newcommand*{\transparent}[3][1]{\parbox[t][0pt][t]{0pt}{"&
     "\makebox[0pt][l]{\latexmp@special btransxxx:#1,#2}}"&
     "#3\parbox[t][0pt][t]{0pt}{" &
     "\makebox[0pt][l]{\latexmp@special etransxxx}}}") to latexmp_lmpfile ;
    write "\makeatother" to latexmp_lmpfile ;
  fi;
%D If preamble file has been specified in the setup only a
%D \type{\input} for this file will be used in the LaTeX preamble:
  if (length latexmp_preamblefile)>0:
    write ("\input{" & latexmp_preamblefile & "}") to latexmp_lmpfile ;
  else:
%D Specific definitions from the setup parameters:
    write ("\documentclass"
      if (length latexmp_classoptions)>0:
	& "[" & latexmp_classoptions & "]"
      fi & "{" & latexmp_docclass & "}") to latexmp_lmpfile ;
    if (length latexmp_fontenc)>0:
      write ("\usepackage[" & latexmp_fontenc & "]{fontenc}")
      to latexmp_lmpfile ;
    fi
    if (length latexmp_inputenc)>0:
      write ("\usepackage[" & latexmp_inputenc & "]{inputenc}")
      to latexmp_lmpfile ;
    fi
    if (length latexmp_babellang)>0:
      write ("\usepackage[" & latexmp_babellang & "]{babel}")
      to latexmp_lmpfile ;
    fi
    if (length latexmp_packages)>0: writepackages_latexmp ; fi;
    if (length latexmp_preamble)>0:
      write latexmp_preamble to latexmp_lmpfile ;
    fi
  fi;
  write "\begin{document}" to latexmp_lmpfile ;
  write "etex" to latexmp_lmpfile ;
  write "picture latexmp_picture[];" to latexmp_lmpfile ;
enddef;

%D \section{Main Macros}

%D The macro that does the job:
vardef textext@#(expr s)=
  save pic ;  picture pic ;
  latexmp_counter:= latexmp_counter+1 ;
  getpicture_latexmp ;
  addstring_latexmp(s) ;
  thelabel@#(pic,origin)
enddef;

%D setting \type{latexmp_attachstrings} to \type{1} enables attaching
%D of strings \type{latexmp_prepend} and \type{latexmp_append} to the
%D string passed to \type{textext}. This may be useful for package
%D authors to implement styling interfaces.
newinternal latexmp_attachstrings ; latexmp_attachstrings:=0 ;
string latexmp_prepend, latexmp_append ;
latexmp_prepend:= "" ; latexmp_append := "" ;

def addstring_latexmp(expr s)=
  if not latexmp_texinit:
    write EOF to latexmp_lmpfile ;
    writeLaTeXpreamble_latexmp ;
    latexmp_texinit := true ;
  fi;
  write "latexmp_picture[" & (decimal latexmp_counter) & "]:= btex " &
  if latexmp_attachstrings=1: latexmp_prepend & s & latexmp_append else: s fi
  & " etex ;" to latexmp_lmpfile ;
enddef;

def getpicture_latexmp =
  if not latexmp_lmploaded:
    if not (readfrom latexmp_lmpfile=EOF):
      scantokens ("input " & latexmp_lmpfile) ;
    fi;
    latexmp_lmploaded := true ;
  fi;
  if known latexmp_picture[latexmp_counter]:
    if latexmp_multicolor and not latexmp_debug:
      pic := colorspecials_latexmp(latexmp_picture[latexmp_counter]) ;
    else:
      pic := latexmp_picture[latexmp_counter] ;
    fi;
  else:
    pic := ("LaTeXMP " & (decimal latexmp_counter))
       infont defaultfont ;
  fi;
enddef;

%D The following is only used if option \type{multicolor} is set in
%D \type{setupLaTeXMP}. It is employed in \type{getpicture_latexmp}
%D in order to strip specials from the LaTeX picture and change
%D the colors of text elements accordigly.
vardef colorspecials_latexmp(expr p) =
  save _P, _bb, _tp, _fp, _t, _addto_P ;
  save _withcolor, _colorpointer, _transparent, _transpointer;
  picture _P ; path _bb ;
  string _withcolor[], _transparent[], _tp, _fp, _addto_P ;
  numeric _colorpointer, _transpointer ;
  _P := nullpicture ;  _bb := pathpart p ;
  _withcolor[0]:= "" ; _colorpointer := 0 ; _transparent[0]:="" ;
  _transpointer:=0 ;
  _addto_P := "addto _P also _tp infont _fp transformed _t " ;
  for c within p:
    if textual c:
      _tp:= textpart c ;
      _fp:= fontpart c ;
      transform _t ;
      (xpart _t,xxpart _t,xypart _t)=(xpart c,xxpart c,xypart c) ; 
      (ypart _t,yypart _t,yxpart _t)=(ypart c,yypart c,yxpart c) ;
      if (_fp="cmtt8") and ((substring (1,9) of _tp)="colorxxx"):
      % color special found
	if (substring (0,1) of _tp)="b":
	% begin color special
	  _colorpointer := _colorpointer+1;
	  _withcolor[_colorpointer]:= colormacro_latexmp(substring (10,(length _tp)) of _tp) ;
	elseif (substring (0,1) of _tp)="e":
	% end color special
	  if not (_colorpointer=0):
%C if \type{\color} is used ungrouped in a parbox the \type{ecolorxxx}
%C appears prior \type{bcolorxxx}. multiple instances of \type{ecolorxxx}
%C would result in counting \type{_colorpointer<0}. thus checking
%C for \type{_colorpointer=0} is a ugly hack for this problem.
	    _colorpointer := _colorpointer-1;
	  fi;
%C else:?? ooops; should not happen 
	fi;
      elseif (_fp="cmtt8") and ((substring (1,9) of _tp)="transxxx"):
      % transparency special found
	if (substring (0,1) of _tp)="b":
	% begin trans special
	  _transpointer := _transpointer+1;
	  _transparent[_transpointer]:= substring (10,(length _tp)) of _tp ;
	elseif (substring (0,1) of _tp)="e":
	% end trans special
	  _transpointer := _transpointer-1;
	fi;
      else:
	scantokens (_addto_P & withcurrentcolor_latexmp ) ;
      fi;
    fi;
  endfor;
  setbounds _P to _bb ;
  _P
enddef;

vardef colormacro_latexmp(expr colspec)=
  save _cmd, _pos, _m, _c ; string _cmd, _m, _c ;
  _pos := 0 ; _cmd:="" ;
  for i=1 upto (length colspec):
    if (substring (i-1,i) of colspec)=":":
      _pos := i ;
    fi;
  endfor;
  if _pos<2: % "x:..." --> no color model found
    errmessage("LaTeXMP: no color model found in: " & colspec) ;
  else:
    _m := substring (0,(_pos-1)) of colspec ;
    _c := substring (_pos,(length colspec)) of colspec ;
    if expandafter known (scantokens ("latexmp_color_" & _m)):
      _cmd := (scantokens ("latexmp_color_" & _m)) & "(" & _c & ")" ;
    else:
      errmessage("LaTeXMP: color model '" & _m & "' not supported)") ;
    fi;
  fi;
  _cmd
enddef;

vardef withcurrentcolor_latexmp=
  if (length _withcolor[_colorpointer])>0:
    if (length _transparent[_transpointer])>0:
      " withcolor transparent(" & _transparent[_transpointer] & "," &
	_withcolor[_colorpointer] &")"
    else:  " withcolor " & _withcolor[_colorpointer] fi
  else:
    if (length _transparent[_transpointer])>0:
      " withcolor transparent(" & _transparent[_transpointer] & ",black)"
    else: "" fi
  fi
enddef;

%D \section{The end macro for rerun mode}
string latexmp_beforererun ; latexmp_beforererun := "" ;

def end_latexmp =
%D read temporary file if strings have been written there
  if latexmp_counter>0:
    write EOF to latexmp_lmpfile;
    scantokens ("input " & latexmp_lmpfile) ;
  fi;
%D re-init
  latexmp_counter := 0 ; latexmp_secondrun := true ; latexmp_texinit := false ;
%D restore defaults
  extra_beginfig := latexmp_extrabeginfig ;
  extra_endfig := latexmp_extraendfig ;
  background := latexmp_background ;
  let end=origEnd_latexmp ; let bye=origBye_latexmp ;
  let shipit=origShipit_latexmp ;
  clear_pen_memory; clearit;
  pickup pencircle scaled .5bp; defaultpen := savepen;
%D run pre-rerun hooks
  scantokens latexmp_beforererun ;
%D input current job again
  scantokens ("input " & jobname) ;
enddef;

%D \section{color support}
vardef Hsvcolor_latexmp(expr H,s,v) =
  save h, o, b, d, pc, sc; numeric h, o, b, d, pc, sc ;
  h := H/60 ;  pc := floor h ;  sc := h - pc ;
  o := (1-s)*v ;  b := (1-(sc*s))*v ;  d := (1-((1-sc)*s))*v ;
  if (pc = 0) or (pc = 6): (v,d,o)
  elseif pc = 1: (b,v,o)	
  elseif pc = 2: (o,v,d)	
  elseif pc = 3: (o,b,v)	
  elseif pc = 4: (d,o,v)	
  else:(v,o,b)
  fi
enddef;
vardef cmykcolor_latexmp(expr c,m,y,k) =
%D use MetaFun cmyk-specials if available; macro \type{cmyk()}
%D checks if \type{cmykcolors=true}
  if known context_spec: cmyk(c,m,y,k) else: (1-c-k,1-m-k,1-y-k) fi
enddef;
vardef graycolor_latexmp(expr g) = (g,g,g) enddef ;

%D which macro should be used for a given color model in multicolor mode.
string latexmp_color_Hsv, latexmp_color_rgb,
latexmp_color_gray, latexmp_color_cmyk, latexmp_color_named ;

latexmp_color_Hsv := "Hsvcolor_latexmp" ;
latexmp_color_gray := "graycolor_latexmp" ;
latexmp_color_rgb := "" ;
latexmp_color_cmyk := "cmykcolor_latexmp" ;
latexmp_color_named := "" ;

%D \section{Key-Value Support Macros}
def processKeyvals_latexmp (text _kvps_)=
  begingroup;
    save _equals, _assign ;
    let _equals= = ;
    
    primarydef _ll_ _assign _rr_ =
      hide(_ll_ _equals _rr_ ) 1
    enddef;

    save = ;
    let = _equals _assign ;
    for _xx_ _equals _kvps_ : endfor ;% NOP
  endgroup;
enddef;
