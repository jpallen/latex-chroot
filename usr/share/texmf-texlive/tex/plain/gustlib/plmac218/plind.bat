@echo off
rem Przyk/ladowy batch. (StaW)
rem PLindex sortuje plik przyklad.idx zapisany w standardzie Mazovii,
rem daj/ac wyj/sciowy plik przyklad.ind
rem U/zycie stylu plaintex.ist pozwala na sk/lad formatem MeX/Plain
plindex.exe -z mazovia -s plaintex.ist przyklad.idx
