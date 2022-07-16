function [new_img] = createDice(back, top, bot, left, right)
    [Y_1, X_1, Z] = size(top);
    [Y_2, X_2, ~] = size(left);
    [Y_3, X_3, ~] = size(right);
    [Y_4, X_4, ~] = size(bot);
    [Y_5, X_5, ~] = size(back);

    new_img = zeros(Y_1 + Y_5 + Y_4, X_2 + X_3 + X_5, Z);

    new_img(1:Y_1, X_2:(X_1 + X_2) - 1, :) = im2double(top);

    new_img(Y_1:(Y_1 + Y_2) - 1, 1:X_2, :) = im2double(left);

    new_img(Y_1:(Y_1 + Y_3) - 1, (X_1 + X_2):(X_1 + X_2 + X_3) - 1, :) = im2double(right);

    new_img((Y_1 + Y_2):(Y_1 + Y_2 + Y_4) - 1, X_2:(X_2 + X_4) - 1, :) = im2double(bot);

    new_img(Y_1:(Y_1 + Y_5) - 1, X_2:(X_2 + X_5) - 1, :) = im2double(back);

    global x_b;
    global y_b;
    [y_b, x_b, ~] = size(back);
    [back_x, back_y] = meshgrid(1:x_b, 1:y_b);
    back_z = 2 .* ones(y_b, x_b);

    [y, x, ~] = size(top);
    [top_x, top_z] = meshgrid(1:x, 1:y);
    top_y = 2 .* ones(y, x);
    top = imrotate(top, 180);
    top = flipdim(top,2);

    [y, x, ~] = size(bot);
    [bot_x, bot_z] = meshgrid(1:x, 1:y);
    bot_y = (y_b - 1) .* ones(y, x);

    [y, x, ~] = size(left);
    [left_y, left_z] = meshgrid(1:y, 1:x);
    left_x = 2 .* ones(x, y);
    left = imrotate(left, 90);

    [y, x, ~] = size(right);
    [right_y, right_z] = meshgrid(1:y, 1:x);
    right_x = (x_b - 1) .* ones(x, y);
    right = imrotate(right, 90);

    %!!!!This should probably be done in get5planes!!!!
    right = flipdim(right, 1);

    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
    %back
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
