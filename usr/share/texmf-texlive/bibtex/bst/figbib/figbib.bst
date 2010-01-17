
ENTRY
  { main
    add
    file
    source
    caption
  }
  {}
  {}
  
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'write$
  if$
}   

FUNCTION {fig}
{ newline$
  "\figbibitem{" write$
  cite$ write$
  "}{" write$
  main write$
  "}{" write$
  add output
  "}{" write$
  file write$
  "}{" write$
  source output
  "}{" write$
  caption output
  "}" write$
  newline$
}


FUNCTION {begin.thefigdblist}
{ "\begin{thefigbiblist}" write$ 
  newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

FUNCTION {end.thefigdblist}
{ newline$
  "\end{thefigbiblist}" write$
  newline$
}

READ
EXECUTE {begin.thefigdblist}
ITERATE {call.type$}
EXECUTE {end.thefigdblist}
