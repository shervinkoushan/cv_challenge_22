function main

    %   First clear everything
    close all
    clear all
    clc

    % Add these directories to the path so that we can call the functions
    % inside
    addpath("tab_1", "tab_2", "tab_3", "helper_functions");

    % The tabs
    NumberOfTabs = 3;
    TabLabels = {'Select image'; 'Define inner rectangle and vanishing point'; 'Move around'};

    % Whether the user can move to these tabs
    global can_go_to_tab2;
    global can_go_to_tab3;
    can_go_to_tab2 = false;
    can_go_to_tab3 = false;

    %   Get user screen size
    SC = get(0, 'ScreenSize');
    MaxMonitorX = SC(3);
    MaxMonitorY = SC(4);

    %   Set the figure window size values
    MainFigScale = 0.8; % Change this value to adjust the figure size
    MaxWindowX = round(MaxMonitorX * MainFigScale);
    MaxWindowY = round(MaxMonitorY * MainFigScale);
    XBorder = (MaxMonitorX - MaxWindowX) / 2;
    YBorder = (MaxMonitorY - MaxWindowY) / 2;
    TabOffset = 0; % This value offsets the tabs inside the figure.
    ButtonHeight = 40;
    PanelWidth = MaxWindowX - 2 * TabOffset + 4;
    PanelHeight = MaxWindowY - ButtonHeight - 2 * TabOffset;
    ButtonWidth = round((PanelWidth - NumberOfTabs) / NumberOfTabs);

    %   Set the color varables.
    White = [1 1 1]; % White - Selected tab color
    BGColor = .9 * White; % Light Grey - Background color

    %%   Create a figure for the tabs
    hTabFig = figure( ...
    'Units', 'pixels', ...
        'Toolbar', 'none', ...
        'Position', [XBorder, YBorder, MaxWindowX, MaxWindowY], ...
        'NumberTitle', 'off', ...
        'Name', 'Computer Vision Challenge', ...
        'MenuBar', 'none', ...
        'Resize', 'off', ...
        'DockControls', 'off', ...
        'Color', White);

    %%   Define a cell array for panel and pushbutton handles, pushbuttons labels and other data
    %   rows are for each tab + two additional rows for other data
    %   columns are uipanel handles, selection pushbutton handles, and tab label strings - 3 columns.
    TabHandles = cell(NumberOfTabs, 3);
    TabHandles(:, 3) = TabLabels(:, 1);
    %   Add additional rows for other data
    TabHandles{NumberOfTabs + 1, 1} = hTabFig; % Main figure handle
    TabHandles{NumberOfTabs + 1, 2} = PanelWidth; % Width of tab panel
    TabHandles{NumberOfTabs + 1, 3} = PanelHeight; % Height of tab panel
    TabHandles{NumberOfTabs + 2, 1} = 0; % Handle to default tab 2 content(set later)
    TabHandles{NumberOfTabs + 2, 2} = White; % Selected tab Color
    TabHandles{NumberOfTabs + 2, 3} = BGColor; % Background color

    %%   Build the Tabs
    for TabNumber = 1:NumberOfTabs
        % create a UIPanel
        TabHandles{TabNumber, 1} = uipanel('Units', 'pixels', ...
        'Visible', 'off', 'Backgroundcolor', White, 'BorderWidth', 1, ...
            'Position', [TabOffset TabOffset PanelWidth PanelHeight]);

        % create a selection pushbutton
        TabHandles{TabNumber, 2} = uicontrol('Style', 'pushbutton', ...
        'Units', 'pixels', ...
            'BackgroundColor', BGColor, ...
            'Position', [TabOffset + (TabNumber - 1) * ButtonWidth PanelHeight + TabOffset ...
                ButtonWidth ButtonHeight], ...
            'String', TabHandles{TabNumber, 3}, ...
            'HorizontalAlignment', 'center', ...
            'FontName', 'arial', ...
            'FontWeight', 'bold', ...
            'FontSize', 10);
    end

    %%   Define the callbacks for the Tab Buttons
    for CountTabs = 1:NumberOfTabs
        set(TabHandles{CountTabs, 2}, 'callback', {@TabSelectCallback, CountTabs});
    end

    %%   Save the TabHandles in guidata
    guidata(hTabFig, TabHandles);

    %% Set content for tab 1
    tab1;

    %%   Make Tab 1 active
    TabSelectCallback(0, 0, 1);
end
