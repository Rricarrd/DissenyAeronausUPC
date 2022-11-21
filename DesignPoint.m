

%% Take Off

% Input data:

g=9.81; %gravity value

kto=2.34/g ; % Proportionality factor for the take-off distance (Loftin 1980)
sigma = 1 ; % Ratio air density at take off altitude - at sea level
CLmaxto = 1.6; % Maximum CL at take−off (Roskam I) - We take the minimum value of the given range.
StoFL = 1000; % Take-off distance (State of the Art)

%Equation

Tto_Wto_to = zeros(1,v_length);

for i = 1:v_length

Tto_Wto_to(1,i)=kto*(Wto_Sw(1,i)/(sigma*CLmaxto*StoFL));

end

%% Climb with engine critical failure

% Input data:

N_e=2; % Number of engines
W2_Wto = 0.98; % Ratio ascent - take-off weight
Tto1e_T21e = 1.2857; % Ratio thrust supplied by one engine in normal regime − thrust supplied by one engine after one of them fails
E2 = 1/16; % Inverse of aerodynamic efficiency
gamma2 = 0.029991; % Ascending angle

% Equation

Tto_Wto_critical=zeros(1,v_length);

for i=1:v_length
    Tto_Wto_critical(1,i)=(N_e/(N_e-1))*Tto1e_T21e*W2_Wto*(E2+gamma2);

end

%% Landing

% Input data:

kl = 0.1070*g; % Proportionality factor for landing distance
Wto_Wl = 0.919; % Ratio weight at take-off - landing
sigma = 1; %Ratio airdensity at take−off altitude − at sea level
CLmaxl = 2.6; % Maximum CL at landing
SlFL = 950; % Landing distance (State of the Art)

% Equation:

Tto_Wto_l=zeros(1,v_length);

for i = 1:v_length

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

%% Plots:
figure(1)
hold on;
p = plot(Wto_Sw,Tto_Wto_to);
plot(Wto_Sw,Tto_Wto_c) ;
plot(Wto_Sw,Tto_Wto_critical) ;
plot(2134.9, 0.3571);
ylim([0,2])
xline(Wto_Sw_l) ;
plot(pointofdesignhorcessna, pointofdesignvercessna, 'O')
plot(pointofdesignhorhonda, pointofdesignverhonda, 'O')
plot(pointofdesignhor, pointofdesignver, 'O')
legend('Takeoff', 'Cruise','2nd segment climb', 'Landing distance');
grid on ;
title('Design Point');
xlabel('W_{t0}/S_{W} [N/{m^2}]');
ylabel('T_{t0}/W_{t0}');

%% Càlcul Design Point escollit
mtow = 4959;

DPdt = datatip(p, pointofdesignhor, pointofdesignver);
SWnos = mtow*g/pointofdesignhor
Ttonos = mtow*g*pointofdesignver

