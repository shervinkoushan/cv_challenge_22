function ShowImageInTab3(file_path,back_rec, top_rec, bottom_rec, left_rec, right_rec, d)  
  
    %   Get TabHandles from guidata and set some varables
        TabHandles = guidata(gcf);
        NumberOfTabs = size(TabHandles,1)-2;
        PanelWidth = TabHandles{NumberOfTabs+1,2};
        PanelHeight = TabHandles{NumberOfTabs+1,3};

        persistent hImageAxes
            
    %   Load the image
        I = imread(file_path);

    % Get handle of default panel content
        h1 = TabHandles{size(TabHandles,1),1};
        
    %   Delete the previous panel content
        if ishandle(h1)
            delete(h1);             % Delete the default content
        else
            delete(hImageAxes);     % Delete the previous image
        end
        
            %   Make Image Tab active
        TabSelectCallback(0,0,3);
        
    %   Set the axes and display the image    
        ImgOffset = 40;
        hImageAxes = axes('Parent', TabHandles{3,1}, ...
            'Units', 'pixels', ...
            'Position', [ImgOffset ImgOffset ...
                PanelWidth-2*ImgOffset PanelHeight-2*ImgOffset]);
        hold on;
        [back_plane, top_plane, bottom_plane, left_plane, right_plane] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, I, d);
       
        %% Create flat dice 
        [new_img] = createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);
        
        set(TabHandles{NumberOfTabs+1,1},'WindowKeyPressFcn',@keyPressCallback);

        
         %% Instructions button
         uicontrol('Parent', TabHandles{3,1}, ...
            'Units', 'pixels', ...
            'Position', [PanelWidth-140 400 100 40], ...
            'String', 'Instructions', ...
            'Callback', @show_instructions , ...
            'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 11);

end

function show_instructions(~, ~)

    dialog_pos_x=500;
    dialog_pos_y=200;
    dialog_width=500;
    dialog_height=450;
    
    d = dialog('Position',[dialog_pos_x dialog_pos_y dialog_width dialog_height],'Name','Instructions');
       
    txt = uicontrol('Parent',d,...
           'Style','text',...
           'Position',[dialog_width/2-150 dialog_height-90 300 40],...
           'String','How to move in the image',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 10);
 
    
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

 function keyPressCallback(~,eventdata)
    
      % set camera step
    dolly_stepx = 0.05;
    dolly_stepy = 0.05;
    dolly_stepz = 0.05;
    key = eventdata.Key;
      switch key
        case 'd'
            camdolly(-dolly_stepx,0,0,'fixtarget');
        case 'a'
            camdolly(dolly_stepx,0,0,'fixtarget');
        case 's'
            camdolly(0,dolly_stepy,0,'fixtarget');
        case 'w'
            camdolly(0,-dolly_stepy,0,'fixtarget');
        case 'q'
            camdolly(0,0,dolly_stepz,'fixtarget');
        case 'e'
            camdolly(0,0,-dolly_stepz,'fixtarget');
        case 'leftarrow'
            tarx=tarx+tar_stepx;
            camdolly(-dolly_stepx,0,0);
        case 'rightarrow'
            tarx=tarx-tar_stepx;
            camdolly(dolly_stepx,0,0);
        case 'uparrow'
            tary=tary+tar_stepy;
            camdolly(0,dolly_stepy,0);
        case 'downarrow'
            tary=tary-tar_stepy;
            camdolly(0,-dolly_stepy,0);
      end
      
      position_updated
 end
  
 function position_updated
    global x_b;
    global y_b;
    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
    cam_p=campos;
    
    top_visible='on';
    bot_visible='on';
    left_visible='on';
    right_visible='on';
    if cam_p(2)<0
      top_visible='off';
    end
    if cam_p(2)>y_b
      bot_visible='off';
    end
    if cam_p(1)<0
      left_visible='off';
    end
    if cam_p(1)>x_b
      right_visible='off';
    end
    
    set(top_warp,'visible',top_visible)
    set(bot_warp,'visible',bot_visible)
    set(left_warp,'visible',left_visible)
    set(right_warp,'visible',right_visible)

 end