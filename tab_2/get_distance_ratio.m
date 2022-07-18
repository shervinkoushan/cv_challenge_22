function [d] = get_distance_ratio(V, inn_rect, im_size)

    % Define a relative focal length
    f = 1;

    % Calculate top and bottom depths
    l = V(2) - 0;
    h = im_size(1) - V(2);
    b = V(2) - inn_rect(2, 2);
    a = inn_rect(2, 3) - V(2);

    d_top = (l * f / b) - f;
    d_bottom = (h * f / a) - f;

    % Calculate left and right depths
    l = V(1) - 0;
    h = im_size(2) - V(1);
    b = V(1) - inn_rect(1, 1);
    a = inn_rect(1, 2) - V(1);

    d_left = (l * f / b) - f;
    d_right = (h * f / a) - f;

    d = [d_top, d_bottom, d_left, d_right];

end
