# Name:    iterate
# Purpose: Performs Newton's method on a matrix of starting values. Outputs a matrix with the roots the starting values converge to.
# inputs:  f - vector that contains a function and its dervative
#          settings - the struct with cooresponding values such as image resolution, tolerance, etc (see final_playground.m for more)
# output:  out - a matrix with the roots at which the settings input initial values converge too
#          itlen - matrix same dimensions as out containgin number of iterations to converge for each pixel
#          roots-   the roots the method find
function [out, itlen, roots] = iterate(f, settings)
  % range.realmin/max, range.imagmin/max, range.resolution
 
  # creating initial vector based of the settings (See make_v.m for more details)
  # contains the complex numbers that will be the initial starting guesses
  v = make_v(settings);
  #Size of the image
  n = settings.resolution;
  
  # creating a vector of size n of all 1s
  # used for preventing the points that have already converged from being iterated over again
  iterating = logical(ones(size(v)));
  iterating_snap = iterating;
  
  #Setting max iteration to 100
  max_iter = 100;
  itlen = 100*ones(size(v));
  iters = zeros(size(v));
  inc = ones(size(v));
  
  #initialize j -> iteration counter
  j = 0;
  
  #while loop continues until max iteration is reached or until tolerance
  while j < max_iter
    iters = iters .+ inc;
    # Newton's method step
    
    # executing function and derivative of the starting values that have not converged
    fv = f(v(iterating)); 
    #max(size(fv))
    # Newtons method step calculation, updating v with new iteration value
    v(iterating) = v(iterating) - settings.a*fv(1,:)./fv(2,:); 
    
    #ignore
    #reshape(v, [settings.resolution, settings.resolution])
    
    # update iterating
    # 0 -> if it has converged based off tolerance
    # 1 -> value has not converged
    iterating_snap = iterating;
    iterating(iterating) = abs(fv(1,:)) > settings.tol;
    iterating_snap = xor(iterating_snap, iterating);
    itlen(iterating_snap) = iters(iterating_snap);
    #reshape(iterating, [settings.resolution, settings.resolution])
    # check for completion
    if max(iterating) == 0 #if points have converged
       #exit while loop, tolerance reached, print message
      printf("   Converged to within %f after %d iterations\n", settings.tol, j);
      break;
    endif
    #increase iteration
    j = j + 1;
  endwhile
  
  #outputting a matrix with the roots
  out = reshape(v, [settings.resolution, settings.resolution]);
  itlen = reshape(itlen, size(out));
  #Capturing the roots
  digits = max([(settings.realmax - settings.realmin), abs(settings.imagmax - settings.imagmin)]);
  digits = abs(ceil(log10(digits/100))) + 1;
  roots = unique(round(out .* (10^digits))/(10^digits));
end
