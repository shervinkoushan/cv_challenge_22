function [cut_im] = cut_image(im,rec)
%CUT_IMAGE Summary of this function goes here
%   Detailed explanation goes here
x = rec(1,:);
y = rec(2,:);

[rows, columns,~] = size(im);

mask = poly2mask(x, y, rows, columns);
maskedRgbImage = bsxfun(@times, im, cast(mask, 'like', im));

cut_im =imcrop(maskedRgbImage, [min(x) min(y) (max(x) - min(x)) (max(y) - min(y))]);

end

