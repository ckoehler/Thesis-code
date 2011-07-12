function [res psl the_min the_max] = isl(af)

  sidelobes = 0;
  mainlobe = 0;
  s = size(af);
  psl = 0;

  % loop across the Doppler axis
  for jj=1:s(1)

    % figure out the mainlobe boundary for this slice
    the_diff = diff(af(jj,:));
    l = length(the_diff);
    [mainlobe_max, mid] = max(af(jj,:));
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
    psl_temp = max(max(sidelobes_only));
    psl = max(psl_temp, psl);

    % compute side and mainlobe, and add them all up.
    sidelobes = sidelobes + sum(sidelobes_only);
    mainlobe = mainlobe + sum(af(jj,the_min+1:the_max));
  end
  psl = 20*log10(psl);
  res = 10*log10(sidelobes/mainlobe);
end
