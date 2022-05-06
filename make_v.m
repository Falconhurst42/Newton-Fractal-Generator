function v = make_v(range)
  real = [];
  imag = [];
  for r = 1:range.resolution
    real = [real; linspace(range.realmin, range.realmax, range.resolution)];
    imag = [imag; linspace(range.imagmin, range.imagmax, range.resolution)];
  end

  mat = real + i*imag';

  v = reshape(mat,1,[]);
end