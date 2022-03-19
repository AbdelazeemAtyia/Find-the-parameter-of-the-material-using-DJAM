clc
clear 
close all

global Hm Bm n_points  
  load p_nh;load Hm_filt;load Bm;
    Hm=Hm_filt(:,7);Bm=Bm(:,7);
x = [p_nh(1:5)];
Ms=x(1); 
k=x(2);
c=x(3);
alpha=x(4);
a=x(5); 
   
    
n_points = length(Hm);
mu0=4*pi*10^-7;

% Generating of more than one loops to reach the final path
Hm = [Hm;Hm;Hm;Hm;Hm;Hm];
Bm = [Bm;Bm;Bm;Bm;Bm;Bm]; 

% [y] = cost_fun(p_nh)
% return
perc_Ms = 0.9;
 perc_k = 1.2;
 perc_c = 0.3;
perc_alpha = 1.5;
perc_a = 1.5;

Lbx=[Ms-Ms*perc_Ms k-k*perc_k c-c*perc_c alpha-alpha*perc_alpha a-a*perc_a];
Ubx=[Ms+Ms*perc_Ms k+k*perc_k c+c*perc_c alpha+alpha*perc_alpha a+a*perc_a];

 %%%%%%%%%%%%%%%%
PARA=[Ms, k, c, alpha, a];

options=psoptimset('MaxIter',15,'Display','iter','CompletePoll','On', ...
    'PollingOrder','Success','InitialMeshSize',1,'ScaleMesh','On','TolX',0,'TolFun',0);
[PARA,fval,exit_flag] = fmincon(@cost_fun,PARA,[],[],[],[],Lbx,Ubx,[],options);
 %save Para_OJAM PARA -ascii






