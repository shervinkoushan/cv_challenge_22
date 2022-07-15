function [outer_rec] = outer_rectangle(van_point, inner_rec, im_size)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    outer_rec = zeros(2, 4);
    x_min = 0;
    x_max = im_size(2);
    y_min = 0;
    y_max = im_size(1);

    %Punkt 1 (upper left)
    x_1 = x_min;
    y_1 = line_intersection_y(van_point, inner_rec(:, 1), x_1);

    y_2 = y_min;
    x_2 = line_intersection_x(van_point, inner_rec(:, 1), y_2);

    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    outer_rec(1, 1) = x;
    outer_rec(2, 1) = y;

    %Punkt 2 (upper right)
    x_1 = x_max;
    y_1 = line_intersection_y(van_point, inner_rec(:, 2), x_1);

    y_2 = y_min;
    x_2 = line_intersection_x(van_point, inner_rec(:, 2), y_2);

    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    outer_rec(1, 2) = x;
    outer_rec(2, 2) = y;

    %Punkt 3 (lower right)
    x_1 = x_max;
    y_1 = line_intersection_y(van_point, inner_rec(:, 3), x_1);

    y_2 = y_max;
    x_2 = line_intersection_x(van_point, inner_rec(:, 3), y_2);

    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    outer_rec(1, 3) = x;
    outer_rec(2, 3) = y;

    %Punkt 4 (lower left)
    x_1 = x_min;
    y_1 = line_intersection_y(van_point, inner_rec(:, 4), x_1);

    y_2 = y_max;
    x_2 = line_intersection_x(van_point, inner_rec(:, 4), y_2);

    if pdist([van_point; x_1, y_1]) > pdist([van_point; x_2, y_2])
        x = x_1;
        y = y_1;
    else
        x = x_2;
        y = y_2;
    end

    outer_rec(1, 4) = x;
    outer_rec(2, 4) = y;

end
