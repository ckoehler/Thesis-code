points = 100;
fontsize=14;
a_param = [0 0.2 0.5 1 1.8 4 10];
N = length(a_param);
s = cell(1,N);
C = get(gca,'ColorOrder');
fig = figure;
hold on;
x = linspace(0,15e-6,200);
for i=1:N
  f = generate_arbitrary_fm(1,200,a_param(i));
  h(i) = plot(x,f, 'Color', C(i, :));
  s{i} = sprintf('a = %1.1f', a_param(i));
end
ind = 1:N;
legend(h(ind),s{ind}, 'Location', 'Best');
title('Non-Linear Frequency Modulation     ', 'FontSize', fontsize);
xlabel('Time / s    ', 'FontSize',fontsize);
ylabel('Amplitude     ', 'FontSize',fontsize);

filename = '../thesis/figures/nlfm-functions.png';
print(fig, '-dpng', '-r300', filename);


