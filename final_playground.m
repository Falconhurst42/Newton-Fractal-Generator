clear all

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

f = @(x) x.^5 + x.^2 - x + 1;
#f = @(x) x.^3 - 1;
f = createf(f);




#f = @(x) [x.^8 + 15.*x.^4 - 16;
#          8.*x.^7 + 60.*x.^3];

#f = @(x) [x.^2 - 1;
#          2.*x];

          
start = time();
printf("Iterating...\n");
[out, roots] = iterate(f, settings);
printf("comp -> hsl...\n");
hsl = comp2hsl(out, roots, settings);
printf("hsl -> rgb...\n");
rgb = hsl2rgb(hsl);
printf("exporting...\n");
imwrite(rgb, "test.png");
printf("box dims...\n");
boxDimensions(out)
printf("Completed in %d seconds\n", time() - start);