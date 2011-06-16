function r = ppp(amp)
  base = ones(1,length(amp));
  a = double(sum(amp));
  b = double(sum(base));
  r = a./b;
end
