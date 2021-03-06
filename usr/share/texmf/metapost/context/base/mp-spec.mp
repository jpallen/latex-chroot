%D \module
%D   [       file=mp-spec.mp,
%D        version=1999.6.26,
%D          title=\CONTEXT\ \METAPOST\ graphics,
%D       subtitle=special extensions,
%D         author=Hans Hagen,
%D           date=\currentdate,
%D      copyright={PRAGMA / Hans Hagen \& Ton Otten}]
%C
%C This module is part of the \CONTEXT\ macro||package and is
%C therefore copyrighted by \PRAGMA. See licen-en.pdf for
%C details.

% Spot colors are not handled by mptopdf !

% let graycolor    = numeric ;
% let greycolor    = numeric ;
% let withanycolor = withcolor ;

% rgbcolor  red     ; red        := (1,0,0) ;
% rgbcolor  green   ; green      := (0,1,0) ;
% rgbcolor  blue    ; blue       := (0,0,1) ;
% cmykcolor cyan    ; cyan       := (1,0,0,0) ;
% cmykcolor magenta ; magenta    := (0,1,0,0) ;
% cmykcolor yellow  ; yellow     := (0,0,1,0) ;
% graycolor black   ; black      := 0 ; % (0) ;
% graycolor white   ; white      := 1 ; % (1) ;

% primarydef p withcolor c =
%     p withanycolor (c)
% enddef ;

% fill fullcircle scaled 10cm withcolor  cyan ;
% fill fullcircle scaled  7cm withcolor   red ;
% fill fullcircle scaled  4cm withcolor white ;

% (r,g,b) => cmyk             : r=123 g=   1 b=hash
%         => spot             : r=123 g=   2 b=hash
%         => transparent rgb  : r=123 g=   3 b=hash
%         => transparent cmyk : r=123 g=   4 b=hash
%         => transparent spot : r=123 g=   5 b=hash
%         => rest             : r=123 g=n>10 b=whatever

%D This module is rather preliminary and subjected to
%D changes. Here we closely cooperates with the \METAPOST\
%D to \PDF\ converter module built in \CONTEXT\ and provides
%D for instance shading. More information can be found in
%D type {supp-mpe.tex}.

if unknown context_tool :    input mp-tool ; fi ;
if   known context_spec : endinput         ; fi ;

boolean context_spec ; context_spec := true ;

numeric _special_counter_ ; _special_counter_ :=   0 ;
numeric _color_counter_   ; _color_counter_   :=  11 ; % < 10 reserved
numeric _special_signal_  ; _special_signal_  := 123 ;

numeric _special_div_ ; _special_div_ := 1000 ;

%D When set to \type {true}, shading will be supported. Some
%D day I will also write an additional directive.

boolean _inline_specials_ ; _inline_specials_ := false ;

%D Because we want to output only those specials that are
%D actually used in a figure, we need a bit complicated
%D bookkeeping and collection of specials. At the cost of some
%D obscurity, we now have rather efficient resources.

string _global_specials_ ; _global_specials_ := "" ;
string _local_specials_  ; _local_specials_  := "" ;

% vardef add_special_signal = % write the version number
%   if (length _global_specials_>0) or (length _local_specials_ >0) :
%     special ("%%MetaPostSpecials: 1.0 " & decimal _special_signal_ ) ;
%   fi ;
% enddef ;
%
% After some reported problems at the \CONTEXT\ mailing list,
% Taco's came up with:

% TH: \quotation {Ok, got it. There is a bug in mp-spec.mp (inside metafun).
% Because of a wrapping number, it fails to recognize the fact that there
% are embedded specials at all.} The corrected definition is:

vardef add_special_signal = % write the version number
  if (length _global_specials_ <> 0) or (length _local_specials_ <> 0) :
    special ("%%MetaPostSpecials: 2.0 " & decimal _special_signal_ & " " & decimal _special_div_) ;
  fi ;
