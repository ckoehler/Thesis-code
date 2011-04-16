clear all;
close all;

signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
resolution = 1;

%function AF = af(signal)
  % Ambiguity function calculation
  % ambiguity function is af(t,f) = sum_over_t(u(t) * u'(t-tau) * exp(j*2*pi*f*t))

  f = linspace(0,1, 101);


  % default signal u, barker code
  %signal = [1 2 3];
  %signal = [1 1 1];


  signal = kron(signal,ones(1,resolution));

  % time vector
  t = (0:length(signal)-1)/resolution;

  % time interval
  dt = t(2)-t(1);

  % get amplitude and phase from the signal
  u_amplitude = abs(signal);
  u_phase = angle(signal);

  % exponential is e^j*phi;
  u_exponent = exp(1i*u_phase);

  % reassemble the signal
  u = u_amplitude .* u_exponent;

  % this is the signal length
  m = length(u);


  % now create the signal sparse matrix. No. of rows
  % are the same as we would get from the convolution, i.e.
  % twice the signal length - 1, or 25 for a length 13 Barker code.
  u_matrix = spdiags(u',0,m*2-1,m);


  % now we need to create a shifted matrix of u, where each row is the
  % signal u shifted in time. To do that, we create a padded vector of
  % u and then just look at parts of the Hankel matrix. It also takes
  % care of getting the time-reversed signal so we get the correlation,
  % not just convolution of the signal.
  u_padded = [zeros(1,m-1) u];
  shifted_u_matrix = sparse(hankel(u_padded));
  shifted_u_matrix = shifted_u_matrix(1:m,:);

  u_correlation = u_matrix*shifted_u_matrix;
  u_correlation = u_correlation(1:m,:);


  % now we need to apply a Doppler shift to this thing. It's defined as:
  u_shift = exp(1i*2*pi*f'*t);

  abs_af = abs(u_shift*u_correlation);
  abs_af = abs_af./max(max(abs_af));
  AF=abs_af;
  delay = [-fliplr(t) t(2:end)];
%end

figure;
surface(delay, f, AF);
shading flat;
view(-40,50)

figure;
subplot(2,1,1);
plot(u_amplitude);
subplot(2,1,2);
plot(u_phase);
