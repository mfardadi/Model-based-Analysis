%% initializations
clc
clear all
%node=21; % Number of nodes
node=11; % Number of nodes
% Internode=20; %Number of Internodes
Internode=10; %Number of Internodes
Nodal_L = 1e-4;% nodal length
Internodal_L=1150*1e-4;%micrometer
Xtotal=Nodal_L*node+Internodal_L*(node-1);
%Xelec=1/(10000); %1+Nodal_L*(node-1)/2+Internodal_L*(node-1)/2; % positioned on top of the middle node
%Xelec=1/(10000)+Nodal_L*(node-1)/2+Internodal_L*(node-1)/2; % positioned on top of the middle node
Xelec=Xtotal-Nodal_L*9-Internodal_L*9; %for lower level injury
% Yelec=500/10000;
Yelec=100/10000;
X = nan(node,1);
Y = nan(node,1);
for j=1:node 
    X(j)=Nodal_L*j+Internodal_L*(j-1);
    Y(j)=0;
end


node2=1; % Number of nodes
%Internode2=20; %Number of Internodes
Nodal_L2 = 1e-4;% nodal length
Internodal_L2=1150*1e-4;%micrometer
Xtotal2=Nodal_L2*node2+Internodal_L2*(node2-1);
Xelec2=1/(10000)+Nodal_L2*(node2-1)/2+Internodal_L2*(node2-1)/2; % positioned on top of the middle node
% Yelec=500/10000;
Yelec2=500/10000;
X2 = nan(node2,1);
Y2 = nan(node2,1);
for k=1:node2 
    X2(k)=Nodal_L2*k+Internodal_L2*(k-1);
    Y2(k)=0;
end
%Cn =1*1e-5/1^2;; % specific capacitance microF /cm2
Cn = 1; % specific capacitance microF /cm2
Ro_e = 500; %extracellular resistivity Ohm.cm
Ro_ax = 70;  %Ohm.cm
Ro_px = 70;  %Ohm.cm


ENaEx = 60; %mv NA+ Nernst potential 
EKEx = -90; %mv K Nernst potential 
ELEx = -65; %mv Leakage Nernst potential 
Erest = -65; %mv rest potential 
ErestE = -65; %mv rest potential 

gNaEx = 30 ; %mS/cm^2 maximum fast NA+ conductance 
gKEx = 100 ; %mS/cm^2 maximum slow K+ conductance 
gLEx = 0.1 ;  %mS/cm^2 maximum nodal leakage conductance


ENaIn = 55; %mv NA+ Nernst potential 
EKIn = -90; %mv K Nernst potential 
ELIn = -65; %mv Leakage Nernst potential 
ErestIn = -64; %mv rest potential 

gNaIn = 35 ; %mS/cm^2 maximum fast NA+ conductance 
gKIn = 9 ; %mS/cm^2 maximum slow K+ conductance 
gLIn = 0.1 ;  %mS/cm^2 maximum nodal leakage conductance


ENaS = 115; %mv NA+ Nernst potential 
EKS = -12; %mv K Nernst potential 
ELS = 10.5989; %mv Leakage Nernst potential 
ErestS = 0; %mv rest potential 

gNaS = 120 ; %mS/cm^2 maximum fast NA+ conductance 
gKS = 36 ; %mS/cm^2 maximum slow K+ conductance 
gLS = 0.3 ;  %mS/cm^2 maximum nodal leakage conductance




d = 6*1e-4; %Axon diameter um (micro meter)
a = 3*1e-4; %axon radius
R = 100; %intracellular resistivity
Gaxial=pi*(d^2)/(4*Ro_ax*Internodal_L)*1e7; 

%% initial condition
V0 = -65; % Initial Membrane voltage = -82mV
V0In = -64;
SV0=0;
V0S=0

% V0 = cumsum(V0);
Exm0 = amEx(V0)./(amEx(V0)+bmEx(V0)); % Initial m-value
Exh0 = ahEx(V0)./(ahEx(V0)+bhEx(V0)); % Initial h-value
Exn0 = anEx(V0)./(anEx(V0)+bnEx(V0)); % Initial n-value



Inm0 = amIn(ErestIn)./(amIn(ErestIn)+bmIn(ErestIn)); % Initial m-value
Inh0 = ahIn(ErestIn)./(ahIn(ErestIn)+bhIn(ErestIn)); % Initial h-value
Inn0 = anIn(ErestIn)./(anIn(ErestIn)+bnIn(ErestIn)); % Initial n-value


Sm0 = amS(V0S)./(amS(V0S)+bmS(V0S)); % Initial m-value
Sh0 = ahS(V0S)./(ahS(V0S)+bhS(V0S)); % Initial h-value
Sn0 = anS(V0S)./(anS(V0S)+bnS(V0S)); % Initial n-value



%y0 = [V0;Exs0;Exm0;Exh0];
Ga=1*Gaxial;


Cn1 =2*1e-5/1^2;; % specific capacitance microF /cm2
%Cn = 2; % specific capacitance microF /cm2
Ro_e = 500; %extracellular resistivity Ohm.cm
Ro_ax = 70;  %Ohm.cm
Ro_px = 70;  %Ohm.cm
ENa = 50*1; %mv NA+ Nernst potential 
ENap = 50*1; %mv NA+ Nernst potential 
ENaf = 50*1;%mv NA+ Nernst potential 
EK = -84*1; %mv K Nernst potential 
ELk = -83.38*1; %mv Leakage Nernst potential 
Erest = -82*1; %mv rest potential 
gNaf = 10*3/1 ; %mS/cm^2 maximum fast NA+ conductance 
gKs = 10*0.08/1 ; %mS/cm^2 maximum slow K+ conductance 
gNap = 10*0.005/1 ;  %mS/cm^2 maximum pesistent NA+ conductance 
gLk = 10*0.08/1 ;  %mS/cm^2 maximum nodal leakage conductance

