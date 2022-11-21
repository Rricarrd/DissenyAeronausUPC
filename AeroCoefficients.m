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

%% 
%% #################### Aerodynaimc coefficients ###########################
Sw = 21.34; %[m2]
g = 9.8;
%% Cruise flight (Lcruise = Wcruise)
z = 11000; %[m]

%Environment Conditions
[rho,P,T,a,M,visco_din] = DensAltura(z,v_c);

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
CL_max = 2.6;

%Environment Conditions
[rho_sea,P_sea,T_sea,a_sea,M_sea,visco_din_sea] = DensAltura(z_sea,v_c); %Revisar quina ha de ser realment aquesta velocitat

%Takeoff Weight
m_takeoff = MTOW - (MTOW*(1-W3_W1));
W_takeoff = m_takeoff*g;


%Stall speed
v_s_m = sqrt((2*W_takeoff)/(rho_sea*CL_max*Sw));
v_s = v_s_m*3.6;
 

%Max lift coeficient wing (Considered in a previous section as a requirement)
CL_max_w = CL_max/0.95;

%Max lift coeficient gross (Considered in a previous section as a requirement)
Cl_max_gross = CL_max_w/0.9;

%%
%High-lift device
k = 1.2; %From Sadraey
V_TO = k * v_s;

V_TO_m = V_TO/3.6;

C_f_C = 0.3; %relation between HLD and wing chord 

Delta_C_L_HLD = 1.3; %Value for Fowler flap (Sadraey)

%Wing airfoil net maximum lift coefficient
Cl_max = Cl_max_gross - Delta_C_L_HLD;

%Airfoil Selected: NACA 2412


%% Wing incidence
%We can look at the Cl-alpha graph to see at what angle we have Cl_i.

%Mirant les gràfiques de CL vs alpha del perfil NACA-2412 sembla que no
%caldra donar-li incidencia a l'ala.

%%








