function v = make_v(range)
  real = linspace(range.realmin, range.realmax, range.resolution) .* ones(range.resolution);
  imag = linspace(range.imagmin, range.imagmax, range.resolution) .* ones(range.resolution);
  
  mat = real + i*imag';

  v = reshape(mat,1,[]);
end