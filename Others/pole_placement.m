clear all
clc

syms x;

% Sampling period
Te = 1/30e3;

% Plant coefficients definition
A = [1 -0.433];
B = [0 0 233.8]; % With retard of -1

% Controller fixed parts definition
Hs = [1 -1];
Hr = [1 1];

% Desired poles definition
xi=0.9;
w0=2*pi*4000;
tfdes=tf(w0^2,[1 2*xi*w0 w0^2]);
tfdesd=c2d(tfdes,Te);
[numdes,dendes]=tfdata(tfdesd,'v');
tfdesd=filt([numdes],[dendes],Te);
p1=dendes(2);
p2=dendes(3);
nb_poles_hf=1;
p3=-0.6;
P=(1+p1*x+p2*x^2)*(1-p3*x);
P=collect(P,x);
Pmat=sym2poly(P);
Pmat=fliplr(Pmat);
P=zeros(1,4);
clear i
for i=1:nb_poles_hf+3
    P(i)=Pmat(i);
end

% Bezout equation resolution
[R,S,T] = bezoutd_AB(A,B,Hs,Hr,P,1,Te);