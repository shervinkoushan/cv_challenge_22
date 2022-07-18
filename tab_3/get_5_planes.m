function [back_plane, top_plane, bottom_plane, left_plane, right_plane] = get_5_planes(image, back_rec, top_rec, bottom_rec, left_rec, right_rec, d)    
    %The function creates from an image and given points 5 planes, they are
    %defined by the points.
    %The image and points have to have the format of the extended image
    %created by the create_big_image function.

    % Convert the image to double.
    image = im2double(image);

    %% Create background plane
    backgroundWidth = back_rec(1, 2) - back_rec(1, 1) + 1;
    backgroundHeight = back_rec(2, 4) - back_rec(2, 1) + 1;

    % Crop the image
    back_plane = imcrop(image, [back_rec(1, 1) back_rec(2, 1) backgroundWidth backgroundHeight]); % [xmin ymin width height]

    %% Create top plane
    % Define depth for image plane
    desiredImageDepth = round(backgroundHeight * mean(d), 0); % For testing get a squared image
    
    % Define fixed points
    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    top_rec = top_rec';

    % Crop the plane part from image
    cropped_top_plane = imcrop(image, [top_rec(1, 1), top_rec(1, 2), (top_rec(2, 1) - top_rec(1, 1)), (top_rec(4, 2) - top_rec(1, 2))]);

    % Get points in cropped image
    new_top_rec = top_rec;
    new_top_rec(:, 1) = new_top_rec(:, 1) - new_top_rec(1, 1);
    new_top_rec(:, 2) = new_top_rec(:, 2) - new_top_rec(1, 2);

    % Find transformation from old points to new
    transform_top = fitgeotrans(new_top_rec, fixed_points, 'projective');

    % Get reference points from cropped plane
    RA = imref2d(size(cropped_top_plane)); % Reference data from image

    % Warp image
    [image_top, BA_top] = imwarp(cropped_top_plane, RA, transform_top);

    % Resize warped image
    image_top = imresize(image_top, [desiredImageDepth, size(image_top, 2)]);
    
    % Crop the black part from plane after transformation
    crop_settings_top = [round(abs(BA_top.XWorldLimits(1))), round(abs(BA_top.YWorldLimits(1))), backgroundWidth, desiredImageDepth];
    top_plane = imcrop(image_top, crop_settings_top);

    %% Create bottom plane
    % Define depth for image plane
    desiredImageDepth = round(backgroundHeight * mean(d), 0);

    % Define fixed points
    fixed_points = [0, 0; backgroundWidth, 0; backgroundWidth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    bottom_rec = bottom_rec';

    % Crop the plane part from image
    cropped_bottom_plane = imcrop(image, [bottom_rec(4, 1), bottom_rec(1, 2), (bottom_rec(3, 1) - bottom_rec(4, 1)), (bottom_rec(4, 2) - bottom_rec(1, 2))]);

    % Get points in cropped image
    new_bottom_rec = bottom_rec;
    new_bottom_rec(:, 1) = new_bottom_rec(:, 1) - new_bottom_rec(4, 1);
    new_bottom_rec(:, 2) = new_bottom_rec(:, 2) - new_bottom_rec(1, 2);

    % Find transformation from old points to new
    transform_bottom = fitgeotrans(new_bottom_rec, fixed_points, 'projective');

    % Get reference points from cropped plane
    RA = imref2d(size(cropped_bottom_plane)); % Reference data from image

    % Warp image
    [image_bottom, BA_bottom] = imwarp(cropped_bottom_plane, RA, transform_bottom);

    % Resize warped image
    image_bottom = imresize(image_bottom, [desiredImageDepth, size(image_bottom, 2)]);
    
    % Crop the black part from plane after transformation
    crop_settings_bottom = [round(abs(BA_bottom.XWorldLimits(1))), round(abs(BA_bottom.YWorldLimits(1)) - 1), backgroundWidth, desiredImageDepth];
    bottom_plane = imcrop(image_bottom, crop_settings_bottom);

    %% Create left plane
    % Define depth for image plane
    desiredImageDepth = round(backgroundHeight * mean(d), 0);

    % Define fixed points
    fixed_points = [0, 0; desiredImageDepth, 0; desiredImageDepth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    left_rec = left_rec';

    % Crop the plane part from image
    cropped_left_plane = imcrop(image, [left_rec(1, 1), left_rec(1, 2), (left_rec(2, 1) - left_rec(1, 1)), (left_rec(4, 2) - left_rec(1, 2))]);

    % Get points in cropped image
    new_left_rec = left_rec;
    new_left_rec(:, 1) = new_left_rec(:, 1) - new_left_rec(1, 1);
    new_left_rec(:, 2) = new_left_rec(:, 2) - new_left_rec(1, 2);
    new_left_rec(new_left_rec == 0) = 1;

    % Find transformation from old points to new
    transform_left = fitgeotrans(new_left_rec, fixed_points, 'projective');

    % Get reference points from cropped plane
    RA = imref2d(size(cropped_left_plane)); % Reference data from image
    
    % Warp image
    [image_left, BA_left] = imwarp(cropped_left_plane, RA, transform_left);


    % Resize the transformed image 
    image_left = imresize(image_left, [size(image_left, 1), desiredImageDepth]);
    
    % Crop the black part from plane after transformation
    crop_settings_left = [round(abs(BA_left.XWorldLimits(1))), round(abs(BA_left.YWorldLimits(1))), desiredImageDepth, desiredImageDepth];
    left_plane = imcrop(image_left, crop_settings_left);
    
    % Resize cropped image
    left_plane = imresize(left_plane, [backgroundHeight desiredImageDepth]);

    %% Create right plane
    % Define depth for image plane
    desiredImageDepth = round(backgroundHeight * mean(d), 0);

    % Define fixed points
    fixed_points = [0, 0; desiredImageDepth, 0; desiredImageDepth, desiredImageDepth; 0, desiredImageDepth];

    % Transpose poinst
    right_rec = right_rec';

    % Crop the plane part from image
    cropped_recht_plane = imcrop(image, [right_rec(1, 1), right_rec(2, 2), (right_rec(2, 1) - right_rec(1, 1)), (right_rec(3, 2) - right_rec(2, 2))]);

    % Get points in cropped image
    new_right_rec = right_rec;
    new_right_rec(:, 1) = new_right_rec(:, 1) - new_right_rec(1, 1);
    new_right_rec(:, 2) = new_right_rec(:, 2) - new_right_rec(2, 2);

    % Find transformation from old points to new
    transform_right = fitgeotrans(new_right_rec, fixed_points, 'projective');

    % Get reference points from cropped plane
    RA = imref2d(size(cropped_recht_plane)); % Reference data from image
    
    % Warp image
    [image_right, BA_right] = imwarp(cropped_recht_plane, RA, transform_right);

    % Resize the transformed image 
    image_right = imresize(image_right, [size(image_right, 1), desiredImageDepth]);

    % Crop the black part from plane after transformation
    crop_settings_right = [round(abs(BA_right.XWorldLimits(1))), round(abs(BA_right.YWorldLimits(1))), desiredImageDepth, desiredImageDepth];
    right_plane = imcrop(image_right, crop_settings_right);
    
    % Resize the cropped image 
    right_plane = imresize(right_plane, [backgroundHeight desiredImageDepth]);

end
