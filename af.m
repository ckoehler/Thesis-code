function [delay v AF] = af(signal, clean_signal, tau, v_max, f_points, carrier, full_af) % Ambiguity function calculation
  % ambiguity function is af(t,f) = sum_over_t(u(t) * u'(t-tau) * exp(j*2*pi*f*t))
  %
  % fs = Range dimension sampling frequency
  % signal = the signal we need the AF of.
  % clean_signal = if different from signal, this is the signal we use to create the time-
  %                 shifted version, or u'(t-tau) above.
  % tau = signal length
  
  % if no signal is given, assume that all we have is a clean signal
  % and use that.
  if isempty(signal)
    signal = clean_signal;
    ir=false;
  else
    ir=true;
  end

  if nargin < 7
    full_af=false;
  end


  % speed of light
  c = 3e8;
  % wavelength
  lam = c/carrier;

  m = length(signal);
  m_clean = length(clean_signal);
  
  % convert v_max to a frequency
  f_max = 2*v_max/lam;

  % frequency span
  if full_af
    f = linspace(-f_max,f_max, 2*f_points);
  else
    f = linspace(0,f_max, f_points);
  end
    
  % time vector. Used for Doppler shift calculations.
  t = linspace(0,tau,m);

  rows = m*2-1;

  % now create the signal sparse matrix. No. of rows
  % are the same as we would get from the convolution, i.e.
  % twice the signal length - 1, or 25 for a length 13 Barker code.
  u_matrix = spdiags(signal',0,rows,m);

  % now we need to create a shifted matrix of u, where each row is the
  % signal u shifted in time. To do that, we create a padded vector of
  % u and then just look at parts of the Hankel matrix. 
  u_padded = [zeros(1,rows-m_clean) clean_signal];
  shifted_u_matrix = sparse(hankel(u_padded));
  shifted_u_matrix = shifted_u_matrix(1:m,:);

  u_correlation = u_matrix*shifted_u_matrix;
  u_correlation = u_correlation(1:m,:);

  % if we have a signal distorted by an impulse response, the shifted_u_matrix
  % is larger and has a bunch of leading 0, exactly m_clean-1 zeros. That will cause the result to be shifted
  % as well, so here we correct for that by chopping off m_clean-1 spots
  if ir
    u_correlation = u_correlation(:, m_clean:end);
  end


  % now we need to apply a Doppler shift to this thing. It's defined as:
  %u_shift = exp(j*2*pi*f'*n./fs);
  u_shift = exp(-j*2*pi*f'*t);

  abs_af = abs(u_shift*u_correlation);

  AF = abs_af./max(max(abs_af));

  % if we have an impulse response, we cut off some zeros from the AF earlier, so the delay axis needs
  % to be recomputed. Since we cut off m_clean-1 points, our t-axis is now m-m_clean/2 points long, over
  % the pulse length.
  if ir
    t = linspace(0, tau, m-m_clean/2);
    delay = [-fliplr(t) t] * c;
  else
    delay = [-fliplr(t) t(2:end)] * c;
  end

  % convert doppler frequency to velocity
  v = f .* c ./ carrier ./ 2;
end
