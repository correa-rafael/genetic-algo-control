

clc; 
clear all; 
Te=1/(30000);


%% System Model for synthesis of controller

c11 = 0.5e-9*1.65;
c1 = ss(c11);

GB1 = 1e9;
GB = ss(1e9);

%%% Voltage Amplifier
wv = 4000 ; 
GFc1=tf([15*12],[1/(2*pi*wv) 1]);
GFc = ss(GFc1);
% [GFc_n, GFc_d] = ss2tf(GFc.a, GFc.b, GFc.c, GFc.d);
% GFc2 = tf(GFc_n, GFc_d);

GFd1=c2d(GFc1,Te, 'tustin');
GFd = ss(GFd1);

[GFd_n, GFd_d] = ss2tf(GFd.a, GFd.b, GFd.c, GFd.d);
GFd2 = filt(GFd_n, GFd_d, Te);




GZ1 = 1e9*c1;
GZ = ss(GZ1);
% 
% 
% GI = tf(1, [1 0]);
% GI1=c2d(GI,Te, 'tustin');
% GId = ss(GI1);
% 
% [GId_n, GId_d] = ss2tf(GId.a, GId.b, GId.c, GId.d);
% GId2 = filt(GId_n, GId_d, Te);



% GN1 = 1 / GB;
% GN = ss(GN1);


% GC = series(GFc, GB);
% GCd=c2d(GC,Te, 'zoh');
% [Gnumd,Gdend] = tfdata(GCd,'v');
% GC_d=filt(Gnumd, Gdend, Te)


% GC_d = GFd2;
% [B,A]=tfdata(GC_d, 'v');

%% Controller Sysnthesis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% definition of the weighting function 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%      20*log10(0.05/0.5)

Ms=2;                    %%% 6 dB
wb=2*pi*1.9e3; % real one

%epsi2=0.1; %/80 ; %(0.1780)
%epsi2=0.1/10000; % working
%epsi2=0.1/10000;
epsi2=0.1/1000000;

Mu= 3.2;             %10V;
wbc=2*pi*3e3;
epsi3= 0.5; 

Mt = 1.5;         %%% 3.5 dB
wt= 2*pi*3e3;
epsi4 = 0.5; 




We1=tf([1/Ms wb],[1 wb*epsi2]);
We = ss(We1);
Wed1=c2d(We1,Te,'tustin');
Wed = ss(Wed1);
% figure(1); sigma(inv(We), 'b'); grid on ; 
% hold on ; sigma(inv(Wed), 'r--'); title('S weighting filter');

% [Wed_n,Wed_d] = tfdata(Wed,'v');
% Wedn = [Wed_n]; 
% Wedn = [Wed_d];
% We1d = filt(Wedn,Wedn);
% We1dd = ss(Wed, Te);




Wu1=tf([1 wbc/Mu],[epsi3 wbc]);
Wu = ss(Wu1);
Wud1=c2d(Wu1,Te,'tustin');
Wud = ss(Wud1);
% figure(2); sigma(inv(Wu), 'b');grid on ; 
% hold on ; sigma(inv(Wud), 'r--'); title('KS weighting filter');

% [Wud_n,Wud_d] = tfdata(Wud,'v');
% Wudn = [Wud_n]; 
% Wudn = [Wud_d];
% Wu1d = filt(Wudn,Wudn,Te);
% Wu1dd = ss(Wud, Te);


%Wt=(tf([1/Mt wt],[1 wt*epsi4]));



Wt1=tf([1 wt/Mt],[epsi4 wt]);
Wt = ss(Wt1);
Wtd1=c2d(Wt1,Te,'tustin');
Wtd = ss(Wtd1);
% figure(3); sigma(inv(Wt), 'b');grid on ; 
% hold on ; sigma(inv(Wtd), 'r--'); title('T weighting filter');

% [Wtd_n,Wtd_d] = tfdata(Wtd,'v');
% Wtdn = [Wtd_n]; 
% Wtdn = [Wtd_d];
% Wt1d = filt(Wtdn,Wtdn,Te);
% Wt1dd = ss(Wtd, Te);

wa = 120000;

TFBO1=tf([15],[1/(2*pi*4000) 1]);   % voltage amplifier
[num1,den1] = tfdata(TFBO1,'v');

TFBO2=tf([12*(2*pi*wa)^2],[1 2*0.7*(2*pi*wa) (2*pi*wa)^2]); % piezo
[num2,den2] = tfdata(TFBO2,'v');

