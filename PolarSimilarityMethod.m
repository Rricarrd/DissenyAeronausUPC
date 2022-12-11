clc
clear
%% Polar Graphing
%Estimated Values by Similarity
CD0 = 0.016;
oswald = 0.85;

%Parameters and cosntants
pi = 3.141592;
points = 100;
CL_max = [0.243 1.684 2.736]; %Cruise, takeoff and landing

%Some design values
S = 21.34;
AR = 9;
b = sqrt(AR*S);


%% Coeficient Vectors
%Creem les arrays de zeros
CD = zeros(3,points);
L_D = zeros(3,points/2);


%Omplim els vectors de Cl max
CL = linspace(-CL_max(3),CL_max(3),points);


for j = 1:3
    for i = 1:points
    CD(j,i) = CD0 + CL(i)^2/(pi*AR*oswald);
    
        if CL(i)>=0
        L_D(j,i) = CL(i)/CD(j,i);
        end

    end
end

%Plotting
figure(1)
hold on
title('Polar Curve by Similarity Method')
xlabel('CL')
ylabel('CD')
grid on
grid minor


plot(CL,CD(1,:)); %Cruise
plot(CL,CD(2,:)); %Takeoff
plot(CL,CD(3,:)); %Landing

hold off

legend('Cruise','Takeoff','Landing')



