clear all
close all
clc

load('system_parameters.mat');

Te = 1/30e3;

PopSize = 40;
MaxGenerations = 18;
lb = [0.005 0 -0.1 -1.05 0.5];
ub = [0.02 0.01 -0.01 1.05 2];

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations);
[x,fval] = ga(@(K)controller_test(K),5,[],[],[],[],lb,ub,[],options);

A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% Controller fixed parts definition
Hs = [1 -1];
%Hr = [1 1];

% Coefficients definitionj
R = [x(1) x(2) x(3)]
S = conv(Hs, [1 x(4) x(5)])

sensitivity_functions(A,B,R,S,Te);