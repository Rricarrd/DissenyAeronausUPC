%% Polar Graphing
%Estimated Values by Similarity
CD0 = 0.017;
oswald = 0.8;

%Parameters and cosntants
pi = 3.141592;
points = 100;
CL_max = 1.5;

%Some design values
S = 21.34;
AR = 9;
b = sqrt(AR*S);


%Coeficient Vectors
CL = linspace(-CL_max,CL_max,points);
CD = zeros(1,points);
L_D = zeros(1,points/2);

for i = 1:points
CD(i) = CD0 + CL(i)^2/(pi*AR*oswald);

if CL(i)>=0
L_D(i) = CL(i)/CD(i);
end
end

%Plotting
figure
plot(CD,CL);

title('Polar Curve by Similarity Method')
xlabel('CD')
ylabel('CL')
grid on
grid minor

figure
plot(CD,L_D);
title('L/D ratio')
xlabel('CD')
ylabel('L/D')
grid on
grid minor


