function ShowImageInTab2(file_path)
    
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
        
    %   Set the axes and display the image    
        ImgOffset = 40;
        hImageAxes = axes('Parent', TabHandles{2,1}, ...
            'Units', 'pixels', ...
            'Position', [ImgOffset ImgOffset ...
                PanelWidth-2*ImgOffset PanelHeight-2*ImgOffset]);
            
        image(I,'Parent', hImageAxes);
        
       % imshow(I);
        hold on
        axis on

    %   Make Image Tab active
        TabSelectCallback(0,0,2);
        
        [rx, ry] = ginput(2) %origin is at top left corner (rx has x,y coordinates of the point)
        plot(rx,ry,'*')

        %% draw the rectangle

        hold on;
        irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
        iry =  round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
        plot(irx,iry,'b'); 
        hold off;

end
       