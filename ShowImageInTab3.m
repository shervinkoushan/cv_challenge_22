function ShowImageInTab3(file_path)

        global back_rec;
        global top_rec;
        global bottom_rec;
        global left_rec;
        global right_rec;
        global d
  
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


end

 function keyPressCallback(~,eventdata)
 
    global tarx;
    global tary;
    global tarz;
    
    tar_stepx = 1.0;
    tar_stepy = 1.0;
    
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
            camtarget([tarx tary tarz]);
        case 'rightarrow'
            tarx=tarx-tar_stepx;
            camtarget([tarx tary tarz]);
        case 'uparrow'
            tary=tary+tar_stepy;
            camtarget([tarx tary tarz]);
        case 'downarrow'
            tary=tary-tar_stepy;
            campos([tarx tary tarz]);
      end
      
      position_updated
 end
  
 function position_updated
 global x_b;
 cam_t=camtarget
 cam_p=campos
    global top_warp;
    global bot_warp;
    global left_warp;
    global right_warp;
  if cam_p(1)>x_b
        set(right_warp,'visible','off')

  end
 end