clear all;
close all;
v_max = 50;
carrier = 9.55e9;

tau = 15e-6;
fs = 2e8;
N = tau*fs;
amp = ones(1,N);
f_points = 100;
impulse_response = [];
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('Pulse w/o IR distortion ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
print(fig, '-dpng', '-r300', '../thesis/figures/pulsewoir-15us.png');

%impulse_response = [0 .1 .2 .4 .5 .8  1 .8 .5 .4 .2 .1 0];
domain = linspace(0,5,N);
impulse_response = raylpdf(domain, 1);
impulse_response = impulse_response/max(impulse_response);
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('Pulse w/ IR distortion ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
print(fig, '-dpng', '-r300', '../thesis/figures/pulsewir-15us.png');


fig = figure;
plot(impulse_response);
title('Impulse response');
print(fig, '-dpng', '-r300', '../thesis/figures/tf1.png');
