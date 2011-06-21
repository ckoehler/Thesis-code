close all;
clear all;
% gets us: a, afs, delays, vs, tau
load 'nlfm.mat';
series_name='nlfm-side';

isls=[];
max_sidelobes=[];
ress=[];
l = size(vs);
screen=[1 6 7 8 9 10 11 12 13 60 100];
screen=[];
for i=1:l(1)
  af = squeeze(afs(i,:,:));
  [isls(i) max_sidelobes(i)] = isl(af);
  ress(i,:) = res(af, delays(i,2)-delays(i,1));
  if(ismember(i,screen))
    t_str = sprintf('NLFM (a=%u)',a(i));
    fig = plotaf(t_str, delays(i,:),vs(i,:),af);
    view(0,0);
    filename = '';
    filename = sprintf('../thesis/figures/%s-%ius-%2.1f.png', series_name,tau*1e6,a(i));
    print(fig, '-dpng', '-r300', filename);
  end
end

fig = plotopti(a, isls, ress,max_sidelobes);
filename = '';
filename = sprintf('../thesis/figures/%s-%ius-opti.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
