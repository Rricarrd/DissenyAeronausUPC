clc
clear
clf

%% Some Considerations
% Flight Parameters
M = 0.75;
Cl_cruise = 0.25;
M_star = 1.15; %takes in account the supercritical airfoil considerations

%Relative thickness
t_c = 0.3*((1-((5+M^2)/(5+(M_star-0.25*Cl_cruise)^2))^(7/2))*((sqrt(1-M^2))/(M^2)))^(2/3);

%% Sweptback wing

Sweep_deg = 20;
Sweep = Sweep_deg/360*2*3.141592;

