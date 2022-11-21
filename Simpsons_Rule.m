function Simpsons_Rule=Simpsons_Rule(q,w,N,Sw,rho,Cd0,K,V_C,C)

 sumatory1=0;
 sumatory2=0;
 a=9.81*q;
 b=9.81*w;
 h=(b-a)/N;
 f_a=(V_C/C)*(a/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*a)/(Sw*rho*V_C^2))^2)))*1/(a) ;
 f_b =(V_C/C)*(b/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*b)/(Sw*rho*V_C^2))^2)))*1/(b) ;

 x=zeros(N-1,1) ;
for y=1:N-1
 x(y)=a+y*h;
end

 for y=1:2:N-1
 f_x_1=(V_C/C)*(x(y)/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*x(y))/(Sw*rho*V_C^2))^2)))*1/(x(y));
 sumatory1=sumatory1+f_x_1;
 end

for y=2:2:N-2
 f_x_2=(V_C/C)*(x(y)/((1/2)*Sw*rho*V_C^2*(Cd0+K*((2*x(y))/(Sw*rho*V_C^2))^2)))*1/(x(y));
 sumatory2 = sumatory2 + f_x_2 ;
end

 Simpsons_Rule=(h/3)*(f_a+4*sumatory1+2*sumatory2+f_b);

 end