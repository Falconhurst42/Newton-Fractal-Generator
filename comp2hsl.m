function hsl = comp2hsl(compvec, roots, settings)
  hmin = 20; hmax = 340;
  lmin = 0.2; lmax = 0.8;
  
  invalid = isnan(compvec) | isinf(compvec);
  
  # convert comp to hsl
  realvec = real(compvec);
  imagvec = imag(compvec);
  realmin = min(realvec(~invalid));
  imagmin = min(imagvec(~invalid));
  realfact = (hmax - hmin) / (max(realvec(~invalid)) - realmin);
  imagfact = (lmax - lmin) / (max(imagvec(~invalid)) - imagmin);
  hvec = ((realvec - realmin) * realfact) + hmin;
  hvec(invalid) = 0;
  svec = 0.5.*ones(size(compvec));
  svec(invalid) = 0;
  lvec = ((imagvec - imagmin) * imagfact) + lmin;
  lvec(invalid) = 0;
  
  # insert roots
  conv = @(x) [round(settings.resolution*(real(x) - settings.realmin)/(settings.realmax - settings.realmin)); 
    round(settings.resolution*(imag(x) - settings.imagmin)/(settings.imagmax - settings.imagmin))];
  root_coords = reshape(conv(roots), [max(size(roots)), 2])
  border = round(settings.resolution/100);
  pixel_coords = [];
  
  for x_offset = -border:border
    for y_offset = -border:border
      coords = root_coords + [x_offset, y_offset];
      pixel_coords = [pixel_coords; coords];
    endfor
  endfor
  
  for i = 1:max(size(pixel_coords))
    lvec(pixel_coords(i, 2), pixel_coords(i, 1)) = 1;
  endfor
  
  hsl = cat(3, hvec, svec, lvec);
endfunction
