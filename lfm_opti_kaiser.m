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
fs = 1e8;
N = tau*fs;
f_signal = linspace(-B/2,B/2,N);

points = 100;
isls=zeros(points,1);
isls0d=zeros(points,1);
max_sidelobes=zeros(points,1);
max_sidelobes0d=zeros(points,1);
ress=[];
ppps=[];
ress0d=[];

kaiser_params = linspace(0,20,points);
the_slice = 18;

for i=1:length(kaiser_params)
  amp = kaiser(N, kaiser_params(i))';
  signal  = makesignal(amp, phase, f_signal, tau, fs);
  [delay v the_af] = af([], signal, tau, fs, v_max, f_points, carrier, true);

  if i==the_slice
    fig = plotafslice(1, 'Tapered AF with PPR=-3 dB', '', delay, the_af);
    xlim([-1500 1500]);
    filename = sprintf('../thesis/figures/%s-%ius-opti-slice%i.png', series_name,tau*1e6,i);
    print(fig, '-dpng', '-r300', filename);
  end

  [isls(i) max_sidelobes(i)] = isl(the_af);
  [isls0d(i) max_sidelobes0d(i)] = isl(the_af(101,:));
  ress(i,:) = res(the_af, delay(2)-delay(1));
  ress0d(i,:) = res(the_af(101,:), delay(2)-delay(1));
  ppps(i,:) = ppp(amp);
end

x = kaiser_params;
  cols = 2;
  rows = 2;
  ppp = true;
  param = '\beta    ';

  fig = figure;
  subplot(rows,cols,1);
  plot(x,isls,x, isls0d);
  title('Integrated Sidelobe Levels     ', 'FontSize', fontsize);
  ylabel('dB');


  subplot(rows, cols,2);
  plot(x, max_sidelobes,x,max_sidelobes0d);
  title('Peak Sidelobe Level    ', 'FontSize', fontsize);
  ylabel('dB');



  subplot(rows,cols,3);
  plot(x,ress(:,1), x, ress0d(:,1));
  title('3dB Range Resolution     ', 'FontSize', fontsize);
  ylabel('Spatial delay in m     ', 'FontSize', fontsize);
  xlabel(param, 'FontSize', fontsize);

  subplot(rows,cols,4);
  plot(x,ppps, x, ppps);
  title('Pulse Power Ratio     ', 'FontSize', fontsize);
  ylabel('dB     ', 'FontSize', fontsize);
  xlabel(param, 'FontSize', fontsize);
  legend('whole AF', 'zero-Doppler slice');

filename = sprintf('../thesis/figures/%s-%ius-opti.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

