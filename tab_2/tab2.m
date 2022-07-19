%% The user selects the inner rectangle, the vanishing point and saves when he/she is satisfied

function tab2(file_path)
    % Get panel dimensions
    tab_handles = guidata(gcf);
    num_tabs = size(tab_handles, 1) - 2;
    panel_width = tab_handles{num_tabs + 1, 2};
    panel_height = tab_handles{num_tabs + 1, 3};

    % Delete previous content
    persistent image_axes
    persistent save_button
    delete(image_axes); % Delete the previous image
    delete(save_button); % Delete the save button

    % Load the image
    img = imread(file_path);

    %   Set the axes and display the image
    image_offset = 40;
    image_axes = axes('Parent', tab_handles{2, 1}, 'Units', 'pixels', ...
        'Position', [image_offset image_offset ...
            panel_width - 2 * image_offset panel_height - 2 * image_offset]);
    imshow(img);
    hold on

    %  Make this tab active
    tab_selected(0, 0, 2);

    [dim_x, dim_y, ~] = size(img);
    image_size = [dim_x dim_y];

    info_text = uicontrol('Style', 'text', ...
        'Position', [panel_width - 170 300 150 100], ...
        'Parent', tab_handles{2, 1}, 'BackgroundColor', [1 1 1], ...
        'string', 'Draw the inner rectangle', 'FontName', 'arial', ...
        'FontWeight', 'bold', 'FontSize', 11);

    %% Background rectangle
    inner_rectangle = drawrectangle('StripeColor', 'y');

    % If we come back to this tab without selecting a rectangle, the
    % previous tab2 function would still be running. We therefore ensure
    % that inner_rectangle is a valid object before continuing
    if ~isvalid(inner_rectangle)
        return
    end

    rect_pos = inner_rectangle.Position;

    ensure_rect_non_zero_area();
    inner_rectangle.Label = 'Inner rectangle';
    addlistener(inner_rectangle, 'ROIMoved', @rectangle_moved);
    hold on

    %% Vanishing point
    % Update the text to tell the user what to do
    set(info_text, 'string', "Select the vanishing point");
    vanishing_point = drawpoint('Color', 'r', 'DrawingArea', smaller_rect(rect_pos));

    % Same as for the inner rectangle, we stop the function if the object
    % has been deleted
    if ~isvalid(vanishing_point)
        return
    end

    vp_pos = vanishing_point.Position;

    update_polygons(rect_pos, vp_pos, image_size);
    vanishing_point.Label = 'Vanishing point';
    addlistener(vanishing_point, 'ROIMoved', @vp_moved);

    set(info_text, 'string', "Make adjustments and save when you are finished");

    %% Save button
    save_button = uicontrol('Parent', tab_handles{2, 1}, ...
    'Units', 'pixels', 'Position', [panel_width - 140 image_offset 100 40], ...
        'String', 'Save', 'Callback', {@save, file_path}, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 11);

    %% Callback for when inner rectangle is moved
    function rectangle_moved(inner_rectangle, evt)
        % User selection changed, need to save first to be able to go tab 3
        toggle_tab(3, false);

        % Set inner rectangle position
        rect_pos = evt.CurrentPosition;
        ensure_rect_non_zero_area();

        % The vanishing point must stay inside the inner rectangle
        set(vanishing_point, 'DrawingArea', smaller_rect(rect_pos));

        if ~(inROI(inner_rectangle, vp_pos(1), vp_pos(2)))
            % Move vanishing point to the middle of the rectangle if it
            % is outside
            vp_pos = [rect_pos(1) + rect_pos(3) / 2 rect_pos(2) + rect_pos(4) / 2];
            set(vanishing_point, 'Position', vp_pos);
        end

        update_polygons(rect_pos, vp_pos, image_size);
    end

    % Make sure the rectangle is decently large. Mainly a safe-guard in
    % case the user just draws a dot as the rectangle
    function ensure_rect_non_zero_area()
        limit = 30;

        if rect_pos(3) < limit
            rect_pos(3) = limit;
        end

        if rect_pos(4) < limit
            rect_pos(4) = limit;
        end

        set(inner_rectangle, 'Position', rect_pos);
    end

    %% Callback for when vanishing point is moved
    function vp_moved(~, evt)
        % User selection changed, need to save first to be able to go tab 3
        toggle_tab(3, false);

        % Update vanishing point position
        vp_pos = evt.CurrentPosition;
        update_polygons(rect_pos, vp_pos, image_size);
    end

end

% Decrease rect size by 1 pixel in each direction
function constraint = smaller_rect(rect)
    constraint = [rect(1) + 1 rect(2) + 1 rect(3) - 2 rect(4) - 2];
end

% Get the four points from the rectangle's positon
% P1 upper left, P2 upper right, P3 bottom right, P4 buttom left
function [x_array, y_array] = x_y_from_rect_pos(position)
    x_min = position(1);
    y_min = position(2);
    width = position(3);
    height = position(4);
    x_array = [x_min x_min + width x_min + width x_min];
    y_array = [y_min y_min y_min + height y_min + height];
end

function save(~, ~, file_path)
    global back_rec;
    global top_rec;
    global bottom_rec;
    global left_rec;
    global right_rec;
    global depth;

    % Now that the inner rectangle and vanishing point is selected, we can go to tab 3
    toggle_tab(3, true);
    tab3(file_path, back_rec, top_rec, bottom_rec, left_rec, right_rec, depth)
end

function update_polygons(rect_pos, vp_pos, image_size)
    persistent top_poly;
    persistent bottom_poly;
    persistent left_poly;
    persistent right_poly;

    % Delete previous polygon plots
    delete(top_poly);
    delete(bottom_poly);
    delete(left_poly);
    delete(right_poly);

    global back_rec;
    global top_rec;
    global bottom_rec;
    global left_rec;
    global right_rec;
    global depth;

    [inner_rect_x, inner_rect_y] = x_y_from_rect_pos(rect_pos);
    vanishing_point = round(vp_pos);
    inner_rect = round([inner_rect_x; inner_rect_y]);
    im_size = round(image_size);
    [back_rec, top_rec, bottom_rec, left_rec, right_rec, depth] = get_5_rect_points(vanishing_point, inner_rect, im_size);

    % Plot the rectangles
    top_poly = plot_polygon(top_rec, 'yellow');
    bottom_poly = plot_polygon(bottom_rec, 'magenta');
    left_poly = plot_polygon(left_rec, 'cyan');
    right_poly = plot_polygon(right_rec, 'green');
end

function handle = plot_polygon(rectangle, color)
    polygon = polyshape(rectangle(1, :), rectangle(2, :));
    handle = plot(polygon, 'FaceColor', color);
end
