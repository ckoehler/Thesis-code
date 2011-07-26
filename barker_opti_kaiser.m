clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'barker';
plot_title = 'Barker Opti';
f_points = 100;
impulse_response = [];
tau = 15e-6;
fs = 2e7;
subN = round(fs*tau/13);
phase = [ 0 0 0 0 0 1 1 0 0 1 0 1 0] * pi;
% this gets us N=325
phase = kron(phase, ones(1,subN));
% normally this is fs*tau=200, so 325 is 
% still sufficiently large
N = subN*13;

f_signal=[];

points = 40;
isls=zeros(points,1);
max_sidelobes=zeros(points,1);
ress=[];
ppps=[];

theslices = [1 40];

kaiser_params = linspace(0,20,points);
slices = [];
index = 1;

for i=1:length(kaiser_params)
  amp = subkaiser(N, kaiser_params(i), subN);
  [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
  [delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier, true);

  if(ismember(i,theslices))
    slices(index,:) = the_af(theslices(index),:);
    index = index + 1;
  end

  %fig = plotaf('', delay, v, the_af);
  [isls(i) max_sidelobes(i)] = isl(the_af);
  ress(i,:) = res(the_af, delay(2)-delay(1));
  ppps(i,:) = ppp(amp);
end
fig = plotafslice([1 2], 'Tapered Barker 13', {'\beta = 0', '\beta = 20'}, delay, slices);
filename = sprintf('../thesis/figures/%s-%ius-opti-slices.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

fig = plotopti(kaiser_params, isls, ress,max_sidelobes, ppps);
filename = sprintf('../thesis/figures/%s-%ius-opti.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

fig = figure;
fontsize = 14;
x = linspace(0,tau, N);
plot(x, real(clean_signal));
title('Barker 13 waveform    ', 'FontSize', fontsize);
xlabel('Time / s     ', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlim([0 tau]);
filename = sprintf('../thesis/figures/%s-%ius-realsignal.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
