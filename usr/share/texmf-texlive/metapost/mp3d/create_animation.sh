#! /bin/sh

/bin/rm -f animpoly.log
for i in `ls animpoly.*| grep 'animpoly.[0-9]'`;do
echo $i
echo '=============='
awk  < $i '{print} /^%%Page: /{print "142 123 translate\n"}' > $i.ps
gs -sDEVICE=ppmraw -sPAPERSIZE=a4 -dNOPAUSE -r36 -sOutputFile=$i.ppm -q -- $i.ps
/bin/rm -f $i.ps
ppmquant 32 $i.ppm | pnmcut 0 114 141 307 | ppmtogif > `expr $i.ppm : '\(.*\)ppm'`gif
/bin/rm -f $i.ppm
done
/bin/rm -f animpoly.gif
gifmerge -10 -l1000 animpoly.*.gif > animpoly.gif
/bin/rm -f animpoly.*.gif
