close all;
clear all;

fontsize = 12;

%% first a simple barker ACF
phase = [ 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];

acf = abs(xcorr(phase,phase));

fig = figure;
plot(acf);
title('Barker 13 Code ACF', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Data points    ', 'FontSize',fontsize);
filename = '../thesis/figures/barker13-acf.png';
print(fig, '-dpng', '-r300', filename);



%% kaiser parameters
N=6;
points = 100
kaiser_params = linspace(0,10,N);
s = cell(1,N);
C = [1 0 0; 1 1 0; 0 1 0; 0 1 1; 0 0 1; 1 0 1];
fig = figure;
hold on;
for i=1:length(kaiser_params)
  amp = kaiser(points, kaiser_params(i))';
  h(i) = plot(amp, 'Color', C(i, :));
  s{i} = sprintf('\\beta = %d', kaiser_params(i));
end
ind = [1 2 3 4 5 6];
legend(h(ind),s{ind});
title('Kaiser Window with varying     \beta     ', 'FontSize', fontsize);
ylabel('Amplitude    ', 'FontSize', fontsize);
xlabel('Data points    ', 'FontSize',fontsize);
ylim([0 1.05]);

filename = '../thesis/figures/kaiserparams.png';
print(fig, '-dpng', '-r300', filename);
