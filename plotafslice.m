function fig = plotafslice(theslice, t_str, leg_str, delay,af)
  fig = figure;
  fontsize=14;
  C = [1 0 0; 1 1 0; 0 1 0; 0 1 1; 0 0 1; 1 0 1];
  C = get(gca,'ColorOrder');

  l = size(af)
  s = length(delay)

  % if for some reason the dimensions don't quite match up, slice the af to make 
  % it fit.
  if l(2) ~= s
    af = af(:,1:s);
  end
  af=20*log10(af);
  af(af<-100) = NaN;
  slices = length(theslice);

  hold on;
  for ii=1:length(theslice)
    slic = theslice(ii)
    h(ii) = plot(delay, af(slic,:), 'Color', C(ii, :));
  end
  if slices > 1
    ind = 1:slices;
    leg=legend(h(ind),leg_str{ind});
    set(leg, 'FontSize', fontsize);
  end

  title(t_str,'FontSize',fontsize);
  xlabel('Range delay in m    ','FontSize',fontsize);
  ylabel('dB      ', 'FontSize', fontsize);
  zlabel('Normalized magnitude in dB    ','FontSize',fontsize);
end
