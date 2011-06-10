function f=generate_arbitrary_fm(tau, fs, a,b, c)
  N = tau*fs;
  n = linspace(-1,1,N);
  x = c.*n.^7 + a.*n.^3 + b.*n;
  x = x./(max(abs(x)));
  f = x;
end
