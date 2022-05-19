#Comp to HSL takes in roots and returns an HSL value for each pixel
function hsl = comp2hsl(compvec, itlen, roots, settings)
  hmin = 20; hmax = 340; #min and max hue
  lmin = 0.2; lmax = 0.8; #min and max brightness, so that no white points (meaning roots will be the only white points in the image.
  smin = 0.2; smax = 1;    #min and max sat, so that no white points (meaning roots will be the only white points in the image.
  
  #makes sure that we don't have divergent cases
  invalid = isnan(compvec) | isinf(compvec);
  
  # convert comp to hsl
  #hue is from real factor, brightness is from imaginary and the minimum of each is mapped to the minimum hue/brightness and same with max
  realvec = real(compvec);
  imagvec = imag(compvec);
  realmin = min(realvec(~invalid));
  realmax = max(realvec(~invalid));
  imagmin = min(imagvec(~invalid));
  imagmax = max(imagvec(~invalid));
  itmin = min(min(itlen(~invalid)));
  itmax = max(max(itlen(~invalid)));
  realfact = (hmax - hmin) / (realmax - realmin);
  imagfact = (lmax - lmin) / (imagmax - imagmin);
  itfact = (smax - smin) / (itmax - itmin);
  realvec - realmin;
  hvec = ((realvec - realmin) * realfact) + hmin; #set hues
  hvec(invalid) = 0; #set invalid hue to red
  #svec = smax - ((itlen - itmin) * itfact); #set saturation
  svec = 0.5*ones(size(compvec));
  svec(invalid) = 0; #set invalid to not saturated
  lvec = ((imagvec - imagmin) * imagfact) + lmin; #set brightness
  lvec(invalid) = 0; #set invalid points to be black
  
  # insert roots
  if settings.roots
    #creates a circle of radius 3 around each root to be marked in white so that roots are clearly marked on the final image
    n = settings.resolution;
    conv = @(x) [round(settings.resolution*(real(x) - settings.realmin)/(settings.realmax - settings.realmin)); 
      round(settings.resolution*(imag(x) - settings.imagmin)/(settings.imagmax - settings.imagmin))];
    root_coords = reshape(conv(roots), [max(size(roots)), 2]);
    border = ceil(n/100);
    pixel_coords = [];
    diags = (-border:border) .* ones(2*border+1,1);
    trans = cat(2, reshape(diags', [(2*border+1)^2,1]), reshape(diags, [(2*border+1)^2,1]));
    filt = sqrt(trans(:,1).^2 .+ trans(:,2).^2) < n/100;
    trans = trans(filt,:);
    
    t = [];
    for i = 1:length(root_coords)
      t = [t; (root_coords(i,:) .+ trans)];
    end
    
    #grabbing just the circle around root
    # filter out out-of-bounds points
    t = t(t(:,1) >= 1 & t(:,1) <= n & t(:,2) >= 1 & t(:,2) <= n,:);
    
    #set lightness of circle around root to have brightness of 1
    for i = 1:length(t)
      lvec(t(i, 2), t(i, 1)) = 1;
    end
  end
  
  #concatinate hue saturation and lightness into a 3 dimencional matrix
  hsl = cat(3, hvec, svec, lvec);
end
