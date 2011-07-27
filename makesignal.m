function signal = makesignal(amp, phase, freq_mod, tau, fs)

  debug = false;
  if ~debug
    echo makesignal off;
  end

  if ~isempty(freq_mod)
    fm = true;
  else
    fm = false;
  end


  if isempty(amp)
    m = length(phase);
    amp = ones(1,m);
  end

  if isempty(phase)
    m = length(amp);
    phase = zeros(1,m);
  end

  signal = amp .* exp(j.*phase);
  
  if debug
    'amp'
    size(amp)
    'phase'
    size(phase)
    m
    fm
    ir
  end


  if fm
    %freq_mod = (2.*pi.*n./fs.*freq_mod);
    freq_mod = 2.*pi.*cumsum(freq_mod./fs);
  else
    freq_mod = 0;
  end

  if debug
    'freq mod'
    size(freq_mod)
  end

  % reassemble the signal
  signal = signal .* exp(j.*freq_mod);

end
