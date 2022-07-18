function [fg] = segmentation(I)
%Gived the user the possibility to segment a foreground object.
%Creates gray image for segmentation.
Im = rgb2gray(I);
mask = zeros(size(Im));
imshow(Im)

%Points around foreground object is created.
h1 = drawpolygon;
roiPoints = h1.Position;
roiPoints = round(roiPoints,0);

%Mask i created based of selected points
mask(roiPoints(1,2):roiPoints(3,2),roiPoints(1,1):roiPoints(3,1)) = 1;

%Use the active contourfor the selected mask to segment the
%foregroundobject
fg = activecontour(Im, mask, 600);
end

