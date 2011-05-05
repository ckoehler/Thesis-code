clear all;
close all;
T = 200e-6;
v_max = 1000;
carrier = 9.55e9;
do_freq_mod = false;
f_signal = [];
fds = 10;
fs = 1e5;

%signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
%af('Barker 13', signal, T, v_max, fds, carrier, fs, f_signal, do_freq_mod,true);

signal = ones(1,13);
B = 1e6;
fs = 2e6;
f_factor = B/T;
t = linspace(0,T,length(signal)*T*fs);
f_signal=f_factor.*t;
do_freq_mod = true;
[AF u] = af('LFM', signal, T, v_max, fds, carrier, fs, f_signal, do_freq_mod, false);

%signal = ones(1,13);
%B = 10e6;
%f_factor = B/T;
%t = linspace(0,T,length(signal)*resolution);
%factor = linspace(0,1,length(signal)*resolution);
%f_signal=f_factor.*t.*factor.^1-B/2;
%do_freq_mod = true;
%%af('Quadratic FM', signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);

%signal = ones(1,13);
%do_freq_mod = false;
%fs = 20;
%fds = 10;
%%af('Pulse', signal, T, v_max, fds, carrier, fs, f_signal, do_freq_mod, true);
%%

%the_pulse = [0 0 1 0 0];
%signal = repmat(the_pulse,[1 6]);
%B = 100e3;
%f_factor = B/T;
%t = linspace(0,T,length(signal)*resolution);
%f_signal=f_factor.*t-B/2;
%do_freq_mod = true;
%%af('LFM Pulse train (6)', signal, T, v_max, carrier, resolution, f_signal, do_freq_mod);
