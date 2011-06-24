%clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'lfm';
plot_title = 'LFM';
lim = inf;


f_points = 100;
impulse_response = [];
phase = [];
B = 5e6;

tau = 15e-6;
fs = 8e7;
N = tau*fs;
amp = ones(1,N);
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

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-0D.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);


tau = 200e-6;
fs = 1.5e7;
N = tau*fs;
amp = ones(1,N);
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-0D.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);


window = 'Hamming';

tau = 15e-6;
fs = 2e7;
N = tau*fs;
amp = hamming(N)';
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz, %s window)      ', plot_title, tau, carrier./1e9,window);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius-%s.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-%s-0D.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);

tau = 200e-6;
fs = 1.2e7;
N = tau*fs;
amp = hamming(N)';
f_signal = linspace(-B/2, B/2, N);
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz, %s window)      ', plot_title, tau, carrier./1e9,window);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius-%s.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-%s-0D.png', series_name,tau*1e6,window);
print(fig, '-dpng', '-r300', filename);
