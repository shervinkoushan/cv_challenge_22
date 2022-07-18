function show_instructions(~, ~)

    % The dialog
    dialog_pos_x = 500;
    dialog_pos_y = 200;
    dialog_width = 500;
    dialog_height = 450;

    dialog_handle = dialog('Position', [dialog_pos_x dialog_pos_y dialog_width dialog_height], 'Name', 'Instructions');

    % Title
    uicontrol('Parent', dialog_handle, 'Style', 'text', ...
    'Position', [dialog_width / 2 - 150 dialog_height - 90 300 40], ...
        'String', 'How to move in the image', 'FontName', 'arial', ...
        'FontWeight', 'bold', 'FontSize', 10);

    % Display each keyboard button
    btn_left = 40;
    btn_middle = 75;
    btn_right = 110;
    display_key('w', btn_middle, 300, dialog_handle);
    display_key('a', btn_left, 270, dialog_handle);
    display_key('s', btn_middle, 270, dialog_handle);
    display_key('d', btn_right, 270, dialog_handle);
    display_key('q', btn_left, 200, dialog_handle);
    display_key('e', btn_right, 200, dialog_handle);
    display_key('left', btn_left, 100, dialog_handle);
    display_key('up', btn_middle, 130, dialog_handle);
    display_key('right', btn_right, 100, dialog_handle);
    display_key('down', btn_middle, 100, dialog_handle);

    % Display info text
    instruction_wasd1 = "Use W and S to rotate vertically,";
    instruction_wasd2 = "A and D to rotate horizontally";
    instruction_qe = "Use Q and E to zoom in and out";
    instruction_arrows = "Use the arrows to pan in the image";

    display_info_text(instruction_wasd1, dialog_handle, 275);
    display_info_text(instruction_wasd2, dialog_handle, 255);
    display_info_text(instruction_qe, dialog_handle, 180);
    display_info_text(instruction_arrows, dialog_handle, 95);

    % Close button
    uicontrol('Parent', dialog_handle, ...
    'Position', [dialog_width / 2 - 35 20 70 35], ...
        'String', 'Close', 'Callback', 'delete(gcf)', ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 9);

    % Wait for the dialog to close before running to completion
    uiwait(dialog_handle);

end

function display_key(char, x, y, dialog_handle)
    side_len = 30;
    ax = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [x y side_len side_len]);
    [im, alpha] = get_key_image(char);
    image(im, 'AlphaData', alpha, 'Parent', ax);
    ax.Visible = 'off';
end

function [image, alpha] = get_key_image(char)
    [image, ~, alpha] = imread(strcat('tab_3/instruction_images/', char, '.png'));
end

function display_info_text(text, handle, pos_y)
    uicontrol('Parent', handle, 'Style', 'text', ...
        'Position', [200 pos_y 200 40], ...
        'String', text, 'HorizontalAlignment', 'left', ...
        'FontName', 'arial', 'FontSize', 9);
end
