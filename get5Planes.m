function [back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(image,back_rec, top_rec, bottom_rec, left_rec, right_rec)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%imread("Show the five planes.png")

image = im2double(image);
RA = imref2d(size(image)); % Reference data from image

% Calculate points of outer rectangle
%outerRectangle = outer_rectangle(vanishingPoint, innerRectangle, size(image));

% Create 5 rectangles
%[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(size(image), vanishingPoint, innerRectangle, outerRectangle);

% Create image with rectangles
% ToDo get the black rounded image with the plane points on it!!!!!!!!!!!!!!!!!!!!!!!!!

%% Create background plane
backgroundWidth = back_rec(1,2)-back_rec(1,1);
backgroundHeight = back_rec(2,4)-back_rec(2,1);

back_plane = imcrop(image,[back_rec(1,1) back_rec(2,1)  backgroundWidth backgroundHeight]); % [xmin ymin width height]

%% Create top plane
% Define fixed points for transformation
desiredImageDepth = backgroundWidth; % For testing get a squared image

fixed_points = [0,0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

transform_top = fitgeotrans(top_rec', fixed_points, 'projective');

[image_top, BA_top] = imwarp(image, RA, transform_top);
crop_settings_top = [round(abs(BA_top.XWorldLimits(1))), round(abs(BA_top.YWorldLimits(1))-1), backgroundWidth, desiredImageDepth];

top_plane = imcrop(image_top, crop_settings_top);

%% Create bottom plane
% Define fixed points for transformation
desiredImageDepth = backgroundWidth; % For testing get a squared image

fixed_points = [0,0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

transform_bottom = fitgeotrans(bottom_rec', fixed_points, 'projective');

[image_bottom, BA_bottom] = imwarp(image, RA, transform_bottom);
crop_settings_bottom = [round(abs(BA_bottom.XWorldLimits(1))), round(abs(BA_bottom.YWorldLimits(1))-1), backgroundWidth, desiredImageDepth];

bottom_plane = imcrop(image_bottom, crop_settings_bottom);

%% Create left plane
% Define fixed points for transformation
desiredImageDepth = backgroundWidth; % For testing get a squared image

fixed_points = [0,0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

transform_left = fitgeotrans(left_rec', fixed_points, 'projective');

[image_left, BA_left] = imwarp(image, RA, transform_left);
crop_settings_left = [round(abs(BA_left.XWorldLimits(1))), round(abs(BA_left.YWorldLimits(1))), desiredImageDepth, backgroundWidth];
cropped_left = imcrop(image_left, crop_settings_left);

left_plane = imresize(cropped_left, [backgroundHeight desiredImageDepth]);


%% Create right plane
% Define fixed points for transformation
desiredImageDepth = backgroundWidth; % For testing get a squared image

fixed_points = [0,0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

transform_right = fitgeotrans(right_rec', fixed_points, 'projective');

[image_right, BA_right] = imwarp(image, RA, transform_right);
crop_settings_right = [round(abs(BA_right.XWorldLimits(1))), round(abs(BA_right.YWorldLimits(1))), desiredImageDepth, backgroundWidth];
cropped_right = imcrop(image_right, crop_settings_right);

right_plane = imresize(cropped_right, [backgroundHeight desiredImageDepth]);

% 
% original_points = [63, 46; 374, 260; 374, 680; 63, 805]; 
% fixed_points = [0,0; 680-260, 0; 680-260, 680-260; 0, 680-260];
% trans = fitgeotrans(original_points, fixed_points, 'projective');
% img_d = im2double(I);


end