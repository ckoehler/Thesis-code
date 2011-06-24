function [signal ir_signal new_tau] = makesignal(amp, phase, freq_mod, imp_resp, tau, fs)

  ir_signal = [];

  debug = false;
  if ~debug
    echo makesignal off;
  end

  if ~isempty(imp_resp)
    ir = true;
  else
    ir = false;
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
  new_tau = tau;

  if ir
    imp_resp = imp_resp ./ max(imp_resp);
    ir_signal = conv(signal, imp_resp);
    new_tau = tau / length(signal) * length(ir_signal);
  end

end