enddef ;

% \quotation {It now tests for \quote {not equal to zero} instead of
% \quote {larger than zero}: because of all the included files, the
% string \type {_local_specials_} becomes longer than the maximum number
% \quote {length} can return, so it returns -32768 instead, and that is
% of course less than zero.}

vardef add_extra_specials =
  scantokens _global_specials_ ;
  scantokens _local_specials_ ;
enddef ;

vardef reset_extra_specials =
  % only local ones
  _local_specials_ := "" ;
enddef ;

boolean insidefigure ; insidefigure := false ;

% todo: alleen als special gebruikt flush

extra_beginfig :=
  " insidefigure := true ; " &
  " reset_extra_specials ; " &
    extra_beginfig ;

extra_endfig :=
  " add_special_signal ; "    &
    extra_endfig              &
  " add_extra_specials ; "    &
  " reset_extra_specials ; "  &
  " insidefigure := false ; " ;

def set_extra_special (expr s) =
  if insidefigure :
    _local_specials_  := _local_specials_  & s ;
  else :
    _global_specials_ := _global_specials_ & s ;
  fi
enddef ;

def flush_special (expr typ, siz, dat) =
  _special_counter_ := _special_counter_ + 1 ;
  if _inline_specials_ :
    set_extra_special
      ( "special "
      & "(" & ditto
      & dat & " "
      & decimal _special_counter_ & " "
      & decimal typ & " "
      & decimal siz
      & " special"
      & ditto & ");" ) ;
  else :
    set_extra_special
      ( "special "
      & "(" & ditto
      & "%%MetaPostSpecial: "
      & decimal siz & " "
      & dat & " "
      & decimal _special_counter_ & " "
      & decimal typ
      & ditto & ");" ) ;
  fi ;
enddef ;

%D The next hack is needed in case you use a version of
%D \METAPOST\ that does not provide you the means to configure
%D the buffer size. Patrick Gundlach suggested to use arrays
%D in this case.

boolean bufferhack ; bufferhack := false ; % true ;

if bufferhack :

  string _global_specials_[] ; numeric _nof_global_specials_ ;
  string _local_specials_[]  ; numeric _nof_local_specials_ ;

  _nof_global_specials_ := _nof_local_specials_ := 0 ;

  vardef add_special_signal = % write the version number
    if (_nof_global_specials_>0) or (_nof_local_specials_>0) :
      special ("%%MetaPostSpecials: 1.0 " & decimal _special_signal_ ) ;
    fi ;
  enddef ;

  vardef add_extra_specials =
    for i=1 upto _nof_global_specials_ :
      scantokens _global_specials_[i] ;
    endfor;
    for i=1 upto _nof_local_specials_ :
      scantokens _local_specials_[i] ;
    endfor;
  enddef ;

  vardef reset_extra_specials =
    string _local_specials_[]  ; _nof_local_specials_ := 0 ;
  enddef ;

  def set_extra_special (expr s) =
    if insidefigure :
      _local_specials_[incr(_nof_local_specials_)]   := s ;
    else :
      _global_specials_[incr(_nof_global_specials_)] := s ;
    fi
  enddef ;

fi ;

%D So far for this hack.

%D Shade allocation.

newinternal shadefactor ; shadefactor := 1 ;

pair shadeoffset ; shadeoffset := origin ;

% vardef define_linear_shade (expr a, b, ca, cb) =
%   flush_special(30, 15, "0 1 " & decimal shadefactor & " " &
%     dddecimal ca & " " & ddecimal (a shifted shadeoffset) & " " &
%     dddecimal cb & " " & ddecimal (b shifted shadeoffset) ) ;
%   _special_counter_
% enddef ;

