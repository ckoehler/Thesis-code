% determine the 3dB mainlobe width
function res = res(af, delay_delta)
  s = size(af);
  res = zeros(s(1),1);

  % loop across the Doppler axis
  for jj=1:s(1)

    % figure out the mainlobe boundary for this slice
    [~, mid] = max(af(jj,:));
    the_max = 0;
    the_min = 0;
    for ii=mid:s(2)
      if af(jj,ii) < 0.5
        the_max = ii-1;
        break;
      end
    end
    for ii=mid-1:-1:1
      if af(jj,ii) < 0.5
        the_min = ii+1;
        break;
      end
    end

    res(jj) = (the_max-the_min)*delay_delta;
  end
end
