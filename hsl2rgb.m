
#take [hvec; svec; lvec]
# ret [rvec; gvec; bvec]
function rgb = hsl2rgb(hsl)
  [n,m,l] = size(hsl);
  hvec = hsl(:,:,1);
  svec = hsl(:,:,2);
  lvec = hsl(:,:,3);
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
  
  RX = MR(hvec) == 2;
  RC = MR(hvec) == 1;
  GX = MG(hvec) == 2;
  GC = MG(hvec) == 1;
  BX = MB(hvec) == 2;
  BC = MB(hvec) == 1;
  
  rvec = xvec.*RX + cvec.*RC;
  gvec = xvec.*GX + cvec.*GC;
  bvec = xvec.*BX + cvec.*BC;
  
  rgb = cat(3, rvec + mvec, gvec + mvec, bvec + mvec);
end