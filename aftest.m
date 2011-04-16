clear all;
close all;

signal = [ +1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
af1 = af(signal);
figure;
surface(af1);
view(-40,50)

signal2 = ones(1,130);
af2 = af(signal2);
figure;
surface(af2);
view(-40,50)
