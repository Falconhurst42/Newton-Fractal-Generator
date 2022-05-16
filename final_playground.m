#Clean up mess
clear all

#setting range of both real and imaginary numbers as well the the tolerance for newtons method and the resolution of the final image.
settings.realmin = -1.5;
settings.realmax = 1.5;
settings.imagmin = -1.5;
settings.imagmax = 1.5;
settings.resolution = 500;
settings.tol = 1e-8;


#f = @(x) [x.^5 + x.^2 - x + 1;
#          5.*x.^4 + 2.*x - 1];
#f = @(x) [x.^3 - 1;
#          3.*x.^2];
#Function that will be ran through Newtons method
f = @(x) x.^5 + x.^2 - x + 1;
#f = @(x) x.^3 - 1;
#create pairs of points in f to their derivatives using secant method
f = createf(f);




#f = @(x) [x.^8 + 15.*x.^4 - 16;
#          8.*x.^7 + 60.*x.^3];

#f = @(x) [x.^2 - 1;
#          2.*x];

#timer for sake of comparing our efficency 
start = time();
printf("Iterating...\n");
[out, roots] = iterate(f, settings); #iterate through newtons method for each point 
printf("comp -> hsl...\n");
hsl = comp2hsl(out, roots, settings); #convert roots into HSL
printf("hsl -> rgb...\n");
rgb = hsl2rgb(hsl); #concert HSL into RGB
printf("exporting...\n");
imwrite(rgb, "test.png"); #turn RGB of pixels into image
printf("box dims...\n");
boxDimensions(out) #Calculate box dimension
printf("Completed in %d seconds\n", time() - start); #print how long it took
