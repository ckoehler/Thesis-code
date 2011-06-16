%clear all;
close all;
v_max = 500;
carrier = 9.55e9;
series_name = 'lfm';
plot_title = 'LFM';
lim = inf;


f_points = 100;
impulse_response = [];
amp = ones(1,13);
phase = [];
B = 5e6;

tau = 15e-6;
fs = 8e7;
N = tau*fs;
%f_signal = (0:(N-1))/N*B - B/2;
f_signal = linspace(-B/2,B/2,N);
fig = figure;
plot(f_signal);
title('Frequency modulation function');
ylabel('Frequency / Hz');
filename = sprintf('../thesis/figures/%s-fmf.png', series_name);
print(fig, '-dpng', '-r300', filename);


[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
return;


tau = 200e-6;
fs = 1e6;
N = tau*fs;
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);


amp = hamming(13)';
window = 'Hamming';

tau = 15e-6;
fs = 1e7;
N = tau*fs;
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz, %s window)      ', plot_title, tau, carrier./1e9,window);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius-%s.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);

tau = 200e-6;
fs = 1e6;
N = tau*fs;
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz, %s window)      ', plot_title, tau, carrier./1e9,window);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius-%s.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);
