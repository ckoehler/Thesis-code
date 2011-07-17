clear all;
close all;
fontsize = 13;
impulse_response = [];
phase = [];
B = 5e6;
tau = 15e-6;
fs = 1e8;
N = tau*fs;
fftN = 2^nextpow2(8*N);
amp = ones(1,N);
a = 40;
bet = 50;

f_signal = B/2.* generate_arbitrary_fm(tau, fs, a);
[nlfm signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);

snlfm = fftshift(abs(fft(nlfm, fftN)));
themax = max(snlfm);
snlfm = snlfm/themax;


f_signal_lin = B/2.* generate_arbitrary_fm(tau, fs, 0);
[lfm signal new_tau] = makesignal(amp, phase, f_signal_lin, impulse_response, tau, fs);

slfm = fftshift(abs(fft(lfm, fftN)))/themax;


% kaiser
amp = kaiser(N,bet)';
[klfm signal new_tau] = makesignal(amp, phase, f_signal_lin, impulse_response, tau, fs);
sklfm = fftshift(abs(fft(klfm, fftN)))/themax;


x=linspace(-N/2,N/2-1,fftN)/tau/1e6;
fig = figure;
plot(x,slfm,'--',x,snlfm,x,sklfm);
leg = legend('LFM','NLFM', 'LFM, tapered');
set(leg, 'FontSize', fontsize);
xlabel('Frequency / MHz','FontSize', fontsize);
ylabel('Normalized Magnitude','FontSize', fontsize);
title('Frequency Spectrum Comparison','FontSize', fontsize);
xlim([-4 4]);
filename = '../thesis/figures/nlfmbwspectrum.png';
print(fig, '-dpng', '-r300', filename);