d = 6*1e-4; %Axon diameter um (micro meter)
a = 3*1e-4; %axon radius
R = 100; %intracellular resistivity
Gaxial=pi*(d^2)/(4*Ro_ax*Internodal_L)*1e7; 

%% initial condition
V0O = -82; % Initial Membrane voltage = -82mV
% V0 = cumsum(V0);
m0 = am(V0O)./(am(V0O)+Bm(V0O)); % Initial m-value
mNap0 = amNap(V0)./(amNap(V0O)+bmNap(V0O)); % Initial m-value
s0 = as(V0O)./(as(V0O)+bs(V0O)); % Initial n-value
h0 = ah(V0O)./(ah(V0O)+bh(V0O)); % Initial h-value

y0 = [V0O;s0;m0;mNap0;h0];
Ga=1*Gaxial;


% RoOmega=0; %100*Ro*Omega;

%Omega=2*pi/1000; %1Hz
%Ro=100*1/(Omega*1000);
Ro=0;
RoOmega=Ro/3;
RoOmegaEx=0; %100*Omega/2;
Bias=RoOmega;
PhaseEx=pi/2;

TawIExt=200;
TawIExtE=1;

gSynE=0.08; %mS/cm^2
gSynI=0.8; %mS/cm^2
ESynI=-80; %mV
ESynE=-10; %mV
wE=0.05;

TawSynE=5; %mS
TawSynI=5; %mS
w17=-0.25;
w71=0.25;



% ESynI2=-80; %mV
% ESynE2=-10; %mV
% gSynE2=0.08; %mS/cm^2
% gSynI2=0.12; %mS/cm^2
% 
% TawSynE2=10; %mS
% TawSynI2=15; %mS
% w12=-0.3;
% w26=0.05;
% %w28=0.12;
% w28=0.01; %after lower level injury 
% %w28=0.07; 

ESynI2=-80; %mV
ESynE2=-10; %mV
gSynE2=0.08; %mS/cm^2
gSynI2=0.12; %mS/cm^2

% TawSynE2=5; %mS
% TawSynI2=15; %mS
% TawSynE26=15;
% w12=-0.09;
% w26=0.04;
% w28=0.11;
%w28=0.03; %after lower level injury 
%w28=0.07; 

TawSynE2=12; %mS
TawSynI2=1; %mS
TawSynE26=15;
w12=-0.28;
w26=0.05;
w28=0.13;
%W28=0.14;
%w28=0.03; %after lower level injury 
%w28=0.07; 

% 
% % 
% ESynI3=-80; %mV
% ESynE3=-10; %mV
% gSynE3=0.08; %mS/cm^2
% gSynI3=0.12; %mS/cm^2
% TawSynE3=22; %mS
% TawSynI3=0.5; %mS
% w63=-0.1;
% w83=0.11;% after UL injury
% w83=0.1;% after UL injury
% %w83=0.1;
% %w83=0.1; %after Upper level injury this connections gets stronger

ESynI3=-80; %mV
ESynE3=-10; %mV
gSynE3=0.08; %mS/cm^2
gSynI3=0.12; %mS/cm^2
TawSynE3=18; %mS
TawSynI3=35; %mS
w63=-0.08;

w83=0.13;
%w83=0.4; %% after Injury
%w83=0.1;
%w83=0.1; %after Upper level injury this connections gets stronger




ESynI4=-80; %mV
ESynE4=-10; %mV
gSynE4=0.08; %mS/cm^2
gSynI4=0.12; %mS/cm^2
TawSynE4=6; %mS
TawSynI4=7; %mS
TawSynE41=15; %mS
%w34=0.03;
w34=0.03;% Before UL injury
%w34=0.09;% after UL injury
%w34=0.07;% after UL injury
w14=0.09;
%w14=0.03; % after UL injury
%w14=0.1;


% ESynI4=-80; %mV
% ESynE4=-10; %mV
% gSynE4=0.08; %mS/cm^2
% gSynI4=0.12; %mS/cm^2
% TawSynE4=6; %mS
% TawSynI4=5; %mS
% %w34=0.03;
% w34=0.05;% after UL injury
% %w34=0.07;% after UL injury
% w14=0.09;
% %w14=0.01; % after UL injury
% %w14=0.1;





ESynI5=-80; %mV
ESynE5=-10; %mV
gSynE5=0.08; %mS/cm^2
gSynI5=0.12; %mS/cm^2
TawSynE5=6; %mS
TawSynI5=1; %mS
w5=0.7;
w15=-0.4;
w85=0.04;
%w85=0.08;


ESynI6=-65; %mV
ESynE6=-15; %mV

ESynE6p=-10;
ESynE610=-24;

ESynI6p=-82;

gSynE6=0.08; %mS/cm^2
gSynI6=0.12; %mS/cm^2
TawSynE6=3; %mS
TawSynI6=3; %mS
TawSynE66=1; %mS
TawSynE66E=5; %mS
w67=-0.55;
w68=0.1;
w66=0.03;
w66E=0.09;

TawSynE10=5; %mS
w10=0.035;

ESynI7=-80; %mV
ESynE7=-10; %mV



gSynE7=0.165; %mS/cm^2
gSynI7=0.85; %mS/cm^2
TawSynE7=0.05; %S
TawSynI7=0.01; %S
w78=0.25;
w79=0.35;

ESynI8=-80; %mV
ESynE8=-10; %mV


gSynE8=0.165; %mS/cm^2
gSynI8=0.8; %mS/cm^2
TawSynE8=0.05; %S
TawSynI8=0.05; %S
w8=0.25;






