function [fisl fres fmsl fppr]=plotopti2d(x,y, isls, ress, max_sidelobes, ppps)
  fontsize=12;

  fisl = figure;
  surface(y,x,isls);
  title('Integrated Sidelobe Levels    ', 'FontSize', fontsize);
  zlabel('dB    ', 'FontSize', fontsize);
  xlabel('Kaiser Parameter    ', 'FontSize', fontsize);
  ylabel('NLFM Parameter    ', 'FontSize', fontsize);
  view(75,20);


  fmsl = figure;
  surface(y,x,10*log10(max_sidelobes));
  title('Maximum Sidelobe Levels    ', 'FontSize', fontsize);
  zlabel('dB    ', 'FontSize', fontsize);
  xlabel('Kaiser Parameter    ', 'FontSize', fontsize);
  ylabel('NLFM Parameter    ', 'FontSize', fontsize);
  view(75,20);



  fres = figure;
  surface(y,x,ress(:,:,1));
  title('3dB Range Resolution    ', 'FontSize', fontsize);
  zlabel('Spatial delay in m    ', 'FontSize', fontsize);
  xlabel('Kaiser Parameter    ', 'FontSize', fontsize);
  ylabel('NLFM Parameter    ', 'FontSize', fontsize);
  view(-40, 30);

  fppr = figure;
  surface(y,x,ppps);
  title('Pulse Power Ratio    ', 'FontSize', fontsize);
  zlabel('Ratio    ', 'FontSize', fontsize);
  xlabel('Kaiser Parameter    ', 'FontSize', fontsize);
  ylabel('NLFM Parameter    ', 'FontSize', fontsize);
  view(50, 40);

end
