function [outer_rec] = outer_rectangle(van_point, inner_rec, im_size)
    %This function creates the outer rectantancle of the image, meaning the
    %point at the edge/outside of the image which ensures that the 4 plaes
    %have a rectangle shape

    %% Finding the min and max values of the image
    outer_rec = zeros(2, 4);
    x_min = 0;
    x_max = im_size(2);
    y_min = 0;
    y_max = im_size(1);



    %% Point one (upper left)

    %There are two sides the line can cross, the x_min (left) or the y_min
    %(top) the x and y values for both cases are checked.
    x_1 = x_min;
    y_1 = line_intersection_y(van_point, inner_rec(:, 1), x_1);

    y_2 = y_min;
    x_2 = line_intersection_x(van_point, inner_rec(:, 1), y_2);

    %The coordinate combination which creates the longest line is selected as this is
    %where we guarantee that the entire picture is included
    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    %Sets the desired value to the output
    outer_rec(1, 1) = x;
    outer_rec(2, 1) = y;

    %% Point 2 (upper right)

    %There are two sides the line can cross, the x_max (right) or the y_min
    %(top) the x and y values for both cases are checked.
    x_1 = x_max;
    y_1 = line_intersection_y(van_point, inner_rec(:, 2), x_1);

    y_2 = y_min;
    x_2 = line_intersection_x(van_point, inner_rec(:, 2), y_2);

    %The coordinate combination which creates the longest line is selected as this is
    %where we guarantee that the entire picture is included
    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    %Sets the desired value to the output
    outer_rec(1, 2) = x;
    outer_rec(2, 2) = y;

    %% Point 3 (lower right)

    %There are two sides the line can cross, the x_max (right) or the y_max
    %(bottom) the x and y values for both cases are checked.
    x_1 = x_max;
    y_1 = line_intersection_y(van_point, inner_rec(:, 3), x_1);

    y_2 = y_max;
    x_2 = line_intersection_x(van_point, inner_rec(:, 3), y_2);

    %The coordinate combination which creates the longest line is selected as this is
    %where we guarantee that the entire picture is included
    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    %Sets the desired value to the output
    outer_rec(1, 3) = x;
    outer_rec(2, 3) = y;

    %% Point 4 (lower left)

    %There are two sides the line can cross, the x_min (left) or the y_max
    %(bottom) the x and y values for both cases are checked.
    x_1 = x_min;
    y_1 = line_intersection_y(van_point, inner_rec(:, 4), x_1);

    y_2 = y_max;
    x_2 = line_intersection_x(van_point, inner_rec(:, 4), y_2);

    %The coordinate combination which creates the longest line is selected as this is
    %where we guarantee that the entire picture is included
    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    %Sets the desired value to the output
    outer_rec(1, 4) = x;
    outer_rec(2, 4) = y;

end
