#Converts a matrix of hsl values into rgb so mat;ab can create an image
#take [hvec; svec; lvec]
# ret [rvec; gvec; bvec]
function rgb = hsl2rgb(hsl)
  [n,m,l] = size(hsl); 
  hvec = hsl(:,:,1); #pull out hues
  svec = hsl(:,:,2); #pull out saturations
  lvec = hsl(:,:,3); #pull out brightnesses
  #C X and M created via these definitions https://www.rapidtables.com/convert/color/hsl-to-rgb.html
  cvec = (1 - abs(2.*lvec - 1)) .* svec;
  xvec = cvec .* (1 - abs(mod(hvec./60, 2) - 1));
  mvec = lvec - cvec./2;

  # 0 -> 0
  # 1 -> cvec
  # 2 -> xvec
  MR = [1 2 0 0 2 1];
  MG = [2 1 1 2 0 0];
  MB = [0 0 2 1 1 2];
  
  # reduce hvec to categories
  hvec = floor(hvec./60)+1;
  
  #bool masks 
  RX = MR(hvec) == 2;
  RC = MR(hvec) == 1;
  GX = MG(hvec) == 2;
  GC = MG(hvec) == 1;
  BX = MB(hvec) == 2;
  BC = MB(hvec) == 1;
  
  #piecewise function from https://www.rapidtables.com/convert/color/hsl-to-rgb.html but in matrix algebra using boolean masks
  rvec = xvec.*RX + cvec.*RC;
  gvec = xvec.*GX + cvec.*GC;
  bvec = xvec.*BX + cvec.*BC;
  
  #return the concatinated RGB values for each pixel
  rgb = cat(3, rvec + mvec, gvec + mvec, bvec + mvec);
end
