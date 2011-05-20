function [signal ir_signal] = makesignal(amp, phase, freq_mod, imp_resp, tau, fs)

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


  % this is how many samples we need to use.
  N = tau*fs;

  % this is the "time" sequence, just a sequence of samples.
  n = 0:N-1;



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
    N
    fm
    ir
  end

  % expand the signal and impulse response for oversampling.
  tempsignal = kron(signal,ones(1,floor(N/m)));

  if debug
    'tempsignal'
    size(tempsignal)
  end

  diff_length = uint32(N-length(tempsignal));
  signal = [tempsignal zeros(1,diff_length)];
  clear tempsignal;

  if fm
    %u_phase = u_phase+pi.*f_signal.*t;
    freq_mod = 2.*pi.*n./fs.*freq_mod;
  else
    freq_mod = 0;
  end

  if debug
    'freq mod'
    size(freq_mod)
  end

  % reassemble the signal
  signal = signal .* exp(j.*freq_mod);
  signal = signal(1:N-diff_length);

  if ir
    imp_resp = imp_resp ./ max(imp_resp);
    imp_resp = kron(imp_resp, ones(1,floor(N/m)));
    ir_signal = conv(signal, imp_resp);
  end

end