% vardef define_circular_shade (expr a, b, ra, rb, ca, cb) =
%   flush_special(31, 17, "0 1 " & decimal shadefactor & " " &
%     dddecimal ca & " " & ddecimal (a shifted shadeoffset) & " " & decimal ra & " " &
%     dddecimal cb & " " & ddecimal (b shifted shadeoffset) & " " & decimal rb ) ;
%   _special_counter_
% enddef ;

% these tests are not yet robust for new gray/cmyk features;
%
% - we need to get rid of cmykcolor() and

vardef _is_cmyk_(expr c) =
    (redpart c = _special_signal_/_special_div_) and (greenpart c = 1/_special_div_)
enddef ;
vardef _is_spot_(expr c) =
    (redpart c = _special_signal_/_special_div_) and (greenpart c = 2/_special_div_)
enddef ;

numeric mp_shade_version ; mp_shade_version := 2 ; % more colors, needs new backend

vardef define_linear_shade (expr a, b, ca, cb) =
    if (mp_shade_version > 1) and _is_cmyk_(ca) and _is_cmyk_(cb) :
        flush_special(32, 17, "0 1 " & decimal shadefactor & " " &
            cmykcolorpattern[bluepart ca] & " " & ddecimal (a shifted shadeoffset) & " " &
            cmykcolorpattern[bluepart cb] & " " & ddecimal (b shifted shadeoffset) ) ;
    elseif (mp_shade_version > 1) and _is_spot_(ca) and _is_spot_(cb) :
        flush_special(34, 17, "0 1 " & decimal shadefactor & " " &
            spotcolorpattern[bluepart ca] & " " & ddecimal (a shifted shadeoffset) & " " &
            cmykcolorpattern[bluepart cb] & " " & ddecimal (b shifted shadeoffset) ) ;
    else :
        flush_special(30, 15, "0 1 " & decimal shadefactor & " " &
            dddecimal ca & " " & ddecimal (a shifted shadeoffset) & " " &
            dddecimal cb & " " & ddecimal (b shifted shadeoffset) ) ;
    fi ;
    _special_counter_
enddef ;

vardef define_circular_shade (expr a, b, ra, rb, ca, cb) =
    if (mp_shade_version > 1) and _is_cmyk_(ca) and _is_cmyk_(cb) :
        flush_special(33, 19, "0 1 " & decimal shadefactor & " " &
            cmykcolorpattern[bluepart ca] & " " & ddecimal (a shifted shadeoffset) & " " & decimal ra & " " &
            cmykcolorpattern[bluepart cb] & " " & ddecimal (b shifted shadeoffset) & " " & decimal rb ) ;
    elseif (mp_shade_version > 1) and _is_spot_(ca) and _is_spot_(cb) :
        flush_special(35, 19, "0 1 " & decimal shadefactor & " " &
            spotcolorpattern[bluepart ca] & " " & ddecimal (a shifted shadeoffset) & " " & decimal ra & " " &
            spotcolorpattern[bluepart cb] & " " & ddecimal (b shifted shadeoffset) & " " & decimal rb ) ;
    else :
        flush_special(31, 17, "0 1 " & decimal shadefactor & " " &
            dddecimal ca & " " & ddecimal (a shifted shadeoffset) & " " & decimal ra & " " &
            dddecimal cb & " " & ddecimal (b shifted shadeoffset) & " " & decimal rb ) ;
    fi ;
  _special_counter_
enddef ;

%D A few predefined shading macros.

boolean trace_shades ; trace_shades := false ;

%  if     (n=1) : a := llcorner p ; b := urcorner p ;
%  elseif (n=2) : a := llcorner p ; b := ulcorner p ;
%  elseif (n=3) : a := lrcorner p ; b := ulcorner p ;
%  else         : a := llcorner p ; b := lrcorner p ;
%  fi ;

