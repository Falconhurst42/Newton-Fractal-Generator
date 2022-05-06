function out = iterate(f, settings)
  % range.realmin/max, range.imagmin/max, range.resolution
  
  v = make_v(settings);
  n = settings.resolution;
  
  max_iter = 100;
  
  j = 0;
  
  while j < max_iter
    # Newton's method step
    fv = f(v);
    v = v - fv(1,:)./fv(2,:);
    
    # check tolerance
    if max(abs(fv(1,:))) < settings.tol
      printf("   Converged to within %f after %d iterations\n", settings.tol, j);
      break;
    endif
    j = j + 1;
  endwhile
  
  out = reshape(v, [settings.resolution, settings.resolution]);
end