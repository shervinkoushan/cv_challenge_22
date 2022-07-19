%% The 3D box is shown to the user and he/she can move around

function tab3(file_path, back_rec, top_rec, bottom_rec, left_rec, right_rec, depth)

    % Extract information about the panel size
    tab_handles = guidata(gcf);
    num_tabs = size(tab_handles, 1) - 2;
    panel_width = tab_handles{num_tabs + 1, 2};
    panel_height = tab_handles{num_tabs + 1, 3};

    persistent image_axes;
    delete(image_axes); % Delete the previous content

    %  Make this tab active
    tab_selected(0, 0, 3);

    %  Load the image
    img = imread(file_path);

    % Set the axes and display the image
    image_offset = 40;
    image_axes = axes('Parent', tab_handles{3, 1}, 'Units', 'pixels', ...
        'Position', [image_offset image_offset ...
            panel_width - 2 * image_offset panel_height - 2 * image_offset]);
    hold on;
    [back_plane, top_plane, bottom_plane, left_plane, right_plane] = image_3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, img, depth);

    % Create flat dice
    create_dice(back_plane, top_plane, bottom_plane, left_plane, right_plane);

    % Use the keyboard buttons to rotate and zoom
    set(tab_handles{num_tabs + 1, 1}, 'WindowKeyPressFcn', @keyPressCallback);

    %% Instructions button
    uicontrol('Parent', tab_handles{3, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 400 120 40], ...
        'String', 'Instructions', 'Callback', @show_instructions, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 11);

    %% Reset button
    uicontrol('Parent', tab_handles{3, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 320 120 40], ...
        'String', 'Reset', 'Callback', @reset, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 11);

    %% Screenshot button
    uicontrol('Parent', tab_handles{3, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 240 120 40], ...
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
    va_step = 1; % view angle step
    key = eventdata.Key;

    curr_view_angle = camva;

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
        case 'y'

            if (curr_view_angle > 15)
                camva(curr_view_angle - va_step);
            end

        case 'x'

            if (curr_view_angle < 90)
                camva(curr_view_angle + va_step);
            end

    end

    hide_planes_if_in_background();
end

function reset(~, ~)
    % Set camera position and angle to initial values
    reset_camera();
    % This will restore any previously hidden planes
    hide_planes_if_in_background();
end