def set_linear_vector (suffix a,b)(expr p,n) =
  if     (n=1) : a := llcorner p ;
                 b := urcorner p ;
  elseif (n=2) : a := lrcorner p ;
                 b := ulcorner p ;
  elseif (n=3) : a := urcorner p ;
                 b := llcorner p ;
  elseif (n=4) : a := ulcorner p ;
                 b := lrcorner p ;
  elseif (n=5) : a := .5[ulcorner p,llcorner p] ;
                 b := .5[urcorner p,lrcorner p] ;
  elseif (n=6) : a := .5[llcorner p,lrcorner p] ;
                 b := .5[ulcorner p,urcorner p] ;
  elseif (n=7) : a := .5[lrcorner p,urcorner p] ;
                 b := .5[llcorner p,ulcorner p] ;
  elseif (n=8) : a := .5[urcorner p,ulcorner p] ;
                 b := .5[lrcorner p,llcorner p] ;
  else         : a := .5[ulcorner p,llcorner p] ;
                 b := .5[urcorner p,lrcorner p] ;
  fi ;
enddef ;

def linear_shade (expr p, n, ca, cb) =
  begingroup ;
  save a, b, sh ; pair a, b ;
  set_linear_vector(a,b)(p,n) ;
  fill p withshade define_linear_shade (a,b,ca,cb) ;
  if trace_shades :
    drawarrow a -- b withpen pencircle scaled 1pt ;
  fi ;
  endgroup ;
enddef ;

vardef predefined_linear_shade (expr p, n, ca, cb) =
  save a, b, sh ; pair a, b ;
  set_linear_vector(a,b)(p,n) ;
  set_shade_vector(a,b)(p,n) ;
  define_linear_shade (a,b,ca,cb)
enddef ;

def set_circular_vector (suffix ab, r)(expr p,n) =
  if     (n=1) : ab := llcorner p ;
  elseif (n=2) : ab := lrcorner p ;
  elseif (n=3) : ab := urcorner p ;
  elseif (n=4) : ab := ulcorner p ;
  else         : ab := center   p ; r := .5r ;
  fi ;
enddef ;

def circular_shade (expr p, n, ca, cb) =
  begingroup ;
  save ab, r ; pair ab ; numeric r ;
  r := (xpart lrcorner p - xpart llcorner p) ++
       (ypart urcorner p - ypart lrcorner p) ;
  set_circular_vector(ab,r)(p,n) ;
  fill p withshade define_circular_shade(ab,ab,0,r,ca,cb) ;
  if trace_shades :
    drawarrow ab -- ab shifted (0,r) withpen pencircle scaled 1pt ;
  fi ;
  endgroup ;
enddef ;

vardef predefined_circular_shade (expr p, n, ca, cb) =
  save ab, r ; pair ab ; numeric r ;
  r := (xpart lrcorner p - xpart llcorner p) ++
       (ypart urcorner p - ypart lrcorner p) ;
  set_circular_vector(ab,r)(p,n) ;
  define_circular_shade(ab,ab,0,r,ca,cb)
enddef ;

%D Since a \type {fill p withshade s} syntax looks better
%D than some macro, we implement a new primary.

primarydef p withshade sc = % == p withcolor shadecolor(sh)
  hide (_color_counter_ := _color_counter_ + 1)
  p withcolor (_special_signal_/_special_div_,_color_counter_/_special_div_,sc/_special_div_)
enddef ;

vardef shadecolor(expr sc) =
  hide (_color_counter_ := _color_counter_ + 1)
  (_special_signal_/_special_div_,_color_counter_/_special_div_,sc/_special_div_)
enddef ;

%D Figure inclusion.

%numeric cef ; cef := 0 ;

def externalfigure primary filename =
  doexternalfigure (filename)
enddef ;

def doexternalfigure (expr filename) text transformation =
  begingroup ; save p, t ; picture p ; transform t ;
  p := nullpicture ; t := identity transformation ;
  flush_special(10, 9,
    dddecimal (xxpart t, yxpart t, xypart t) & " " &
    dddecimal (yypart t,  xpart t,  ypart t) & " " & filename) ;
  addto p contour unitsquare scaled 0 ;
  setbounds p to unitsquare transformed t ;
  _color_counter_ := _color_counter_ + 1 ;
  draw p withcolor (_special_signal_/_special_div_,_color_counter_/_special_div_,_special_counter_/_special_div_) ;
  endgroup ;
