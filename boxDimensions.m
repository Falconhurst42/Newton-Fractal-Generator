function dim = boxDimensions(out)
  n = max(size(out));

  vals = reshape(out, [n^2,1]);

  coords = (1:n) .* ones(n,1);
  coords = cat(2,reshape(coords, [n^2,1]),reshape(coords', [n^2,1]));

  max_power = floor(log2(n-1));
  min_power = 1;
  info_arr = [];
  
  # for each power
  for p = max_power:-1:min_power
    box_size = 2^p
    box_dim = ceil(n / box_size);
    border_box_count = 0;
    
    # for each box
    for x = 0:box_dim-1
      minx = 1 + x * box_size;
      for y = 0:box_dim-1
        miny = 1 + y * box_size;
        #printf("[%d, %d]\n", round(minx), round(miny))
        offset_coords = coords .- [minx, miny];
        mask = offset_coords(:,1) < box_size & offset_coords(:,1) >= 0 & offset_coords(:,2) < box_size & offset_coords(:,2) >= 0;
        vals(mask);
        unique(round(vals(mask).*1000));
        if max(size(unique(round(vals(mask).*1000)))) != 1
          border_box_count = border_box_count + 1;
        end
      end
    end
    
    # save data
    info_arr = [info_arr; border_box_count, box_dim^2];
  end
  
  info_arr
  loglog(info_arr(:,1), info_arr(:,2));
  info_arr = cat(2, log(info_arr(:,1)), log(info_arr(:,2)));
  
  dim = polyfit(info_arr(:,1), info_arr(:,2),1)(1);
end