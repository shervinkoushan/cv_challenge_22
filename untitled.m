%I = imread("Show the five planes.png");
I = imread("lib/oil-painting.png");
%figure;
%imshow(I)

v = [775,500];
ir = [340,960,960,340; 182,182,661,661];
im_size = [829, 1152];



or = outer_rectangle(v, ir, im_size);
% 
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);

[bigim, back_b, top_b, bot_b, left_b, right_b] = createBigim(back_rec, top_rec, bottom_rec, left_rec, right_rec, I);


%right_b = right_b'
%right_b(2,2) = 1;
bot_b = bot_b'
original_points = bot_b; 
fixed_points = [0, 0; 2000, 0; 2000, 2000; 0, 2000];
trans = fitgeotrans(original_points, fixed_points, 'projective');
%img_d = im2double(I);
I_flip = flipdim(I ,1);
%I_flip = flipdim(I_flip ,2);
img_d = im2double(I_flip);

% Set trensformation settings
RA = imref2d(size(img_d));

[img_trans, BA] = imwarp(img_d, RA, trans);

img_trans = flipdim(img_trans,1);


figure
imshow(img_trans)



%%crop_settings = [round(abs(BA.XWorldLimits(1)+1)), round(abs(BA.YWorldLimits(1)+1)), 680-260, 680-260];

% fin_image = imcrop(img_trans, crop_settings);
% 
% figure
% imshow(fin_image)
% hold on
% points = transformPointsInverse(trans, original_points);
%scatter(points())
