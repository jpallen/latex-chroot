#!/bin/sh
tex -ini -fmt=cyrtex -progname=tex cyrtex.ini
tex -ini -fmt=cyramstex -progname=amstex cyramstx.ini
tex -ini -fmt=cyrtexinfo -progname=texinfo cyrtxinf.ini
tex -ini -fmt=cyrblue -progname=tex cyrblue.ini

pdftex -ini -fmt=cyrpdftex -progname=pdftex cyrtex.ini
pdftex -ini -fmt=cyrpdftexinfo -progname=pdftexinfo cyrtxinf.ini
