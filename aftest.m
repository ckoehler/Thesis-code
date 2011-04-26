clear all;
close all;
T = 200e-6;
v_max = 100;
carrier = 9.55e9;
do_freq_mod = false;
f_signal = [];

resolution = 10;
signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
%af1 = af(signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

resolution = 3;
signal = ones(1,51);
%f_signal = [-25:25] * .0031;
f_signal = [-25:25] * .0031;
do_freq_mod = true;
af2 = af(signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

signal2 = [ 1 1 1 1 1];
do_freq_mod = false;
%af3 = af(signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);
