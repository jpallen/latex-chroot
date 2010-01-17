%%
%% This is file `law.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% camel.dtx  (with options: `bstheader,eng')
%% law.dtx  (with options: `bstheader,eng')
%% camel.dtx  (with options: `bstlibrary,eng')
%% law.dtx  (with options: `bstfunctions,eng')
%% camel.dtx  (with options: `bsttrailer,eng')
%% This file is part of the Law module of the Camel package.
%% ---------------------------------------------------------
%% This is a generated file.
%% IMPORTANT NOTICE:
%% 
%% You are allowed to change this file, subject to the following
%% conditions.  Under any circumstances, new macro definitions
%% should not be added to this file.  You are welcome to modify
%% the macro definitions contained in this file for your own
%% use.  If you pass a copy of the modified version to someone
%% else, you should (a) let me know about the change on
%% fb@soas.ac.uk, and (b) put a note of the changes and of your
%% own contact details in the file.  Furthermore, you must
%% acknowledge Camel and its author(s) in the new file (if it
%% is distributed to others), and you must attach these same
%% conditions to the new file.
%% 
%% You are not allowed to distribute this file alone.  You are not
%% allowed to take money for the distribution or use of this file
%% (or a changed version) except for a nominal charge for copying
%% etc.
%% 
%% You are allowed to distribute this file under the condition that
%% it is distributed with all of its contents, intact.
%% 
%% For error reports, or offers to help make Camel a more powerful,
%% friendlier, and better package, please contact me on
%% `fb' at soas.ac.uk
%% 
FUNCTION { hello }
{
"     ============================================"
"     bibliography package, version 1.0k or later"
"     Use with LaTeX2e and the Camel prototype    "
"     --------------------------------------------"
"     documentation last updated: 5 December 1994 "
"     code last updated: 22 March 1995            "
"     version:           1.0i                     "
"     Camel style package.                        "
"     This is the `law' style for BibTeX and the  "
"     ============================================"
stack$
}
ENTRY
{ address
annote
author
booktitle
chapter
edition
editor
howpublished
institution
journal
key
month
note
number
organization
pages
publisher
school
series
title
type
volume
year
date
jurisdiction
court
division
divno
casedate
translator
booktranslator
cites
units
}
{}
{ label extra.label sort.label }
STRINGS { s t u v scrubdate
 volume.var year.var number.var journal.var pages.var }
INTEGERS { itemcount date.specials charcount a b c
           nameptr namesleft numnames a.logical }
FUNCTION {dc..} {"District Court"}
FUNCTION {sc..} {"Supreme Court"}
 FUNCTION {not}
 {   { #0 }
     { #1 }
   if$
 }
 FUNCTION {and}
 {   'skip$
     { pop$ #0 }
   if$
 }
 FUNCTION {or}
 {   { pop$ #1 }
     'skip$
   if$
 }
FUNCTION {times.ten}
 { duplicate$ duplicate$ duplicate$ duplicate$ duplicate$
   duplicate$ duplicate$ duplicate$ duplicate$
   + + + + + + + + +
 }
FUNCTION {character.length}
    { 'u :=
      #0 'charcount :=
      { u empty$ not }
        { u
         #2
          global.max$ substring$ 'u :=
          charcount #1 + 'charcount :=
        }while$
      charcount
    }
FUNCTION {first.in.second}
    { 's :=
      duplicate$ empty$
      { pop$ pop$ #0 #0 }
      { swap$ duplicate$ character.length 'a :=
        swap$ duplicate$ character.length 'b :=
        b a <
        { pop$ pop$ #0 #0 }
        { s "end" =
          { b a - #1 + global.max$ substring$ =
            { b a - #1 + #1 }
            { #0 #0
            }if$
          }
          { s "start" =
            { #1 a substring$ =
              { #1 #1 }
              { #0
              }if$
            }
            { s "reverse" =
              { b a - #1 + 'b :=
                { b #0 > }
                { duplicate$
                  b a substring$
                  's :=
                  swap$ duplicate$ s =
                    { pop$ pop$ b #0 'b := #1 }
                    { b #1 =
                      { pop$ pop$ #0 #0 'b := #0 }
                      { swap$ b #1 - 'b :=
                      }if$
                    }if$
                }while$
              }
              { b a - #1 + 'b := #1 'c :=
                { c b < }
                { duplicate$
                  c a substring$
                  's :=
                  swap$ duplicate$ s =
                    { pop$ pop$ c b 'c := #1 }
                    { b c - #1 =
                      { pop$ pop$ #0 b 'c := #0 }
                      { swap$ c #1 + 'c :=
                      }if$
                    }if$
                }while$
              }if$
            }if$
          }if$
        }if$
      }if$
    }
FUNCTION { get.character.type }
  { duplicate$ "*" =
     { pop$ duplicate$ empty$
        { pop$ "other" }
        { chr.to.int$ duplicate$
          duplicate$ #47 > swap$ #58 < and
          { pop$ "numeral" }
          { duplicate$ #64 > swap$ duplicate$ #91 < swap$
            duplicate$ #96 > swap$ #123 < and 'a.logical :=
            and a.logical or
            { "letter" }
            { "other"
            }if$
          }if$
        }if$
     }
     { =
       { "other" }
       { "letter"
       }if$
     }if$
  }
FUNCTION { type.last.char }
  { duplicate$ character.length
    #1 substring$
    "*" get.character.type
  }
 FUNCTION {empty.to.null}
 { duplicate$ empty$
     { pop$ "" }
     'skip$
   if$
 }
FUNCTION { check }
{ 't :=
  duplicate$ empty$
  { "empty " t * " in " * cite$ * warning$}
  'skip$
  if$
}
FUNCTION {either.or}
 { duplicate$ empty$
   { pop$ duplicate$ empty$
     { pop$ "" }
     'skip$
     if$
   }
   { swap$ duplicate$ empty$
     { pop$ }
     { "both items in an either.or pair are non-empty in " cite$ *
       warning$
       "  I'm using only ONE of these items (the second passed by the function)."
       warning$
       pop$
     }if$
   }if$
 }
FUNCTION {either.or.nowarning}
 { duplicate$ empty$
   { pop$ duplicate$ empty$
     { empty.to.null }
     'skip$
     if$
   }
   { swap$ pop$ }
   if$
 }
FUNCTION {must.must.must}
    { empty.to.null 't :=
      empty.to.null swap$ empty.to.null swap$ t
      * *
      write$
    }
FUNCTION {might.ifone.must}
    { empty.to.null 't :=
      swap$ duplicate$ empty$
      { pop$ pop$ t }
      { swap$ empty.to.null t * * }
      if$
      write$
    }
FUNCTION {iftwo.might.iftwo}
    { 't :=
      duplicate$ empty$
       { pop$ pop$ }
       { empty.to.null swap$ empty.to.null swap$
         t empty.to.null
         * * write$ }
      if$
    }
FUNCTION {must.ifthree.might}
    { duplicate$ empty$
       { pop$ pop$ empty.to.null }
       { 't :=
         swap$ empty.to.null
         swap$ empty.to.null
         t * *
       }if$
      write$
    }
FUNCTION {field.tag.no.combine}
  { "endlabel" =
    { duplicate$ empty$
      { pop$ pop$ empty.to.null }
      { empty.to.null 's := empty.to.null
      swap$ empty.to.null swap$ s * *
      }if$
    }
    { duplicate$ empty$
      { pop$ pop$ empty.to.null }
      { empty.to.null 's := empty.to.null
        swap$ empty.to.null s swap$ * *
      }if$
    }if$
  }
FUNCTION {change.letter.case}
    { 't :=
      duplicate$ empty$
        'skip$
        { t chr.to.int$ "n" chr.to.int$ =
          'skip$
          { t change.case$ }
          if$
        }
      if$
    }
 FUNCTION {n.dashify}
 { 't :=
   ""
     { t empty$ not }
     { t #1 #1 substring$ "-" =
      { t #1 #2 substring$ "--" = not
          { "--" *
            t #2 global.max$ substring$ 't :=
          }
          {   { t #1 #1 substring$ "-" = }
           { "-" *
             t #2 global.max$ substring$ 't :=
           }
            while$
          }
        if$
      }
      { t #1 #1 substring$ *
        t #2 global.max$ substring$ 't :=
      }
       if$
     }
   while$
 }
FUNCTION { gather.chars }
  {
    "forward" =
    { swap$ duplicate$ character.length 'a :=
      't :=
      duplicate$
      { t #1 #1 substring$ swap$ get.character.type
        "other" =
        t empty$ not and }
      { t #2 global.max$ substring$ 't := duplicate$
      }while$
      duplicate$ t #1 #1 substring$ swap$ get.character.type
      t #1 #1 substring$ swap$
      "" swap$ duplicate$ 'u :=
      t #2 global.max$ substring$ 't :=
      { u = }
      { * swap$
        u * 'u :=
        u #1 #1 substring$ swap$
        u #1 #1 substring$
        u #2 global.max$ substring$ 'u :=
        t #1 #1 substring$ swap$ get.character.type
        t #1 #1 substring$ swap$
        duplicate$ u =
        { t #2 global.max$ substring$ 't :=  }
        { swap$ pop$
        }if$
      }while$
      swap$ pop$ t swap$ u
    }
    { swap$ duplicate$ character.length 'a :=
      't :=
      duplicate$
      { t a #1 substring$ swap$ get.character.type
        "other" =
        t empty$ not and }
      { a #1 - 'a :=
        t #1 a substring$ 't :=
      }while$
      duplicate$ t a #1 substring$ swap$ get.character.type
      t a #1 substring$ swap$
      "" swap$ duplicate$ 'u :=
      a #1 - 'a :=
      t #1 a substring$ 't :=
      { u = }
      { swap$ * swap$
        u * 'u :=
        u #1 #1 substring$ swap$
        u #1 #1 substring$
        u #2 global.max$ substring$ 'u :=
        t a #1 substring$ swap$ get.character.type
        t a #1 substring$ swap$
        duplicate$ u =
        { a #1 - 'a := t #1 a substring$ 't :=  }
        { swap$ pop$
        }if$
      }while$
      swap$ pop$ t swap$ u
    }if$
  }
 FUNCTION {tie.or.space.connect}
 { duplicate$ text.length$ #3 <
     { "~" }
     { " " }
   if$
   swap$ * *
 }
FUNCTION {format.pages}
    { swap$ duplicate$ empty$
      { pop$ pop$ "" }
      { swap$ duplicate$ "short" =
        { pop$
          's :=
          ""
          s #1 #1 substring$
          { "-" = not }
            { s #1 #1 substring$ *
              s #2 global.max$ substring$ 's :=
              s #1 #1 substring$
              duplicate$ "" =
                { pop$ "-" }
                'skip$
                if$
            }
          while$
        }
      { "full" =
        { pages n.dashify }
        { "invalid switch fed to the format.pages function"
           warning$
        }if$
      }if$
    }if$
}
FUNCTION {format.names}
    { swap$ duplicate$ empty$
        { swap$ pop$ }
        { 's :=
          'u :=
          #1 'nameptr :=
          s num.names$ 'numnames :=
          numnames 'namesleft :=
          { namesleft #0 > }
            { u "lastonly" =
              { s nameptr "{vv~}{ll}" format.name$ 't := }
              { u "firstinitial"  =
                { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't := }
                { u "full" =
                  { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=}
                  { "style error; invalid or non-existent toggle" warning$ }
                  if$
                }
                if$
              }
              if$
              nameptr #1 >
                { namesleft #1 >
                  { ", " * t * }
                  { numnames #2 >
                    { "," * }
                    'skip$
                    if$
                    t "others" =
                      { " et~al." * }
                      { " and " * t * }
                    if$
                  }
                if$
                }
                't
              if$
              nameptr #1 + 'nameptr :=
              namesleft #1 - 'namesleft :=
            }
          while$
        }
      if$
    }
 FUNCTION {format.month.year}
 { year empty$
     { month empty$
      { "" }
      { "there's a month but no year in " cite$ * warning$
        month
      }
       if$
     }
     { month empty$
      'year
      { month " " * year * }
       if$
     }
   if$
 }
FUNCTION {fillout.a.year}
 { duplicate$ character.length #2 =
   { "19" swap$ * }
   'skip$
   if$
 }
FUNCTION {parse.month}
 { duplicate$ "jan" =
   { pop$ "1" }
   { duplicate$ "feb" =
     { pop$ "2" }
     { duplicate$ "mar" =
       { pop$ "3" }
       { duplicate$ "apr" =
         { pop$ "4" }
         { duplicate$ "may" =
           { pop$ "5" }
           { duplicate$ "jun" =
             { pop$ "6" }
             { duplicate$ "jul" =
               { pop$ "7" }
               { duplicate$ "aug" =
                 { pop$ "8" }
                 { duplicate$ "sep" =
                   { pop$ "9" }
                   { duplicate$ "oct" =
                     { pop$ "10" }
                     { duplicate$ "nov" =
                       { pop$ "11" }
                       { duplicate$ "dec" =
                         { pop$ "12" }
                         { "invalid month in " cite$ * warning$
                           "passing text to Camel verbatim" warning$
                           "t" 'scrubdate :=
                         }if$
                       }if$
                     }if$
                   }if$
                 }if$
               }if$
             }if$
           }if$
         }if$
       }if$
     }if$
   }if$
 }
FUNCTION { format.month.name }
 { swap$ duplicate$ empty$
   { pop$ pop$ "" }
   { swap$ "long" =
     { duplicate$ "1" =
       { "January" }
       { duplicate$  "2" =
         { "February" }
         { duplicate$  "3" =
           { "March" }
           { duplicate$ "4" =
             { "April" }
             { duplicate$  "5" =
               { "May" }
               { duplicate$ "6" =
                 { "June" }
                 { duplicate$  "7" =
                   { "July" }
                   { duplicate$  "8" =
                     { "August" }
                     { duplicate$  "9" =
                       { "September" }
                       { duplicate$  "10" =
                         { "October" }
                         { duplicate$  "11" =
                           { "November" }
                           { duplicate$  "12" =
                             { "December" }
                             { "invalid month in " cite$ * warning$ ""
                               "passing text to Camel verbatim" warning$
                               "t" 'scrubdate :=
                             }if$
                           }if$
                         }if$
                       }if$
                     }if$
                   }if$
                 }if$
               }if$
             }if$
           }if$
         }if$
       }if$
     }
     { duplicate$ "1" =
       { "Jan." }
       { duplicate$  "2" =
         { "Feb." }
         { duplicate$  "3" =
           { "Mar." }
           { duplicate$ "4" =
             { "Apr." }
             { duplicate$  "5" =
               { "May" }
               { duplicate$ "6" =
                 { "Jun." }
                 { duplicate$  "7" =
                   { "Jul." }
                   { duplicate$  "8" =
                     { "Aug." }
                     { duplicate$  "9" =
                       { "Sept." }
                       { duplicate$  "10" =
                         { "Oct." }
                         { duplicate$  "11" =
                           { "Nov." }
                           { duplicate$  "12" =
                             { "Dec." }
                             { ""
                             }if$
                           }if$
                         }if$
                       }if$
                     }if$
                   }if$
                 }if$
               }if$
             }if$
           }if$
         }if$
       }if$
     }if$
swap$ pop$
   }if$
 }
FUNCTION {extract.date}
    { 'v := "" 's := "" 't := "" 'u :=
      itemcount #0 =
      { cites empty$
        { "some date or other is COMPLETELY empty in " cite$ *
          warning$ }
        'skip$
        if$
      }
      { itemcount #1 =
        { pop$ fillout.a.year 's := "" 'u := "" 't := }
        { itemcount #2 =
          { pop$ swap$ pop$ swap$ duplicate$ character.length #4 =
            { swap$ "--" swap$ * * 's := "" 't := }
            { swap$ fillout.a.year 's := 't :=
            }if$
            "" 'u :=
          }
          { itemcount #3 =
            { date.specials
              { pop$ fillout.a.year 's :=
                "month" =
                { 't :=
                  pop$ 'u := }
                { 'u :=
                  pop$ 't :=
                }if$
              }
              { pop$ fillout.a.year 's :=
                pop$ 'u :=
                pop$ 't :=
              }if$
            }
            { "too many items for date in " cite$ * warning$
            }if$
          }if$
        }if$
      }if$
      v duplicate$ "month.dd.yy" =
      { pop$ s ", " u "\ " t "long" format.month.name }
      { duplicate$ "dd.month.yy" =
        { pop$ s "\ " t "long" format.month.name "\ " u }
        { duplicate$ "mo.dd.yy" =
          { pop$ s ", " u "\ " t "short" format.month.name }
          { duplicate$ "dd.mo.yy" =
            { pop$ s "\ " t "short" format.month.name "\ " u }
            { duplicate$ "dd.mm.yy" =
              { pop$ s "/" t "/" u }
              { duplicate$ "mm.dd.yy" =
                { s "/" u "/" t }
                { "yy" =
                  { "" "" "" "" s }
                  { "invalid date toggle in style file" warning$
                  }if$
                }if$
              }if$
            }if$
          }if$
        }if$
      }if$
      "" 'v :=
      duplicate$ empty$
      { pop$ pop$ }
      { swap$ * 'v := }
      if$
      duplicate$ empty$
      { pop$ pop$ }
      { swap$ * v swap$ *  'v := }
      if$
      duplicate$ empty$
      { pop$ v }
      { v swap$ * }
      if$
 }
FUNCTION {topup.date}
 { 'a :=
   duplicate$ character.length #2 =
   { duplicate$ #1 #1 substring$ chr.to.int$ #48 -
     times.ten swap$ #2 #1 substring$ chr.to.int$ #48 -
     +
   }
   { duplicate$ character.length #1 =
     { chr.to.int$ #48 - }
     { pop$ #0 "I can't cope with more than two Japanese year digits in "
       cite$ * warning$
     }if$
   }if$
 a + int.to.str$
 }
FUNCTION {format.jdate}
 { duplicate$ #2 global.max$ substring$ "*" "forward" gather.chars
   pop$ 't := swap$
   #1 #1 substring$ duplicate$ "s" =
   { pop$ t #1925 topup.date }
   { duplicate$ "m" =
     { pop$ t #1867 topup.date }
     { duplicate$ "t" =
       { pop$ t #1911 topup.date }
       { "h" =
         { t #1988 topup.date }
         { "invalid Imperial calendar code in " cite$ * warning$
         }if$
       }if$
     }if$
   }if$
   swap$
   "*" "forward" gather.chars
   pop$ swap$
   "*" "forward" gather.chars
   pop$ swap$ pop$ 't := swap$ "default" swap$ t swap$ "default"
   swap$ "default"
   #2 'itemcount :=
 }
FUNCTION {format.date}
  { 'v :=
    empty.to.null 's :=
    #0 'charcount :=
    #0 'itemcount :=
    #0 'date.specials :=
    { s empty$ not }
      { s "*" "forward" gather.chars
        duplicate$ "letter" =
        { pop$ duplicate$ character.length #1 = itemcount not and
          { pop$ pop$ s format.jdate "" 's := }
          { duplicate$ character.length #3 =
            { swap$ 's :=
              parse.month "month" #1 'date.specials := }
            { swap$ 's :=
              pop$ "1" "invalid date in " cite$ * warning$
              "passing text to Camel verbatim" warning$
              "t" 'scrubdate :=
              "default"
            }if$
          }if$
        }
        { "numeral" =
          { duplicate$ character.length #1 =
            { swap$ 's := "default" }
            { duplicate$ character.length #2 =
              { swap$ 's := "default" }
              { duplicate$ character.length #4 =
                { swap$ 's := "default" }
                { swap$ 's := pop$ "1"
                  "invalid numerical element in date for " cite$ * warning$
                  "passing text to Camel verbatim" warning$
                  "t" 'scrubdate :=
                  "default"
                }if$
              }if$
            }if$
          }
          { swap$ 's := pop$ "1"
            "failed to parse date in " cite$ * warning$
            "default"
          }if$
        }if$
        itemcount #1 + 'itemcount :=
      }while$
    v extract.date
    scrubdate "t" =
    { pop$ year empty.to.null }
    'skip$
    if$
  }
FUNCTION {parse.one.cite}
{ duplicate$ "=" = not
  { "=" "forward" gather.chars pop$
    duplicate$ "[" swap$ "forward" first.in.second
    { swap$ duplicate$ "]" swap$ "forward" first.in.second
        { "" 'volume.var :=
          'b := swap$ 'a := a b <
            { duplicate$ a #1 + b a #1 + - substring$
              'year.var :=
              b #1 + global.max$ substring$
              " " "forward" gather.chars pop$
              duplicate$ "*" "forward" gather.chars
              "numeral" =
              { swap$ duplicate$ empty$
                { pop$ pop$ 'number.var := }
                { pop$ pop$ swap$ * "" 'number.var :=
                }if$
              }
              { pop$ pop$ " " swap$ * swap$ * "" 'number.var :=
              }if$
            }
            { "Weird syntax error in " cite$ * warning$
            }if$
        }
        { "Opening [ without closing ] in " cite$ * warning$
        }if$
    }
    { pop$ duplicate$ ")" swap$ "reverse" first.in.second
      { swap$ duplicate$ "(" swap$ "reverse" first.in.second
        { 'a := swap$ 'b := a b <
          { duplicate$ a #1 + b a #1 + - substring$
            'year.var :=
            #1 a #1 - substring$
            " " "forward" gather.chars pop$
            duplicate$ "/" swap$ "forward" first.in.second
              { pop$ "/" "forward" gather.chars pop$
                swap$ duplicate$ empty$
                  { pop$ "" 'number.var := }
                  { #2 global.max$ substring$
                    'number.var :=
                  }if$
              }
              { pop$ "" 'number.var :=
              }if$
            duplicate$ empty$
              { pop$ "" 'volume.var := }
              { duplicate$ "*" "forward" gather.chars
                "numeral" =
                { swap$ duplicate$ empty$
                  { pop$ pop$ 'volume.var := }
                  { pop$ pop$ swap$ * "" 'volume.var :=
                  }if$
                }
                { pop$ pop$ " " swap$ * swap$ * "" 'volume.var :=
                }if$
              }if$
          }
          { "Weird syntax error in " cite$ * warning$
          }if$
        }
        { "Closing ) without opening ( in " cite$ * warning$
        }if$
      }
      { pop$ "No recognizable date in string in " cite$ * warning$
      }if$
    }if$
    " " swap$ * " " "reverse" gather.chars pop$
    duplicate$ "*" "forward" gather.chars
    "numeral" =
    { swap$ duplicate$ empty$
      { pop$ pop$ 'pages.var := }
      { pop$ pop$ swap$ * "" 'pages.var :=
      }if$
    }
    { pop$ pop$ swap$ * "" 'pages.var :=
    }if$
   duplicate$ empty$
   { 'journal.var := }
   { duplicate$ character.length #2 -
     #3 swap$ substring$ 'journal.var :=
   }if$
 }
 'skip$
 if$
}
FUNCTION {build.bridges}
  { duplicate$ empty$
    { pop$ skip$ }
    { duplicate$ "sections" =
      { pop$ "\bridges{\ \S~}{}{\ \S\S~}{\ }{\ \S~}{\ \S\S~}"
      "" "" must.must.must
      }

      { duplicate$ "articles" =
        { pop$
          "\bridges{\ art.~}{}{\ arts.~}{\ }{\ art.~}{\ arts.~}"
          "" "" must.must.must
        }
        { "schedules" =
          { "\bridges{\ sched.~}{}{\ scheds.~}{\ }{\ sched.~}{\ scheds.~}"
            "" "" must.must.must
          }
          'skip$
          if$
        }if$
      }if$
    }if$
 }
FUNCTION { get.a.kinda.sort.key }
{     author empty$
     { title empty$
       { "0000" }
       { title "*" "forward" gather.chars pop$
         duplicate$ "l" change.letter.case "the" =
         { pop$ "*" "forward" gather.chars pop$ swap$ pop$ }
         { duplicate$ "l" change.letter.case "a" =
           { pop$ "*" "forward" gather.chars pop$ swap$ pop$ }
           { swap$ pop$
           }if$
         }if$
       }if$
     }
     { author #1 "{ll}" format.name$
     }if$
}
FUNCTION {j.format.division}
 { division empty$
   'skip$
   { dc.. court "end" first.in.second
     { pop$ " No.~" 's := "endlabel" 't := }
     { pop$ sc.. court "start" first.in.second
       { pop$ "No.\ " 's := "frontlabel" 't := }
       {  pop$ " " 's :=  "endlabel" 't :=
       }if$
     }if$
   }if$
   division s divno t field.tag.no.combine
 }
FUNCTION {article}
{ volume empty$ not number empty$ not and
  volume empty$ number empty$ year "mo.dd.yy" format.date
  pop$ itemcount #1 = not and and or
  { "\bridges{,\ p.~}{,\ }{,\ }{\ }{\ at~}{\ at~}"
    "" "" must.must.must
    newline$
  }
  { title type.last.char "numeral" =
    { "\bridges{,\ }{,\ }{,\ }{\ }{\ at~}{\ at~}"
      "" "" must.must.must
      newline$
    }
    'skip$
    if$
  }if$
 "\lexibib{article}{" cite$ "}{" must.must.must
 get.a.kinda.sort.key
 "}{" "" must.must.must
author  "lastonly" format.names
"}{"
""
must.must.must
title "title" check
"}{"
""
must.must.must
  volume empty$ not number empty$ not and
  { journal "journal" check ", v.~" volume must.must.must
    ", n.~" number "}{" must.must.must }
  { volume empty$ not
    { volume "\ " journal "journal" check empty.to.null
      might.ifone.must
      "}{" "" "" must.must.must}
    { year "mo.dd.yy" format.date itemcount #1 =
      { "[" swap$ "] " iftwo.might.iftwo
      number "\ " journal "journal" check might.ifone.must
      "}{" "" "" must.must.must}
      { pop$ number empty$
        { "\\" journal "journal" check "\\" must.must.must
          "}{" "" "" must.must.must }
        { number "\ " journal "journal" check might.ifone.must
          "}{" "" "" must.must.must
        }if$
      }if$
    }if$
  }if$
pages "short" format.pages "pages" check
"}{"
""
must.must.must
volume empty$ not
  { "(" "" "" must.must.must
    publisher ":\ " "" might.ifone.must
    "" year "mo.dd.yy" format.date ")" must.must.must }
  { year "mo.dd.yy" format.date itemcount #1 =
    'pop$
    { "" "" must.must.must
    }if$
  }if$
crossref empty$
{ "}" "" "" must.must.must }
{ booktitle empty$
  { "no booktitle (name of special issue) for "
     cite$ "/" crossref ".  Why a crossref?" * * * * warning$
    "}" "" "" must.must.must }
  { volume empty$ {""} {") ("} if$ booktitle "}" must.must.must}
  if$
}if$
newline$
}
FUNCTION {book}
{ title type.last.char "numeral" =
    { "\bridges{,\ }{}{,\ }{\ }{\ at~}{\ at~}"
      "" "" must.must.must
      newline$
    }
    { units empty.to.null "paras" =
      { "\bridges{,\ para.~}{}{,\ paras.~}{\ }{,\ para.~}{,\ paras.}"
        "" "" must.must.must
        newline$
      }
      'skip$
      if$
    }if$
  "\lexibib{book}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{" must.must.must
  volume empty$
  { "" }
  { "\volno\ " }
  if$
  author
  "firstinitial" format.names "}{" must.must.must
  booktitle empty$
    { title "title" check "" ""  must.must.must }
    { booktitle ": " title must.ifthree.might
    }if$
  type empty.to.null "cmnd" =
  type empty.to.null "command" =
  type empty.to.null "command papers" =
  or or
  { ", " year "mo.dd.yy" format.date
    ", " "Cmnd. "
    * * *
    series empty$
    { "no.~" }
    { "Ser.~" series ", No.~" * *
    }if$
  number "number" check
   * *
   "" "" must.must.must
   }
   'skip$
   if$
  "}{}{}{" "(" "" must.must.must
    editor empty$ translator empty$ and
    { series empty$
      'skip$
      { series " No.~" number
      "endlabel" field.tag.no.combine ", " "" must.must.must }
      if$
    }
    { editor translator either.or "firstinitial" format.names
      translator empty$
      { editor num.names$ #1 >
        { " eds.\ " }
        { " ed.\ " }
        if$
      }
      { " trans.\ " }
      if$
      "" must.must.must
    }if$
  edition " ed.\ " "" might.ifone.must
  type empty.to.null "cmnd" =
  type empty.to.null "command" =
  type empty.to.null "command papers" =
  or or
  { "" }
  { year "mo.dd.yy" format.date
  }if$
  ")}" "" must.must.must
  newline$
}
FUNCTION{incollection}
{ "\lexibib{incollection}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{" must.must.must
  author "lastonly" format.names "author" check
  "}{" "" must.must.must
  title "title" check
  "}{" "" must.must.must
  chapter empty$
    { "\\in \\" }
    { "\\" type empty$
      { "chapter " chapter "chapter" check " of \\" * * * }
      { type " " chapter "chapter" check " of \\" * * * *
      }if$
    }if$
  booktitle "booktitle" check
  "}{" must.must.must
  pages "short" format.pages "pages" check
  "}{" "(" must.must.must
    editor empty$ translator empty$ and
    { series empty$
      'skip$
      { series " No.~" number
      "endlabel" field.tag.no.combine ", " "" must.must.must }
      if$
    }
    { editor booktranslator either.or "firstinitial" format.names
      booktranslator empty$
      { editor num.names$ #1 >
        { " eds.\ " }
        { " ed.\ " }
        if$
      }
      { " trans.\ " }
      if$
      "" must.must.must
    }if$
  edition " ed.\ " "" might.ifone.must
  year "mo.dd.yy" format.date ")}" "" must.must.must
  newline$
}
FUNCTION{inbook}
{ "\lexibib{inbook}{" cite$ "}{" must.must.must
  get.a.kinda.sort.key "" "}{" must.must.must
  author "firstinitial" format.names "author" check
  "}{" "" must.must.must
  title booktitle =
    { chapter empty$
      { "no chapter or separate title for inbook entry " cite$ * warning$
      }
      { "{\rm " "Chapter" type either.or.nowarning
        " " chapter " of} " * * * *
      }if$
    }
    { ""
    }if$
  title "title" check
  "}{" must.must.must
  title booktitle =
    { "" }
    { chapter empty$
      { "{\rm in} " }
      { type empty$
        { "{\rm Chapter " chapter " of} " * * }
        { "{\rm " type " " chapter " of} " * * * *
        }if$
      }if$
    }if$
  booktitle "booktitle" check
  "}{" must.must.must
  pages "short" format.pages "pages" check
  "}{" "(" must.must.must
    translator empty$
    { series empty$
      'skip$
      { series " No.~" number
      "endlabel" field.tag.no.combine ", " "" must.must.must }
      if$
    }
    { translator "firstinitial" format.names
      " trans.\ "
      "" must.must.must
    }if$
  edition " ed.\ " "" might.ifone.must
  year "mo.dd.yy" format.date ")" "}" must.must.must
  newline$
}
FUNCTION{booklet}
{ "\lexibib{booklet}{" cite$ "}{" must.must.must
  get.a.kinda.sort.key "" "}{" must.must.must
  author "full" format.names "}{" "" must.must.must
  "\\" title "\\}{}{}{(" must.must.must
  howpublished ", " "" might.ifone.must
  year "mo.dd.yy" format.date
  ")}" "" must.must.must
  newline$
}
FUNCTION {techreport}
{"\lexibib{techreport}{" cite$ "}{" must.must.must
  get.a.kinda.sort.key "" "}{" must.must.must
  institution author either.or.nowarning
  "full" format.names "author & institution" check
  "}{" title "title" check must.must.must
  "}{}{}{" "(" "" must.must.must
  author empty$
    'skip$
    {institution "\ "  "" might.ifone.must
    }if$
  type empty$
    { "Technical report" }
    { type
    }if$
  type empty.to.null "Cmnd" =
  { "\ " }
  { " No.~"
  }if$
  number "endlabel" field.tag.no.combine
  ", " "" must.must.must
  year "mo.dd.yy" format.date
  "" ")}" must.must.must
  newline$
  }
FUNCTION {mastersthesis}
{"\lexibib{mastersthesis}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "}{" "" must.must.must
  author
  "full" format.names "author" check
  "}{" title "title" check must.must.must
  "}{}{}{("
  type empty$
    { "Master's Thesis" }
    { type
    }if$
  ", " must.must.must
  institution "institution" check ", " "" might.ifone.must
  year "mo.dd.yy" format.date
  ")" "}" must.must.must
  newline$
  }
FUNCTION {clear.cite.vars}
 {
"" 'volume.var :=
"" 'number.var :=
"" 'journal.var :=
"" 'pages.var :=
"" 'year.var :=
 }
FUNCTION {case}
{ cites empty.to.null "=" *
  journal empty$
  { parse.one.cite }
  { volume empty.to.null 'volume.var :=
    number empty.to.null 'number.var :=
    journal 'journal.var :=
    pages empty.to.null 'pages.var :=
    year empty.to.null 'year.var :=
  }if$
  volume.var empty$ not number.var empty$ not and
  { "\bridges{,\ p.~}{,\ }{,\ }{\ }{\ at~}{\ at~}"
    "" "" must.must.must
    newline$ }
  'skip$
  if$
 "\lexibib{case}{" cite$ "}{" must.must.must
  get.a.kinda.sort.key "" "}{}{" must.must.must
  title empty$
  {  "Decision of the " court "court" check "" must.must.must
      " (" j.format.division ")" iftwo.might.iftwo
      ", " "" "" must.must.must
      casedate "month.dd.yy" format.date "" "" must.must.must
      "}{" "" "" must.must.must
  }
  { title "}{" "" must.must.must }
  if$
  volume.var empty$ not number.var empty$ not and
  { journal.var "journal" check ", v.~" volume.var must.must.must
    ", n.~" number.var "}{" must.must.must }
  { volume.var empty$
    { "[" year.var "mo.dd.yy" format.date "] " iftwo.might.iftwo
      number.var "\ " journal.var "journal" check might.ifone.must
      "}{" "" "" must.must.must }
    { volume.var "\ " journal.var "journal" check empty.to.null
      might.ifone.must
      "}{" "" "" must.must.must
    }if$
  }if$
pages.var "short" format.pages "pages" check
"}{"
"("
must.must.must
volume.var empty$
  'skip$
  { year.var "mo.dd.yy" format.date "" "" must.must.must
  }if$
crossref empty$
{ ")}" "" "" must.must.must }
{ booktitle empty$
  { "no booktitle (name of special issue) for "
     cite$ "/" crossref * * * warning$
    ")}" "" "" must.must.must }
  { volume.var empty$ {""} {") ("} if$ booktitle "}" must.must.must}
  if$
}if$
{ duplicate$ "=" = not }
{ parse.one.cite
  "={" "" "" must.must.must
  volume.var empty$ not number.var empty$ not and
  { journal.var "journal" check ", v.~" volume.var must.must.must
    ", n.~" number.var "}{" must.must.must }
  { volume.var empty$
    { "[" year.var "mo.dd.yy" format.date "] " iftwo.might.iftwo
      number.var "\ " journal.var "journal" check might.ifone.must
      "}{" "" "" must.must.must }
    { volume.var "\ " journal.var "journal" check empty.to.null
      might.ifone.must
      "}{" "" "" must.must.must
    }if$
  }if$
pages.var "short" format.pages "pages" check
"}{"
""
must.must.must
volume.var empty$
  'skip$
  { "(" year.var "mo.dd.yy" format.date ")" must.must.must
  }if$
crossref empty$
{ "}" "" "" must.must.must }
{ booktitle empty$
  { "no booktitle (name of special issue) for "
     cite$ "/" crossref * * * warning$
    "}" "" "" must.must.must }
  { volume.var empty$ {""} {") ("} if$ booktitle "}" must.must.must}
  if$
}if$
}while$
pop$
clear.cite.vars
newline$
annote empty.to.null write$ newline$
}
FUNCTION {j.statute}
 { "\lexibib{jstatute}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{}{" must.must.must
   title "title" check empty.to.null "}{}{}{" "" must.must.must
   title empty$ {""} {"("} if$
   "" "" must.must.must
   number empty$
     'skip$
     { type empty$
       { "Law" }
       { type
       }if$
       "\ no.~" *
       number "number" check " of "
       iftwo.might.iftwo
     }
     if$
   year "yy" format.date
   title empty$ {""} {")"} if$
   "}" must.must.must
   newline$
 }
FUNCTION { s.statute }
{ "\lexibib{statute}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{}{" must.must.must
  title "title" check ", No.~" number
  "endlabel" field.tag.no.combine
  number empty$
    { "\ " * }
    { "\ of " * }
    if$
  year "mo.dd.yy" format.date "}{}{}{}" must.must.must
  newline$
}
FUNCTION { e.statute }
{ "\lexibib{statute}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{}{" must.must.must
  title "title" check "\ "
  year "mo.dd.yy" format.date must.must.must
  "}{}{}{}" "" "" must.must.must
  newline$
}
FUNCTION { statute }
 { type build.bridges
   jurisdiction empty.to.null duplicate$
   "japan" =
   { pop$ j.statute }
   { duplicate$ "singapore" =
     { pop$ s.statute }
     { duplicate$ "england" =
       { pop$ e.statute }
       { pop$ "IMPORTANT: unknown jurisdiction for " cite$ * warning$
       }if$
     }if$
   }if$
 }
FUNCTION {unpublished}
{ "\lexibib{book}{" cite$ "}{" must.must.must
   get.a.kinda.sort.key "" "}{" must.must.must
  author "firstinitial" format.names "}{" "" must.must.must
  title "title" check "" ""  must.must.must
  "}{}{}{" "(" "" must.must.must
   note
  ")}" "" must.must.must
  newline$
}
FUNCTION {default.type} { book }
READ
EXECUTE {hello}
FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { et.al.char.used }

FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}

EXECUTE {initialize.et.al.char.used}

FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 >
    { numnames #4 >
        { #3 'namesleft := }
        { numnames 'namesleft := }
      if$
      #1 'nameptr :=
      ""
        { namesleft #0 > }
        { nameptr numnames =
            { s nameptr "{ff }{vv }{ll}{ jj}" format.name$ "others" =
                { "{\etalchar{+}}" *
                  #1 'et.al.char.used :=
                }
                { s nameptr "{v{}}{l{}}" format.name$ * }
              if$
            }
            { s nameptr "{v{}}{l{}}" format.name$ * }
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
      numnames #4 >
        { "{\etalchar{+}}" *
          #1 'et.al.char.used :=
        }
        'skip$
      if$
    }
    { s #1 "{v{}}{l{}}" format.name$
      duplicate$ text.length$ #2 <
        { pop$ s #1 "{ll}" format.name$ #3 text.prefix$ }
        'skip$
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            { key #3 text.prefix$ }
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        { key #3 text.prefix$ }
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "manual" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  duplicate$
  year "yy" format.date purify$ #-1 #2 substring$
  *
  'label :=
  year "yy" format.date purify$ #-1 #4 substring$
  *
  sortify 'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {case.sort}
{ title empty$
    { key empty$
        { "to sort, need title or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { title sort.format.title }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            { type$ "case" =
              'case.sort
              { type$ "statute" =
                'case.sort
                'author.sort
              if$
              }
            if$
            }
          if$
        }
      if$
    }
  if$
  "    "
  *
  year "yy" format.date sortify
  *
  "    "
  *
  title empty.to.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{$^{#1}$}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

EXECUTE {begin.bib}

ITERATE {call.type$}
%% 
%%
%% End of file `law.bst'.
