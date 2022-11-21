function Trapezoidal_Rule=Trapezoidal_Rule(q,w,N,Sw,rho,Cd0,K,V_C,C)

sumatory=0;
a = 9.81*q;
b = 9.81*w;
h = (b-a)/N;

    for x=1:N
    x_1=a+(x-1)*h ;
    x_2=a+(x)*h ;
    f_x_1=(V_C/C)*(1/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*x_1)/(Sw*rho*V_C^2))^2))) ;
    f_x_2=(V_C/C)*(1/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*x_2)/(Sw*rho*V_C^2))^2)));
    
    f=(h/2)*(f_x_1+f_x_2);
    sumatory = sumatory + f ;
    end

Trapezoidal_Rule = sumatory;

end