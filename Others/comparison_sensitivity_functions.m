clear all
clc

% Sampling period
Te = 1/30000;

% Plant coefficients definition
A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% PI coefficients definition
R_PI = [0.21e-3 0.21e-3];
S_PI = [1 -1];

% Sensitivity functions calculation with PI controller
[S0_PI, KS0_PI, T_PI] = sensitivity_functions(A,B,R_PI,S_PI,Te);

% PP coefficients definition
R_PP = [0.002 0.00117 -0.00083];
S_PP = [1.0000 0.15375 -0.7068 -0.44694];

% Sensitivity functions calculation with PP controller
[S0_PP, KS0_PP, T_PP] = sensitivity_functions(A,B,R_PP,S_PP,Te);

% H infinity coefficients definition (reduced order)
% R_Hinf = [0.00824 -0.00448];
% S_Hinf = [1 -0.99992];

% H infinity coefficients definition (4th order)
R_Hinf = [6.33e-3 0.85e-3 -3.97e-3 1.38e-3 -0.14e-3];
S_Hinf = [1 -466.1e-3 -933.9e-3 451.7e-3 -51.6e-3];

% Sensitivity functions calculation with H infinity controller
[S0_Hinf, KS0_Hinf, T_Hinf] = sensitivity_functions(A,B,R_Hinf,S_Hinf,Te);

% GA coefficients definition
R_GA = [0.0198 0.0057 -0.0141];
S_GA = [1.0000 -0.9427 0.8285 -0.8858];

% Sensitivity functions calculation with GA controller
[S0_GA, KS0_GA, T_GA] = sensitivity_functions(A,B,R_GA,S_GA,Te);

figure()
plotS0 = bodeplot(S0_GA, 'r--', S0_PP, 'b-', S0_Hinf, 'k-.', {2*pi*10, pi/Te});
setoptions(plotS0,'FreqUnits','Hz','PhaseVisible','off');
title('Output Sensitivity Function (S_{yp})');
legend('With GA controller', 'With PP controller', 'With H Infinity controller');
    
figure()
plotKS0 = bodeplot(KS0_GA, 'r--', KS0_PP, 'b-', KS0_Hinf, 'k-.', {2*pi*10, pi/Te});
setoptions(plotKS0,'FreqUnits','Hz','PhaseVisible','off'); 
legend('With GA controller', 'With PP controller', 'With H Infinity controller');
title('Input Sensitivity Function (S_{up})');
    
figure()
plotT = bodeplot(T_GA, 'r--', T_PP, 'b-', T_Hinf, 'k-.', {2*pi*10, pi/Te});
setoptions(plotT,'FreqUnits','Hz','PhaseVisible','off');
legend('With GA controller', 'With PP controller', 'With H Infinity controller');
title('Complementary Sensitivity Function (S_{yr})');

