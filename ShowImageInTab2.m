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
            
        %image(I,'Parent', hImageAxes);
        
        
        imshow(I);
        hold on
        %axis on

    %   Make Image Tab active
        TabSelectCallback(0,0,2);
        
        %% Background rectangle
        rectangle = drawrectangle('StripeColor','y');
        rectangle_pos = customWait(rectangle)
        hold on
        
        %% Vanishing point
        vanishing_point=drawpoint();
        vp_pos=customWait(vanishing_point)


end
       

%% From https://de.mathworks.com/help/images/use-wait-function-after-drawing-roi-example.html
function pos = customWait(hROI)

% Listen for mouse clicks on the ROI
l = addlistener(hROI,'ROIClicked',@clickCallback);

% Block program execution
uiwait;

% Remove listener
delete(l);

% Return the current position
pos = hROI.Position;

end

function clickCallback(~,evtData)
   position = evtData.Source.Position

if strcmp(evtData.SelectionType,'double')
    uiresume;
end

end