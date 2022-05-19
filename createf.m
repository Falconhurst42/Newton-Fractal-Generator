#Creates f(x}, f'(x) pairs using secant method using matrix algebra since it is faster than for loops
function pair_f = createf(f)
  h = 1e-10*(1+1i); #tolerance for secant method
  pair_f = @(x) [f(x); secant(f, x, h)];
end
