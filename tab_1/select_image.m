%% Opens a dialog that shows the 6 predefined images, then opens tab 2 with the path to the selected image as input

function select_image(~, ~)

    % Dialog dimensions

    dialog_pos_x = 500;
    dialog_pos_y = 200;
    dialog_width = 500;
    dialog_height = 450;

    d = dialog('Position', [dialog_pos_x dialog_pos_y dialog_width dialog_height], 'Name', 'Select image');

    % Title
    uicontrol('Parent', d, 'Style', 'text', ...
    'Position', [dialog_width / 2 - 150 dialog_height - 90 300 40], ...
        'String', 'Click on the image you would like to use', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 10);

    % Close button
    uicontrol('Parent', d, 'Position', [dialog_width / 2 - 35 20 70 35], ...
    'String', 'Close', 'Callback', 'delete(gcf)', 'Style', 'pushbutton', ...
        'HorizontalAlignment', 'center', 'FontName', 'arial', ...
        'FontWeight', 'bold', 'FontSize', 9);

    % Some constants
    button_width = 100;
    button_height = 100;
    folder_path = 'lib/';
    file_names = ["simple-room.png" "oil-painting.png" "shopping-mall.png" ...
            "uhren-turm.jpg" "metro-station.png" "sagrada_familia.png"];
    pos_x = [50 200 350 50 200 350];
    pos_y = [250 250 250 100 100 100];

    % Create an image button for each image
    for i = 1:length(file_names)
        filepath = append(folder_path, file_names(i));
        image = imread(filepath);
        [r, c, ~] = size(image);
        x = ceil(r / 90);
        y = ceil(c / 90);
        g = image(1:x:end, 1:y:end, :);
        g(g == 255) = 5.5 * 255;
        uicontrol('Parent', d, ...
            'Position', [pos_x(i) pos_y(i) button_width button_height], ...
            'CData', g, 'Callback', {@image_callback, filepath});
    end

    path = "";

    % Wait for the dialog to close before running to completion
    uiwait(d);

    % Image clicked -> set file path
    function image_callback(~, ~, filepath)
        path = filepath;
        delete(gcf);
    end

    if path ~= ""
        % Now that an image is selected, we can go to tab 2
        % We can't move to tab 3 yet though
        toggle_tab(2, true);
        toggle_tab(3, false);
        tab2(path);
    end

end
