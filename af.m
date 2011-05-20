function AF = af(signal, clean_signal, tau, v_max, fds, carrier)
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


  % speed of light
  c = 3e8;
  % wavelength
  lam = c/carrier;
  AF = -1;


  m = length(signal);
  m_clean = length(clean_signal);
  
  % convert v_max to a frequency
  f_max = 2*v_max/lam;

  % frequency span
  f = linspace(0,f_max, 100);
    
  % time vector. We only need this for plotting.
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
  % is larger and has a bunch of leading 0. That will cause the result to be shifted
  % as well, so here we correct for that. Conveniently, it's off by length of the clean
  % signal, or m_clean.
  if ir
    u_correlation = u_correlation(:, m_clean:end);
  end
  size(u_correlation)


  % now we need to apply a Doppler shift to this thing. It's defined as:
  %u_shift = exp(j*2*pi*f'*n./fs);
  u_shift = exp(j*2*pi*f'*t);
  size(u_shift)

  abs_af = abs(u_shift*u_correlation);



  %abs_af = u_correlation;
  abs_af = abs_af./max(max(abs_af));
  %AF=abs_af(:,1:end-(2*diff_length));
  AF = abs_af;
  size(AF)
  %t = t(1:end-diff_length);
  delay = [-fliplr(t) t(2:end)] * c;
  size(delay)

  % convert doppler frequency to velocity
  v = f .* c ./ carrier ./ 2;
  size(v)

  figure;
  % TODO: need to adjust the delay. If we have an IR signal, the delay will be longer, tau*(2*m-1).
  %surface(delay, v, AF);
  surface(AF);
  view(-40,50);
  t_str = 'foo';
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

  %figure;
  %first_title = sprintf('%s -- Amplitude', desc_str);
  %subplot(2, number_of_columns,1);
  %plot(t, u_amplitude(1:end-diff_length));
  %xlim([0, t(end)]);
  %title(first_title);

  %subplot(2, number_of_columns,2);
  %plot(t, u_phase(1:end-diff_length));
  %xlim([0, t(end)]);


  %if do_freq_mod
    %title('Phase (before frequency modulation)');
    %subplot(2, number_of_columns,3);
    %combined = u_phase+u_freqmod;
    %plot(t, combined(1:end-diff_length));
    %xlim([0, t(end)]);
    %title('Phase (after frequency modulation)');
    %xlabel('Signal duration tau');

    %subplot(2, number_of_columns,4);
    %plot(t,f_signal(1:end-diff_length));
    %title('Frequency');
    %xlim([0, t(end)]);
    %ylabel('Frequency Hz');
    %xlabel('Signal duration tau');
  %else
    %title('Phase');
    %xlabel('Signal duration tau');
  %end

  %figure;
  %if ir
    %u = u_pre;
  %end
  %plot(t,real(u(1:end-diff_length)));
  %xlim([0, t(end)]);
  %signal_title = sprintf('%s -- Full Signal', desc_str);
  %title(signal_title);
  %xlabel('Signal duration tau');
end
