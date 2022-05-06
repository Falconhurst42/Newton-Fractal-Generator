function hsl = comp2hsl(compvec)
  hmin = 20; hmax = 340;
  lmin = 0.2; lmax = 0.8;
  
  invalid = isnan(compvec) | isinf(compvec);
  
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
  
  hsl = cat(3, hvec, svec, lvec);
endfunction
