function [rho,P,T,a,M,visco_din] = DensAltura(z,v)
%%Càlcul de la densitat en fucnió de l'altura. També del Mach
v = v/3.6;
visco_cinem = 1.8e-5;

if z <=11000
R = 287;
g = 9.81;
z0 = 0;
gradient = -0.0065;
T0 = 288.15;
P0 = 101325;
rho0 = 1.225;
gamma = 1.4;

T = T0 + gradient*z;
exponent = (-1-(g/(R*gradient)));
rho = rho0*((T/T0)^exponent);

exponentP = (-(g/(R*gradient)));
P = P0*((T/T0)^exponentP);
a = sqrt(gamma*R*T);
M = v/a;

elseif z > 11000
    
R = 287;
g = 9.81;
z0 = 11000;

T0 = 216.65;
P0 = 22632;
rho0 = 0.3639;
gamma = 1.4;

T = T0;
zrel = z-z0;
rho = rho0*exp((-g/(R*T))*zrel);
P = P0*exp((-g/(R*T))*zrel);
a = sqrt(gamma*R*T);
M = v/a;
end

visco_din = visco_cinem/rho;

end


%kkk

