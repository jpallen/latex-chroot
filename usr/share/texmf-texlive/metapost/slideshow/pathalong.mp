%% draw some text (t) along a curve (p)

vardef pathalong (expr _p, t) =
  save l, ll, del,let, pos, p;
  picture let, ll;
  path del, p;

  l := length(t) - 1;
  pos = 0;
  p := _p;

  ll := nullpicture;

  for i := 0 upto l:
    
    let := substring (i,i+1) of t infont defaultfont scaled defaultscale;

    addto ll also (let rotated(angle(direction pos of p)))
         shifted point pos of p;

    del := (((xpart urcorner let, infinity)--(xpart urcorner let, -infinity))
           rotated(angle(direction pos of p)))
           shifted point pos of p;

    p := subpath(pos,length(p)) of p;
    pos := ypart (del intersectiontimes p);
    exitif pos <= 0;

    endfor;

    ll
enddef;

%% draw the text contained in t so that the bottoms of the letters are on
%% the base-line and the tops abut path p
vardef textunder(expr p,t) =
  save l, ll, pos, h, i;
  picture l, ll;
  numeric pos, h, i;
  ll := nullpicture;
  pos := 0;
  for i = 0 upto (length t - 1):
    l := substring(i, i+1) of t infont defaultfont scaled defaultscale;
    h := ypart urcorner l;
    if h > 0:
      addto ll also (l yscaled ((ypart (((pos,-infinity)--(pos,infinity)) intersectionpoint p)) / ypart ulcorner l)) shifted (pos, 0);
    fi;
    pos := pos + xpart lrcorner l;
  endfor;

  ll
enddef;

