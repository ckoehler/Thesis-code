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

kaiser_params = linspace(0,20,points);
the_slice = 18;

for i=1:length(kaiser_params)
  amp = kaiser(N, kaiser_params(i))';
  [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
  [delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier, true);

  if i==the_slice
    fig = plotafslice(1, 'Windowed AF with PPR=3 dB', delay, the_af);
    filename = sprintf('../thesis/figures/%s-%ius-opti-slice%i.png', series_name,tau*1e6,i);
    print(fig, '-dpng', '-r300', filename);
  end

  %fig = plotaf('', delay, v, the_af);
  [isls(i) max_sidelobes(i)] = isl(the_af);
  ress(i,:) = res(the_af, delay(2)-delay(1));
  ppps(i,:) = ppp(amp);
end

fig = plotopti(kaiser_params, isls, ress,max_sidelobes, ppps);
filename = sprintf('../thesis/figures/%s-%ius-opti.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

