function plotopti(x, isls, ress, max_sidelobes)

  fig = figure;
  subplot(3,1,1);
  plot(x,isls);
  title('Integrated Sidelobe Levels');
  ylabel('dB');


  subplot(3,1,2);
  plot(x,10*log10(max_sidelobes));
  title('Maximum Sidelobe Levels');
  ylabel('dB');



  subplot(3,1,3);
  plot(x,ress(:,1));
  title('3dB Beamwidth');
  ylabel('Spatial delay in m');
  xlabel('Parameter');
  %surface(kaiser_params, v, ress');

  %print(fig, '-dpng', '-r300', 'test.png');

end
