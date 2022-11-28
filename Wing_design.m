clear
clc
%% Weights From Previous Code
%% ############### WeightFractions ##############
%% TabulatedValues
W4_W1 = 0.98;
W5_W4 = 0.97;
W7_W6 = 0.99;
W8_W7 = 0.97;
W11_W10 = 0.99;
W12_W11 = 0.997;

W3_W1 = 0.985;

%Constants
e = 2.71828;

%% Breguet Equation
%Cruise speeds (Average among aircraft)
v_c = 800; %[km/h]
v_c_m = v_c/3.6; %[m/s]
%Flight efficiency
L_D = 16;

%SFC for a High Bypass Ratio Turbofan
SFC_Cruise = 0.4;
SFC_Loiter = 0.5;

%Range max
R_max_km = 2500;

%Range loiter
R_loiter_km = 325;

%Endurance
E_min = 45;
E_h = 45/60;

%Breguet Equation
W6_W5 =e^((-R_max_km*SFC_Cruise)/(0.866*v_c*L_D));
W9_W8 =e^((-R_loiter_km*SFC_Cruise)/(0.866*v_c*L_D));

%Endurance Equation
W10_W9 = e^((-E_h*SFC_Loiter)/(L_D));


%% Fuel Weight
FW_MTOW = 1-(W4_W1*W5_W4*W6_W5*W7_W6*W8_W7*W9_W8*W10_W9*W11_W10*W12_W11);

%% PL
%Passenger payload
Pax = 8;
Pax_total_weight = 96;

PL = Pax * Pax_total_weight;

%% OEW
%Average values from examples
OEW_MTOW = 0.64;

%% MTOW
%Equation
MTOW = (PL)/(1-OEW_MTOW-FW_MTOW);

%Fuel Weight
FW = FW_MTOW*MTOW;


%% #################### Aerodynaimc coefficients ###########################
Sw = 21.34; %[m2]
g = 9.8;
%% Cruise flight (Lcruise = Wcruise)
z = 11000; %[m]

%Environment Conditions
[rho,P,T,a,visco_din] = DensAltura(z);

%Weights determination
mi_cruise = MTOW - (MTOW*(1-W4_W1*W5_W4)) ;
mf_cruise = MTOW - (MTOW*(1-W4_W1*W5_W4*W6_W5));

%Average weight
W_cruise = 0.5*(mi_cruise +mf_cruise)*g;

%Reynolds
MAC = 2; %[m] From similar airplanes
Re_cruise = (v_c_m*MAC/visco_din);

%Lift Coefficient
CL_Cruise = W_cruise/(0.5*rho*v_c_m^2*Sw);

%Corrected lift with other airplane elements such as the tail (Negative
%lift) (Sadraeys)
CL_Cruise_W = CL_Cruise/0.95;

%Ideal lift coefficient
Cl_i = CL_Cruise_W/0.9;

%% Takeoff (Ltakeoff = Wtakeoff)
z_sea = 0;

%Max lift coeficient (Considered in a previous section as a requirement)
CL_max = 1.6;

%Environment Conditions
[rho_sea,P_sea,T_sea,a_sea,visco_din_sea] = DensAltura(z_sea);


%Takeoff Weight
m_takeoff = MTOW - (MTOW*(1-W3_W1));
W_takeoff = m_takeoff*g;


%Stall speed
k = 1.2;
v_s_m = sqrt((2*W_takeoff)/(rho_sea*CL_max*Sw));
v_s = v_s_m*3.6;

v_to = v_s*k;
v_to_m = v_to/3.6;

%Max lift coeficient wing (Considered in a previous section as a requirement)
CL_max_w = CL_max/0.95;

%Max lift coeficient gross (Considered in a previous section as a requirement)
CL_max_gross = CL_max_w/0.9;


%% ########### 5.16-WING DESIGN STEPS ###########
%% 1. Select Number of wings
% The aircraft will use a monoplane configuration

%% 2. Select wing vertical location
% The aircraft will use a low-wing configuration

%% 3. Select wing configuration
% It's contemplated to use a swept, tappered and twisted wing.

%% 4. Calculate average aircraft weight at cruise
%from AeroCoefficients

%% 5. Calculate required aircraft cruise lift coeff
CL_c = CL_Cruise; %from AeroCoefficients