enddef ;

%D Experimental:

%numeric currenthyperlink ; currenthyperlink := 0 ;

def hyperlink primary t = dohyperlink(t) enddef ;
def hyperpath primary t = dohyperpath(t) enddef ;

def dohyperlink (expr destination) text transformation  =
  begingroup ; save somepath ; path somepath ;
  somepath := fullsquare transformation ;
  dohyperpath(destination) somepath ;
  endgroup ;
enddef ;

def dohyperpath (expr destination) expr somepath =
  begingroup ;
  flush_special(20, 7,
    ddecimal (xpart llcorner somepath, ypart llcorner somepath) & " " &
    ddecimal (xpart urcorner somepath, ypart urcorner somepath) & " " & destination) ;
  _color_counter_ := _color_counter_ + 1 ;
  fill boundingbox unitsquare scaled 0 withcolor
    (_special_signal_/_special_div_,_color_counter_/_special_div_,_special_counter_/_special_div_) ;
  endgroup ;
enddef ;

% \setupinteraction[state=start]
% \setupcolors     [state=start]
%
% Hello There! \blank
%
% \startMPcode
% pickup pencircle scaled 5 ;
% draw fullcircle scaled 4cm withcolor red ;
% hyperpath "nextpage" boundingbox currentpicture ;
% draw origin withcolor blue ;
% \stopMPcode
%
% \blank Does it work or not?
%
% \startMPcode
% pickup pencircle scaled 5 ;
% draw fullcircle scaled 4cm withcolor red ;
% hyperpath "nextpage" fullcircle scaled 4cm ;
% draw origin withcolor blue ;
% draw fullcircle scaled 4cm shifted (1cm,1cm);
% \stopMPcode
%
% \blank Does it work or not? \page Hello There! \blank
%
% \startMPcode
% pickup pencircle scaled 5 ;
% draw fullcircle scaled 2cm shifted (-2cm,-1cm) ;
% draw fullcircle scaled 3cm shifted (2cm,1cm) withcolor red ;
% draw fullcircle scaled 1cm ;
% hyperlink "previouspage" scaled 3cm shifted (2cm,1cm) ;
% draw origin withcolor blue ;
% \stopMPcode
%
% \blank Does it work or not?

_cmyk_counter_ := 0 ;

extra_endfig := " resetcmykcolors ; " & extra_endfig ;

def resetcmykcolors =
  numeric cmykcolorhash[][][][] ;
enddef ;

resetcmykcolors ; boolean cmykcolors ; cmykcolors := false ; % true

string cmykcolorpattern[] ; % needed for transparancies

vardef cmyk(expr c,m,y,k) =
  if cmykcolors :
    save ok ; boolean ok ;
    if unknown cmykcolorhash[c][m][y][k] :
      ok := false ; % not yet defined
    elseif cmykcolorhash[c][m][y][k] = -1 :
      ok := false ; % locally defined and undefined
    else :
      ok := true ;  % globally already defined
    fi ;
    if not ok :
      save s ; string s ; s := dddecimal (c,m,y) & " " & decimal k ;
      _cmyk_counter_ := _cmyk_counter_ + 1 ;
      cmykcolorpattern[_cmyk_counter_/_special_div_] := s ;
      cmykcolorhash[c][m][y][k] := _cmyk_counter_ ;
      flush_special(1, 7, decimal _cmyk_counter_ & " " & s) ;
      _local_specials_ := _local_specials_ &
        " cmykcolorhash[" & decimal c & "][" & decimal m &
        "][" & decimal y & "][" & decimal k & "] := -1 ; " ;
    fi ;
    (_special_signal_/_special_div_,1/_special_div_,cmykcolorhash[c][m][y][k]/_special_div_)
  else :
    (1-c-k,1-m-k,1-y-k)
  fi
