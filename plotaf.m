function fig = plotaf(t_str, delay,v,af)
  fig = figure;

  %af=20*log10(af);
  surface(delay, v, af);
  view(-40,50);
  title(t_str,'FontSize',12);
  xlabel('Range delay in m    ','FontSize',12);
  ylabel('Radial velocity in m/s     ','FontSize',12);
  zlabel('Normalized magnitude in dB    ','FontSize',12);
  %axis([-inf inf -inf inf -inf inf]);
  shading flat;
  shading faceted;
  cmrow = [41	143	165] ./ 255;
  cm=repmat(cmrow, [64 1]); 	
  colormap(cm);
end
