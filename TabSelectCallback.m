%%   Callback for Tab Selection
function TabSelectCallback(~, ~, SelectedTab)

    % First check if we can move to this tab, if not nothing will happen
    global can_go_to_tab2;
    global can_go_to_tab3;

    if (SelectedTab==1 || (SelectedTab==2 && can_go_to_tab2) || (SelectedTab==3 && can_go_to_tab3))
    %   All tab selection pushbuttons are greyed out and uipanels are set to
    %   visible off, then the selected panel is made visible and it's selection
    %   pushbutton is highlighted.

    %   Set up some varables
    TabHandles = guidata(gcf);
    NumberOfTabs = size(TabHandles, 1) - 2;
    White = TabHandles{NumberOfTabs + 2, 2}; % White
    BGColor = TabHandles{NumberOfTabs + 2, 3}; % Light Grey
    
    

    %   Turn all tabs off
    for TabCount = 1:NumberOfTabs
        set(TabHandles{TabCount, 1}, 'Visible', 'off');
        set(TabHandles{TabCount, 2}, 'BackgroundColor', BGColor);
    end

    %   Enable the selected tab
    set(TabHandles{SelectedTab, 1}, 'Visible', 'on');
    set(TabHandles{SelectedTab, 2}, 'BackgroundColor', White);
    
    end

end
