clear
clc
%% DATA INPUT

max_takeoff_weight = 4959;     % [kg]
empty_weight = max_takeoff_weight * 0.64;   % [kg]
max_payload = 768;     % [kg]

max_fuel = 1017.6;       % [kg]
reserve_fuel = 309.9;    % [kg]

takeoff_fuel = max_takeoff_weight * (1 - 0.98);
landing_fuel = max_takeoff_weight * (1 - 0.997);
cruise_fuel = max_fuel - takeoff_fuel - landing_fuel - reserve_fuel;

desired_range = 2500;   % [km]
cruise_speed = 800; % [km/h]
C = 0.4;               % [m/s^2] 
L_D = 16;

%% CALCULATIONS

payload = zeros(4, 1);
weights = zeros(4, 1);
reserve_fuel_weight = zeros(4, 1);
ranges = zeros(4, 1);

% Case 1 
payload(1, 1) = max_payload;
weights(1, 1) = max_payload + reserve_fuel;
reserve_fuel_weight(1, 1) = payload(1, 1) + reserve_fuel;
ranges(1, 1) = 0;

% Case 2
payload(2, 1) = max_payload;
weights(2, 1) = max_payload + (max_takeoff_weight - max_payload - empty_weight);   % max payload + fuel hasta MTOW
reserve_fuel_weight(2, 1) = payload(2, 1) + reserve_fuel;

fuel = max_takeoff_weight - max_payload - empty_weight;

w4_2 = max_takeoff_weight - (fuel - reserve_fuel) * 0.34;      
w5_2 = max_takeoff_weight - (fuel - reserve_fuel) * 0.91;  

ranges(2, 1) = 0.866*((cruise_speed / C) * L_D * log(w4_2/w5_2));

%ranges(2, 1) = desired_range;

% Case 3 
payload(3, 1) = max_takeoff_weight - max_fuel- empty_weight;
weights(3, 1) = payload(3, 1) + max_fuel;

w4_3 = max_takeoff_weight - (max_fuel - reserve_fuel) * 0.34;      
w5_3 = max_takeoff_weight - (max_fuel - reserve_fuel) * 0.91;  

%w4_3 = max_takeoff_weight - takeoff_fuel;      
%w5_3 = max_takeoff_weight - max_fuel + landing_fuel + reserve_fuel;  

% el gasto de combustible en crucero representa el 57% del gasto total de
% combustible, del restante, se reparte el 34% a la fase de despegue-ascenso y el
% restante 9% al descenso-aterrizaje.

reserve_fuel_weight(3, 1) = payload(3, 1) + reserve_fuel;
ranges(3, 1) = 0.866*((cruise_speed / C) * L_D * log(w4_3/w5_3));

% Case 4 
payload(4, 1) = 0;
weights(4, 1) = max_fuel;

w4_4 = (empty_weight + max_fuel) - (max_fuel - reserve_fuel) * 0.34;
w5_4 = (empty_weight + max_fuel) - (max_fuel - reserve_fuel) * 0.91;

%w4_4 = empty_weight + max_fuel - takeoff_fuel;
%w5_4 = empty_weight + max_fuel - takeoff_fuel - cruise_fuel;

reserve_fuel_weight(4, 1) = payload(4, 1) + reserve_fuel;
ranges(4, 1) = 0.866*((cruise_speed /C) * L_D * log(w4_4/w5_4));


%% PLOT
payload = payload + empty_weight;
weights = weights + empty_weight;
reserve_fuel_weight = reserve_fuel_weight + empty_weight;


figure (1)
plot(ranges, payload, '-', ranges, weights, '-', ranges, reserve_fuel_weight, '-');
legend('Payload', 'Payload + Fuel', 'Payload + Reserve Fuel');
%plot(ranges, payload);

ylim([3000 5200]);
%ylim([0 1000]);
xlabel('Range [km]');
ylabel('Weight [kg]');
title('Weight-Range Diagram')
yline(max_takeoff_weight, '-', 'MTOW');     % [kg]
yline(empty_weight, '-', 'OEW');   % [kg]




