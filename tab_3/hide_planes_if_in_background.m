function hide_planes_if_in_background
    % This function ensures that we can still see inside the 3d dice,
    % i.e. if we move around on one side that plane will be hidden so that
    % we can see what is behind

    global x_b;
    global y_b;
    global back_warp;
    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
    cam_p = campos;

    back_visible = 'on';
    top_visible = 'on';
    bot_visible = 'on';
    left_visible = 'on';
    right_visible = 'on';

    if cam_p(3) < 0
        back_visible = 'off';
    end

    if cam_p(2) < 0
        top_visible = 'off';
    end

    if cam_p(2) > y_b
        bot_visible = 'off';
    end

    if cam_p(1) < 0
        left_visible = 'off';
    end

    if cam_p(1) > x_b
        right_visible = 'off';
    end

    set(back_warp, 'visible', back_visible)
    set(top_warp, 'visible', top_visible)
    set(bot_warp, 'visible', bot_visible)
    set(left_warp, 'visible', left_visible)
    set(right_warp, 'visible', right_visible)

end
