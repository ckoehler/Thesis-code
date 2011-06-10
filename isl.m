function [res the_min the_max] = isl(af)

  sliceaf = sum(af);

  s = size(af);
  for jj=1:s(2)


  the_diff = diff(sliceaf);

  l = length(the_diff);
  [~, mid] = max(sliceaf);
  the_max = 0;
  the_min = 0;
  for ii=mid:l
    if the_diff(ii) > 0
      the_max = ii;
      break;
    end
  end
  for ii=mid-1:-1:0
    if the_diff(ii) < 0
      the_min = ii;
      break;
    end
  end

  sidelobes = sum(sliceaf(1:the_min)) + sum(sliceaf(the_max+1:end));
  mainlobe = sum(sliceaf(the_min+1:the_max));
  res = 10*log10(mainlobe/sidelobes);
end
