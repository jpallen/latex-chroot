
ENTRY
  { main1
    add1
    file
    source1
    caption1
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
  main1 write$
  "}{" write$
  add1 output
  "}{" write$
  file write$
  "}{" write$
  source1 output
  "}{" write$
  caption1 output
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
