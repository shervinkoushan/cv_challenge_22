function [back_plane, top_plane, bottom_plane, left_plane, right_plane] = image_3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, im, d)
    % The function creates a box from the 5 planes
    % First a new image is created so all points of the recangle have positive values
    % Function get_5_planes creates a rectangle out of each plane
    % Function create_dice will put all the planes together

    %% Create big image
    [bigim, back_b, top_b, bot_b, left_b, right_b] = create_big_image(back_rec, top_rec, bottom_rec, left_rec, right_rec, im);

    %% Create 5 planes
    [back_plane, top_plane, bottom_plane, left_plane, right_plane] = get_5_planes(bigim, back_b, top_b, bot_b, left_b, right_b, d);

end
