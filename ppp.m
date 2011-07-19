function r = ppp(amp)
  base = ones(1,length(amp));
  a = double(sum(amp.^2));
  b = double(sum(base.^2));
  r = 10*log10(a./b);
end
