% D. Roegel, 20/5/2001

input metaobj

% Proof from
% David, Nour, Raffalli: Introduction à la logique, Paris: Dunod, 2001
% p. 197

verbatimtex
  \newcount\pntcnt
  \pntcnt=0
  \def\npoints#1{\pntcnt=#1\vbox{\offinterlineskip\kern5pt\npointsa}}
  \def\npointsa{\ifnum\pntcnt>0\hbox{$.$}\kern5pt\advance\pntcnt-1
                  \expandafter\npointsa\fi}      
etex

beginfig(1);
%  setObjectDefaultOption("PTree")("treemode")("U");    % default is down
  newAssumption.pi1(btex $\Pi_1$ etex);
  newConclusion.pi1c1(btex \npoints3 etex);
  newPTreeR.pi1proof(pi1c1)(pi1)("") "rule(0)";
  newConclusion.pi1c2(btex $\Gamma,B \vdash \Delta$ etex);
  newPTreeR.a1(pi1c2)(pi1proof)("") "rule(0)";
  
  newAssumption.pi2(btex $\Pi_2$ etex);
  newConclusion.pi2c1(btex \npoints3 etex);
  newPTreeR.pi2proof(pi2c1)(pi2)("") "rule(0)";
  newConclusion.pi2c2(btex $\Gamma,C \vdash \Delta$ etex);
  newPTreeR.a2(pi2c2)(pi2proof)("") "rule(0)";

  
  newConclusion.c1(btex $\Gamma,B\lor C \vdash \Delta$ etex);
  newPTreeR.proof1(c1)(a1,a2)(btex $\lor_g$ etex);

  newAssumption.pi3(btex $\Pi_3$ etex);
  newConclusion.pi3c1(btex \npoints3 etex);
  newPTreeR.pi3proof(pi3c1)(pi3)("") "rule(0)";
  newConclusion.pi3c2(btex $\Gamma' \vdash B,C, \Delta'$ etex);
  newPTreeR.a3(pi3c2)(pi3proof)("") "rule(0)";
  
  newConclusion.c2
       (btex $\Gamma_A,\Gamma'\vdash B,C,\Delta,\Delta'_A$ etex);
  newPTreeR.proof2(c2)(proof1,a3)(btex {\it mix\/}$(1)$ etex);
  newConclusion.c2points
      (btex $\npoints{12}$ etex);
  newPTreeR.proof2a(c2points)(proof2)("") "rule(0)";
  
  duplicateObj(a4,a1);
  duplicateObj(a5,a3);
  newConclusion.c3(btex $\Gamma' \vdash B\lor C, \Delta'$ etex);
  newPTreeR.proof3(c3)(a5)(btex $\lor_d$ etex);
  newConclusion.c4(btex $\Gamma_A,\Gamma',B \vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof4(c4)(a4,proof3)(btex {\it mix\/}$(2)$ etex);
  newConclusion.c5(btex $\Gamma_A,\Gamma',\Gamma_A,\Gamma'
                        \vdash C,\Delta, \Delta'_A,\Delta, \Delta'_A$ etex);
  newHRazor.hr1(-4cm);
  newPTreeR.proof5(c5)(proof2a,hr1,proof4)(btex {\it mix\/}$(3)$ etex);

  duplicateObj(a6,a2);
  
  duplicateObj(proof3a,proof3); 
  
  newConclusion.c7(btex $\Gamma_A,\Gamma',C
                        \vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof3b(c7)(a6,proof3a)(btex {\it mix\/}$(4)$ etex);
  newConclusion.c8(btex $\Gamma_A,\Gamma',\Gamma_A,\Gamma',\Gamma_A,\Gamma'
        \vdash \Delta, \Delta'_A,\Delta, \Delta'_A,\Delta, \Delta'_A$ etex);
  newPTreeR.proof3d(c8)(proof5,proof3b)(btex {\it mix\/}$(5)$ etex)
                     "hsep(5mm)";
  newConclusion.c9(btex $\Gamma_A,\Gamma'\vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof3E(c9)(proof3d)(btex contr$_g$,contr$_d$ etex);


  %yscaleObj(proof3E,2);
  %reflectObj(proof3E,(0,0),(0,1));
  %slantObj(proof3E,0.2);
  
  proof3E.c=origin;
  drawObj(proof3E);

endfig;

clearObj pi,a,c,proof,hr;

beginfig(2);
  setObjectDefaultOption("PTree")("treemode")("U");    % default is down
  newAssumption.pi1(btex $\Pi_1$ etex);
  newConclusion.pi1c1(btex \npoints3 etex);
  newPTreeR.pi1proof(pi1c1)(pi1)("") "rule(0)";
  newConclusion.pi1c2(btex $\Gamma,B \vdash \Delta$ etex);
  newPTreeR.a1(pi1c2)(pi1proof)("") "rule(0)";
  
  newAssumption.pi2(btex $\Pi_2$ etex);
  newConclusion.pi2c1(btex \npoints3 etex);
  newPTreeR.pi2proof(pi2c1)(pi2)("") "rule(0)";
  newConclusion.pi2c2(btex $\Gamma,C \vdash \Delta$ etex);
  newPTreeR.a2(pi2c2)(pi2proof)("") "rule(0)";

  
  newConclusion.c1(btex $\Gamma,B\lor C \vdash \Delta$ etex);
  newPTreeR.proof1(c1)(a1,a2)(btex $\lor_g$ etex);

  newAssumption.pi3(btex $\Pi_3$ etex);
  newConclusion.pi3c1(btex \npoints3 etex);
  newPTreeR.pi3proof(pi3c1)(pi3)("") "rule(0)";
  newConclusion.pi3c2(btex $\Gamma' \vdash B,C, \Delta'$ etex);
  newPTreeR.a3(pi3c2)(pi3proof)("") "rule(0)";
  
  newConclusion.c2
       (btex $\Gamma_A,\Gamma'\vdash B,C,\Delta,\Delta'_A$ etex);
  newPTreeR.proof2(c2)(proof1,a3)(btex {\it mix\/}$(1)$ etex);
  newConclusion.c2points
      (btex $\npoints{12}$ etex);
  newPTreeR.proof2a(c2points)(proof2)("") "rule(0)";
  
  duplicateObj(a4,a1);
  duplicateObj(a5,a3);
  newConclusion.c3(btex $\Gamma' \vdash B\lor C, \Delta'$ etex);
  newPTreeR.proof3(c3)(a5)(btex $\lor_d$ etex);
  newConclusion.c4(btex $\Gamma_A,\Gamma',B \vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof4(c4)(a4,proof3)(btex {\it mix\/}$(2)$ etex);
  newConclusion.c5(btex $\Gamma_A,\Gamma',\Gamma_A,\Gamma'
                        \vdash C,\Delta, \Delta'_A,\Delta, \Delta'_A$ etex);
  newHRazor.hr1(-4cm);
  newPTreeR.proof5(c5)(proof2a,hr1,proof4)(btex {\it mix\/}$(3)$ etex);

  duplicateObj(a6,a2);
  
  duplicateObj(proof3a,proof3); 
  
  newConclusion.c7(btex $\Gamma_A,\Gamma',C
                        \vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof3b(c7)(a6,proof3a)(btex {\it mix\/}$(4)$ etex);
  newConclusion.c8(btex $\Gamma_A,\Gamma',\Gamma_A,\Gamma',\Gamma_A,\Gamma'
        \vdash \Delta, \Delta'_A,\Delta, \Delta'_A,\Delta, \Delta'_A$ etex);
  newPTreeR.proof3d(c8)(proof5,proof3b)(btex {\it mix\/}$(5)$ etex)
                     "hsep(5mm)";
  newConclusion.c9(btex $\Gamma_A,\Gamma'\vdash \Delta, \Delta'_A$ etex);
  newPTreeR.proof3E(c9)(proof3d)(btex contr$_g$,contr$_d$ etex);


  %yscaleObj(proof3E,2);
  %reflectObj(proof3E,(0,0),(0,1));
  %slantObj(proof3E,0.2);
  
  proof3E.c=origin;
  drawObj(proof3E);

endfig;



end
