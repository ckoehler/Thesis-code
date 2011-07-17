function f=generate_arbitrary_fm(tau, fs, a)
  N = tau*fs;
  n = linspace(-1,1,N);
  x = a.*n.^9 + n;
  f = x./(max(abs(x)));
end
