clear all;
close all;
resolution = 10;
T = 200e-6;
f_max = 600000;
carrier = 9.55e9;
do_freq_mod = false;
f_signal = [];

signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
af1 = af(signal, T, f_max, carrier, resolution, f_signal, do_freq_mod)

signal = ones(1,51);
f_signal = [-25:25] * .0031;
do_freq_mod = true;
af2 = af(signal, T, f_max, carrier, resolution, f_signal, do_freq_mod)

signal2 = [ 1 1 1 1 1];
do_freq_mod = false;
af3 = af(signal, T, f_max, carrier, resolution, f_signal, do_freq_mod)
