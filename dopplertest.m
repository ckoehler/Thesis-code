close all;
clear all;



v_max = 100;
carrier = 9.55e9;


lambda = 3e8/9.55e9;
v=1000;
amp = ones(1,200);
f_points = 100;
impulse_response = [];

tau = 1e-6;
fs = 2e8;
[s foo ntau] = makesignal(amp, [], [], impulse_response, tau, fs);
l = length(s);
dshift = exp(1i*2*pi/lambda*linspace(0,v,l).*(0:l-1)/fs);
s = s.*dshift;
acf1 = abs(conv(s,fliplr(conj(s)),'same'));


tau2 = 200e-6;
fs = 1e7;
[s2 foo ntau] = makesignal(amp, [], [], impulse_response, tau2, fs);
l = length(s2);
dshift = exp(1i*2*pi/lambda*linspace(0,v,l).*(0:l-1)/fs);
s2 = s2.*dshift;

acf2 = abs(conv(s2,fliplr(conj(s2)),'same'));


subplot(2,1,1);
plot(acf1);
t_str = sprintf('tau = %i',tau);
title(t_str);
subplot(2,1,2);
plot(acf2);
t_str = sprintf('tau = %i',tau2);
title(t_str);

