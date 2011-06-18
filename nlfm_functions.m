f = generate_arbitrary_fm(1,200,0);
g = generate_arbitrary_fm(1,200,10);
subplot(2,1,1);
plot(f);
title('Non-Linear Frequency Modulation, a=0');
subplot(2,1,2);
plot(g);
title('Non-Linear Frequency Modulation, a=10');
print('-dpng', '-r300', '../thesis/figures/nlfm-functions.png');

