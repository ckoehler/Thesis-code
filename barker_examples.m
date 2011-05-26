clear all;
close all;
v_max = 100;
carrier = 9.55e9;
series_name = 'barker';


phase = [ 0 0 0 0 0 1 1 0 0 1 0 1 0] * pi;
f_points = 100;
impulse_response = [];

tau = 15e-6;
fs = 20e6;
[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
t_str = sprintf('Simple pulse ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
%print(fig, '-dpng', '-r300', filename);

%tau = 15e-6;
%fs = 2e8;
%[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
%[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
%t_str = sprintf('Simple pulse ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
%fig = plotaf(t_str, delay,v,the_af);
%filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
%print(fig, '-dpng', '-r300', filename);

%tau = 50e-6;
%fs = 2e7;
%[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
%[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
%t_str = sprintf('Simple pulse ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
%fig = plotaf(t_str, delay,v,the_af);
%filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
%print(fig, '-dpng', '-r300', filename);

%tau = 100e-6;
%fs = 2e6;
%[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
%[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
%t_str = sprintf('Simple pulse ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
%fig = plotaf(t_str, delay,v,the_af);
%filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
%print(fig,'-dpng', '-r300', filename);

%tau = 200e-6;
%fs = 1e6;
%[clean_signal signal new_tau] = makesignal([], phase, [], impulse_response, tau, fs);
%[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);
%t_str = sprintf('Simple pulse ( \\tau=%3.3e s, f=%1.2f GHz)      ', tau, carrier./1e9);
%fig = plotaf(t_str, delay,v,the_af);
%filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
%print(fig, '-dpng', '-r300', filename);
