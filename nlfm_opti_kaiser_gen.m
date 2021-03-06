close all;
clear all;
% gets us: a, afs, delays, vs, tau, kaiser_params
load 'nlfm_kaiser.mat';
series_name='nlfm-kaiser';

isls=[];
psl=[];
ress=[];
ppps=[];

% first dimension is the waveforms, second is the amplitudes
l = size(vs);

screen=[1 6 7 8 9 10 11 12 13 60 100];
screen=[];
for i=1:l(1)
  for j=1:l(2)
    amp = kaiser(200, kaiser_params(j));
    ppps(i,j,:)= ppp(amp);
    af = squeeze(afs(i,j,:,:));
    [isls(i,j) psl(i,j)] = isl(af);
    ress(i,j,:) = res(af, delays(i,j,2)-delays(i,j,1));
    %if(ismember(i,screen))
      %t_str = sprintf('NLFM (a=%u)',a(i));
      %fig = plotaf(t_str, delays(i,:),vs(i,:),af);
      %view(0,0);
      %filename = '';
      %filename = sprintf('../thesis/figures/%s-%ius-%2.1f.png', series_name,tau*1e6,a(i));
      %print(fig, '-dpng', '-r300', filename);
    %end
  end
end


save('nlfm2dopti.mat', 'tau', 'series_name', 'a','kaiser_params','isls','ress','psl', 'ppps');
