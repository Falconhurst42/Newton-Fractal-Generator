#function dim is a function that takes in a matrix of values of roots that each in a range of numbers converges to, outputs a numerical estimate of the box dimension
function dim = boxDimensions(out) 
  #get the size of the matrix
  n = max(size(out)); 

  #reshaping the out vector so we can more easily manipulate it, more efficient for arithmatic and passing into functions and iterating through
  vals = reshape(out, [n^2,1]);

  #Getting coords to hold each column of the matrix
  coords = (1:n) .* ones(n,1);
  coords = cat(2,reshape(coords, [n^2,1]),reshape(coords', [n^2,1]));

  #getting how many times we will iterate and creating an array to hold our output
  max_power = floor(log2(n-1));
  min_power = 1;
  info_arr = [];

  # for each power 
  for p = max_power:-1:min_power
    #make the boxes bigger by a power of 2 and record how many boxes we have
    box_size = 2^p
    box_dim = ceil(n / box_size);
    border_box_count = 0;

    # for each box
    for x = 0:box_dim-1
      minx = 1 + x * box_size;
      for y = 0:box_dim-1 #for each part of box
        miny = 1 + y * box_size; #getting starting y in matrix
        #printf("[%d, %d]\n", round(minx), round(miny))
        offset_coords = coords .- [minx, miny]; #finding where we are looking in the matrix
        mask = offset_coords(:,1) < box_size & offset_coords(:,1) >= 0 & offset_coords(:,2) < box_size & offset_coords(:,2) >= 0; #creating a logical mask to make math faster
        vals(mask); #mask our values
        unique(round(vals(mask).*1000)); #see how many diffetent roots are in the box
        if max(size(unique(round(vals(mask).*1000)))) != 1 #if more than one root in a box, then box contains a border 
          border_box_count = border_box_count + 1; #add border box
        end
      end
    end
    info_arr = [info_arr; border_box_count, box_dim^2];
  end

  #Creating a log log plot of the number of boxes vs the size of boxes and creating a matrix of each data point in the log log plot so we can get the slope
  info_arr
  loglog(info_arr(:,1), info_arr(:,2));
  info_arr = cat(2, log(info_arr(:,1)), log(info_arr(:,2)));

  #Polyfit the log log of the number of boxes verses the size of the boxes to get the slope of the linear fit, which is the box dimension estimate
  dim = polyfit(info_arr(:,1), info_arr(:,2),1)(1);
end
