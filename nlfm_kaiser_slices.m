close all;
%clear all;
% gets us: a, afs, delays, vs, tau, kaiser_params
% a is size 70, kaiser_params, or beta, is 40.
%load 'nlfm_kaiser.mat';
series_name='nlfm-kaiser-slices';



idx = [[20 10]; [20 25]; [40 10]; [40 25];];

fig = figure;
for ii=1:length(idx)
  theaidx = idx(ii, 1);
  thebetaidx = idx(ii,2);
  thea = a(theaidx);
  thebeta = kaiser_params(thebetaidx);

  t_str = sprintf('a=%1.2f and   \\beta=%1.2f', thea, thebeta);
  delay = squeeze(delays(theaidx, thebetaidx, :));
  the_af = squeeze(afs(theaidx, thebetaidx, :,:));

  the_af=20*log10(the_af);
  the_af(the_af<-100) = NaN;
  subplot(2,2,ii);
  plot(delay, the_af(1,:));
  xlim([-1500 1500]);
  title(t_str,'FontSize',12);
  xlabel('Range delay in m    ','FontSize',12);
  zlabel('Normalized magnitude in dB    ','FontSize',12);



  filename = sprintf('../thesis/figures/%s-%ius.png', series_name,tau*1e6);
  print(fig, '-dpng', '-r300', filename);

end

