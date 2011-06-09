clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'lfm-isl';
plot_title = 'LFM ISL';
lim = 1000;


f_points = 100;
impulse_response = [];
amp = ones(1,13);
phase = [];
B = 1e6;

tau = 15e-6;
fs = 5e6;
N = tau*fs;
n = 0:N-1;
f_signal=B./N.*n./2;

[clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
[delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier);

sliceaf = sum(the_af);
sliceaf = 10*log10(sliceaf/max(sliceaf));
sliceaf(sliceaf < -100)=NaN;
plot(sliceaf);
