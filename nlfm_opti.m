close all;
clear all;
% gets us: a, afs, delays, vs, tau
load 'nlfm.mat';
series_name='nlfm-side';

isls=[];
max_sidelobes=[];
ress=[];
l = size(vs);
screen=[1 100];
%screen=[];
for i=1:l(1)
  af = squeeze(afs(i,:,:));
  [isls(i) max_sidelobes(i)] = isl(af);
  ress(i,:) = res(af, delays(i,2)-delays(i,1));
  if(ismember(i,screen))
    t_str = sprintf('NLFM (a=%u)',a(i));
    fig = plotafslice(1,t_str, '', delays(i,:),af);
    filename = sprintf('../thesis/figures/%s-%ius-10.png', series_name,tau*1e6);
    print(fig, '-dpng', '-r300', filename);
  end
end

fig = plotopti(a, isls, ress,max_sidelobes);
filename = sprintf('../thesis/figures/%s-%ius-opti.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

theslice=30;
thea = a(theslice);
t_str = '';
t_str = sprintf('NLFM zero-Doppler slice for a=%f', thea);
fig = plotafslice(1,t_str, '', delays(theslice,:),squeeze(afs(theslice,:,:)));
filename = sprintf('../thesis/figures/%s-%ius-0D-1.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);

theslice=65;
thea = a(theslice);
t_str = '';
t_str = sprintf('NLFM zero-Doppler slice for a=%f', thea);
fig = plotafslice(1,t_str, '',  delays(theslice,:),squeeze(afs(theslice,:,:)));
filename = sprintf('../thesis/figures/%s-%ius-0D-2.png', series_name,tau*1e6);
print(fig, '-dpng', '-r300', filename);
