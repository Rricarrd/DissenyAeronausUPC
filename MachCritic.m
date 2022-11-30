clc
clear 

%% Critical Mach Determination
% http://www.akiti.ca/Mcrit.html
%Conditions
Minf = 0.75;
gamma = 1.4;

%Airfoil Cp Minimum at 0º AOA
cp_min_0 = -0.6628;

%% Root Finder
%http://www.akiti.ca/fxn2zero.html
%Parameters
a1 = cp_min_0 *(gamma/2);
a2 = (gamma-1)/2;
a3 = gamma/(gamma-1);
b = 0.5; %Can be varied by trial and error
c = 1; %Upper Mcr must be at maximum 1, as thats the Mach

%Root
syms Mcr
eqn = a1/sqrt(1-Mcr^2)-((1/Mcr^2)*(((1+a2*Mcr^2)/(1+a2))^a3-1))==0;

sol = vpasolve(eqn,Mcr,0.5);

%Plot
elements = 100;
Mcr_data = linspace(0.5,1,elements);
for i = 1:elements
eqn_data(i) = a1/sqrt(1-Mcr_data(i)^2)-((1/Mcr_data(i)^2)*(((1+a2*Mcr_data(i)^2)/(1+a2))^a3-1));
end
plot(Mcr_data,eqn_data);



%We calculate the minimum Cp over diferent flight Mach. In the end, when
%Mcrit = Minf when M = 0.66. So we have out Mcrit


%We need to reduce our Mcrit by increasing the sweep angle
Mcrit = double(abs(sol));
sweep = acos(sqrt(Mcrit/Minf));
sweep_deg = sweep/(2*pi)*360; 


