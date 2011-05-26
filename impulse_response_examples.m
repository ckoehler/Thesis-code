clear all;
close all;
v_max = 100;
carrier = 9.55e9;


tau = 200e-6;
amp = ones(1,13);
fs = 2e6;
f_points = 100;
impulse_response = [];
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('Pulse w/o IR distortion ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
print(fig, '-dpng', '-r300', '../thesis/figures/pulsewoir-200us.png');

impulse_response = [0 .1 .2 .4 .5 .8  1 .8 .5 .4 .2 .1 0];
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('Pulse w/ IR distortion ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
print(fig, '-dpng', '-r300', '../thesis/figures/pulsewir-200us.png');


fig = figure;
plot(impulse_response);
title('Transfer function');
print(fig, '-dpng', '-r300', '../thesis/figures/tf1.png');
