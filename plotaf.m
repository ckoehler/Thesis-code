function fig = plotaf(t_str, delay,v,af)
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
  surface(delay, v, af);
  view(-40,50);
  title(t_str,'FontSize',12);
  xlabel('Range delay in m    ','FontSize',12);
  ylabel('Radial velocity in m/s     ','FontSize',12);
  zlabel('Normalized magnitude in dB    ','FontSize',12);
  %axis([-inf inf -inf inf -inf inf]);
  shading flat;
  %shading faceted;
  %cmrow = [41	143	165] ./ 255;
  %cm=repmat(cmrow, [64 1]); 	
  %colormap(cm);
end
