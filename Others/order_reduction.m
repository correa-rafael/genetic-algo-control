clear all
clc

% Sampling period
Te = 1/30000;

% Plant coefficients definition
A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

R4 = [6.33e-3 0.85e-3 -3.97e-3 1.38e-3 -0.14e-3];
S4 = [1 -466.1e-3 -933.9e-3 451.7e-3 -51.6e-3];
K4 = tf(R4,S4,1/30000);
[S04, KS04, T4] = sensitivity_functions(A,B,R4,S4,Te);

K3 = balred(K4, 3);
[R3, S3] = tfdata(K3, 'v');
[S03, KS03, T3] = sensitivity_functions(A,B,R3,S3,Te);

K1 = balred(K4, 1);
[R1, S1] = tfdata(K1, 'v');
[S01, KS01, T1] = sensitivity_functions(A,B,R1,S1,Te);

R1_ahmad = [0.00824 -0.00448];
S1_ahmad = [1 -0.99992];
[S01_ahmad, KS01_ahmad, T1_ahmad] = sensitivity_functions(A,B,R1_ahmad,S1_ahmad,Te);

figure()
plotS0 = bodeplot(S04, 'r--', S03, 'b-', S01, 'k-.', S01_ahmad, 'r-', {2*pi*10, pi/Te});
setoptions(plotS0,'FreqUnits','Hz','PhaseVisible','off');
set(findall(gcf,'Type','line'),'LineWidth',2);
title('Output Sensitivity Function (S_{yp})');
legend('4th order', '3rd order', '1st order', '1st ordem Ahmad');
    
figure()
plotKS0 = bodeplot(KS04, 'r--', KS03, 'b-', KS01, 'k-.', KS01_ahmad, 'r-', {2*pi*10, pi/Te});
setoptions(plotKS0,'FreqUnits','Hz','PhaseVisible','off'); 
set(findall(gcf,'Type','line'),'LineWidth',2);
legend('4th order', '3rd order', '1st order', '1st ordem Ahmad');
title('Input Sensitivity Function (S_{up})');
   
figure()
plotT = bodeplot(T4, 'r--', T3, 'b-', T1, 'k-.', T1_ahmad, 'r-', {2*pi*10, pi/Te});
setoptions(plotT,'FreqUnits','Hz','PhaseVisible','off');
set(findall(gcf,'Type','line'),'LineWidth',2);
legend('4th order', '3rd order', '1st order', '1st ordem Ahmad');
title('Complementary Sensitivity Function (S_{yr})');

