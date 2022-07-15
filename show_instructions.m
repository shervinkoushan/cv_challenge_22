function show_instructions(~, ~)

    % The dialog
    dialog_pos_x=500;
    dialog_pos_y=200;
    dialog_width=500;
    dialog_height=450; 
    
    dialog_handle = dialog('Position',[dialog_pos_x dialog_pos_y dialog_width dialog_height],'Name','Instructions');
       
    % Title
    uicontrol('Parent',dialog_handle,...
           'Style','text',...
           'Position',[dialog_width/2-150 dialog_height-90 300 40],...
           'String','How to move in the image' ,...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 10);
       
    % axes for each keyboard button
    btn_len=30;
    btn_left=40;
    btn_middle=75;
    btn_right=110;
    axes_w = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_middle 300 btn_len btn_len]);
    axes_a = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_left 270 btn_len btn_len]);
    axes_s = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_middle 270 btn_len btn_len]);
    axes_d = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_right 270 btn_len btn_len]);    
    axes_q = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_left 200 btn_len btn_len]);    
    axes_e = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_right 200 btn_len btn_len]);    
    axes_left = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_left 100 btn_len btn_len]);    
    axes_up = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_middle 130 btn_len btn_len]);    
    axes_right = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_right 100 btn_len btn_len]);    
    axes_down = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [btn_middle 100 btn_len btn_len]);    

    % The buttons
    [w,alpha_w] = get_key_image('w');
    [a,alpha_a] = get_key_image('a');
    [s,alpha_s] = get_key_image('s');
    [d,alpha_d] = get_key_image('d');
    [q,alpha_q] = get_key_image('q');
    [e,alpha_e] = get_key_image('e');
    [left,alpha_left] = get_key_image('left');
    [right,alpha_right] = get_key_image('right');
    [down,alpha_down] = get_key_image('down');
    [up,alpha_up] = get_key_image('up');

    
    
    % Display the buttons
    image(w,'AlphaData',alpha_w,'Parent',axes_w);
    image(a,'AlphaData',alpha_a,'Parent',axes_a);
    image(s,'AlphaData',alpha_s,'Parent',axes_s);
    image(d,'AlphaData',alpha_d,'Parent',axes_d);
    image(q,'AlphaData',alpha_q,'Parent',axes_q);
    image(e,'AlphaData',alpha_e,'Parent',axes_e);
    image(left,'AlphaData',alpha_left,'Parent',axes_left);
    image(down,'AlphaData',alpha_down,'Parent',axes_down);
    image(up,'AlphaData',alpha_up,'Parent',axes_up);
    image(right,'AlphaData',alpha_right,'Parent',axes_right);



   % Display info text
    instruction_wasd="Use W and S to rotate vertically, A and D to rotate horizontally";
    instruction_qe="Use Q and E to zoom in and out";
    instruction_arrows="Use the arrows to pan in the image";
    
    display_info_text(instruction_wasd,dialog_handle, 275);
    display_info_text(instruction_qe,dialog_handle, 180);
    display_info_text(instruction_arrows,dialog_handle, 95);
       
    % Close button
    uicontrol('Parent',dialog_handle,...
           'Position',[dialog_width/2-35 20 70 35],...
           'String','Close',...
           'Callback','delete(gcf)',...
           'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 9);
       
    % Hide all axes (must be done after image has been set)
    axes_w.Visible='off';
    axes_a.Visible='off';
    axes_s.Visible='off';
    axes_d.Visible='off';
    axes_q.Visible='off';
    axes_e.Visible='off';
    axes_left.Visible='off';
    axes_right.Visible='off';
    axes_up.Visible='off';
    axes_down.Visible='off';

        
    
% Wait for d to close before running to completion
    uiwait(dialog_handle);
   
end

function [image, alpha]=get_key_image(button)
    [image,~,alpha] = imread(strcat('instruction_images/',button,'.png')); 
end

function display_info_text(text,handle, pos_y)
    uicontrol('Parent',handle,'Style','text',...
           'Position',[190 pos_y 200 40],...
           'String',text,...
            'FontName', 'arial',...
            'FontSize', 8);
end