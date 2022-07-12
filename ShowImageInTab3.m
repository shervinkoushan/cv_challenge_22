function ShowImageInTab3(back_rec, top_rec, bottom_rec, left_rec, right_rec, I)


    
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
            delete(saveButton);     % Delete the save button
        end
        
    %   Set the axes and display the image    
        ImgOffset = 40;
        hImageAxes = axes('Parent', TabHandles{2,1}, ...
            'Units', 'pixels', ...
            'Position', [ImgOffset ImgOffset ...
                PanelWidth-2*ImgOffset PanelHeight-2*ImgOffset]);
        [bigim, back_b, top_b, bot_b, left_b, right_b] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, I);
        imshow(bigim);
        imshow(I);
        hold on

    %   Make Image Tab active
        TabSelectCallback(0,0,3);
        
       
        

       
end
