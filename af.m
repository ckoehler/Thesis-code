function AF = af(desc_str, signal, T, v_max, carrier, resolution, f_signal, do_freq_mod)
  % Ambiguity function calculation
  % ambiguity function is af(t,f) = sum_over_t(u(t) * u'(t-tau) * exp(j*2*pi*f*t))
  
  % speed of light
  c = 3e8;

  % wavelength
  lam = c/carrier;

  % convert v_max to a frequency
  f_max = 2*v_max/lam;

  orig_m = length(signal);

  % expand the signal for oversampling.
  signal = kron(signal,ones(1,resolution));
  %f_signal = kron(f_signal,ones(1,resolution));

  % time vector
  t = linspace(0,T,length(signal));

  % frequency span
  f = linspace(0,f_max, length(signal));
    
  % time interval
  dt = t(2)-t(1);

  % get amplitude and phase from the signal
  u_amplitude = abs(signal);
  u_phase = angle(signal);
  %
  % this is the signal length
  m = length(u_amplitude);

  if(do_freq_mod)
    %u_phase = u_phase+pi.*f_signal.*t;
    u_freqmod = pi.*f_signal.*t;


    % rebuild the bandwidth from the f_signal
    B = f_signal(end)-f_signal(1);
    t_str = sprintf('%s (T=%3.3e s, f=%1.2f GHz, B = %3.2f MHz)      ', desc_str, T, carrier./1e9, B./1e6);
  else
    u_freqmod = 0;
    t_str = sprintf('%s (T=%3.3e s, f=%1.2f GHz)      ', desc_str, T, carrier./1e9);
  end

  % exponential is e^j*phi;
  u_exponent = exp(j*u_phase).*exp(j.*u_freqmod);

  % reassemble the signal
  u = u_amplitude .* u_exponent;



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
  delay = [-fliplr(t) t(2:end)] * c;

  % convert doppler frequency to velocity
  v = f .* c ./ carrier ./ 2;

  figure;
  surface(delay, v, AF);
  view(-40,50);
  title(t_str,'FontSize',12);
  xlabel('Range delay in m    ','FontSize',12);
  ylabel('Radial velocity in m/s     ','FontSize',12);
  zlabel('Normalized magnitude     ','FontSize',12);
  axis([-inf inf -inf inf 0 1]);
  shading flat;
  %shading faceted;
  %cmrow = [41	143	165] ./ 255;
  %cm=repmat(cmrow, [64 1]); 	
  %colormap(cm);

  figure;
  first_title = sprintf('%s -- Amplitude', desc_str);
  subplot(4,1,1);
  plot(t, u_amplitude);
  xlim([0, t(end)]);
  title(first_title);

  subplot(4,1,2);
  plot(t, u_phase);
  xlim([0, t(end)]);
  title('Phase (before frequency modulation)');

  subplot(4,1,3);
  plot(t, u_phase+u_freqmod);
  xlim([0, t(end)]);
  title('Phase (after frequency modulation)');

  subplot(4,1,4);
  plot(t,f_signal);
  title('Frequency');
  xlim([0, t(end)]);
  ylabel('Frequency Hz');
  xlabel('Signal duration T');
end
