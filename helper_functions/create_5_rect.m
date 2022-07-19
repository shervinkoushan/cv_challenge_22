function [back_rec, top_rec, bottom_rec, left_rec, right_rec] = create_5_rect(im_size, van_point, inner_rec, outer_rec)
    % Function has as input:
    % 1. image size im_size
    % 2. vanishing point van_point
    % 3. inner rectangular inner_rec
    % 4. outer rectangular outer_rec

    % With this 9 points the 5 rectuangulars are calculated
    % Starting point of the rectangular is always top left corner
    % calculate the the 5 rectegulars: top_rec, bottom_rec, left_rec, right_rec,

    ymax = im_size(1);
    xmax = im_size(2);
    ymin = 0;
    xmin = 0;

    % back_rec
    back_rec = inner_rec;

    % Calculation of the top rectangular
    top_rec_x = [outer_rec(1, 1), outer_rec(1, 2), inner_rec(1, 2), inner_rec(1, 1)];
    top_rec_y = [outer_rec(2, 1), outer_rec(2, 2), inner_rec(2, 2), inner_rec(2, 1)];
    
    % Check if left top corner lies on the top image line
    if (top_rec_y(1) ~= ymin)
        top_rec_x(1) = line_intersection_x(van_point, inner_rec(:, 1), ymin);
        top_rec_y(1) = ymin;
    end
    % Check if top right corner lies on the the image line 
    if (top_rec_y(2) ~= ymin)
        top_rec_x(2) = line_intersection_x(van_point, inner_rec(:, 2), ymin);
        top_rec_y(2) = ymin;
    end
    top_rec = [top_rec_x; top_rec_y];

    % Calculation of the bottom rectangular
    bottom_rec_x = [inner_rec(1, 4), inner_rec(1, 3), outer_rec(1, 3), outer_rec(1, 4)];
    bottom_rec_y = [inner_rec(2, 4), inner_rec(2, 3), outer_rec(2, 3), outer_rec(2, 4)];

    % Check if bottom left corner lies on the top image line
    if (bottom_rec_y(3) ~= ymax)
        bottom_rec_x(3) = line_intersection_x(van_point, inner_rec(:, 3), ymax);
        bottom_rec_y(3) = ymax;
    end
    % Check if bottom right corner lies on the top image line
    if (bottom_rec_y(4) ~= ymax)
        bottom_rec_x(4) = line_intersection_x(van_point, inner_rec(:, 4), ymax);
        bottom_rec_y(4) = ymax;
    end
    bottom_rec = [bottom_rec_x; bottom_rec_y];

    % Calculation of the left rectangular
    left_rec_x = [outer_rec(1, 1), inner_rec(1, 1), inner_rec(1, 4), outer_rec(1, 4)];
    left_rec_y = [outer_rec(2, 1), inner_rec(2, 1), inner_rec(2, 4), outer_rec(2, 4)];
    % Check if left top corner lies on the top image line
    if (left_rec_x(1) ~= xmin)
        left_rec_y(1) = line_intersection_y(van_point, inner_rec(:, 1), xmin);
        left_rec_x(1) = xmin;
    end
    % Check if left bottom corner lies on the top image line
    if (left_rec_x(4) ~= xmin)
        left_rec_y(4) = line_intersection_y(van_point, inner_rec(:, 4), xmin);
        left_rec_x(4) = xmin;
    end
    left_rec = [left_rec_x; left_rec_y];

    % Calculation of the right rectangular
    right_rec_x = [inner_rec(1, 2), outer_rec(1, 2), outer_rec(1, 3), inner_rec(1, 3)];
    right_rec_y = [inner_rec(2, 2), outer_rec(2, 2), outer_rec(2, 3), inner_rec(2, 3)];
    % Check if right top corner lies on the top image line
    if (right_rec_x(2) ~= xmax)
        right_rec_y(2) = line_intersection_y(van_point, inner_rec(:, 2), xmax);
        right_rec_x(2) = xmax;
    end
    % Check if right bottom corner lies on the top image line
    if (right_rec_x(3) ~= xmax)
        right_rec_y(3) = line_intersection_y(van_point, inner_rec(:, 3), xmax);
        right_rec_x(3) = xmax;
    end
    right_rec = [right_rec_x; right_rec_y];

end
