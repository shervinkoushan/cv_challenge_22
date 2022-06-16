function main

%%   Set up some varables
%   First clear everything
        clear all
        clc
        
        NumberOfTabs = 2;               % Number of tabs to be generated
        TabLabels = {'Select image'; 'Perform homography'};
        
%   Get user screen size
        SC = get(0, 'ScreenSize');
        MaxMonitorX = SC(3);
        MaxMonitorY = SC(4);
        
 %   Set the figure window size values
        MainFigScale = .7;          % Change this value to adjust the figure size
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

        % create a selection pushbutton
            TabHandles{TabNumber,2} = uicontrol('Style', 'pushbutton',...
                'Units', 'pixels', ...
                'BackgroundColor', BGColor, ...
                'Position', [TabOffset+(TabNumber-1)*ButtonWidth PanelHeight+TabOffset...
                    ButtonWidth ButtonHeight], ...          
                'String', TabHandles{TabNumber,3},...
                'HorizontalAlignment', 'center',...
                'FontName', 'arial',...
                'FontWeight', 'bold',...
                'FontSize', 10);

        end

%%   Define the callbacks for the Tab Buttons
%   All callbacks go to the same function with the additional argument being the Tab number
        for CountTabs = 1:NumberOfTabs
            set(TabHandles{CountTabs,2}, 'callback', ...
                {@TabSellectCallback, CountTabs});
        end

%%   Define content for the Open Image File Tab
    %   Open Image Pushbutton
        uicontrol('Parent', TabHandles{1,1}, ...
            'Units', 'pixels', ...
            'Position', [round(PanelWidth/2)-100 2*ButtonHeight 200 ButtonHeight], ...
            'String', 'Upload image', ...
            'Callback', @OpenImageCallback , ...
            'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 12);
 
    %   Build the text for the first tab
        Intro = {'Computer vision challenge';};
        
    %   Display it
        uicontrol('Style', 'text',...
            'Position', [ round(PanelWidth/4) 3*ButtonHeight ...
                round(PanelWidth/2) round(PanelHeight/2) ],...
            'Parent', TabHandles{1,1}, ...
            'string', Intro,...
            'BackgroundColor', White,...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 14);
    
%%   Define default content for the Image Tab
    %   Build default text for the Image tab
        Intro = {'Use the Open Image Tab to display an image here'};

    %   Display it - Put the handle in TabHandles so that it can be deleted later 
        TabHandles{NumberOfTabs+2,1} = uicontrol('Style', 'text',...
            'Position', [ round(PanelWidth/4) 3*ButtonHeight ...
                round(PanelWidth/2) round(PanelHeight/2) ],...
            'Parent', TabHandles{2,1}, ...
            'string', Intro,...
            'BackgroundColor', White,...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 14);
	  

%%   Save the TabHandles in guidata
        guidata(hTabFig,TabHandles);

%%   Make Tab 1 active
        TabSellectCallback(0,0,1);

end
%%   Callback for Tab Selection
function TabSellectCallback(~,~,SelectedTab)
%   All tab selection pushbuttons are greyed out and uipanels are set to
%   visible off, then the selected panel is made visible and it's selection
%   pushbutton is highlighted.

    %   Set up some varables
        TabHandles = guidata(gcf);
        NumberOfTabs = size(TabHandles,1)-2;
        White = TabHandles{NumberOfTabs+2,2};            % White      
        BGColor = TabHandles{NumberOfTabs+2,3};          % Light Grey
        
    %   Turn all tabs off
        for TabCount = 1:NumberOfTabs
            set(TabHandles{TabCount,1}, 'Visible', 'off');
            set(TabHandles{TabCount,2}, 'BackgroundColor', BGColor);
        end
        
    %   Enable the selected tab
        set(TabHandles{SelectedTab,1}, 'Visible', 'on');        
        set(TabHandles{SelectedTab,2}, 'BackgroundColor', White);

end

%%   Open Image File Callback
    function OpenImageCallback(~,~)
    
    %   Get TabHandles from guidata and set some varables
        TabHandles = guidata(gcf);
        NumberOfTabs = size(TabHandles,1)-2;
        PanelWidth = TabHandles{NumberOfTabs+1,2};
        PanelHeight = TabHandles{NumberOfTabs+1,3};

    %   Two persistent varables are needed
        persistent StartPicDirectory hImageAxes
        
    %   Initilize the StartPicDirectory if first time through
        if isempty(StartPicDirectory)
            StartPicDirectory = cd;
        end
    
    %   Get the file name from the user
        [PicNameWithTag, PicDirectory] = uigetfile({'*.jpg;*.tif;*.png','Image Files'},...
            'Select an image file',StartPicDirectory);

        if PicNameWithTag == 0,
            %   If User canceles then display error message
                errordlg('You should select an Image File');
            return
        end
        
    %   Set the default directory to the currently selected directory
        StartPicDirectory = PicDirectory;

    %   Build path to file
        PicFilePath = strcat(PicDirectory,PicNameWithTag);
            
    %   Load the image
        InitPicRGB = imread(PicFilePath);

    % Get handle of default panel content
        h1 = TabHandles{size(TabHandles,1),1};
        
    %   Delete the previous panel content
        if ishandle(h1)
            delete(h1);             % Delete the default content
        else
            delete(hImageAxes);     % Delete the previous image
        end
        
    %   Set the axes and display the image    
        ImgOffset = 40;
        hImageAxes = axes('Parent', TabHandles{2,1}, ...
            'Units', 'pixels', ...
            'Position', [ImgOffset ImgOffset ...
                PanelWidth-2*ImgOffset PanelHeight-2*ImgOffset]);
            
        image(InitPicRGB,'Parent', hImageAxes);

    %   Make Image Tab active
        TabSellectCallback(0,0,2);
    
    end
       