function r=subkaiser(N ,param, subpulselength)
  
  a = kaiser(subpulselength, param)';

  r = repmat(a, 1, N/subpulselength);

end
