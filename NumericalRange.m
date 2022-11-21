clear
clc

%% DATA INPUT

MTOW = 4959; % As calculated in section 3.5 [kg]
OEW = 0.64*MTOW; % As stated in section 3.3 [kg]
Max_fuel = 1017.6; % As calculated in section 3.5 [kg]
% trip_fuel = 0.9*max_fuel; % [kg]
Reservoir_fuel = Max_fuel*0.2; % Estimated as 10% of trip fuel [kg]
Max_payload = 768; % Payload for 8 passangers. Calculated in section 3.2 [kg]
Average_payload = 768/8*3; % Payload for 3 passangers.

%desired_range = 2500; % As stated in requeriments section [km]
Max_speed = 800; % As stated in requeriments section [km/h]
Cruise_speed = Max_speed / 3.6;

C = 0.4; % As stated in section 3.4.4.3
L_D = 16; % As stated in section 3.4.4.3

% Design point parameters
Sw=21.0829;
rho=0.3636;
Cd0=0.3;
e_oswald=0.85;
AR=9;
K=1/(e_oswald*AR*pi);


%% NUMERICAL METHOD

N=2:2:1000; % Vector that defines number of iterations

Weights=[Max_payload+OEW+Reservoir_fuel  MTOW; 
              MTOW+Max_fuel+Reservoir_fuel  MTOW;
              OEW+Reservoir_fuel OEW+Max_fuel];

Trapezoidal=zeros(length(Weights),length(N));
Simpsons=zeros(length(Weights),length(N));

Error_Trapezoidal_Rule=zeros(1,length(N)-1);
Error_Simpsons_Rule=zeros(1,length(N)-1);

% Application of numerical methods

for y=1:length(N)
    for x=1:length(Weights)
        t=Weights(x,1);
        s=Weights(x,2);
        Trapezoidal(x,y)=Trapezoidal_Rule(t,s,N(y),Sw,rho,Cd0,K,Cruise_speed,C);
        Simpsons(x,y)=Simpsons_Rule(t,s,N(y),Sw,rho,Cd0,K,Cruise_speed,C);
    end
    h(y)=((Weights(3,1)-Weights(3,2))*9.81/(N(y)));
end

% Calculation of error associated to each method

for y=1:(length(N)-1)
    Error_Trapezoidal_Rule(1,y)=abs((Trapezoidal(3,y)-Trapezoidal(3,end)))./(Trapezoidal(3,end));
    Error_Simpsons_Rule(1,y)=abs((Simpsons(3,y)-Simpsons(3,end)))./(Simpsons(3,end));
end

log_trap=log(Error_Trapezoidal_Rule);
log_simp=log(Error_Simpsons_Rule);

%% PLOT ERROR ASSOCIATED TO NUMERICAL METHODS

% Plot absolute error
figure(3)
subplot(2,2,[1,2])
plot(N(1:(end-1)),Error_Trapezoidal_Rule);
title('Error associated to Trapezoidal rule method','Interpreter','latex');
xlabel('Number of discretization elements (N)','Interpreter','latex');
ylabel('Absolute numerical error ($\varepsilon_V$)','Interpreter','latex');
subplot(2,2,[3,4])
plot(N(1:(end-1)),Error_Simpsons_Rule);
title('Error associated to Simpson`s rule method','Interpreter','latex');
xlabel('Number of discretization elements (N)','Interpreter','latex');
ylabel('Absolute numerical error ($\varepsilon_V$)','Interpreter','latex');
xlim([0 150]);

% Plot error in logarithmic scale
figure(4)
plot(N(1:(end-1)),log_trap);
title('Error associated to numerical methods','Interpreter','latex');
xlabel('Number of discretization elements (N)','Interpreter','latex');
ylabel('Logarithm of numerical error (log ($\varepsilon_V$))','Interpreter','latex');
hold on
plot(N(1:(end-1)),log_simp);
legend('Error associated to Trapezoidal rule method','Error associated to Simpson`s rule method','Interpreter','latex','location','southwest');
