%I = imread("Show the five planes.png");
I = imread("lib\oil-painting.png");
%figure;
%imshow(I)

v = [775,500];
ir = [340,960,960,340; 182,182,661,661];
im_size = [829, 1152];



or = outer_rectangle(v, ir, im_size);
% 
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);

[bigim, back_b, top_b, bot_b, left_b, right_b] = createBigim(back_rec, top_rec, bottom_rec, left_rec, right_rec, I);
bigim = im2double(bigim);
new_bigim = zeros(size(bigim,1)+100,size(bigim,2)+100,3);
new_bigim(1:size(bigim,1), 1:size(bigim,2),:) = bigim; 

bot_b = bot_b';

% %% Left side
%fixed_points = [1, 1; 2000, 1; 2000, 2000; 1, 2000]
%trans_left = fitgeotrans(left_b', fixed_points, 'projective');
% img_d = im2double(new_bigim);
% RA = imref2d(size(img_d));
% 
% [img_trans, BA] = imwarp(img_d, RA, trans_left);
% 
% figure
% imshow(img_trans)

%% Right side
original_points = ...
    [1074, 330; ...
    1266, 1; ...
    1266, 976; ...
    1074, 809]; 

%% Cut image

cropped_points = ...
    [1, 330; ...
    193 1; ...
    193, 976; ...
    1, 809];

fixed_points = [1, 1; 2000, 1; 2000, 2000; 1, 2000]
trans = fitgeotrans(cropped_points,fixed_points, 'projective');
img_d = im2double(bigim);

cropped_plane = imcrop(img_d, [1074, 0, 1266-1074, 976]);

%img_d = flip(img_d,1);
%figure
%imshow(img_d);
%hold on
%scatter(original_points(:,1), original_points(:,2), 'r')

% Set trensformation settings
RA = imref2d(size(cropped_plane));

[img_trans, BA] = imwarp(cropped_plane, RA, trans);

figure
imshow(img_trans)

%crop_settings = [round(abs(BA.XWorldLimits(1)+1)), round(abs(BA.YWorldLimits(1)+1)), 680-260, 680-260];

% fin_image = imcrop(img_trans, crop_settings);
% 
% figure
% imshow(fin_image)
% hold on
% points = transformPointsInverse(trans, original_points);
%scatter(points())
