# Three point center differnece method function f by using a step size of h
function sl = threePtCenterDiff(f, x, h)
  sl = (f(x + h) - f(x-h)) / (2*h);  
end
