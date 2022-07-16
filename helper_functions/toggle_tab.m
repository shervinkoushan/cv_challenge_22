function toggle_tab (tab_number, enable)

    switch tab_number
        case 2
            global can_go_to_tab2;
            can_go_to_tab2 = enable;
        case 3
            global can_go_to_tab3;
            can_go_to_tab3 = enable;
    end

end
