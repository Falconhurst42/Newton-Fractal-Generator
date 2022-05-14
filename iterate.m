function [out, roots] = iterate(f, settings)
  % range.realmin/max, range.imagmin/max, range.resolution
  
  v = make_v(settings);
  n = settings.resolution;
  
  iterating = logical(ones(size(v)));
  
  max_iter = 100;
  
  j = 0;
  
  while j < max_iter
    # Newton's method step
    fv = f(v(iterating));
    v(iterating) = v(iterating) - fv(1,:)./fv(2,:);
    #reshape(v, [settings.resolution, settings.resolution])
    
    # update iterating
    iterating(iterating) = abs(fv(1,:)) > settings.tol;
    #reshape(iterating, [settings.resolution, settings.resolution])
    # check for completion
    if max(iterating) == 0
      printf("   Converged to within %f after %d iterations\n", settings.tol, j);
      break;
    endif
    j = j + 1;
  endwhile
  
  out = reshape(v, [settings.resolution, settings.resolution]);
  digits = max([(settings.realmax - settings.realmin), abs(settings.imagmax - settings.imagmin)]);
  digits = abs(ceil(log10(digits/100))) + 1;
  roots = unique(round(out .* (10^digits))/(10^digits));
end