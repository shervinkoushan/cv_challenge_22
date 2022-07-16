function main

    % Close everything
    close all
    clear all
    clc

    % Add these directories to the path so that we can call the functions inside
    addpath("tab_1", "tab_2", "tab_3", "helper_functions");

    % The tabs
    num_tabs = 3;
    tab_labels = {'Select image'; 'Define inner rectangle and vanishing point'; 'Move around'};

    % Avoid tab 2 and 3 being clicked when no image is selected
    toggle_tab(2, false);
    toggle_tab(3, false);

    % The screen size of the user
    screen_size = get(0, 'ScreenSize');
    monitor_max_x = screen_size(3);
    monitor_max_y = screen_size(4);

    % Constants that define the UIPanel
    scale = 0.8;
    window_max_x = round(monitor_max_x * scale);
    window_max_y = round(monitor_max_y * scale);
    x_border = (monitor_max_x - window_max_x) / 2;
    y_border = (monitor_max_y - window_max_y) / 2;
    btn_height = 40;
    panel_width = window_max_x + 4;
    panel_height = window_max_y - btn_height;
    btn_width = round((panel_width - num_tabs) / num_tabs);

    % Colors
    white = [1 1 1];
    bg_color = .9 * white;

    % Figure for the tabs
    tab_fig = figure('Units', 'pixels', 'Toolbar', 'none', ...
    'Position', [x_border, y_border, window_max_x, window_max_y], ...
        'NumberTitle', 'off', ...
        'Name', 'Computer Vision Challenge', 'MenuBar', 'none', ...
        'Resize', 'off', 'DockControls', 'off', 'Color', white);

    % Store the information we need in tab_handles
    tab_handles = cell(num_tabs, 3);
    tab_handles(:, 3) = tab_labels(:, 1);
    tab_handles{num_tabs + 1, 1} = tab_fig;
    tab_handles{num_tabs + 1, 2} = panel_width;
    tab_handles{num_tabs + 1, 3} = panel_height;
    tab_handles{num_tabs + 2, 1} = 0;
    tab_handles{num_tabs + 2, 2} = white;
    tab_handles{num_tabs + 2, 3} = bg_color;

    % Set functionality and design of tabs
    for tab = 1:num_tabs
        % The tab is a UIPanel
        tab_handles{tab, 1} = uipanel('Units', 'pixels', ...
        'Visible', 'off', 'Backgroundcolor', white, 'BorderWidth', 1, ...
            'Position', [0 0 panel_width panel_height]);

        % Button for each tab
        tab_handles{tab, 2} = uicontrol('Style', 'pushbutton', ...
        'Units', 'pixels', 'BackgroundColor', bg_color, ...
            'Position', [(tab - 1) * btn_width panel_height btn_width btn_height], ...
            'String', tab_handles{tab, 3}, 'HorizontalAlignment', 'center', ...
            'FontName', 'arial', 'FontWeight', 'bold', 'FontSize', 10);
    end

    % Callback when tab is clicked
    for tab = 1:num_tabs
        set(tab_handles{tab, 2}, 'callback', {@tab_selected, tab});
    end

    % Save tab handles in guidata
    guidata(tab_fig, tab_handles);

    % Set content for tab 1 and make this tab active
    tab1;
end
