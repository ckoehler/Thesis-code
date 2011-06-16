clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'lfm-isl';
plot_title = 'LFM ISL';
f_points = 100;
impulse_response = [];
phase = [];
B = 5e6;
tau = 15e-6;
fs = 2e7;
N = tau*fs;
f_signal = linspace(-B/2,B/2,N);

points = 100;
isls=zeros(points,1);
max_sidelobes=zeros(points,1);
ress=[];
ppps=[];

kaiser_params = linspace(0,50,points);

for i=1:length(kaiser_params)
  amp = kaiser(N, kaiser_params(i))';
  [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
  [delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier, true);

  %fig = plotaf('', delay, v, the_af);
  [isls(i) max_sidelobes(i)] = isl(the_af);
  ress(i,:) = res(the_af, delay(2)-delay(1));
  ppps(i,:) = ppp(amp);
end

plotopti(kaiser_params, isls, ress,max_sidelobes, ppps);
