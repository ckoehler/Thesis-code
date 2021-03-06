clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'pulse';


f_points = 100;
impulse_response = [];

tau = 15e-6;
fs = 2e8;
N = tau*fs;
amp = ones(1,N);
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('Simple pulse ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotafslice([1 100], t_str, {'v=0','v=50'}, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

tau = 200e-6;
fs = 1e7;
N = tau*fs;
amp = ones(1,N);
[clean_signal signal new_tau] = makesignal(amp, [], [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('Simple pulse ( \\tau=200 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotafslice([1 100], t_str, {'v=0','v=50'}, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
