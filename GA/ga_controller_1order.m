clear all
close all
clc

load('system_parameters.mat');

Te = 1/30e3;

PopSize = 40;
MaxGenerations = 18;
lb = [-0.01 -0.01];
ub = [0.01 0.01];

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations);
[x,fval] = ga(@(K)controller_test(K),2,[],[],[],[],lb,ub,[],options);

A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% Coefficients definitionj
R = [x(1) x(2)]
S = [1 -1]

sensitivity_functions(A,B,R,S,Te);