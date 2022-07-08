% Give the path of picture
pic = imread('lib\oil-painting.png');

%Generate label matrix
L = superpixels(pic,1000);

imshow(pic);

h1 = drawpolygon;

roiPoints = h1.Position;

roi = poly2mask(roiPoints(:,1),roiPoints(:,2),size(L,1),size(L,2));

BW = grabcut(pic,L,roi);
imshow(BW)


maskedImage = pic;
maskedImage(repmat(~BW,[1 1 3])) = 0;
imshow(maskedImage)