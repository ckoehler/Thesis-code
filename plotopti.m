function fig=plotopti(x, isls, ress, max_sidelobes, ppps)

  if nargin == 4
    rows = 1;
    cols = 3;
    ppp = false;
  else
    cols = 2;
    rows = 2;
    ppp = true;
  end

  fig = figure;
  subplot(rows,cols,1);
  plot(x,isls);
  title('Integrated Sidelobe Levels');
  ylabel('dB');


  subplot(rows, cols,2);
  plot(x,10*log10(max_sidelobes));
  title('Maximum Sidelobe Levels');
  ylabel('dB');



  subplot(rows,cols,3);
  plot(x,ress(:,1));
  title('3dB Range Resolution');
  ylabel('Spatial delay in m');
  xlabel('Parameter');

  if ppp
    subplot(rows,cols,4);
    plot(x,ppps);
    title('Pulse Power Ratio');
    ylabel('Ratio');
    xlabel('Parameter');
  end

end
