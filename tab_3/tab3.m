function tab3(file_path, back_rec, top_rec, bottom_rec, left_rec, right_rec, d)

    %   Get TabHandles from guidata and set some varables
    tab_handles = guidata(gcf);
    num_tabs = size(tab_handles, 1) - 2;
    panel_width = tab_handles{num_tabs + 1, 2};
    panel_height = tab_handles{num_tabs + 1, 3};

    persistent image_axes;
    delete(image_axes); % Delete the previous contents

    %  Make this tab active
    tab_selected(0, 0, 3);

    %   Load the image
    img = imread(file_path);

    %  Set the axes and display the image
    ImgOffset = 40;
    image_axes = axes('Parent', tab_handles{3, 1}, 'Units', 'pixels', ...
        'Position', [ImgOffset ImgOffset ...
            panel_width - 2 * ImgOffset panel_height - 2 * ImgOffset]);
    hold on;
    [back_plane, top_plane, bottom_plane, left_plane, right_plane] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, img, d);

    % Create flat dice
    createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);

    % Use the keyboard buttons to roate and zoom
    set(tab_handles{num_tabs + 1, 1}, 'WindowKeyPressFcn', @keyPressCallback);

    %% Instructions button
    uicontrol('Parent', tab_handles{3, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 400 120 40], ...
        'String', 'Instructions', 'Callback', @show_instructions, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 11);

    %% Screenshot button
    uicontrol('Parent', tab_handles{3, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 320 120 40], ...
        'String', 'Export image', 'Callback', {@take_screenshot, image_axes}, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 11);

end

function take_screenshot(~, ~, ax)
    % Get the desired location and file type
    [file, path, ext] = uiputfile({'*.png'; '*.jpg'});

    if ~(isequal(file, 0) || isequal(path, 0))
        % Check if the file is of type any (Matlab automatically appends
        % this option even if it is not specified in uiputfile
        % If it is of type any, save it as a png file
        if ext == 3
            file = strcat(file, ".png");
        end

        % Export the image
        exportgraphics(ax, fullfile(path, file));
    end

end

function keyPressCallback(~, eventdata)
    % Key pressed -> find out which one and control camera accordingly

    % Camera step
    dolly_stepx = 0.05;
    dolly_stepy = 0.05;
    dolly_stepz = 0.05;
    key = eventdata.Key;

    switch key
        case 'd'
            camdolly(-dolly_stepx, 0, 0, 'fixtarget');
        case 'a'
            camdolly(dolly_stepx, 0, 0, 'fixtarget');
        case 's'
            camdolly(0, dolly_stepy, 0, 'fixtarget');
        case 'w'
            camdolly(0, -dolly_stepy, 0, 'fixtarget');
        case 'q'
            camdolly(0, 0, dolly_stepz, 'fixtarget');
        case 'e'
            camdolly(0, 0, -dolly_stepz, 'fixtarget');
        case 'leftarrow'
            camdolly(-dolly_stepx, 0, 0);
        case 'rightarrow'
            camdolly(dolly_stepx, 0, 0);
        case 'uparrow'
            camdolly(0, dolly_stepy, 0);
        case 'downarrow'
            camdolly(0, -dolly_stepy, 0);
    end

    hide_planes_if_in_background
end

function hide_planes_if_in_background
    % This function ensures that we can still see inside the 3d dice,
    % i.e. if we move around on one side that plane will be hidden so that
    % we can see whats behind

    global x_b;
    global y_b;
    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
    cam_p = campos;

    top_visible = 'on';
    bot_visible = 'on';
    left_visible = 'on';
    right_visible = 'on';

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

    set(top_warp, 'visible', top_visible)
    set(bot_warp, 'visible', bot_visible)
    set(left_warp, 'visible', left_visible)
    set(right_warp, 'visible', right_visible)

end
