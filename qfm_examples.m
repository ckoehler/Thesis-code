clear all;
close all;
v_max = 100;
carrier = 9.55e9;
series_name = 'qfm';
plot_title = 'QFM';


f_points = 100;
impulse_response = [];
amp = ones(1,13);
phase = [];
B = 1e6;

tau = 15e-6;
fs = 50e6;
N = tau*fs;
n = 0:N-1;
f_signal=B./N.*n.^2./2;
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

tau = 50e-6;
fs = 2e7;
N = tau*fs;
n = 0:N-1;
f_signal=B./N.*n./2;
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

tau = 100e-6;
fs = 1e7;
N = tau*fs;
n = 0:N-1;
f_signal=B./N.*n./2;
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig,'-dpng', '-r300', filename);

tau = 200e-6;
fs = 1e7;
N = tau*fs;
n = 0:N-1;
f_signal=B./N.*n./2;
[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
