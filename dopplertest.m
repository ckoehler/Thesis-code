close all;
clear all;

carrier = 9.55e9;


lambda = 3e8/carrier;
v=50;
f_points = 100;
impulse_response = [];

tau = 1e-6;
fs = 2e8;
N=tau*fs;
amp = ones(1,N);
[s foo ntau] = makesignal(amp, [], [], impulse_response, tau, fs);
l = length(s);
dshift = exp(1i*2*pi/lambda.*v.*(0:l-1)/fs);
sd = s.*dshift;
%acf1 = abs(conv(s,fliplr(conj(sd)),'same'));
acf1 = abs(xcorr(s,sd));


tau2 = 200e-6;
fs = 2e5;
N=tau2*fs;
%N = 200;
amp = ones(1,N);
[s2 foo ntau] = makesignal(amp, [], [], impulse_response, tau2, fs);
l = length(s2);
dshift = exp(1i*2*pi/lambda.*v.*(0:l-1)/fs);
sd2 = s2.*dshift;

%acf2 = abs(conv(s2,fliplr(conj(sd2)),'same'));
acf2 = abs(xcorr(s2,sd2));


subplot(2,1,1);
plot(acf1);
t_str = sprintf('tau = %i',tau);
title(t_str);
subplot(2,1,2);
plot(acf2);
t_str = sprintf('tau = %i',tau2);
title(t_str);

