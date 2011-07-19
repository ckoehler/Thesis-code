function fig=plotopti(x, isls, ress, psl, ppps)

  fontsize = 14;
  if nargin == 4
    rows = 3;
    cols = 1;
    ppp = false;
    param = 'a      ';
  else
    cols = 2;
    rows = 2;
    ppp = true;
    param = '\beta    ';
  end

  fig = figure;
  subplot(rows,cols,1);
  plot(x,isls);
  title('Integrated Sidelobe Levels     ', 'FontSize', fontsize);
  ylabel('dB');


  subplot(rows, cols,2);
  plot(x, psl);
  title('Peak Sidelobe Level    ', 'FontSize', fontsize);
  ylabel('dB');



  subplot(rows,cols,3);
  plot(x,ress(:,1));
  title('3dB Range Resolution     ', 'FontSize', fontsize);
  ylabel('Spatial delay in m     ', 'FontSize', fontsize);
  xlabel(param, 'FontSize', fontsize);

  if ppp
    subplot(rows,cols,4);
    plot(x,ppps);
    title('Pulse Power Ratio     ', 'FontSize', fontsize);
    ylabel('dB     ', 'FontSize', fontsize);
    xlabel(param, 'FontSize', fontsize);
  end

end
