clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'barker';
plot_title = 'LFM Opti';
f_points = 100;
impulse_response = [];
tau = 15e-6;
fs = 2e7;
phase = [ 0 0 0 0 0 1 1 0 0 1 0 1 0] * pi;
% this gets us N=325
phase = kron(phase, ones(1,25));
% normally this is fs*tau=200, so 325 is 
% still sufficiently large
N = 325;

f_signal=[];

points = 40;
isls=zeros(points,1);
max_sidelobes=zeros(points,1);
ress=[];
ppps=[];

the_slice = 3;

kaiser_params = linspace(0,20,points);

for i=1:length(kaiser_params)
  amp = kaiser(N, kaiser_params(i))';
  [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
  [delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier, true);

  if i==the_slice
    fig = plotafslice(1, 'Windowed Barker at minimum ISL', delay, the_af);
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
