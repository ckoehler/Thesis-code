clear all;
close all;
v_max = 50;
carrier = 9.55e9;
f_points = 100;
impulse_response = [];
phase = [];
B = 5e6;
tau = 15e-6;
fs = 1e7;
N = tau*fs;

a = (linspace(0,10,70));

points = 40;
kaiser_params = linspace(0,20,points);



delays = [];
vs = [];
afs=[];
ress=[];
ppps=[];


for i=1:length(a)
  f_signal = B/2.* generate_arbitrary_fm(tau, fs, a(i));
  for j=1:length(kaiser_params)
    amp = kaiser(N, kaiser_params(j))';

    [clean_signal signal new_tau] = makesignal(amp, phase, f_signal, impulse_response, tau, fs);
    [delay v the_af] = af(signal, clean_signal, new_tau, fs, v_max, f_points, carrier, true);
    delays(i,j,:)=delay;
    vs(i,j,:)=v;
    afs(i,j,:,:)=the_af;
  end
  i
end

save('nlfm_kaiser.mat', 'delays','vs','afs','a','tau','kaiser_params');
