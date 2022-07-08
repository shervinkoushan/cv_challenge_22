% Group Reperban approach

%%   Set up some varables
%   First clear everything
        close all
        clear all
        clc
        
        NumberOfTabs = 2;               % Number of tabs to be generated
        TabLabels = {'Select image'; 'Perform homography'};
        
%   Get user screen size
        SC = get(0, 'ScreenSize');
        MaxMonitorX = SC(3);
        MaxMonitorY = SC(4);
        
 %   Set the figure window size values
        MainFigScale = 0.8;          % Change this value to adjust the figure size
        MaxWindowX = round(MaxMonitorX*MainFigScale);
        MaxWindowY = round(MaxMonitorY*MainFigScale);
        XBorder = (MaxMonitorX-MaxWindowX)/2;
        YBorder = (MaxMonitorY-MaxWindowY)/2; 
        TabOffset = 0;              % This value offsets the tabs inside the figure.
        ButtonHeight = 40;
        PanelWidth = MaxWindowX-2*TabOffset+4;
        PanelHeight = MaxWindowY-ButtonHeight-2*TabOffset;
        ButtonWidth = round((PanelWidth-NumberOfTabs)/NumberOfTabs);
                
 %   Set the color varables.  
        White = [1  1  1];            % White - Selected tab color     
        BGColor = .9*White;           % Light Grey - Background color
            
%%   Create a figure for the tabs
        hTabFig = figure(...
            'Units', 'pixels',...
            'Toolbar', 'none',...
            'Position',[ XBorder, YBorder, MaxWindowX, MaxWindowY ],...
            'NumberTitle', 'off',...
            'Name', 'Computer Vision Challenge',...
            'MenuBar', 'none',...
            'Resize', 'off',...
            'DockControls', 'off',...
            'Color', White);
    
%%   Define a cell array for panel and pushbutton handles, pushbuttons labels and other data
    %   rows are for each tab + two additional rows for other data
    %   columns are uipanel handles, selection pushbutton handles, and tab label strings - 3 columns.
            TabHandles = cell(NumberOfTabs,3);
            TabHandles(:,3) = TabLabels(:,1);
    %   Add additional rows for other data
            TabHandles{NumberOfTabs+1,1} = hTabFig;         % Main figure handle
            TabHandles{NumberOfTabs+1,2} = PanelWidth;      % Width of tab panel
            TabHandles{NumberOfTabs+1,3} = PanelHeight;     % Height of tab panel
            TabHandles{NumberOfTabs+2,1} = 0;               % Handle to default tab 2 content(set later)
            TabHandles{NumberOfTabs+2,2} = White;           % Selected tab Color
            TabHandles{NumberOfTabs+2,3} = BGColor;         % Background color
            
%%   Build the Tabs
        for TabNumber = 1:NumberOfTabs
        % create a UIPanel   
            TabHandles{TabNumber,1} = uipanel('Units', 'pixels', ...
                'Visible', 'off', ...
                'Backgroundcolor', White, ...
                'BorderWidth',1, ...
                'Position', [TabOffset TabOffset ...
                PanelWidth PanelHeight]);

%Calling the gui 
%   1.Selecting a Image
%   2.Draw vanishing point and inner rectangular
%   3.Give back the values v and ir

%Take care to round the values no 12.12312 something insted 12.0
%gui ouput replaces these values:
v = [778,489];
ir = [360,970,970,360; 197,197,661,661];
im_size = [829, 1152];

%%   Define the callbacks for the Tab Buttons
%   All callbacks go to the same function with the additional argument being the Tab number
        for CountTabs = 1:NumberOfTabs
            set(TabHandles{CountTabs,2}, 'callback', ...
                {@TabSelectCallback, CountTabs});
        end

%Call function create5rect.m which gives 5 arrays for the five rectangulares
%Top, bottom, left, right and back
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);


big_im = zeros([ymax+tmargin+bmargin xmax+lmargin+rmargin cdepth]);
big_im_alpha = zeros([size(big_im,1) size(big_im,2)]);
big_im(tmargin+1:end-bmargin,lmargin+1:end-rmargin,:) = im2double(im);
big_im_alpha(tmargin+1:end-bmargin,lmargin+1:end-rmargin) = 1;

%%   Make Tab 1 active
        TabSelectCallback(0,0,1);

end
