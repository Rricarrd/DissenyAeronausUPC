clc
clear
%% Airfoil Comparison
% Add Data Folder
folder = fileparts(mfilename('C:\Users\rrica\OneDrive\Documents\GitHub\Aeronaus')); 
addpath(genpath(folder));

%Extract data to tables
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


%Tables to arrays
sc20410_Re1e6 = table2array(sc20410_Re1e6_tab);
sc20412_Re1e6 = table2array(sc20412_Re1e6_tab);
sc20712_Re1e6 = table2array(sc20712_Re1e6_tab);
whitcomb_Re1e6 = table2array(whitcomb_Re1e6_tab);

sc20410_Re1e6_n5 = table2array(sc20410_Re1e6_n5_tab);
sc20412_Re1e6_n5 = table2array(sc20412_Re1e6_n5_tab);
sc20712_Re1e6_n5 = table2array(sc20712_Re1e6_n5_tab);
whitcomb_Re1e6_n5 = table2array(whitcomb_Re1e6_n5_tab);