%% 6. Calculate the required aircraft take-off lift coeff
C_L_TO = 0.85 * 2 * W_takeoff/(rho_sea*v_to_m^2*Sw);

%% 7. Select the HLD type and its location on the wing

%for the type of aircraft that we are working with and the expected Delta
%Cl it will probably be a () flap

%% 8. Determine the HLD geometry (span, chord and maximmum deflection)

C_f_C = 0.3; %relation between HLD and wing chord (based on similar aircraft)

Delta_C_L_HLD = 1.3; %Value for Fowler flap (Sadraey)

%Wing airfoil net maximum lift coefficient
CL_max_takeoff_noflap = CL_max_gross - Delta_C_L_HLD;

%define b_flap, and maximum deflection

%% 9. Select airfoil

%Airfoil Selected: 

Cl_alpha_deg = 0.25; %1/deg
Cl_alpha = (Cl_alpha_deg*360)/(2*pi); %1/rad


alpha_0 = -2; %deg


%% 10. Determine the wing incidence

%We can look at the Cl-alpha graph to see at what angle we have Cl_i.

i_w = 0;

%% 11. Select the sweep angle and the dihedral angle.

Sweep = 10; %value in degrees, it's just a first approximation
Dihedral = 2; %value in degrees, it's just a first approximation

%% 12. Select other wing parameters such as AR, Tapper ratio, and wing twist

AR = 9;
taper = 0.35;
twist = -0.5;

%% 13. Calculate lift distribution at cruise. (We can use XFLR5 or lifting line theory, see section 5.14)
%Lifting line theory

N = 19; % (number of segments - 1)


b = sqrt(AR*Sw); % wing span (m)
MAC = Sw/b; % Mean Aerodynamic Chord (m)
Croot = (1.5*(1+taper)*MAC)/(1+taper+taper^2); % root chord (m)
theta = pi/(2*N):pi/(2*N):pi/2;
alpha = i_w+twist:-twist/(N-1):i_w;
% segment’s angle of attack
z = (b/2)*cos(theta);
c = Croot * (1 - (1-taper)*cos(theta)); % Mean Aerodynamics Chord at each segment (m)
mu = c * Cl_alpha / (4 * b);
LHS = mu .* (alpha-alpha_0)/57.3; % Left Hand Side
% Solving N equations to find coefficients A(i):
for i=1:N
for j=1:N
B(i,j) = sin((2*j-1) * theta(i)) * (1 + (mu(i) * (2*j-1)) / sin(theta(i)));
end
end
A=B\transpose(LHS);
for i = 1:N
sum1(i) = 0;
sum2(i) = 0;
for j = 1 : N
sum1(i) = sum1(i) + (2*j-1) * A(j)*sin((2*j-1)*theta(i));
sum2(i) = sum2(i) + A(j)*sin((2*j-1)*theta(i));
end
end
CL = 4*b*sum2 ./ c;
CL1(1) = 0;
y_s(1) = b/2;

for i = 2:N+1
    CL1(i) = CL(i-1);
    y_s(i) = z(i-1);
end

plot(y_s,CL1,'-o')
grid
title('Lift distribution')
xlabel('Semi-span location (m)')
ylabel ('Lift coefficient')
<<<<<<< HEAD
CL_wing = pi * AR * A(1);

=======
CL_wing_cruise = pi * AR * A(1);
%L = 0.5 * rho * V^2 * Sw * CL_wing;
>>>>>>> 0b231a1770d7885a7f5dad2e5e0d9e063ca6d261

%% 14. Check the lift distribution at cruise is elliptic, otherwise change some parameters of step 13

%% 15. Calculate the wing lift at cruise
L_cruise = 0.5 * rho * v_c_m^2 * Sw * CL_wing_cruise; %[N]
L_cruise_kgf = L_cruise/9.8;

%% 16. The wing lift at cruise must be equal to the required cruise lift coeff (Step 5). If not, return to 10 and change incidence

%% 17. Calculate the wing lift coefficient at take-off (CLw_TO). 
%Employ a flap at take-off with deflection δf and wing angle of attack αw = αsTO − 1. 
%Note that αs at take-off is usually smaller than αs at cruise. Please note that the minus one (−1) is for safety.  






