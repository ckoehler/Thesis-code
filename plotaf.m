function fig = plotaf(t_str, delay,v,af, uselin)
  fig = figure;
  fontsize=14;

  if nargin==4
    db = true;
  else
    db = ~uselin;
  end

  l = size(af);
  s = length(delay);

  if db
    af=20*log10(af);
    af(af<-100) = NaN;
  end

  surface(delay, v, af);
  %surface(af);
  view(-40,50);
  title(t_str,'FontSize',fontsize);
  xlabel('Range delay in m    ','FontSize',fontsize);
  ylabel('Radial velocity in m/s     ','FontSize',fontsize);

  if db
    zlabel('dB    ','FontSize',fontsize);
  else
    zlabel('Normalized magnitude ','FontSize',fontsize);
  end

  %axis([-inf inf -inf inf -inf inf]);
  shading flat;
  %shading faceted;
  %cmrow = [41	143	165] ./ 255;
  %cm=repmat(cmrow, [64 1]); 	
  %colormap(cm);
end
