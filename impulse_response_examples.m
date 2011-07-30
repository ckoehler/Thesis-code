clear all;
close all;
v_max = 50;
carrier = 9.55e9;
fontsize = 14;

tau = 15e-6;
fs = 2e8;
N = tau*fs;
amp = ones(1,N);
f_points = 100;


%% IR
domain = linspace(0,5,N);
impulse_response = raylpdf(domain, 1);
impulse_response = impulse_response/max(impulse_response);

%% IR plot
fig = figure;
x = linspace(0, tau, N);
plot(x, impulse_response);
title('Impulse response   ', 'FontSize', fontsize);
xlabel('Time / s   ', 'FontSize', fontsize);
ylabel('Gain   ', 'FontSize', fontsize);
print(fig, '-dpng', '-r300', '../thesis/figures/tf1.png');


%% pulse
signal  = makesignal(amp, [], [], tau, fs);
[delay v the_af] = af(impulse_response, signal, tau, fs, v_max, f_points, carrier);
t_str = sprintf('Pulse w/ IR distortion ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
print(fig, '-dpng', '-r300', '../thesis/figures/pulsewir-15us.png');




%% LFM
%
B = 5e6;
f_signal = linspace(-B/2,B/2,N);
signal = makesignal(amp, [], f_signal, tau, fs);
[delay v the_af] = af(impulse_response, signal, tau, fs, v_max, f_points, carrier);
t_str = sprintf('LFM w/ IR distortion ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/lfmwir-%ius.png',tau*1e6);
print(fig, '-dpng', '-r300', filename);


%% NLFM
B = 5e6;
a = 3;
f_signal = B/2 .* generate_arbitrary_fm(tau, fs, a);
signal = makesignal(amp, [], f_signal, tau, fs);
[delay v the_af] = af(impulse_response, signal, tau, fs, v_max, f_points, carrier);
t_str = sprintf('NLFM w/ IR distortion ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/nlfmwir-%ius.png',tau*1e6);
print(fig, '-dpng', '-r300', filename);

[delay v the_af] = af([], signal, tau, fs, v_max, f_points, carrier);
t_str = sprintf('NLFM ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/nlfm-%ius-af.png',tau*1e6);
print(fig, '-dpng', '-r300', filename);


%% barker
phase = [ 0 0 0 0 0 1 1 0 0 1 0 1 0] * pi;
phase = kron(phase, ones(1,50));
f_points = 100;
%impulse_response = [];
signal = makesignal([], phase, [], tau, fs);
[delay v the_af] = af(impulse_response, signal, tau, fs, v_max, f_points, carrier);
t_str = sprintf('Barker w/ IR distortion ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
filename = sprintf('../thesis/figures/barkerwir-%ius.png', tau*1e6);
print(fig, '-dpng', '-r300', filename);
