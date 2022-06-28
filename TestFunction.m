

% Give the path of picture
picture_folder = 'C:\Users\phili\GitHub\cv_challenge_22\lib\oil-painting.png';

% Create grayscale double image
img = im2double(rgb2gray(imread(picture_folder)));

c = [222 525 555 202]';
r = [441 444  339 333]';

name = 'Nils';

imshow(img);
hold on;
plot([c;c(1)],[r;r(1)],'r','Linewidth',2);
text(c(1),r(1)+20,'0, 11','Color','y');
text(c(2),r(2)+20,'11, 11','Color','y');
text(c(3),r(3)-20,'11, 0','Color','y');
text(c(4),r(4)-20,'0, 0','Color','y');
hold off;
F = getframe();
g = frame2im(F);
imwrite(g,[name '_overlay.jpg']);

base = [ 0 11; 11 11; 11 0; 0 0];

tf = fitgeotrans([c r], base*80, 'projective');
T = tf';

[xf1, xf1_ref] = imwarp(img,tf);
imshow(xf1)
xf1_ref
imwrite(xf1,[name '_registered.jpg']);


