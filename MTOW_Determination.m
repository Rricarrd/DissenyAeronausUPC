%% ###############WeightFractions##############
%% TabulatedValues
W4_W1 = 0.98;
W5_W4 = 0.97;
W7_W6 = 0.99;
W8_W7 = 0.97;
W11_W10 = 0.99;
W12_W11 = 0.997;

%Constants
e = 2.71828;

%% Breguet Equation
%Cruise speeds (Average among aircraft)
v_c = 800;

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




%% TRIP FUEL
%Equation
TF = MTOW*(1-W4_W1*W5_W4*W6_W5*W7_W6*W12_W11);



%% RESERVE FUEL
%Fuel value in W7
RF = FW - TF;