enddef ;

% newcolor truecyan, truemagenta, trueyellow ;
%
% truecyan    = cmyk (1,0,0,0) ;
% truemagenta = cmyk (0,1,0,0) ;
% trueyellow  = cmyk (0,0,1,0) ;

%D Spot colors

_spotcolor_counter_ := 0 ;
_spotcolor_number_ := 0 ;

extra_endfig := " resetspotcolors ; " & extra_endfig ;

def resetspotcolors =
  numeric spotcolorhash[][] ;
enddef ;

resetspotcolors ; boolean spotcolors ; spotcolors := false ; % true

string spotcolorpattern[] ; % needed for transparancies

vardef spotcolor(expr p, s) =
  multitonecolor(p, 1, "", decimal s)
enddef ;

vardef multitonecolor(expr n, f, d, p) = % name fractions names factors
  if spotcolors :
    save ok, pc_tag ; boolean ok ; string pc_tag ;
    pc_tag := "_pct_" & n ;
    if not unstringed(pc_tag) :
      _spotcolor_number_ := _spotcolor_number_ + 1 ;
      setunstringed(pc_tag,_spotcolor_number_) ;
    fi ;
    pp := getunstringed(pc_tag) ;
    pc_tag := "_pct_"& decimal f & "_" & if d = "" : n else : d fi & "_" & p ; % check for d empty
    if not unstringed(pc_tag) :
      _spotcolor_number_ := _spotcolor_number_ + 1 ;
      setunstringed(pc_tag,_spotcolor_number_) ;
    fi ;
    ps := getunstringed(pc_tag) ;
    if unknown spotcolorhash[pp][ps] :
      ok := false ; % not yet defined
    elseif spotcolorhash[pp][ps] = -1 :
      ok := false ; % locally defined and undefined
    else :
      ok := true ;  % globally already defined
    fi ;
    if not ok :
      save ss ; string ss ; ss := n & " " & decimal f & " " & if d = "" : n else : d fi & " " & p ;
      _spotcolor_counter_ := _spotcolor_counter_ + 1 ;
      spotcolorpattern[_spotcolor_counter_/_special_div_] := ss ;
      spotcolorhash[pp][ps] := _spotcolor_counter_ ;
      flush_special(2, 7, decimal _spotcolor_counter_ & " " & ss) ;
      _local_specials_ := _local_specials_ &
        "spotcolorhash["&decimal pp&"]["&decimal ps&"]:=-1;" ;
    fi ;
    (_special_signal_/_special_div_,2/_special_div_,spotcolorhash[pp][ps]/_special_div_)
  else :
   .5white
  fi
enddef ;

%D Transparency

normaltransparent     :=  1 ; multiplytransparent   :=  2 ;
screentransparent     :=  3 ; overlaytransparent    :=  4 ;
softlighttransparent  :=  5 ; hardlighttransparent  :=  6 ;
colordodgetransparent :=  7 ; colorburntransparent  :=  8 ;
darkentransparent     :=  9 ; lightentransparent    := 10 ;
differencetransparent := 11 ; exclusiontransparent  := 12 ;

% nottransparent        :=  0 ;
% compatibletransparent := 99 ;

% fill fullcircle scaled 10cm withcolor transparant(8,.3,red) ;

