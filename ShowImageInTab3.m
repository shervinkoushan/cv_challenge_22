function ShowImageInTab3(file_path)

        global back_rec;
        global top_rec;
        global bottom_rec;
        global left_rec;
        global right_rec;
  
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
        [back_plane, top_plane, bottom_plane, left_plane, right_plane] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, I);
       
        %% Create flat dice 
        [new_img] = createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);
        
        rotate3d(hImageAxes)
end
