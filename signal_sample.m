clear all;
signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];

tau = 200e-6;
fs = 5e6;
N = tau*fs;

% this is the "time" sequence, just a sequence of samples.
n = 0:N-1;

ssignal = kron(signal,ones(1,N/length(signal)));

bsignal = [ssignal zeros(1,N-length(ssignal))]
