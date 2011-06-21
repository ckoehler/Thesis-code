function [fisl fres fmsl fppr]=plotopti2d(x,y, isls, ress, max_sidelobes, ppps)

  fisl = figure;
  surface(y,x,isls);
  title('Integrated Sidelobe Levels');
  zlabel('dB');
  xlabel('Kaiser Parameter');
  ylabel('NLFM Parameter');
  view(75,20);


  fmsl = figure;
  surface(y,x,10*log10(max_sidelobes));
  title('Maximum Sidelobe Levels');
  zlabel('dB');
  xlabel('Kaiser Parameter');
  ylabel('NLFM Parameter');
  view(75,20);



  fres = figure;
  surface(y,x,ress(:,:,1));
  title('3dB Range Resolution');
  zlabel('Spatial delay in m');
  xlabel('Kaiser Parameter');
  ylabel('NLFM Parameter');
  view(-40, 30);

  fppr = figure;
  surface(y,x,ppps);
  title('Pulse Power Ratio');
  zlabel('Ratio');
  xlabel('Kaiser Parameter');
  ylabel('NLFM Parameter');
  view(50, 40);

end
