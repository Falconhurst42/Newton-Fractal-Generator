#Clean up mess
clear all

#setting range of both real and imaginary numbers as well the the tolerance for newtons method and the resolution of the final image.
d_x = 2;
d_y = 2;
x_cent = 0;
y_cent = 0;
settings.realmin = x_cent - d_x;
settings.realmax = x_cent + d_x;
settings.imagmin = y_cent - d_y;
settings.imagmax = y_cent + d_y;
settings.resolution = 1000;
settings.tol = 1e-6;
settings.a = 1;#+1i;    ## can use modified newton's method: it probably won't converge
settings.roots = logical(0);  


### Function that will be ran through Newtons method
#f = @(x) x.^5 + x.^2 - x + 1;
#f = @(x) x.^3 - 1;
#f = @(x) x.^6 + x.^3 - 1;
#f = @(x) atan(x)-0.1.*x.^3;
#f = @(x) x.^5 + 3i.*x.^3 - (5 + 2i);
#f = @(x) atan(x).^3-0.1.*x.^3; # lightness artifacts from comp2hsl
f = @(x) x.^8 + x.^6 + (2+3i).*x.^4 + (3+5i)*x.^2 - 1;
#f = @(x) x.^4 + 3i*x.^3 - 2*x.^2 + 3*x - 5;

# rework into new_f(x) = [f(x);f'(x)] using numerical differentiation
f = createf(f);

### Here be explicit [f; f'] pairs without numerical differentiation
#f = @(x) [x.^5 + x.^2 - x + 1;
#          5.*x.^4 + 2.*x - 1];
#f = @(x) [x.^3 - 1;
#          3.*x.^2];
#f = @(x) [x.^6 + x.^3 - 1;
#          6.*x.^5 + 3.*x.^2];
#f = @(x) [x.^5 + 3i.*x.^3 - (5 + 2i);
#          5.*x.^4 + 9i.*x.^2];

#timer for sake of comparing our efficency 
start = time();
#iterate through newtons method for each point
printf("Iterating...\n");
[out, itlen, roots] = iterate(f,settings);
#convert from output to HSL (roots passed for root markers)
printf("comp -> hsl...\n");
hsl = comp2hsl(out, itlen, roots, settings); 
#convert HSL to RGB
printf("hsl -> rgb...\n");
rgb = hsl2rgb(hsl); 
#output RGB to image
printf("exporting...\n");
imwrite(rgb, "test.png");
  #Calculate box dimension 
  #printf("box dims...\n");
  #boxDimensions(out) 
#print how long it took
printf("Completed in %d seconds\n", time() - start);
