function [back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(image,back_rec, top_rec, bottom_rec, left_rec, right_rec)

%% Calculate depth for image

%% Convert image to double
image = im2double(image);

%% Create background plane
backgroundWidth = back_rec(1,2)-back_rec(1,1)+1;
backgroundHeight = back_rec(2,4)-back_rec(2,1)+1;

back_plane = imcrop(image,[back_rec(1,1) back_rec(2,1)  backgroundWidth backgroundHeight]); % [xmin ymin width height]


%% Create top plane

% Initialize points
topPlane_Depth = 200;
topPlane_fixedPoints = [0,0; backgroundWidth, 0; backgroundWidth, topPlane_Depth; 0, topPlane_Depth];

% Transpose poinst
top_rec = top_rec';

% Crop triangle part from image
topPlane_blackImageCropped= imcrop(image, [top_rec(1,1), top_rec(1,2), (top_rec(2,1)-top_rec(1,1)),(top_rec(4,2)-top_rec(1,2))]);

new_top_rec = top_rec;
new_top_rec(:,1) = new_top_rec(:,1)-new_top_rec(1,1);
new_top_rec(:,2) = new_top_rec(:,2)-new_top_rec(1,2);

top_plane = 0;
bottom_plane = 0;
left_plane = 0;
right_plane = 0;

end