function tab1
    tab_handles = guidata(gcf);
    num_tabs = size(tab_handles, 1) - 2;
    panel_width = tab_handles{num_tabs + 1, 2};
    panel_height = tab_handles{num_tabs + 1, 3};
    
    % Title
    uicontrol('Style', 'text', ...
    'Position', [round(panel_width / 4) panel_height-150 round(panel_width / 2) 50], ...
        'Parent', tab_handles{1, 1}, ...
        'string', "A tour into the picture", 'BackgroundColor', [1 1 1], ...
        'HorizontalAlignment', 'center', 'FontName', 'arial', ...
        'FontWeight', 'bold', 'FontSize', 16);
    
    % Example image
    scale=1.2;
    [im, ~, alpha] =imread("lib/example.png");
    ax = axes('Parent', tab_handles{1, 1}, 'Units', 'pixels', ...
    'Position', [round(panel_width/4)-100 250 round(683*scale) round(131*scale)]);
    image(im, 'AlphaData', alpha, 'Parent', ax);
    ax.Visible = 'off';
    
    
    %% Buttons at the bottom
    btn_height=40;

    % Select Image Pushbutton
    uicontrol('Parent', tab_handles{1, 1}, ...
    'Units', 'pixels', ...
        'Position', [round(panel_width / 2) - 300 3 * btn_height 200 btn_height], ...
        'String', 'Select image', 'Callback', @select_image, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 12);

    % Open Image Pushbutton
    uicontrol('Parent', tab_handles{1, 1}, 'Units', 'pixels', ...
    'Position', [round(panel_width / 2) + 100 3 * btn_height 200 btn_height], ...
        'String', 'Upload image', 'Callback', @open_image, ...
        'Style', 'pushbutton', 'HorizontalAlignment', 'center', ...
        'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 12);


    % Make tab 1 active
    tab_selected(0, 0, 1);
end
