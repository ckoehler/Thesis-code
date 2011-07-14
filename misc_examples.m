close all;
clear all;

fontsize = 12;

%% first a simple barker ACF
phase = [ 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];

acf = abs(xcorr(phase,phase));

fig = figure;
plot(acf);
title('Barker 13 Code ACF', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Data points    ', 'FontSize',fontsize);
filename = '../thesis/figures/barker13-acf.png';
print(fig, '-dpng', '-r300', filename);



%% kaiser parameters
N=6;
points = 100
kaiser_params = linspace(0,10,N);
s = cell(1,N);
C = [1 0 0; 1 1 0; 0 1 0; 0 1 1; 0 0 1; 1 0 1];
fig = figure;
hold on;
for i=1:length(kaiser_params)
  amp = kaiser(points, kaiser_params(i))';
  h(i) = plot(amp, 'Color', C(i, :));
  s{i} = sprintf('\\beta = %d', kaiser_params(i));
end
ind = [1 2 3 4 5 6];
legend(h(ind),s{ind});
title('Kaiser Window with varying     \beta     ', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Data points    ', 'FontSize',fontsize);
ylim([0 1.05]);

filename = '../thesis/figures/kaiserparams.png';
print(fig, '-dpng', '-r300', filename);

%% LFM whole AF
v_max = 100000;
carrier = 9.55e9;
series_name = 'lfm-full';
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
f_signal = linspace(-B/2,B/2,N);

[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('%s ( \\tau=%3.3e s, f=%1.2f GHz)      ', plot_title, tau, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);


%% Kaiser FFT
close all;
k = [0; kaiser(121,0); 0;];
figure;
plot(fftshift(abs(fft(fftshift(k)))));


k = [0; kaiser(121,10); 0;];
figure;
plot(fftshift(abs(fft(fftshift(k)))));


%% LFM waveform
series_name = 'lfm-waveform';

impulse_response = [];
phase = [];
B = 5e6;
tau = 5e-6;
fs = 8e7;
N = tau*fs;
amp = ones(1,N);
f_signal = linspace(0,B,N);

[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
fig = figure;
x = linspace(0,tau,N);
plot(x,real(clean_signal));
xlim([0,tau]);
title('LFM waveform, \tau=5 \mus    ', 'FontSize',fontsize);
xlabel('Pulse length \tau    ', 'FontSize',fontsize);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);


%% simple pulse waveform show-n-tell
impulse_response = [];
phase = [];
B = 5e6;
tau = 15e-6;
fs = 8e7;
N = tau*fs;
X = 100;
Y = 2000;
amp = [zeros(1,X) ones(1,N) zeros(1,X)];
f_signal = [zeros(1,X) 8e5*ones(1,N) zeros(1,X)];
[s signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);

s = [s zeros(1, Y) s];

new_N = 2*N+4*X+Y;
x = 1:new_N;
fig = figure;
plot(x, real(s), x, abs(s), '--'); 
ylim([-1.1 1.1]);
xlim([0 new_N]);
xlabel('time    ', 'FontSize', fontsize);
filename = '../thesis/figures/basic_waveform.png';
print(fig, '-dpng', '-r300', filename);
