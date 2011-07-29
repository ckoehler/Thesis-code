close all;
clear all;

fontsize = 14;

%% first a simple barker ACF
phase = [ 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
x = -12:1:12;

acf = abs(xcorr(phase,phase));

fig = figure;
plot(x, acf);
title('Barker 13 Code ACF', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Lag', 'FontSize',fontsize);
xlim([-12 12]);
filename = '../thesis/figures/barker13-acf.png';
print(fig, '-dpng', '-r300', filename);



%% kaiser parameters
N=6;
points = 100
kaiser_params = linspace(0,10,N);
s = cell(1,N);
C = get(gca,'ColorOrder');
fig = figure;
hold on;
x = linspace(0,15e-6,points);
for i=1:length(kaiser_params)
  amp = kaiser(points, kaiser_params(i))';
  h(i) = plot(x, amp, 'Color', C(i, :));
  s{i} = sprintf('\\beta = %d', kaiser_params(i));
end
ind = [1 2 3 4 5 6];
leg=legend(h(ind),s{ind});
set(leg, 'FontSize', fontsize);
title('Kaiser Window with varying     \beta     ', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Time / s     ', 'FontSize',fontsize);
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
t_str = sprintf('%s ( \\tau=15 \\mus, f=%1.2f GHz )      ', plot_title, carrier./1e9);
fig = plotaf(t_str, delay,v,the_af);
xlim([-lim lim]);
filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

%% Pulse whole AF
v_max = 6000;
carrier = 9.55e9;

f_points = 100;
impulse_response = [];
phase = [];
B = 5e6;

tau = 15e-6;
fs = 8e7;
N = tau*fs;
amp = ones(1,N);

[clean_signal signal new_tau] = makesignal(amp, phase, [], impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier);
t_str = sprintf('Pulse ( \\tau=15 \\mus, f=%1.2f GHz )      ', carrier./1e9);
fig = plotaf(t_str, delay,v,the_af, true);
filename = '../thesis/figures/pulsefullaf.png';
print(fig, '-dpng', '-r300', filename);

%% Kaiser FFT
close all;

tau = 15e-6;
N = 256;
a = ones(1,20);
a = fftshift(abs(fft(a, N)));


b = kaiser(20,1);
b = fftshift(abs(fft(b, N)));


c = kaiser(20,10);
c = fftshift(abs(fft(c, N)));

d = kaiser(20,20);
d = fftshift(abs(fft(d, N)));

x = linspace(-N/2,N/2-1,N)/tau/1e3;
fig = figure;
plot(x,a,'--',x,b,x,c,x,d);
xlabel('Frequency / kHz', 'FontSize', fontsize);
ylabel('Amplitude', 'FontSize', fontsize);
leg = legend('rect. pulse','Kaiser \beta=1', 'Kaiser \beta=10', 'Kaiser \beta=20');
set(leg, 'FontSize', fontsize);
xlim([-.8e4 .8e4]);
filename = '../thesis/figures/fftspec.png';
print(fig, '-dpng', '-r300', filename);

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
ylabel('Amplitude       ', 'FontSize', fontsize);
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
xlabel('Time    ', 'FontSize', fontsize);
filename = '../thesis/figures/basic_waveform.png';
print(fig, '-dpng', '-r300', filename);


%% pulse spectrum

fontsize = 13;
impulse_response = [];
phase = [];
B = 5e6;
tau = 15e-6;
fs = 1e8;
N = tau*fs;
fftN = 2^nextpow2(8*N);
amp = ones(1,N);
[s signal new_tau] = makesignal(amp, phase, [], impulse_response, tau, fs);

ss = fftshift(abs(fft(s, fftN)));
ss = 20*log10(ss/max(ss));


x=linspace(-N/2,N/2-1,fftN)/tau/1e6;
fig = figure;
plot(x,ss);
xlabel('Frequency / MHz','FontSize', fontsize);
ylabel('dB   ','FontSize', fontsize);
title('Rectangular Pulse    ','FontSize', fontsize);
xlim([-4 4]);
filename = '../thesis/figures/pulsespectrum.png';
print(fig, '-dpng', '-r300', filename);


%% pulse and window
N = 1000;
tau = 15e-6;
w = kaiser(N,7);
rect = [0 ones(1,N-2) 0];
x = linspace(0,tau, N);

fig = figure;
plot(x,w, x, rect);
xlabel('Time / s ', 'FontSize', fontsize);
ylabel('Amplitude', 'FontSize', fontsize);
xlim([-1e-6 16e-6]);
ylim([0, 1.1]);
filename = '../thesis/figures/pprdemo.png';
print(fig, '-dpng', '-r300', filename);


%% sinc function

tau = 15e-6;
fs = 1e9;
N = tau*fs;
f = linspace(-10/tau, 10/tau, N);
fx = linspace(-10,10, N);
x = abs(sinc(f.*tau));
x = x/max(x);

plot(fx, x);
xlabel('Multiples of 1/\tau', 'FontSize', fontsize);
ylabel('Amplitude', 'FontSize', fontsize);
title('AF Doppler dimension of a rectangular pulse ', 'FontSize', fontsize); 
xlim([-10 10]);
filename = '../thesis/figures/sincnulls.png';
print(fig, '-dpng', '-r300', filename);