TFBO3=tf([1e9],[1/(2*pi*13000) 1]);   % current sensor
[num3,den3] = tfdata(TFBO3,'v');



GGc = TFBO1 * TFBO2 * TFBO3 * c1 ;
TFBOc2d=c2d(GGc,Te,'zoh');
[GGcd_n,GGcd_d] = tfdata(TFBOc2d,'v');
B = [GGcd_n]; % with single delay
A = [GGcd_d];
TFBOcd = filt(B,A,Te);



%%

%  systemnames = 'GFd GZ Wed Wud Wtd';   %%% discrete plant
% % systemnames = 'GFd GZ Wed Wud';
%  inputvar = '[ r; Zs; n; u]';
% outputvar = '[Wed; Wud; Wtd; r-n-GZ-GFd]';
% % outputvar = '[Wed; Wud; r-n-GZ-GFd]';
%  input_to_GFd = '[u]';
%  input_to_GZ = '[Zs]';
%  input_to_Wed = '[r-n-GZ-GFd]';
%  input_to_Wud = '[u]';
%  input_to_Wtd = '[GFd+GZ]';
%  sysoutname = 'P';
%  cleanupsysic = 'yes';
%  sysic

 
%  systemnames = 'GFc GZ We Wu Wt';   %%% continuous plant
%  inputvar = '[ r; Zs; n; u]';
%  outputvar = '[We; Wu; Wt; r-n-GZ-GFc]';
%  input_to_GFc = '[u]';
%  input_to_GZ = '[Zs]';
%  input_to_We = '[r-n-GZ-GFc]';
%  input_to_Wu = '[u]';
%  input_to_Wt = '[GFc+GZ]';
% % input_to_GN = '[n]';
% % input_to_c1 = '[Zs]';
%  sysoutname = 'P';
%  cleanupsysic = 'yes';
%  sysic
 

systemnames = 'GFc c1 GB We Wu Wt';   %%% continuous plant
inputvar = '[ r; Zs; n; u]';
outputvar = '[We; Wu; Wt; r-n-GB]';
input_to_GFc = '[u]';
input_to_c1 = '[GFc+Zs]';
input_to_GB = '[c1]';
input_to_We = '[r-n-GB]';
input_to_Wu = '[u]';
input_to_Wt = '[c1]';
sysoutname = 'P';
cleanupsysic = 'yes';
sysic


% 
% %systemnames = 'GFd GZ Wed Wud GId';   %%% integrator
% systemnames = 'GFd Wed Wud GId'; 
% inputvar = '[ r; Zs; n; u]';
% outputvar = '[Wed; Wud; GId]';
% input_to_GFd = '[u]';
% %input_to_GZ = '[Zs]';
% input_to_Wed = '[r-n-Zs-GFd]';
% input_to_Wud = '[u]';
% input_to_GId = '[r-n-Zs-GFd]';
% sysoutname = 'P';
% cleanupsysic = 'yes';
% sysic


%systemnames = 'GFd GZ Wed Wud Wtd';   %%% discrete simple plant, No GB, GZ
% systemnames = 'GFd Wed Wud';            %% WORKING    
% inputvar = '[ r; Zs; n; u]';
% %outputvar = '[Wed; Wud; Wtd; r-n-GZ-GFd]';
% outputvar = '[Wed; Wud; r-n-Zs-GFd]';
% input_to_GFd = '[u]';
% %input_to_GZ = '[Zs]';
% input_to_Wed = '[r-n-Zs-GFd]';
% input_to_Wud = '[u]';
% %input_to_Wtd = '[GFd+GZ]';
% sysoutname = 'P';
%  cleanupsysic = 'yes';
%  sysic

% %systemnames = 'GFd GZ Wed Wud Wtd';   %%% continus simple plant, No GB, GZ
% systemnames = 'GFc We Wu';
% inputvar = '[ r; Zs; n; u]';
% %outputvar = '[Wed; Wud; Wtd; r-n-GZ-GFd]';
% outputvar = '[We; Wu; r-n-Zs-GFc]';
% input_to_GFc = '[u]';
% %input_to_GZ = '[Zs]';
% input_to_We = '[r-n-Zs-GFc]';
% input_to_Wu = '[u]';
% %input_to_Wtd = '[GFd+GZ]';
% sysoutname = 'P';
% cleanupsysic = 'yes';
% sysic


