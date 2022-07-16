function tab2(file_path)

    %% Global variables
    global vanishing_point;
    global rect_pos;
    global vp_pos;
    global image_size;

    %   Get TabHandles from guidata and set some varables
    TabHandles = guidata(gcf);
    NumberOfTabs = size(TabHandles, 1) - 2;
    PanelWidth = TabHandles{NumberOfTabs + 1, 2};
    PanelHeight = TabHandles{NumberOfTabs + 1, 3};

    persistent hImageAxes
    persistent saveButton

    %   Load the image
    I = imread(file_path);

    delete(hImageAxes); % Delete the previous image
    delete(saveButton); % Delete the save button

    %   Set the axes and display the image
    ImgOffset = 40;
    hImageAxes = axes('Parent', TabHandles{2, 1}, ...
        'Units', 'pixels', ...
        'Position', [ImgOffset ImgOffset ...
            PanelWidth - 2 * ImgOffset PanelHeight - 2 * ImgOffset]);
    imshow(I);
    hold on

    %   Make Image Tab active
    tab_selected(0, 0, 2);

    [dim_x, dim_y, ~] = size(I);
    image_size = [dim_x dim_y];

    info_text = uicontrol('Style', 'text', ...
        'Position', [PanelWidth - 170 300 150 100], ...
        'Parent', TabHandles{2, 1}, ...
        'BackgroundColor', [1 1 1], ...
        'string', 'Draw the inner rectangle', ...
        'HorizontalAlignment', 'center', ...
        'FontName', 'arial', ...
        'FontWeight', 'bold', ...
        'FontSize', 11);

    %% Background rectangle
    inner_rectangle = drawrectangle('StripeColor', 'y');
    rect_pos = inner_rectangle.Position;
    ensure_rect_non_zero_area(inner_rectangle);
    inner_rectangle.Label = 'Inner rectangle';
    addlistener(inner_rectangle, 'ROIMoved', @rectangle_moved);
    hold on

    %% Vanishing point
    set(info_text, 'string', "Select the vanishing point");
    vanishing_point = drawpoint('Color', 'r', 'DrawingArea', smaller_rect(rect_pos));
    vp_pos = vanishing_point.Position;
    update_polygons();
    vanishing_point.Label = 'Vanishing point';
    addlistener(vanishing_point, 'ROIMoved', @vp_moved);

    set(info_text, 'string', "Make adjustments and save when you are finished");

    %% Save button
    saveButton = uicontrol('Parent', TabHandles{2, 1}, ...
    'Units', 'pixels', ...
        'Position', [PanelWidth - 140 ImgOffset 100 40], ...
        'String', 'Save', ...
        'Callback', {@save, file_path}, ...
        'Style', 'pushbutton', ...
        'HorizontalAlignment', 'center', ...
        'FontName', 'arial', ...
        'FontWeight', 'bold', ...
        'FontSize', 11);
end

% Decrease rect size by 1 pixel in each direction
function constraint = smaller_rect(rect)
    constraint = [rect(1) + 1 rect(2) + 1 rect(3) - 2 rect(4) - 2];
end

% P1 upper left, P2 upper right, P3 bottom right, P4 buttom left
function [x_array, y_array] = x_y_from_rect_pos(position)
    x_min = position(1);
    y_min = position(2);
    width = position(3);
    height = position(4);
    x_array = [x_min x_min + width x_min + width x_min];
    y_array = [y_min y_min y_min + height y_min + height];
end

function ensure_rect_non_zero_area(inner_rectangle)
    global rect_pos;

    limit = 30;

    if rect_pos(3) < limit
        rect_pos(3) = limit;
    end

    if rect_pos(4) < limit
        rect_pos(4) = limit;
    end

    set(inner_rectangle, 'Position', rect_pos);
end

function rectangle_moved(inner_rectangle, evt)
    % User selection changed, need to save first to be able to go tab 3
    global can_go_to_tab3;
    can_go_to_tab3 = false;

    global rect_pos;
    global vp_pos;
    global vanishing_point;
    rect_pos = evt.CurrentPosition;
    ensure_rect_non_zero_area(inner_rectangle);
    % The vanishing point must stay inside the inner rectangle
    set(vanishing_point, 'DrawingArea', smaller_rect(rect_pos));

    if ~(inROI(inner_rectangle, vp_pos(1), vp_pos(2)))
        % Move vanishing point to the middle of the rectangle if it
        % is outside
        vp_pos = [rect_pos(1) + rect_pos(3) / 2 rect_pos(2) + rect_pos(4) / 2];
        set(vanishing_point, 'Position', vp_pos);
    end

    update_polygons();
end

function vp_moved(~, evt)
    % User selection changed, need to save first to be able to go tab 3
    global can_go_to_tab3;
    can_go_to_tab3 = false;
    global vp_pos;
    vp_pos = evt.CurrentPosition;
    update_polygons();
end

function save(~, ~, file_path)
    global back_rec;
    global top_rec;
    global bottom_rec;
    global left_rec;
    global right_rec;
    global d;
    % Now that the inner rectangle and vanishing point is
    % is selected, we can go to tab 3
    global can_go_to_tab3;
    can_go_to_tab3 = true;
    tab3(file_path, back_rec, top_rec, bottom_rec, left_rec, right_rec, d)
end

function update_polygons()
    persistent top_poly;
    persistent bottom_poly;
    persistent left_poly;
    persistent right_poly;

    % Delete previous polygon plots
    delete(top_poly);
    delete(bottom_poly);
    delete(left_poly);
    delete(right_poly);

    global rect_pos;
    global vp_pos;
    global image_size;

    global back_rec;
    global top_rec;
    global bottom_rec;
    global left_rec;
    global right_rec;
    global d;

    [inner_rect_x, inner_rect_y] = x_y_from_rect_pos(rect_pos);
    vanishing_point = round(vp_pos);
    inner_rect = round([inner_rect_x; inner_rect_y]);
    im_size = round(image_size);
    [back_rec, top_rec, bottom_rec, left_rec, right_rec, d] = backend(vanishing_point, inner_rect, im_size);

    top_poly = plot_polygon(top_rec, 'yellow');
    bottom_poly = plot_polygon(bottom_rec, 'magenta');
    left_poly = plot_polygon(left_rec, 'cyan');
    right_poly = plot_polygon(right_rec, 'green');
end

function handle = plot_polygon(rectangle, color)
    polygon = polyshape(rectangle(1, :), rectangle(2, :));
    handle = plot(polygon, 'FaceColor', color);
end
