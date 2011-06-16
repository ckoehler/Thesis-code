clear all;
close all;
v_max = 50;
carrier = 9.55e9;
series_name = 'lfm';
plot_title = 'LFM';
lim = 1000;
f_points = 100;
impulse_response = [];
amp = ones(1,13);
amp=kaiser(13,2);
phase = [];
B = 5e6;
tau = 15e-6;
fs = 1e7;
N = tau*fs;

a = (linspace(0,10,100));

delays = [];
vs = [];
afs=[];
for i=1:length(a)
  %f_signal = linspace(-B/2, B/2, N);
  f_signal = generate_arbitrary_fm(tau, fs, a(i));

  [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
  [delay v the_af] = af(signal, clean_signal, new_tau, v_max, f_points, carrier, true);
  delays(i,:)=delay;
  vs(i,:)=v;
  afs(i,:,:)=the_af;

end

save('nlfm.mat', 'delays','vs','afs','a','tau');
