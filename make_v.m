# Name:    make_v
# Purpose: reconstructs a n x n matrix of numbers on the complex plain based off of settings input
# Input:   settings - image size, min and max for both real and imaginary numbers -> complex plain numbers
# Output:  v - a vector of n^2 complex numbers
function v = make_v(settings)
  # creating initial vectors for real and imaginary numbers
  real = [];
  imag = [];
  # iterate until reaching resolution (from settings)
  for r = 1:settings.resolution
    # creating a row for every row in resolution
    real = [real; linspace(settings.realmin, settings.realmax, settings.resolution)];
    imag = [imag; linspace(settings.imagmin, settings.imagmax, settings.resolution)];
  end
  # adding together to create a matrix of complex numbers
  mat = real + i*imag';
  # reshaping this matrix into vector with n x n values
  v = reshape(mat,1,[]);
end
