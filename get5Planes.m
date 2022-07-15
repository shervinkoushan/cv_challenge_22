function [back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(image, back_rec, top_rec, bottom_rec, left_rec, right_rec, d)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    %imread("Show the five planes.png")

    image = im2double(image);
    %RA = imref2d(size(image)); % Reference data from image

    % Calculate points of outer rectangle
    %outerRectangle = outer_rectangle(vanishingPoint, innerRectangle, size(image));

    % Create 5 rectangles
    %[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(size(image), vanishingPoint, innerRectangle, outerRectangle);

    % Create image with rectangles
    % ToDo get the black rounded image with the plane points on it!!!!!!!!!!!!!!!!!!!!!!!!!

    %% Create background plane
    backgroundWidth = back_rec(1, 2) - back_rec(1, 1) + 1;
    backgroundHeight = back_rec(2, 4) - back_rec(2, 1) + 1;

    back_plane = imcrop(image, [back_rec(1, 1) back_rec(2, 1) backgroundWidth backgroundHeight]); % [xmin ymin width height]

    %% Create top plane
    % Define fixed points for transformation
    %Change this to take depth into account, currently implemented
    desiredImageDepth = round(backgroundHeight * mean(d), 0); % For testing get a squared image

    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    top_rec = top_rec';

    % Crop triangle part from image
    cropped_top_plane = imcrop(image, [top_rec(1, 1), top_rec(1, 2), (top_rec(2, 1) - top_rec(1, 1)), (top_rec(4, 2) - top_rec(1, 2))]);

    % Get points in cropped image
    new_top_rec = top_rec;
    new_top_rec(:, 1) = new_top_rec(:, 1) - new_top_rec(1, 1);
    new_top_rec(:, 2) = new_top_rec(:, 2) - new_top_rec(1, 2);

    transform_top = fitgeotrans(new_top_rec, fixed_points, 'projective');

    RA = imref2d(size(cropped_top_plane)); % Reference data from image
    [image_top, BA_top] = imwarp(cropped_top_plane, RA, transform_top);

    image_top = imresize(image_top, [desiredImageDepth, size(image_top, 2)]);
    crop_settings_top = [round(abs(BA_top.XWorldLimits(1))), round(abs(BA_top.YWorldLimits(1))), backgroundWidth, desiredImageDepth];

    top_plane = imcrop(image_top, crop_settings_top);

    %% Create bottom plane
    % Define fixed points for transformation
    desiredImageDepth = round(backgroundHeight * mean(d), 0); % For testing get a squared image

    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    bottom_rec = bottom_rec';

    % Crop triangle part from image
    cropped_bottom_plane = imcrop(image, [bottom_rec(4, 1), bottom_rec(1, 2), (bottom_rec(3, 1) - bottom_rec(4, 1)), (bottom_rec(4, 2) - bottom_rec(1, 2))]);

    % Get points in cropped image
    new_bottom_rec = bottom_rec;
    new_bottom_rec(:, 1) = new_bottom_rec(:, 1) - new_bottom_rec(4, 1);
    new_bottom_rec(:, 2) = new_bottom_rec(:, 2) - new_bottom_rec(1, 2);

    transform_bottom = fitgeotrans(new_bottom_rec, fixed_points, 'projective');

    RA = imref2d(size(cropped_bottom_plane)); % Reference data from image
    [image_bottom, BA_bottom] = imwarp(cropped_bottom_plane, RA, transform_bottom);

    image_bottom = imresize(image_bottom, [desiredImageDepth, size(image_bottom, 2)]);
    crop_settings_bottom = [round(abs(BA_bottom.XWorldLimits(1))), round(abs(BA_bottom.YWorldLimits(1)) - 1), backgroundWidth, desiredImageDepth];

    bottom_plane = imcrop(image_bottom, crop_settings_bottom);

    %% Create left plane
    % Define fixed points for transformation
    desiredImageDepth = round(backgroundHeight * mean(d), 0); % For testing get a squared image

    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    left_rec = left_rec';

    % Crop triangle part from image
    cropped_left_plane = imcrop(image, [left_rec(1, 1), left_rec(1, 2), (left_rec(2, 1) - left_rec(1, 1)), (left_rec(4, 2) - left_rec(1, 2))]);

    % Get points in cropped image
    new_left_rec = left_rec;
    new_left_rec(:, 1) = new_left_rec(:, 1) - new_left_rec(1, 1);
    new_left_rec(:, 2) = new_left_rec(:, 2) - new_left_rec(1, 2);
    new_left_rec(new_left_rec == 0) = 1;

    transform_left = fitgeotrans(new_left_rec, fixed_points, 'projective');

    RA = imref2d(size(cropped_left_plane)); % Reference data from image
    [image_left, BA_left] = imwarp(cropped_left_plane, RA, transform_left);

    image_left = imresize(image_left, [size(image_left, 1), desiredImageDepth]);
    crop_settings_left = [round(abs(BA_left.XWorldLimits(1))), round(abs(BA_left.YWorldLimits(1))), desiredImageDepth, desiredImageDepth];

    left_plane = imcrop(image_left, crop_settings_left);

    left_plane = imresize(left_plane, [backgroundHeight desiredImageDepth]);

    %% Create right plane
    % Define fixed points for transformation
    desiredImageDepth = round(backgroundHeight * mean(d), 0); % For testing get a squared image

    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    right_rec = right_rec';

    % Crop triangle part from image
    cropped_recht_plane = imcrop(image, [right_rec(1, 1), right_rec(2, 2), (right_rec(2, 1) - right_rec(1, 1)), (right_rec(3, 2) - right_rec(2, 2))]);

    % Get points in cropped image
    new_right_rec = right_rec;
    new_right_rec(:, 1) = new_right_rec(:, 1) - new_right_rec(1, 1);
    new_right_rec(:, 2) = new_right_rec(:, 2) - new_right_rec(2, 2);

    transform_right = fitgeotrans(new_right_rec, fixed_points, 'projective');

    RA = imref2d(size(cropped_recht_plane)); % Reference data from image
    [image_right, BA_right] = imwarp(cropped_recht_plane, RA, transform_right);

    image_right = imresize(image_right, [size(image_right, 1), desiredImageDepth]);

    crop_settings_right = [round(abs(BA_right.XWorldLimits(1))), round(abs(BA_right.YWorldLimits(1))), desiredImageDepth, desiredImageDepth];
    right_plane = imcrop(image_right, crop_settings_right);

    right_plane = imresize(right_plane, [backgroundHeight desiredImageDepth]);

    %
    % original_points = [63, 46; 374, 260; 374, 680; 63, 805];
    % fixed_points = [0,0; 680-260, 0; 680-260, 680-260; 0, 680-260];
    % trans = fitgeotrans(original_points, fixed_points, 'projective');
    % img_d = im2double(I);

end
