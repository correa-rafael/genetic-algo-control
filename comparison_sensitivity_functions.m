clear all
clc

% Sampling period
Te = 1/20000;

% Plant coefficients definition
A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1
A = tf(A, 1, Te, 'Variable', 'z^-1');
B = tf(B, 1, Te, 'Variable', 'z^-1');

% PI coefficients definition
R_PI = [0.21e-3 0.21e-3];
S_PI = [1 -1];
R_PI = tf(R_PI, 1, Te, 'Variable', 'z^-1');
S_PI = tf(S_PI, 1, Te, 'Variable', 'z^-1');

% Sensitivity functions calculation with PI controller
S0_PI = A*S_PI / (A*S_PI + B*R_PI);
KS0_PI = A*R_PI / (A*S_PI + B*R_PI);
T_PI = B*R_PI / (A*S_PI + B*R_PI);
SG_PI = B*S_PI / (A*S_PI + B*R_PI);

% PP coefficients definition
R_PP = [0.002 0.00117 -0.00083];
S_PP = [1.0000 0.15375 -0.7068 -0.44694];
R_PP = tf(R_PP, 1, Te, 'Variable', 'z^-1');
S_PP = tf(S_PP, 1, Te, 'Variable', 'z^-1');

% Sensitivity functions calculation with PP controller
S0_PP = A*S_PP / (A*S_PP + B*R_PP);
KS0_PP = A*R_PP / (A*S_PP + B*R_PP);
T_PP = B*R_PP / (A*S_PP + B*R_PP);
SG_PP = B*S_PP / (A*S_PP + B*R_PP);

% H infinity coefficients definition (3th order)
R_Hinf = [0.006328 0.0004912 -0.004518 0.001329];
S_Hinf = [1 -0.5236 -0.9856 0.5093];
R_Hinf = tf(R_Hinf, 1, Te, 'Variable', 'z^-1');
S_Hinf = tf(S_Hinf, 1, Te, 'Variable', 'z^-1');

% Sensitivity functions calculation with H infinity controller
S0_Hinf = A*S_Hinf / (A*S_Hinf + B*R_Hinf);
KS0_Hinf = A*R_Hinf / (A*S_Hinf + B*R_Hinf);
T_Hinf = B*R_Hinf / (A*S_Hinf + B*R_Hinf);
SG_Hinf = B*S_Hinf / (A*S_Hinf + B*R_Hinf);

% GA coefficients definition
R_GA = [0.0198 0.0057 -0.0141];
S_GA = [1.0000 -0.9427 0.8285 -0.8858];
R_GA = tf(R_GA, 1, Te, 'Variable', 'z^-1');
S_GA = tf(S_GA, 1, Te, 'Variable', 'z^-1');

% Sensitivity functions calculation with GA controller
S0_GA = A*S_GA / (A*S_GA + B*R_GA);
KS0_GA = A*R_GA / (A*S_GA + B*R_GA);
T_GA = B*R_GA / (A*S_GA + B*R_GA);
SG_GA = B*S_GA / (A*S_GA + B*R_GA);

figure('WindowState', 'maximized');
subplot(2,2,1);
plotS0 = bodeplot(S0_PI, 'r--', S0_PP, 'b-', S0_Hinf, 'k-.', S0_GA, 'g-', {2*pi*10, pi/Te});
setoptions(plotS0,'FreqUnits','Hz','PhaseVisible','off');
title('Sensitivity Function S_{0}', 'FontSize', 25);
set(findall(gcf,'Type','line'),'LineWidth',2);

subplot(2,2,2);
plotKS0 = bodeplot(KS0_PI, 'r--', KS0_PP, 'b-', KS0_Hinf, 'k-.', KS0_GA, 'g-', {2*pi*10, pi/Te});
setoptions(plotKS0,'FreqUnits','Hz','PhaseVisible','off'); 
title('Sensitivity Function KS_{0}', 'FontSize', 25);
set(findall(gcf,'Type','line'),'LineWidth',2);
    
subplot(2,2,3);
plotT = bodeplot(T_PI, 'r--', T_PP, 'b-', T_Hinf, 'k-.', T_GA, 'g-', {2*pi*10, pi/Te});
setoptions(plotT,'FreqUnits','Hz','PhaseVisible','off');
title('Sensitivity Function T', 'FontSize', 25);
set(findall(gcf,'Type','line'),'LineWidth',2);

subplot(2,2,4);
plotSG = bodeplot(SG_PI, 'r--', SG_PP, 'b-', SG_Hinf, 'k-.', SG_GA, 'g-', {2*pi*10, pi/Te});
setoptions(plotSG,'FreqUnits','Hz','PhaseVisible','off');
legend('PI controller', 'Pole Placement controller', 'H-infinity controller', 'Genetic Algorithm controller', 'FontSize', 25);
title('Sensitivity Function SG', 'FontSize', 25);
set(findall(gcf,'Type','line'),'LineWidth',2);
