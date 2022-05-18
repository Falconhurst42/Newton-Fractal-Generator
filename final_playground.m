#Clean up mess
clear all

#setting range of both real and imaginary numbers as well the the tolerance for newtons method and the resolution of the final image.
settings.realmin = -3;
settings.realmax = 3;
settings.imagmin = -3;
settings.imagmax = 3;
settings.resolution = 2000;
settings.tol = 1e-8;


### Function that will be ran through Newtons method
#f = @(x) x.^5 + x.^2 - x + 1;
f = @(x) x.^3 - 1;
#f = @(x) x.^6 + x.^3 - 1;
#f = @(x) atan(x)-0.1.*x.^3;
#f = @(x) atan(x).^3-0.1.*x.^3; # lightness artifacts from comp2hsl
#f = @(x) asin(mod(real(x)-1,2)-1).^2 + 0.2.*x.^2-0.5; 

# rework into new_f(x) = [f(x);f'(x)] using 3pt center difference method
f = createf(f);

### Here be explicit [f; f'] pairs without 3pt center difference method
#f = @(x) [x.^5 + x.^2 - x + 1;
#          5.*x.^4 + 2.*x - 1];
#f = @(x) [x.^3 - 1;
#          3.*x.^2];
#f = @(x) [x.^6 + x.^3 - 1;
#          6.*x.^5 + 3.*x.^2];
#f = @(x) [x.^5 + 3i.*x.^3 - (5 + 2i);
#          5.*x.^4 + 9i.*x.^2]

#timer for sake of comparing our efficency 
start = time();
printf("Iterating...\n");
[out, roots] = iterate(f, settings); #iterate through newtons method for each point 
printf("comp -> hsl...\n");
hsl = comp2hsl(out, roots, settings); #convert from output to HSL (roots passed for reoot markers)
printf("hsl -> rgb...\n");
rgb = hsl2rgb(hsl); #convert HSL to RGB
printf("exporting...\n");
imwrite(rgb, "test.png"); #output RGB to image
printf("box dims...\n");
boxDimensions(out) #Calculate box dimension
printf("Completed in %d seconds\n", time() - start); #print how long it took
