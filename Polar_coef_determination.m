clear
clc

%Data
e_oswald=0.85;
AR=9;
T_max=16540;
V_max=800/3.6;
W=4959*9.81;
rho_0=1.225;
S_wing=21.34;
rho=0.3636;
sigma=rho/rho_0;
%Coefficients

K=1/(pi*e_oswald*AR);
CD0=(2*T_max-(4*K*W^2)/(rho*sigma*V_max^2*S_wing))/(rho_0*V_max^2*S_wing);

CL=-1:0.01:1;
CD=CD0+K*CL.^2;

plot(CL,CD)

