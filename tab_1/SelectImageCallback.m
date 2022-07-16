%%   Select Image Callback
function SelectImageCallback(~, ~)

    dialog_pos_x = 500;
    dialog_pos_y = 200;
    dialog_width = 500;
    dialog_height = 450;

    d = dialog('Position', [dialog_pos_x dialog_pos_y dialog_width dialog_height], 'Name', 'Select image');

    txt = uicontrol('Parent', d, ...
        'Style', 'text', ...
        'Position', [dialog_width / 2 - 150 dialog_height - 90 300 40], ...
        'String', 'Click on the image you would like to use', ...
        'FontName', 'arial', ...
        'FontWeight', 'bold', ...
        'FontSize', 10);

    btn = uicontrol('Parent', d, ...
        'Position', [dialog_width / 2 - 35 20 70 35], ...
        'String', 'Close', ...
        'Callback', 'delete(gcf)', ...
        'Style', 'pushbutton', ...
        'HorizontalAlignment', 'center', ...
        'FontName', 'arial', ...
        'FontWeight', 'bold', ...
        'FontSize', 9);

    button_width = 100;
    button_height = 100;
    folder_path = 'lib/';
    file_names = ["simple-room.png" "oil-painting.png" "shopping-mall.png" ...
            "uhren-turm.jpg" "metro-station.png" "sagrada_familia.png"];
    pos_x = [50 200 350 50 200 350];
    pos_y = [250 250 250 100 100 100];

    for i = 1:length(file_names)
        filepath = append(folder_path, file_names(i));
        image = imread(filepath);
        [r, c, ~] = size(image);
        x = ceil(r / 90);
        y = ceil(c / 90);
        g = image(1:x:end, 1:y:end, :);
        g(g == 255) = 5.5 * 255;
        image_button = uicontrol('Parent', d, ...
            'Position', [pos_x(i) pos_y(i) button_width button_height], ...
            'CData', g, ...
            'Callback', {@image_callback, filepath});
    end

    PicFilePath = "";
    % Wait for d to close before running to completion
    uiwait(d);

    function image_callback(~, ~, filepath)
        PicFilePath = filepath;
        delete(gcf);
    end

    if PicFilePath ~= ""
        % Now that an image is selected, we can go to tab 2
        % We cant move to tab 3 yet though
        enable_tab2_disable_tab3;
        tab2(PicFilePath);
    end

end
