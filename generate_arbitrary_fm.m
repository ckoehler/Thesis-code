function f=generate_arbitrary_fm(tau, fs, a,b)
  N = tau*fs;
  n = -N/2:N/2-1;
  x = a.*n.^3 + b.*n;
  x = x./(max(abs(x)));
  f = x;
end
