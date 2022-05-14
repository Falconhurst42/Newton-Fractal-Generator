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
  n = settings.resolution;
  conv = @(x) [round(settings.resolution*(real(x) - settings.realmin)/(settings.realmax - settings.realmin)); 
    round(settings.resolution*(imag(x) - settings.imagmin)/(settings.imagmax - settings.imagmin))];
  root_coords = reshape(conv(roots), [max(size(roots)), 2]);
  border = ceil(n/100);
  pixel_coords = [];
  diags = (-border:border) .* ones(2*border+1,1);
  trans = cat(2, reshape(diags', [(2*border+1)^2,1]), reshape(diags, [(2*border+1)^2,1]));
  filt = sqrt(trans(:,1).^2 .+ trans(:,2).^2) < n/100;
  trans = trans(filt,:);
  
  t = [];
  for i = 1:length(root_coords)
    t = [t; (root_coords(i,:) .+ trans)];
  endfor
  
  # filter out out-of-bounds points
  t = t(t(:,1) >= 1 & t(:,1) <= n & t(:,2) >= 1 & t(:,2) <= n,:);
  
  for i = 1:length(t)
    lvec(t(i, 2), t(i, 1)) = 1;
  endfor
  
  hsl = cat(3, hvec, svec, lvec);
endfunction