%Find H-infinity optimal controller%

nmeas=1; ncon=1;
[Khinf,CL,GAM,INFO] = hinfsyn(P,nmeas,ncon,'DISPLAY','on')

[KK_num , KK_den] = ss2tf(Khinf.a, Khinf.b, Khinf.c, Khinf.d);

ctrl_Hinf = tf(KK_num, KK_den);

%ctrl_Hinf= series(ctrl_Hinf,GId2);


ctrl_Hinf1=c2d(ctrl_Hinf,Te, 'tustin');
ctrl_Hinfd = ss(ctrl_Hinf1);

[R, S] = ss2tf(ctrl_Hinfd.a, ctrl_Hinfd.b, ctrl_Hinfd.c, ctrl_Hinfd.d)
ctrl_Hinfd2 = filt(R, S, Te);




%[R,S]=tfdata(ctrl_Hinf, 'v');

%%%%%%%%% (T) Verification for RS controller

% 
% R1 = filt([R(1) R(2) R(3) R(4) R(5)],1,Te); 
% S1 = filt([S(1) S(2) S(3) S(4) R(5)],1,Te);



% delete HI_Cont_thesis
% save HI_Cont_thesis R S T0



%% plotting

%Te=1/(30000);
%c1 = 2.29 * 0.75e-9 ;
%c1 = 1.65 * 0.75e-9 ;



R1 = filt(R,1,Te); 
S1 = filt(S,1,Te);


A1 = filt(A,1,Te);
B1 = filt(B,1,Te);
% 
 P1 = A1*S1 + B1*R1 ;
% 
 [PN, PD]=tfdata(P1, 'v');
 
 BR=R1*B1;
 [BR1,BR2]=tfdata(BR,'v');
% 
 T0 = sum(PN)/sum(BR1) % it's exact





%L= series(GC_d, ctrl_Hinf); %discrete

L= series(TFBOcd, ctrl_Hinfd2); %discrete complete


%L= series(GFc1, ctrl_Hinf); % continuoes

Sen=inv(1+L);  

T= feedback(L,1);

%SG=series(Sen, GC_d);


KS=series(ctrl_Hinfd2, Sen);


figure; 
sigma(Sen);
grid on ; 


figure; 
sigma(T);
grid on; 


% figure; 
% sigma(SG);
% grid on; 


figure;
sigma(KS);
grid on;

figure;
step(T*T0);
grid on; 

























% ctrl_Hinfd=c2d(ctrl_Hinf,Te,'zoh');
% 
% 
% [ctrl_Hinfd_n,ctrl_Hinfd_d] = tfdata(ctrl_Hinfd,'v');
% ctrl_Hinfdn = [ctrl_Hinfd_n]; 
% ctrl_Hinfdd = [ctrl_Hinfd_d];
% ctrl_Hinfd_TF = filt(ctrl_Hinfdn,ctrl_Hinfdd,Te);
% R = [ctrl_Hinfd_n]; 
% S = [ctrl_Hinfd_d];
% 
% 
% 
% %%
%  
%  
%  
%  
%%%¨Piezo Actuator
wa = 120000;
ga = 12 ; 
%TFBO2=tf([1.2e-9],[1/(2*pi*120000) 1]);
%TFBO2=tf([12e-10*(2*pi*120000)^2],[1 2*0.7*(2*pi*120000) (2*pi*120000)^2]);
TFBO2=tf([ga*(2*pi*wa)^2],[1 2*0.7*(2*pi*wa) (2*pi*wa)^2]);
% [num2,den2] = tfdata(TFBO2,'v');
% TFBOd2=c2d(TFBO2,Te, 'tustin');
% [numd2,dend2] = tfdata(TFBOd2,'v');


%%% Current Sensor
TFBO3=tf([1e9],[1/(2*pi*13000) 1]);
% [num3,den3] = tfdata(TFBO3,'v');
% TFBOd3=c2d(TFBO3,Te, 'tustin');
% [numd3,dend3] = tfdata(TFBOd3,'v');


%%% Physical Law
k = 2.29 ;
c1 = k * 0.75e-9 ;   % point of functional 

