function f=generate_lfm(B,tau,fs)
  N = tau*fs;
  n = -N/2:N/2-1;
  f=B./N.*n./2;
end
