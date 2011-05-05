tau = 20e-6;
B = 5e6;
fs = 30e6;
N = tau*fs;
Ts = 1/fs;
n = 0:N-1;

f_of_t = (0.5.*n.*B./N);
shift = exp(j*2*pi .* f_of_t ./fs.*n);
% So phi(t) = 2*pi*f(t)/fs*n

plot(tau*n,shift);
