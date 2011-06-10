function [res max_sidelobe the_min the_max] = isl(af)

  sidelobes = 0;
  sidelobes1 = 0;
  mainlobe = 0;
  s = size(af);
  max_sidelobe = 0;

  % loop across the Doppler axis
  for jj=1:s(1)

    % figure out the mainlobe boundary for this slice
    the_diff = diff(af(jj,:));
    l = length(the_diff);
    [~, mid] = max(af(jj,:));
    the_max = 0;
    the_min = 0;
    for ii=mid:l
      if the_diff(ii) > 0
        the_max = ii;
        break;
      end
    end
    for ii=mid-1:-1:1
      if the_diff(ii) < 0
        the_min = ii;
        break;
      end
    end

    sidelobes_only = [af(jj, 1:the_min) af(jj, the_max+1:end)];
    max_sidelobe = max(max(sidelobes_only), max_sidelobe);

    % compute side and mainlobe, and add them all up.
    sidelobes = sidelobes + sum(sidelobes_only);
    mainlobe = mainlobe + sum(af(jj,the_min+1:the_max));
  end
  res = 10*log10(mainlobe/sidelobes);
end