c11d = ss(c1);
c11 = ss(c1);
c1d = (c1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% complete model DIGITAL %%%%


% GGd = TFBOd1 * TFBOd2 * TFBOd3 * c1; 
% [GG_n,GG_d] = tfdata(GGd,'v');
% Bd = [GG_n]; % with single delay
% Ad = [GG_d];
% TFBOd = filt(Bd,Ad,Te);



%%% complete model CONTINUOUS %%%%


GGc = TFBO1 * TFBO2 * TFBO3 * c1 ;
GGc1 = ss(GGc);
TFBOc2d=c2d(GGc,Te,'zoh'); %%%%%%%%%%%%%%%%%% tustin
[GGcd_n,GGcd_d] = tfdata(TFBOc2d,'v');
Bcd = [GGcd_n]; % with single delay
Acd = [GGcd_d];
TFBOcd = filt(Bcd,Acd,Te);


%%%% Model for synthesis of controller

%TFBO4=12*c1*TFBO1*TFBO3;

Gf = ga*c1*TFBO1;
Gf1 = ss(Gf);

Gfd=c2d(Gf,Te,'zoh');
[Gfd_n,Gfd_d] = tfdata(Gfd,'v');
Gfdn = [Gfd_n]; 
Gfdn = [Gfd_d];
Gf1d = filt(Gfdn,Gfdn,Te);
Gf1dd = ss(Gfd, Te);



Gb = TFBO3; 
Gb1 = ss(Gb);


% Gbd=c2d(Gb,Te,'zoh');
% [Gbd_n,Gbd_d] = tfdata(Gbd,'v');
% Gbdn = [Gbd_n]; 
% Gbdn = [Gbd_d];
% Gb1d = filt(Gbdn,Gbdn,Te);
% Gb1dd = ss(Gbd, Te);


Gn = 1/Gb; 
Gn1 = ss(Gn);

% Gnd=c2d(Gn,Te, 'tustin');
% [Gnd_n,Gnd_d] = tfdata(Gnd,'v');
% Gndn = [Gnd_n]; 
% Gndn = [Gnd_d];
% Gn1d = filt(Gndn,Gndn,Te);
% Gn1dd = ss(Gnd, Te);


%% open loop design transfer function

G11 = series(Gf, Gb); 
G1 = ss(G11);


TFBOc2d2=c2d(G11,Te,'zoh');
[numd,dend] = tfdata(TFBOc2d2,'v');
B = [numd]; % with single delay
A = [dend];
TFBOc2d2d = filt(B,A,Te);
TFBOc2d2d = ss(TFBOc2d2d);





%Wt = 1.5 ;
%Generalized plant P is found with function sysic%
% systemnames = 'Gf1 Gb1 We1 Wu1 Wt1 Gn1 c11'; %%% continuous plant
% systemnames = 'Gf1 Gb1 We1 Wu1 Wt1 Gn1 c11';
% inputvar = '[ r; Zs; n; u]';
% outputvar = '[We1; Wu1; Wt1; r-Gb1]';
% input_to_Gf1 = '[u]';
% input_to_Gb1 = '[Gn1+c11+Gf1]';
% input_to_We1 = '[r-Gb1]';
% input_to_Wu1 = '[u]';
% input_to_Wt1 = '[Gf1+c11]';
% input_to_Gn1 = '[n]';
% input_to_c11 = '[Zs]';
% sysoutname = 'P';
% cleanupsysic = 'yes';
% sysic
% sysout = sysic;
% tf(sysout)


% Wt at voltage 

% systemnames = 'Gf1 Gb1 We1 Wu1 Wt1 Gn1 c11';
% inputvar = '[ r; Zs; n; u]';
% outputvar = '[We1; Wu1; Wt1; r-Gb1]';
% input_to_Gf1 = '[u]';
% input_to_Gb1 = '[Gn1+c11+Gf1]';
% input_to_We1 = '[r-Gb1]';
% input_to_Wu1 = '[u]';
% input_to_Wt1 = '[Gb1]';
% input_to_Gn1 = '[n]';
% input_to_c11 = '[Zs]';
% sysoutname = 'P';
% cleanupsysic = 'yes';
% sysic
% %sysou



systemnames = 'Gf1dd Gb1dd We1dd Wu1dd Wt1dd Gn1dd c11d';   %%% discrete plant
inputvar = '[ r; Zs; n; u]';
outputvar = '[We1dd; Wu1dd; Wt1dd; r-Gb1dd]';
input_to_Gf1dd = '[u]';
input_to_Gb1dd = '[Gn1dd+c11d+Gf1dd]';
input_to_We1dd = '[r-Gb1dd]';
input_to_Wu1dd = '[u]';
input_to_Wt1dd = '[Gf1dd+c11d]';
input_to_Gn1dd = '[n]';
input_to_c11d = '[Zs]';
sysoutname = 'P';
cleanupsysic = 'yes';
sysic

%Find H-infinity optimal controller%

nmeas=1; ncon=1;
[Khinf,CL,GAM,INFO] = hinfsyn(P,nmeas,ncon,'DISPLAY','on')

[KK_num , KK_den] = ss2tf(Khinf.a, Khinf.b, Khinf.c, Khinf.d);

ctrl_Hinf = tf(KK_num, KK_den);

ctrl_Hinfd=c2d(ctrl_Hinf,Te,'zoh');


[ctrl_Hinfd_n,ctrl_Hinfd_d] = tfdata(ctrl_Hinfd,'v');
ctrl_Hinfdn = [ctrl_Hinfd_n]; 
ctrl_Hinfdd = [ctrl_Hinfd_d];
ctrl_Hinfd_TF = filt(ctrl_Hinfdn,ctrl_Hinfdd,Te);
R = [ctrl_Hinfd_n]; 
S = [ctrl_Hinfd_d];

% 
% R1 = filt([R(1) R(2) R(3) R(4) R(5) R(6)],1,Te); 
% S1 = filt([S(1) S(2) S(3) S(4) S(5) S(6)],1,Te);
% 
% [Scoef,denS]=tfdata(S1,'v');
% [Rcoef,denR]=tfdata(R1,'v');
% 
% A1 = filt([A(1) A(2) A(3)],1,Te);
% B1 = filt([B(1) B(2) B(3)],1,Te)
% 
% P1 = A1*S1 + B1*R1 ;
% 
% [PN PD]=tfdata(P1, 'v');
% 
% T = (PN(1)+PN(2)+PN(3)+PN(4)+PN(5)+PN(6)+PN(7)+PN(8))/(B(1)+B(2)+B(3));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% %LC = series(GGc, ctrl_Hinf); %continuous model & continuous controller TF 
% 
% %LC= series(TFBOc2d, ctrl_Hinfd); %discrete model & discrete controller TF
% 
% LC= series(TFBOcd, ctrl_Hinfd_TF); %discrete model & discrete controller TF
% 
% %L = series(GGc1, Khinf);
% 
% 
% S0=inv(1+LC);  
% poleS=pole(S0)
% 
% T0= feedback(LC,1);
% poleT=pole(T0)
% 
% %SG0=S0*GGc;
% %SG0=S0*TFBOc2d;
% SG0=S0*TFBOcd;
% poleSG=pole(SG0)
% 
% %KS0=ctrl_Hinf*S0;
% %KS0=ctrl_Hinfd*S0;
% KS0=ctrl_Hinfd_TF*S0;
% poleKS=pole(KS0)
% 
% 
% 
% figure; 
% sigma(S0, 'b')
% hold on; 
% sigma(inv(We1), 'g--');   % r on y1 
% hold on ; 
% sigma(inv(We1*Gb1*c11), 'k--');  % Zs on y1
% hold on ; 
% sigma(inv(We1), 'r--');  % n on y1
% hold on; 
% sigma(inv(Wt1*c11), 'k--')
% grid on ; 
% 
% figure; 
% sigma(KS0, 'r')
% hold on; 
% sigma(inv(Wu1), 'g--');    % r on y2
% hold on ; 
% sigma(inv(Wu1*Gb1*c11), 'k--');   %  Zs on y2
% hold on ; 
% sigma(inv(Wu1), 'r--');    % n on y2
% grid on ;
% 
% 
% figure; 
% sigma(KS0)
% hold on; 
% sigma(inv(Gf1*Wt1), 'r--'); 
% % hold on ; 
% % sigma(inv(Gf1*Wt1), 'k'); 
% % grid on ;
% 
% figure; 
% sigma(T0, 'r')
% hold on; 
% sigma(inv(Wt1)*Gb1, 'g--');   % r on y3
% hold on ;
% sigma(inv(Wt1)*Gb1*1e-9, 'r--');  % n on y3
% grid on ;
% 
% 
% figure; 
% sigma(T0);
% hold on; 
% sigma(inv(Wt1), 'r--'); 
% grid on ; 
% 
% 
% 
% figure ; 
% margin(LC); 
% grid on ;
% allmargin(LC)
% 
% figure; 
% step(T0, 'k')
% 
% 
