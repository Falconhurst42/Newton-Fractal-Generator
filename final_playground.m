clear all

settings.realmin = -2;
settings.realmax = 2;
settings.imagmin = -2;
settings.imagmax = 2;
settings.resolution = 150;
settings.tol = 1e-6;


f = @(x) [x.^5 + x.^2 - x + 1;
          5.*x.^4 + 2.*x - 1];
#f = @(x) [x.^3 - 1;
#          3.*x.^2];

          
start = time();
printf("Iterating...\n");
[out, roots] = iterate(f, settings);
printf("comp -> hsl...\n");
hsl = comp2hsl(out, roots, settings);
printf("hsl -> rgb...\n");
rgb = hsl2rgb(hsl);
printf("exporting...\n");
imwrite(rgb, "test.png");
printf("Completed in %d seconds\n", time() - start);