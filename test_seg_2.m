% Give the path of picture
RGB = imread('C:\Users\phili\GitHub\cv_challenge_22\lib\oil-painting.png');

imshow(RGB)

L = superpixels(RGB,500);

f = drawrectangle();

foreground = createMask(f,RGB);

b1 = drawrectangle('Color','r');
b2 = drawrectangle('Color','r');

background = createMask(b1,RGB) + createMask(b2,RGB);

BW = lazysnapping(RGB,L,foreground,background);

imshow(labeloverlay(RGB,BW,'Colormap',[0 1 0]))


maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
imshow(maskedImage)