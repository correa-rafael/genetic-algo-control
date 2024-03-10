clear all
close all
clc

load('system_parameters.mat');

PopSize = 90;
MaxGenerations = 40;
lb = [0.005 -0.015 -1.05 0.5];
ub = [0.02 -0.001 1.05 2];

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations);
[x,fval] = ga(@(K)controller_test(K),4,[],[],[],[],lb,ub,[],options);

A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% Controller fixed parts definition
Hs = [1 -1];
Hr = [1 1];

% Coefficients definition
R = conv(Hr, [x(1) x(2)])
S = conv(Hs, [1 x(3) x(4)])

sensitivity_functions(A,B,R,S,Te);