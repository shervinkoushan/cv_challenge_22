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
    axes_w = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [75 330 btn_len btn_len]);
    axes_a = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [40 300 btn_len btn_len]);
    axes_s = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [75 300 btn_len btn_len]);
    axes_d = axes('Parent', dialog_handle, 'Units', 'pixels', 'Position', [110 300 btn_len btn_len]);    
    
    % The buttons
    [w,alpha_w] = get_key_image('w');
    [a,alpha_a] = get_key_image('a');
    [s,alpha_s] = get_key_image('s');
    [d,alpha_d] = get_key_image('d');
    [q,alpha_q] = get_key_image('q');
    [e,alpha_e] = get_key_image('e');
    
    
    % Display the buttons
    image(w,'AlphaData',alpha_w,'Parent',axes_w);
    image(a,'AlphaData',alpha_a,'Parent',axes_a);
    image(s,'AlphaData',alpha_s,'Parent',axes_s);
    image(d,'AlphaData',alpha_d,'Parent',axes_d);

   % Display info text
    instruction_wasd="Use W and S to rotate vertically, A and D to rotate horizontally";
    instruction_qe="Use Q and E to zoom in and out";
    instruction_arrows="Use the arrows to pan in the image";
    
    display_info_text(instruction_wasd,dialog_handle, 300);
    display_info_text(instruction_qe,dialog_handle, 200);
    display_info_text(instruction_arrows,dialog_handle, 100);
       
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