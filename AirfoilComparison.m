clc
clear
clf

%% ################### Airfoil Comparison #############################
% Add Data Folder
addpath("AirfoilsData\");

%% Extract data to tables
%Ncrit = 9 (Cruise)
sc20410_Re1e6_tab = readtable('xf-sc20410-il-1000000.csv');
sc20412_Re1e6_tab = readtable('xf-sc20412-il-1000000.csv');
sc20712_Re1e6_tab = readtable('xf-sc20712-il-1000000.csv');
whitcomb_Re1e6_tab = readtable('xf-whitcomb-il-1000000.csv');

%Ncrit = 5 (Takeoff and landing)
sc20410_Re1e6_n5_tab = readtable('xf-sc20410-il-1000000-n5.csv');
sc20412_Re1e6_n5_tab = readtable('xf-sc20412-il-1000000-n5.csv');
sc20712_Re1e6_n5_tab = readtable('xf-sc20712-il-1000000-n5.csv');
whitcomb_Re1e6_n5_tab = readtable('xf-whitcomb-il-1000000-n5.csv');


%% Tables to arrays
sc20410_Re1e6 = table2array(sc20410_Re1e6_tab);
sc20412_Re1e6 = table2array(sc20412_Re1e6_tab);
sc20712_Re1e6 = table2array(sc20712_Re1e6_tab);
whitcomb_Re1e6 = table2array(whitcomb_Re1e6_tab);

sc20410_Re1e6_n5 = table2array(sc20410_Re1e6_n5_tab);
sc20412_Re1e6_n5 = table2array(sc20412_Re1e6_n5_tab);
sc20712_Re1e6_n5 = table2array(sc20712_Re1e6_n5_tab);
whitcomb_Re1e6_n5 = table2array(whitcomb_Re1e6_n5_tab);

%% Vector Extraction

%Ncrit = 9
[sc20410_cl,sc20410_cd,sc20410_alpha,sc20410_cl_cd,sc20410_cm] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20410_Re1e6);
[sc20412_cl,sc20412_cd,sc20412_alpha,sc20412_cl_cd,sc20412_cm] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20412_Re1e6);
[sc20712_cl,sc20712_cd,sc20712_alpha,sc20712_cl_cd,sc20712_cm] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20712_Re1e6);
[whitcomb_cl,whitcomb_cd,whitcomb_alpha,whitcomb_cl_cd,whitcomb_cm] = Extract_Alpha_Cl_Cd_ClCd_Cm(whitcomb_Re1e6);

%Ncrit = 5
[sc20410_cl_n5,sc20410_cd_n5,sc20410_alpha_n5,sc20410_cl_cd_n5,sc20410_cm_n5] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20410_Re1e6_n5);
[sc20412_cl_n5,sc20412_cd_n5,sc20412_alpha_n5,sc20412_cl_cd_n5,sc20412_cm_n5] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20412_Re1e6_n5);
[sc20712_cl_n5,sc20712_cd_n5,sc20712_alpha_n5,sc20712_cl_cd_n5,sc20712_cm_n5] = Extract_Alpha_Cl_Cd_ClCd_Cm(sc20712_Re1e6_n5);
[whitcomb_cl_n5,whitcomb_cd_n5,whitcomb_alpha_n5,whitcomb_cl_cd_n5,whitcomb_cm_n5] = Extract_Alpha_Cl_Cd_ClCd_Cm(whitcomb_Re1e6_n5);

%% ######################## Plotting ###########################
%% Cl vs alpha 
%Ncrit = 9
figure
plot(sc20410_alpha,sc20410_cl);
hold on
plot(sc20412_alpha,sc20412_cl);
plot(sc20712_alpha,sc20712_cl);
plot(whitcomb_alpha,whitcomb_cl);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cl');
title('Cl vs Alpha - Ncrit = 9');
grid on
grid minor

%Ncrit = 5
figure
plot(sc20410_alpha_n5,sc20410_cl_n5);
hold on
plot(sc20412_alpha_n5,sc20412_cl_n5);
plot(sc20712_alpha_n5,sc20712_cl_n5);
plot(whitcomb_alpha_n5,whitcomb_cl_n5);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cl');
title('Cl vs Alpha - Ncrit = 5');
grid on
grid minor


%% Cd vs Cl
%Ncrit = 9
figure
plot(sc20410_cl,sc20410_cd);
hold on
plot(sc20412_cl,sc20412_cd);
plot(sc20712_cl,sc20712_cd);
plot(whitcomb_cl,whitcomb_cd);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Cd');
ylabel('Cl');
title('Cl vs Cd - Ncrit = 9');
grid on
grid minor

%Ncrit = 5
figure
plot(sc20410_cl_n5,sc20410_cd_n5);
hold on
plot(sc20412_cl_n5,sc20412_cd_n5);
plot(sc20712_cl_n5,sc20712_cd_n5);
plot(whitcomb_cl_n5,whitcomb_cd_n5);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Cd');
ylabel('Cl');
title('Cl vs Cd - Ncrit = 5');
grid on
grid minor

%% Cl/Cd vs alpha
%Ncrit = 9
figure
plot(sc20410_alpha,sc20410_cl_cd);
hold on
plot(sc20412_alpha,sc20412_cl_cd);
plot(sc20712_alpha,sc20712_cl_cd);
plot(whitcomb_alpha,whitcomb_cl_cd);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cl/Cd');
title('Cl/Cd vs Alpha - Ncrit = 9');
grid on
grid minor

%Ncrit = 5
figure
plot(sc20410_alpha_n5,sc20410_cl_cd_n5);
hold on
plot(sc20412_alpha_n5,sc20412_cl_cd_n5);
plot(sc20712_alpha_n5,sc20712_cl_cd_n5);
plot(whitcomb_alpha_n5,whitcomb_cl_cd_n5);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cl/Cd');
title('Cl/Cd vs Alpha - Ncrit = 5');
grid on
grid minor


%% Cm vs alpha
%Ncrit = 9
figure
plot(sc20410_alpha,sc20410_cm);
hold on
plot(sc20412_alpha,sc20412_cm);
plot(sc20712_alpha,sc20712_cm);
plot(whitcomb_alpha,whitcomb_cm);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cm');
title('Cm vs Alpha - Ncrit = 9');
grid on
grid minor

%Ncrit = 5
figure
plot(sc20410_alpha_n5,sc20410_cm_n5);
hold on
plot(sc20412_alpha_n5,sc20412_cm_n5);
plot(sc20712_alpha_n5,sc20712_cm_n5);
plot(whitcomb_alpha_n5,whitcomb_cm_n5);
hold off

legend('NASA SC(2)-0410','NASA SC(2)-0412','NASA SC(2)-0712','WHITCOMB SC', 'Location' , 'southeast');
xlabel('Alpha (º)');
ylabel('Cm');
title('Cm vs Alpha - Ncrit = 5');
grid on
grid minor

