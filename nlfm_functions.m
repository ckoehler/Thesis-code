N=6;
points = 100;
fontsize=13;
a_param = linspace(0,10,N);
s = cell(1,N);
C = [1 0 0; 1 1 0; 0 1 0; 0 1 1; 0 0 1; 1 0 1];
fig = figure;
hold on;
for i=1:length(a_param)
  f = generate_arbitrary_fm(1,200,a_param(i));
  h(i) = plot(f, 'Color', C(i, :));
  s{i} = sprintf('a = %d', a_param(i));
end
ind = [1 2 3 4 5 6];
legend(h(ind),s{ind}, 'Location', 'Best');
title('Non-Linear Frequency Modulation', 'FontSize', fontsize);
xlabel('Samples    ', 'FontSize',fontsize);

filename = '../thesis/figures/nlfm-functions.png';
print(fig, '-dpng', '-r300', filename);


