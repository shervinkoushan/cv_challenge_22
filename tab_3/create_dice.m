function [new_img] = createDice(back, top, bot, left, right)
    %This function aims to create the dice for all the 5 planes created from
    %get5Planes. This is done by plotting them in a 3D space and placing the
    %cropped image of the rectangle on top. Also a flat image which combines
    %all the sides is created.

    %% Create the 2D image that combines the 5 planes.

    % Get the size of all the planes
    [Y_1, X_1, Z] = size(top);
    [Y_2, X_2, ~] = size(left);
    [Y_3, X_3, ~] = size(right);
    [Y_4, X_4, ~] = size(bot);
    [Y_5, X_5, ~] = size(back);

    %Create the size of the new image
    new_img = zeros(Y_1 + Y_5 + Y_4, X_2 + X_3 + X_5, Z);

    %Placing the different planes at the correct position in the new image.
    %i.e a plus sign shape.
    new_img(1:Y_1, X_2:(X_1 + X_2) - 1, :) = im2double(top);
    new_img(Y_1:(Y_1 + Y_2) - 1, 1:X_2, :) = im2double(left);
    new_img(Y_1:(Y_1 + Y_3) - 1, (X_1 + X_2):(X_1 + X_2 + X_3) - 1, :) = im2double(right);
    new_img((Y_1 + Y_2):(Y_1 + Y_2 + Y_4) - 1, X_2:(X_2 + X_4) - 1, :) = im2double(bot);
    new_img(Y_1:(Y_1 + Y_5) - 1, X_2:(X_2 + X_5) - 1, :) = im2double(back);

    %% Creating the actual dice

    global x_b;
    global y_b;

    %Create a meshgrid based on the size of the image
    [y_b, x_b, ~] = size(back);
    [back_x, back_y] = meshgrid(1:x_b, 1:y_b);
    %The z-axis i multiplied by two to avoid gaps between the planes
    back_z = 2 .* ones(y_b, x_b);

    %Create a meshgrid based on the size of the image.
    [y, x, ~] = size(top);
    [top_x, top_z] = meshgrid(1:x, 1:y);
    %For the top plane the y-axis turns into the z-axis and y is there for
    %close to zero.
    top_y = 2 .* ones(y, x);
    %the image is rotated and flipped due to the (0,0) being in the top
    %left corner.
    top = imrotate(top, 180);
    top = flipdim(top, 2);

    %Create a meshgrid based on the size of the image.
    [y, x, ~] = size(bot);
    [bot_x, bot_z] = meshgrid(1:x, 1:y);
    %For bottom the z and y axis are swapped and y is equal to the max of
    %the back image. we subract one to avoid gaps.
    bot_y = (y_b - 1) .* ones(y, x);

    %Create a meshgrid based on the size of the image.
    [y, x, ~] = size(left);
    [left_y, left_z] = meshgrid(1:y, 1:x);
    %For left the z and x aaxis are swapped and x is set equal to the min
    %of the back image. We multipy by two to avoid a gap between the
    %planes.
    left_x = 2 .* ones(x, y);
    %The image is rotated due to (0,0) being at the top left corner
    left = imrotate(left, 90);

    %Create a meshgrid based on the size of the image.
    [y, x, ~] = size(right);
    [right_y, right_z] = meshgrid(1:y, 1:x);
    %For right the z and x axis are swapped and x is equal to the max of
    %the back image. Ee subract one to avoid gaps.
    right_x = (x_b - 1) .* ones(x, y);
    %the image is rotated and flipped due to the (0,0) being in the top
    %left corner.
    right = imrotate(right, 90);
    right = flipdim(right, 1);

    %% Plotting the images on the five planes
    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
    %Taking the coodinates of the plane and fitting the belonging cropped
    %image.
    warp(back_x, back_y, back_z, back);

    %top
    top_warp = warp(top_x, top_y, top_z, top);

    %bot
    bot_warp = warp(bot_x, bot_y, bot_z, bot);

    %left
    left_warp = warp(left_x, left_y, left_z, left);

    %right
    right_warp = warp(right_x, right_y, right_z, right);

    axis equal; % make X,Y,Z dimentions be equal
    axis vis3d; % freeze the scale for better rotations
    axis off; % turn off the stupid tick marks
    camproj('perspective'); % make it a perspective projection

    % set camera position
    camx = x_b / 2;
    camy = y_b / 2;
    camz = 12 * y_b;

    % set camera target
    tarx = x_b / 2;
    tary = y_b / 2;
    tarz = 0;

    % set camera on ground
    camup([0, 1, 0]);

    campos([camx camy camz]);
    camtarget([tarx tary tarz]);
    camroll(180);

end
