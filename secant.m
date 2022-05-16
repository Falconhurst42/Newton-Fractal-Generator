function sl = secant(f, x, h)
  sl = (f(x + h) - f(x)) / h;  
end