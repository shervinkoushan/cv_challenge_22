%%   Callback for Tab Selection
function tab_selected(~, ~, selected_tab)

    % First check if we can move to this tab, if not nothing will happen
    global can_go_to_tab2;
    global can_go_to_tab3;

    if (selected_tab == 1 || (selected_tab == 2 && can_go_to_tab2) || (selected_tab == 3 && can_go_to_tab3))
       
        % The variables we need
        tab_handles = guidata(gcf);
        num_tabs = size(tab_handles, 1) - 2;
        white = tab_handles{num_tabs + 2, 2}; % White
        BGColor = tab_handles{num_tabs + 2, 3}; % Light Grey

        % Turn all tabs off
        for tab = 1:num_tabs
            set(tab_handles{tab, 1}, 'Visible', 'off');
            set(tab_handles{tab, 2}, 'BackgroundColor', BGColor);
        end

        % Enable the selected tab
        set(tab_handles{selected_tab, 1}, 'Visible', 'on');
        set(tab_handles{selected_tab, 2}, 'BackgroundColor', white);

    end

end
