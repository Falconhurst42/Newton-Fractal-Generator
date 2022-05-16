function pair_f = createf(f)
  h = 1e-10;
  pair_f = @(x) [f(x); secant(f, x, h)];
end