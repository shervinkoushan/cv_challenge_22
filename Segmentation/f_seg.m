I = imread('lib\oil-painting.png');

%Im = im2double(I);
Im = rgb2gray(I);

mask = zeros(size(Im));

imshow(Im)

h1 = drawpolygon;

roiPoints = h1.Position;

roiPoints = round(roiPoints,0);

mask(roiPoints(1,2):roiPoints(3,2),roiPoints(1,1):roiPoints(3,1)) = 1;

bw = activecontour(Im, mask, 600);

imshow(bw);