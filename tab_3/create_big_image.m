function [big_image, back_b, top_b, bot_b, left_b, right_b] = create_big_image(back, top, bot, left, right, im)
    % This function takes the points of the 5 rectangles and creates a big image
    % where the coordinates for the rectangles no longer have negative values.
    % The image will be placed in the new bag image and the end result gives an
    % image with a black border and all the coordinate points will be positive values.

    %% Create the big image and place the original image inside it

    % Find the maximun and minimum values for the rectangles for the y-axis
    min_y_val = [top(2, :), left(2, :), right(2, :)];
    max_y_val = [bot(2, :), left(2, :), right(2, :)];

    %Find the image size
    [y_max, x_max, depth] = size(im);

    %The values in y-direction of how much the rectangles are outside the original image.
    neg_y_marg = -min(min_y_val);
    pos_y_marg = max(max_y_val) - y_max;

    % Find the maximun and minimum values for the rectangles for the x-axis
    min_x_val = [top(1, :), left(1, :), bot(1, :)];
    max_x_val = [top(1, :), right(1, :), bot(1, :)];

    %The values in x-direction of how much the rectangles are outside the original image.
    neg_x_marg = -min(min_x_val);
    pos_x_marg = max(max_x_val) - x_max;

    %Create the correct bigim size
    big_image = zeros(neg_y_marg + pos_y_marg + y_max, neg_x_marg + pos_x_marg + x_max, depth);

    %Place the original image at the correct coordinates
    big_image(neg_y_marg + 1:neg_y_marg + y_max, neg_x_marg + 1:x_max + neg_x_marg, :) = im2double(im);

    %% Move the rectangle points to the correct location in the new big im.
    back_b = back;
    top_b = top;
    bot_b = bot;
    left_b = left;
    right_b = right;

    %Add the x and y margin to the old rectangle coordinates
    back_b(1, :) = back(1, :) + neg_x_marg;
    back_b(2, :) = back(2, :) + neg_y_marg;

    top_b(1, :) = top(1, :) + neg_x_marg;
    top_b(2, :) = top(2, :) + neg_y_marg;

    bot_b(1, :) = bot(1, :) + neg_x_marg;
    bot_b(2, :) = bot(2, :) + neg_y_marg;

    left_b(1, :) = left(1, :) + neg_x_marg;
    left_b(2, :) = left(2, :) + neg_y_marg;

    right_b(1, :) = right(1, :) + neg_x_marg;
    right_b(2, :) = right(2, :) + neg_y_marg;

end
