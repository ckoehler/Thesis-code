function [delay v af] = af(signal, clean_signal, tau, fs, v_max, f_points, carrier, full_af) 
  % Ambiguity function calculation
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

  if nargin < 8
    full_af=false;
  end


  % speed of light
  c = 3e8;
  % wavelength
  lam = c/carrier;

  m = length(signal);
  m_clean = length(clean_signal);

  af = [];
  
  % convert v_max to a frequency
  f_max = 2*v_max/lam;

  % frequency span
  if full_af
    f = linspace(-f_max,f_max, 2*f_points);
  else
    f = linspace(0,f_max, f_points);
  end

  %f = [1.5917e3 1.5917e3];
  for i=1:length(f)
    dshift = exp(1i*2*pi.*f(i).*(0:m_clean-1)/fs);
    shifted_s = clean_signal.*dshift;

    af(i,:) = abs(xcorr(signal, shifted_s));
    %af(i,:) = abs(conv(signal,fliplr(conj(shifted_s))));
    
  end
  af = af./max(max(af));

  % compute delay
  t = linspace(0, tau, m);
  delay = [-fliplr(t) t(2:end)] * c / 2;

  % convert doppler frequency to velocity
  v = f .* lam ./ 2;
end
