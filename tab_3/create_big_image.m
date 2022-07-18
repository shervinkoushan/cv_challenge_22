function [bigim, back_b, top_b, bot_b, left_b, right_b] = create_big_image(back, top, bot, left, right, im)
%This function takes the points of the 5 rectangles and creates a big image
%where the cooridnates for the rectangles no longer has negative values. 
%The image will be placed in the new bag image and the end result gives an
%image with a black border and all the coordinate points will be positive
%values.

%% Create the big image and place the original image inside it

    % Find the maximun and minimum values for the rectangles for the y-axis
    minyval = [top(2, :), left(2, :), right(2, :)];
    maxyval = [bot(2, :), left(2, :), right(2, :)];

    %Find the image size
    [ymax, xmax, depth] = size(im);
    
    %The values in y-direction of how much the rectangles are outside the original image.
    negymarg = -min(minyval);
    posymarg = max(maxyval) - ymax;

    % Find the maximun and minimum values for the rectangles for the x-axis
    minxval = [top(1, :), left(1, :), bot(1, :)];
    maxxval = [top(1, :), right(1, :), bot(1, :)];

    %The values in x-direction of how much the rectangles are outside the original image.
    negxmarg = -min(minxval);
    posxmarg = max(maxxval) - xmax;

    %Create the correct bigim size
    bigim = zeros(negymarg + posymarg + ymax, negxmarg + posxmarg + xmax, depth);

    %Place the original image at the correct coordinates
    bigim(negymarg + 1:negymarg + ymax, negxmarg + 1:xmax + negxmarg, :) = im2double(im);

%% Move the rectangle points to the correct location in the new big im.
    back_b = back;
    top_b = top;
    bot_b = bot;
    left_b = left;
    right_b = right;

    %Add the x and y margin to the old rectangle coordinates
    back_b(1, :) = back(1, :) + negxmarg;
    back_b(2, :) = back(2, :) + negymarg;

    top_b(1, :) = top(1, :) + negxmarg;
    top_b(2, :) = top(2, :) + negymarg;

    bot_b(1, :) = bot(1, :) + negxmarg;
    bot_b(2, :) = bot(2, :) + negymarg;

    left_b(1, :) = left(1, :) + negxmarg;
    left_b(2, :) = left(2, :) + negymarg;

    right_b(1, :) = right(1, :) + negxmarg;
    right_b(2, :) = right(2, :) + negymarg;

end
