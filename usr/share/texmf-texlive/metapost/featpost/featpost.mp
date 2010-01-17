% featpost.mp
% L. Nobre G.
% 2005
%
% Use "export TEX=latex" in your .bashrc.
% Begin by pre-compiling this set of macros with "inimpost featpost.mp".
% Produce your PostScript (PS) figures with "mpost -mem featpost file".
% The output of this command (one or several files named "file.N")
% must be in the current directory to use the bashscripts laproof,
% lbproof and lcproof. Produce your EncapsulatedPostScript (EPS) figures 
% with "bashscript/lXproof file N". laproof tranforms PS into EPS if
% the figure is smaller than an A4 page. lbproof produces JPEG and EPS
% that fits the width of an A4 portrait page and lcproof produces EPS 
% that fits the height of an A4 portrait page independently of its 
% original size.
% N is the number of the figure (in file) that you want to encapsulate.
% It is not necessary to use "export TEX=latex" nor "lXproof file N"
% if the figures have no text. 
% The resulting EPS figures are not insertable in LaTex documents.
% The originals file.N are.

input plain;
input featpost3Dplus2D;

dump;

% It is possible to interactively experiment the effect
% of figure parameters. This requires:
% 1) MetaPost code written as "anglinerigorouscircle.mp".
% 2) xcmd package (kindly provided by Pedro Sebastião);
%	  it may be downloaded from http://lince.cii.fc.ul.pt/
%	  in Debian, Red Hat or tar.gz package formats.
% 3) Perl.
% 4) gv.
% 5) run command "xcmd/xmpost anglinerigorouscircle" or 
%		 "xcmd/xmpost anymetapostwoextension".
