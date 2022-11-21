
clc; clear; close all;


Wto_Sw= (100:10:3000);
x_length=length(Wto_Sw);

%% Parameters

T_to = 9100; %Take-off thrust (2 engines)
T_cr = 7291.6; % Cruise thrust
Tto_Tcr = T_to/T_cr; % Take-off thrust vs Cruise thrust ratio
Wcr_Wto = 0.95; % Cruise weight vs Take-off thrust ratio
rho = 0.3636 ; % Air density (at cruise altitude)
v = 222 ; % Cruise velocity
cd0 = 0.0161 ; % Parasite drag coefficient
A = 9; % Aspect Ratio
oswald = 0.85; % Oswald's Factor

g=9.81; % Gravity
kto=2.34/g ; % Proportionality factor for the take-off distance (Loftin 1980)

CLmaxto = 1.6; % Maximum CL at take−off (Scholz, D) - We take the minimum value of the given range.
StoFL = 1000; % Take-off distance (State of the Art)

N_e=2; % Number of engines
W2_Wto = 0.98; % Ascent weight vs Take-off weight ratio
Tto1e_T21e = 1.2857; % Thrust 1 engine normal regime vs thrust 1 engine in failure
E2 = 1/16; % Inverse of aerodynamic efficiency
gamma2 = 0.029991; % Ascending angle

kl = 0.1070*g; % Proportionality factor for landing distance
Wto_Wl = 0.919; % Weight at take-off vs weight at landing ratio
sigma = 1; % Air density at take-off altitude vs air density at sea level ratio
CLmaxl = 2.6; % Maximum CL at landing (Scholz, D)
SlFL = 1000; % Landing distance (State of the Art)


%% Thrust required for horizontal cruise flight

Tto_Wto_c=zeros(1,x_length);

for i = 1:x_length
    Tto_Wto_c(1,i)=Tto_Tcr*Wcr_Wto*((0.5*rho*v^2)/(Wcr_Wto*Wto_Sw(1,i)))*(cd0+ ((Wto_Sw(1,i)*Wcr_Wto)^2/((0.5*rho*v^2)^2*pi*A*oswald)));
end
%% Take-Off distance

Tto_Wto_to = zeros(1,x_length);

for i = 1:x_length
    Tto_Wto_to(1,i)=kto*(Wto_Sw(1,i)/(sigma*CLmaxto*StoFL));
end

%% Second segment climb with an engine failure

Tto_Wto_critical=zeros(1,x_length);

for i=1:x_length
    Tto_Wto_critical(1,i)=(N_e/(N_e-1))*Tto1e_T21e*W2_Wto*(E2+gamma2);
end

%% Landing distance

Tto_Wto_l=zeros(1,x_length);

for i = 1:x_length
    Wto_Sw_l=kl*Wto_Wl*sigma*CLmaxl*SlFL ;
end

%% Point of Design

pointofdesignver = 0.34;
pointofdesignhor = 2280;

%Point of design del Cessna Citation M2
pointofdesignvercessna = 0.3571; 
pointofdesignhorcessna = 2134.9;

%Point of design del Honda HA-420
pointofdesignverhonda = 0.3822;
pointofdesignhorhonda = 2380.9;

%% Plot

figure(1)
hold on;
p = plot(Wto_Sw,Tto_Wto_to);
plot(Wto_Sw,Tto_Wto_c) ;
plot(Wto_Sw,Tto_Wto_critical) ;
plot(2134.9, 0.3571);
scatter(pointofdesignhor, pointofdesignver, 'r', 'filled');
scatter(pointofdesignhorcessna, pointofdesignvercessna, 'filled');
scatter(pointofdesignhorhonda,pointofdesignverhonda, 'filled');
ylim([0,1.8])
xline(Wto_Sw_l) ;
legend('Takeoff', 'Cruise','2nd segment climb', 'Landing distance','Design Point','Cesna Citation M2', 'Honda HA-420');
grid on ;
title('Design Point');
xlabel('W_{t0}/S_{W} [N/{m^2}]');
ylabel('T_{t0}/W_{t0}');

%% Values from design point
mtow = 4959;

DPdt = datatip(p, pointofdesignhor, pointofdesignver);
SWnos = mtow*g/pointofdesignhor
Ttonos = mtow*g*pointofdesignver
