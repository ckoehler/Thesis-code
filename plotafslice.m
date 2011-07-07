function fig = plotafslice(theslice, t_str, delay,af)
  fig = figure;

  l = size(af);
  s = length(delay);

  % if for some reason the dimensions don't quite match up, slice the af to make 
  % it fit.
  if l(2) ~= s
    af = af(:,1:s);
  end
  af=20*log10(af);
  af(af<-100) = NaN;
  plot(delay, af(theslice,:));
  xlim([-1500 1500]);
  title(t_str,'FontSize',12);
  xlabel('Range delay in m    ','FontSize',12);
  zlabel('Normalized magnitude in dB    ','FontSize',12);
end
