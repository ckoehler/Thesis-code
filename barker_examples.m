clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'barker';
plot_title = 'Barker, 13 elements';


phase = [ 0 0 0 0 0 1 1 0 0 1 0 1 0] * pi;
phase = kron(phase, ones(1,50));
f_points = 100;
impulse_response = [];


tau = 1e-6;
fs = 2e8;
[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-0D.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

tau = 200e-6;
fs = 1e7;
[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

fig = plotafslice(1,t_str, delay,the_af);
filename = sprintf('../thesis/figures/%s-%ius-0D.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
