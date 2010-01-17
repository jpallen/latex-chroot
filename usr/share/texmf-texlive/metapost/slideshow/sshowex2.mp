%%
%% slide-show example which demonstrates text wrapping, and changing the background
%% on the fly
%%


input slideshow;

% start with a blue to red gradient, then `gradually' shift it to red to blue
noslides := 11;
def doback =
   background := image(drawgradient((charcode/noslides)[blue,red], (charcode/noslides)[red,blue]););
enddef;

doback;

extra_endfig := extra_endfig & "doback;";

continue;
nextfig;
  header("A Walk in the Park");
endfig;
bpoint("I was walking in the park one day, when the most remarkable thing happened.");
bpoint("There was a lady there, well, I say lady because I was brought up to believe one should use this term to refer to adult members of the fair sex, but from her behaviour, I'm not sure it's the right term at all.");
bpoint("This lady, as I call her, was conveying herself by way of two-wheeled roller skates, and she was wearing a tiny pair of short pants, and a top which, although it completely covered her torso, was extremely revealing as to her form.");
bpoint("Well, she noticed that she had my attention, and behaved in a manner which I can only describe as provacative in the extreme.");
bpoint(ditto & "Do you want a closer look, Jack?" & ditto & " she asked (but my name is not Jack, nor John for that matter), and then she lifted her top, exposing the most disgusting protuberances.");
bpoint("Needless to say, I was shocked.");
bpoint("I quickly found a park warden and reported the vixen (I can't bring myself to call her a lady again).");
bpoint(ditto & "What, the one in the white spandex top?" & ditto & " he exclaimed.");
bpoint("I supposed that's what that material was, and he assured me that he would seek her out and speak to her about the matter.");
bpoint("It seemed to me that more severe handling was suggested by the circumstances, but he was eager to do the job, so I left him to it.");



end
