function show_instructions(~, ~)

    dialog_pos_x=500;
    dialog_pos_y=200;
    dialog_width=500;
    dialog_height=450;
    
    d = dialog('Position',[dialog_pos_x dialog_pos_y dialog_width dialog_height],'Name','Instructions');
       
    uicontrol('Parent',d,...
           'Style','text',...
           'Position',[dialog_width/2-150 dialog_height-90 300 40],...
           'String','How to move in the image',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 10);
        
    instruction_wasd="Use W and S to rotate vertically, A and D to rotate horizontally";
    [x,~] = imread('instruction_images/wasd.png'); 
    I2=imresize(x, [42 113]);
    uicontrol('units','pixels','position',[40 200 113 42],'cdata',I2,'Parent',d);
    uicontrol('Parent',d,'Style','text',...
           'Position',[190 200 200 40],...
           'String',instruction_wasd,...
            'FontName', 'arial',...
            'FontSize', 8);
        
    [x,~] = imread('instruction_images/qe.png'); 
    I2=imresize(x, [42 113]);
    uicontrol('units','pixels','position',[40 300 113 42],'cdata',I2,'Parent',d);
    uicontrol('Parent',d,'Style','text',...
           'Position',[190 300 200 40],...
           'String','Use Q and E to zoom in and out',...
            'FontName', 'arial',...
            'FontSize', 8);
        
    [x,~] = imread('instruction_images/arrow.png'); 
    I2=imresize(x, [42 113]);
    uicontrol('units','pixels','position',[40 100 113 42],'cdata',I2,'Parent',d);
    uicontrol('Parent',d,'Style','text',...
           'Position',[190 100 200 40],...
           'String','Use the arrows to pan in the image',...
            'FontName', 'arial',...
            'FontSize', 8);
          
    btn = uicontrol('Parent',d,...
           'Position',[dialog_width/2-35 20 70 35],...
           'String','Close',...
           'Callback','delete(gcf)',...
           'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 9);
       
    
    % Wait for d to close before running to completion
    uiwait(d);
   
end