vardef transparent(expr n, t, c) =
  save s, ss, nn, cc, is_cmyk, is_spot, ok ;
  string s, ss ; numeric nn ; color cc ; boolean is_cmyk, is_spot, ok ;
  % transparancy type
  if string n :
    if expandafter known scantokens(n&"transparent") :
      nn := scantokens(n&"transparent") ;
    else :
      nn := 0 ;
    fi
  else : % nn := min(n,13)
    nn := if n<13 : n else : nn := 0 fi ;
  fi ;
  % we need to expand the color (can be cmyk(..) or predefined)
  cc := c ; % expand color
  % check for cmyk special
  is_cmyk := (redpart   cc = _special_signal_/_special_div_)
         and (greenpart cc = 1/_special_div_) ;
  is_spot := (redpart   cc = _special_signal_/_special_div_)
         and (greenpart cc = 2/_special_div_) ;
  % build special string, fetch cmyk components
  s := decimal nn & " " & decimal t & " " &
       if     is_cmyk : cmykcolorpattern[bluepart cc]
       elseif is_spot : spotcolorpattern[bluepart cc]
       else           : dddecimal cc fi ;
  % check if this one is already used
  ss := cleanstring("tr_" & s) ;
  % we now have rather unique names, i.e. a color spec of .234 becomes
  % tr..._234.... and metapost gives a number overflow (parse error)
  % for variables like tr_12345678 which may result from many decimal
  % positions (imo mp bug)
  ss := asciistring(ss) ;
  % efficiency hack
  if expandafter unknown scantokens(ss) :
    ok := false ; % not yet defined
  elseif scantokens(ss) < 0  :
    ok := false ; % locally defined and undefined
  else :
    ok := true ;  % globally already defined
  fi ;
  if not ok :
    if is_spot  :
      flush_special(5, 8, s) ;
    elseif is_cmyk :
      flush_special(4, 8, s) ;
    else :
      flush_special(3, 7, s) ;
    fi ;
    scantokens(ss) := _special_counter_ ;
    _local_specials_ := _local_specials_ &
      "scantokens(" & ditto & ss & ditto & ") := -1 ;" ;
  fi ;
  % go ahead
  if is_spot :
    (_special_signal_/_special_div_,5/_special_div_,scantokens(ss)/_special_div_)
  elseif is_cmyk :
    (_special_signal_/_special_div_,4/_special_div_,scantokens(ss)/_special_div_)
  else :
    (_special_signal_/_special_div_,3/_special_div_,scantokens(ss)/_special_div_)
  fi
enddef ;

%D This function returns true of false, dependent on transparency.

vardef is_transparent(text t) =
  begingroup ; save transparent ; save _c_, _b_ ;
    vardef transparent(expr nn, tt, cc) = _b_ := true ; cc enddef ;
    boolean _b_ ; _b_ := false ;
    color _c_ ; _c_ := t ; _b_
  endgroup
enddef ;

%D This function returns the not transparent color.

vardef not_transparent(text t) =
  begingroup ; save transparent ;
  vardef transparent(expr nn, tt, cc) = cc enddef ;
  t endgroup
enddef ;

%D Basic position tracking:

def register (expr label, width, height, offset) =
  begingroup ;
  flush_special(50, 7,
    ddecimal offset & " " &
    decimal  width  & " " &
    decimal  height & " " & label) ;
  endgroup ;
enddef ;

%D We cannot scale cmyk colors directly since this spoils
%D the trigger signal (such colors are no real colors).

vardef scaledcmyk(expr c,m,y,k,sf) =
  cmyk(sf*c,sf*m,sf*y,sf*k)
enddef ;

vardef scaledcmykasrgb(expr c,m,y,k,sf) =
  (sf*(1-c-k,1-m-k,1-y-k))
enddef ;

vardef scaledrgbascmyk(expr c,m,y,k,sf) =
  scaledcmyk(1-c,1-m,1-y,0,sf)
enddef ;

vardef scaledrgb(expr r,g,b,sf) =
  (sf*(r,g,b))
enddef ;

vardef scaledgray(expr s,sf) =
  (sf*(s,s,s))
enddef ;

% spotcolor is already scaled

endinput ;

% just an exercise (due to a question by Chof on the context mailing list); scaling of
% 'special' colors is not possible and the next solution is incomplete (spot colors,
% transparency, etc); watch the the tricky chained macro construction

