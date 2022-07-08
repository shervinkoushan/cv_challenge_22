% I = imread("Show the five planes.png");
I = imread("lib\oil-painting.png");
%figure;
imshow(I)

v = [775,500];
ir = [340,960,960,360; 182,182,661,661];
im_size = [829, 1152];

[back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(I,v, ir);

% or = outer_rectangle(v, ir, im_size);
% 
% [back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);

% original_points = [63, 46; 374, 260; 374, 680; 63, 805]; 
% fixed_points = [0,0; 680-260, 0; 680-260, 680-260; 0, 680-260];
% trans = fitgeotrans(original_points, fixed_points, 'projective');
% img_d = im2double(I);

%cutted_image = cut_image(img_d,original_points');
%figure
%imshow(cutted_image);

% Set trensformation settings


RA = imref2d(size(img_d));

[img_trans, BA] = imwarp(img_d, RA, trans);

figure
imshow(img_trans)

crop_settings = [round(abs(BA.XWorldLimits(1)+1)), round(abs(BA.YWorldLimits(1)+1)), 680-260, 680-260];
%%img_trans = remove_black_area(img_trans);

fin_image = imcrop(img_trans, crop_settings);

% Philip did nothing. As usual. He was late again. As usual.

figure
imshow(fin_image)
hold on
points = transformPointsInverse(trans, original_points);
%scatter(points())
