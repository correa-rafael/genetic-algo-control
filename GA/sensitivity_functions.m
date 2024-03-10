function [S0, KS0, T] = sensitivity_functions(A,B,R,S,Te)
    %Delay and discretization delay need to be integrated in B 

    %Inputs:
    %A=[a0 a1 ... aNa]
    %B=[b0 b1 ... bNb]
    %R=[r0 r1 ... rNr]
    %S=[s0 s1 ... sNs]
    %Te ... scalar representing the system's sampling periodnj

    % Plant coefficients definition      
    A = tf(A, 1, Te, 'Variable', 'z^-1');
    B = tf(B, 1, Te, 'Variable', 'z^-1');
    
    % Controller coefficients definition
    R = tf(R, 1, Te, 'Variable', 'z^-1');
    S = tf(S, 1, Te, 'Variable', 'z^-1');

    % Sensitivity functions definition
    S0 = A*S / (A*S + B*R);
    KS0 = A*R / (A*S + B*R);
    T = B*R / (A*S + B*R);
    
    % Plots
    plot_sensitivity_functions(S0,KS0,T,Te);
end