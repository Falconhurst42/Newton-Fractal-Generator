#Creates redefines f(x) to produce [f(x), f'(x)] pairs where f'(X) is calculated using threePtCenterDiff method
# this is fsater for cacluation, and allows the iterate method to take explicit or estimated derivatives
function pair_f = createf(f)
  h = 1e-10; #tolerance for threePtCenterDiff method
  pair_f = @(x) [f(x); threePtCenterDiff(f, x, h)];
end
