function J = controller_test_x(parms)

syms x;

% Sampling period
Te = 1/20000;

% Plant coefficients definition
A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% Controller fixed parts definition
Hs = [1 -1];
Hr = [1 1];

% Coefficients definition
R = conv(Hr, [parms(1) parms(2)]);
S = conv(Hs, [1 parms(3) parms(4)]);

% Sensitivity functions calculation with PP controller
[S0, KS0, T] = sensitivity_functions(A,B,R,S,Te);writematrix

% -------------- S0 -----------------

% Get the dB values of the Bode plot
[mag_S0, ~, w] = bode(S0);
mag_S0 = squeeze(mag_S0);
mag_S0 = 20*log10(mag_S0); % Convert to dB

% Calculate the maximum amplitude in dB in the frequency domain
max_amplitude_S0 = max(mag_S0);

% Find the amplitude 800 rad/s in dB
w_desired = 800;
[~, index] = min(abs(w - w_desired)); % Find the nearest index
amplitude_S0_800rad = mag_S0(index);


% -------------- KS0 -----------------

% Get the dB values of the Bode plot
[mag_KS0, ~, ~] = bode(KS0);
mag_KS0 = squeeze(mag_KS0);
mag_KS0 = 20*log10(mag_KS0); % Convert to dB

% Calculate the maximum amplitude in dB in the frequency domain
max_amplitude_KS0 = max(mag_KS0);

% -------------- T -----------------

% Get the dB values of the Bode plot
[mag_T, ~, w] = bode(T);
mag_T = squeeze(mag_T);
mag_T = 20*log10(mag_T); % Convert to dB

% Calculate the maximum amplitude in dB in the frequency domain
max_amplitude_T = max(mag_T);

% Find the amplitude at 10 kHz in dB
w_desired = 6.28e4; % About 10 kHz
[~, index] = min(abs(w - w_desired)); % Find the nearest index
amplitude_T_10kHz = mag_T(index);

% Find the amplitude at 5 kHz in dB
w_desired = 6.28e3 * 5; % About 10 kHz
[~, index] = min(abs(w - w_desired)); % Find the nearest index
amplitude_T_5kHz = mag_T(index);

% -----------------------GA---------------------------

assignin('base', 'R', R);
assignin('base', 'S', S);

try
    sim("GA_test.slx");

catch ME
    if strcmp(ME.identifier, 'Simulink:Engine:DerivativeNotFinite')
    end
end

if isnan(STAE(length(STAE)))
    W0 = 1e9;
else
    W0 = 5e4*STAE(length(STAE));
end

% Stability condition
if abs((-parms(3)-sqrt(parms(3)^2-4*parms(4)))/2) > 1 || abs((-parms(3)+sqrt(parms(3)^2-4*parms(4)))/2) > 1
    L0 = 1e9;
else
    L0 = 0;
end

% S0 maximum condition
if max_amplitude_S0 > 6
    L1 = 1e9;
else
    L1 = 0;
end

% KS0 maximum condition
if max_amplitude_KS0 > -40
    L2 = 1e9;
else
    L2 = 0;
end

% T maximum condition
if max_amplitude_T > 3.5
    L3 = 1e9;
else
    L3 = 0;
end

% No-peak condition
if peak_test(length(peak_test)) > 0
    L4 = 1e9;
else
    L4 = 0;
end

% 5.4 V condition
if test_5_4(length(test_5_4)) > 0
    L5 = 1e9;
else
    L5 = 0;
end


% Optimization conditions
W1 = (amplitude_S0_800rad)*10;
W2 = (amplitude_T_10kHz)*30;
W3 = (amplitude_T_5kHz)*80;
W4 = (test_5_3(length(test_5_3)))*1e9;

if W4==0
    W4 = 1e9;
end

J = L0 + L1 + L2 + L3 + L4 + L5 + W0 + W1 + W3 + W4 + 200