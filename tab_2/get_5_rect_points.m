function [back_rec, top_rec, bottom_rec, left_rec, right_rec, depth] = get_5_rect_points(vanishing_point, inner_rectangle, image_size)

    %% Use Function outer_rectangular.m to calculate the outer rectangle
    % Refer to Report Tour into the picture: Figure 4 c, outer rectangle is
    % the points 11, 10, 4, 5
    or = outer_rectangle(vanishing_point, inner_rectangle, image_size);

    %% Get the depth of the 5 planes
    [depth] = get_distance_ratio(vanishing_point, inner_rectangle, image_size);

    %% Call function create_5_rect which gives 5 arrays for the five rectangles
    % Top, bottom, left, right and back
    [back_rec, top_rec, bottom_rec, left_rec, right_rec] = create_5_rect(image_size, vanishing_point, inner_rectangle, or);

end
