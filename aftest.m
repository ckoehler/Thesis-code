clear all;
close all;
T = 200e-6;
v_max = 1000;
carrier = 9.55e9;
do_freq_mod = false;
f_signal = [];

resolution = 20;
signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
%af1 = af('Barker 13', signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

resolution = 10;
signal = ones(1,51);
B = 100e3;
f_factor = B/T;
t = linspace(0,T,length(signal)*resolution);
f_signal=f_factor.*t-B/2;
do_freq_mod = true;
af2 = af('LFM', signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

resolution = 10;
signal = ones(1,51);
B = 100e3;
f_factor = B/T;
t = linspace(0,T,length(signal)*resolution);
factor = linspace(0,1,length(signal)*resolution);
f_signal=f_factor.*t.*factor.^1-B/2;
do_freq_mod = true;
af2 = af('Quadratic FM', signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

signal2 = [ 1 1 1 1 1];
do_freq_mod = false;
%af3 = af(signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);