% vardef normalgray(expr s      ) = (s,s,s) enddef ;
% vardef normalrgb (expr r,g,b  ) = (r,g,b) enddef ;
% vardef normalcmyk(expr c,m,y,k) = if cmykcolors : save ok ; boolean ok ; if unknown cmykcolorhash[c][m][y][k] : ok := false ; elseif cmykcolorhash[c][m][y][k] = -1 : ok := false ; else : ok := true ; fi ; if not ok : save s ; string s ; s := dddecimal (c,m,y) & " " & decimal k ; _cmyk_counter_ := _cmyk_counter_ + 1 ; cmykcolorpattern[_cmyk_counter_/_special_div_] := s ; cmykcolorhash[c][m][y][k] := _cmyk_counter_ ; flush_special(1, 7, decimal _cmyk_counter_ & " " & s) ; _local_specials_ := _local_specials_ & " cmykcolorhash[" & decimal c & "][" & decimal m & "][" & decimal y & "][" & decimal k & "] := -1 ; " ; fi ; (_special_signal_/_special_div_,1/_special_div_,cmykcolorhash[c][m][y][k]/_special_div_) else : (1-c-k,1-m-k,1-y-k) fi enddef ;

% vardef gray(expr s)       = normalgray(s      ) enddef ;
% vardef rgb (expr r,g,b)   = normalrgb (r,g,b  ) enddef ;
% vardef cmyk(expr c,m,y,k) = normalcmyk(c,m,y,k) enddef ;

% numeric _scaled_color_t_ ;
% color   _scaled_color_c_ ;

% def withscaledcolor =
%     hide (
%         _scaled_color_t_ := 0 ; % direct
%         def gray(expr s) =
%             hide (
%                 _gray_s_ := s ;
%                 _scaled_color_t_ := 1; % gray
%             )
%             0
%         enddef ;
%         def rgb (expr r,g,b) =
%             hide (
%                 _rgb_r_ := r ; _rgb_g_ := g ; _rgb_b_ := b ;
%                 _scaled_color_t_ := 2 ; % rgb
%             )
%             0
%         enddef ;
%         def cmyk (expr c,m,y,k) =
%             hide (
%                 _cmyk_c_ := c ; _cmyk_m_ := m ; _cmyk_y_ := y ; _cmyk_k_ := k ;
%                 _scaled_color_t_ := 3 ; % cmyk
%             )
%             0
%         enddef ; )
%     dowithscaledcolor
% enddef ;

% def dowithscaledcolor expr t =
%     hide (
%         if color t : _scaled_color_c_ := t fi ;
%         vardef gray(expr s)       = normalgray(s)       enddef ;
%         vardef rgb (expr r,g,b)   = normalrgb (r,g,b)   enddef ;
%         vardef cmyk(expr c,m,y,k) = normalcmyk(c,m,y,k) enddef ;
%     )
% enddef ;

% def by expr s =
%     if     _scaled_color_t_ = 0 :
%         withcolor s*_scaled_color_c_
%     elseif _scaled_color_t_ = 1 :
%         withcolor gray(s*_gray_s_)
%     elseif _scaled_color_t_ = 2 :
%         withcolor rgb (s*_rgb_r_, s*_rgb_g_, s*_rgb_b_)
%     elseif _scaled_color_t_ = 3 :
%         withcolor cmyk(s*_cmyk_c_, s*_cmyk_m_, s*_cmyk_y_, s*_cmyk_k_)
%     fi
% enddef ;

% fill fullcircle scaled 10cm withscaledcolor cmyk(0,0,1,0) by .5 ;
% fill fullcircle scaled  8cm withscaledcolor rgb (0,0,1)   by .5 ;
% fill fullcircle scaled  6cm withscaledcolor gray(1)       by .5 ;
% fill fullcircle scaled  4cm withscaledcolor     (0,1,0)   by .5 ;
