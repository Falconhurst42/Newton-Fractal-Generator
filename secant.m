# secant methon function f by using a step size of h
function sl = secant(f, x, h)
  sl = (f(x + h) - f(x)) / h;  
end
