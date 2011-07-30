function [fisl fres fmsl fppr]=plotopti2d(x,y, isls, ress, psl, ppps)
  fontsize=14;

  fisl = figure;
  pcolor(y,x,isls);
  colorbar();
  caxis([-100 0]);
  title('Integrated Sidelobe Levels    ', 'FontSize', fontsize);
  zlabel('dB    ', 'FontSize', fontsize);
  xlabel('\beta    ', 'FontSize', fontsize);
  ylabel('a    ', 'FontSize', fontsize);


  fmsl = figure;
  pcolor(y,x,psl);
  colorbar();
  caxis([-100 0]);
  title('Peak Sidelobe Level    ', 'FontSize', fontsize);
  zlabel('dB    ', 'FontSize', fontsize);
  xlabel('\beta    ', 'FontSize', fontsize);
  ylabel('a    ', 'FontSize', fontsize);



  fres = figure;
  pcolor(y,x,ress(:,:,1));
  colorbar();
  title('3dB Range Resolution    ', 'FontSize', fontsize);
  zlabel('Spatial delay in m    ', 'FontSize', fontsize);
  xlabel('\beta    ', 'FontSize', fontsize);
  ylabel('a    ', 'FontSize', fontsize);

  fppr = figure;
  plot(y,ppps(1,:));
  title('Pulse Power Ratio    ', 'FontSize', fontsize);
  ylabel('dB    ', 'FontSize', fontsize);
  xlabel('\beta    ', 'FontSize', fontsize);

end
