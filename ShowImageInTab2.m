function ShowImageInTab2(file_path)
    
    %   Get TabHandles from guidata and set some varables
        TabHandles = guidata(gcf);
        NumberOfTabs = size(TabHandles,1)-2;
        PanelWidth = TabHandles{NumberOfTabs+1,2};
        PanelHeight = TabHandles{NumberOfTabs+1,3};

        persistent hImageAxes
        persistent saveButton
            
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
        imshow(I);
        hold on

    %   Make Image Tab active
        TabSelectCallback(0,0,2);
        
        
        %% Global variables
        global rectangle_pos;
        global vp_pos;
        global image_size;
        
        [dim_x,dim_y,~]=size(I);
        image_size=[dim_x dim_y];
        
       info_text= uicontrol('Style', 'text',...
        'Position', [ PanelWidth-170 300 150 100 ],...
        'Parent', TabHandles{2,1}, ...
        'BackgroundColor', [1 1 1],...
        'string', 'Draw the inner rectangle',...
        'HorizontalAlignment', 'center',...
        'FontName', 'arial',...
        'FontWeight', 'bold',...
        'FontSize', 11);
        
        %% Background rectangle
        rectangle = drawrectangle('StripeColor','y');
        rectangle_pos=rectangle.Position;
        rectangle.Label = 'Inner rectangle';
        addlistener(rectangle,'ROIMoved',@rectangle_moved);
        hold on
        
        %% Vanishing point
        set(info_text,'string',"Select the vanishing point");
        vanishing_point=drawpoint('Color','r');
        vp_pos=vanishing_point.Position;
        vanishing_point.Label = 'Vanishing point';
        addlistener(vanishing_point,'ROIMoved',@vp_moved);
                
        set(info_text,'string',"Make adjustments and save when you are finished");

        %% Save button
         saveButton=uicontrol('Parent', TabHandles{2,1}, ...
            'Units', 'pixels', ...
            'Position', [PanelWidth-140 ImgOffset 100 40], ...
            'String', 'Save', ...
            'Callback', @save , ...
            'Style', 'pushbutton',...
            'HorizontalAlignment', 'center',...
            'FontName', 'arial',...
            'FontWeight', 'bold',...
            'FontSize', 11);

       
end

% P1 upper left, P2 upper right, P3 bottom right, P4 buttom left
function [x_array, y_array] = x_y_from_rect_pos(position)
    x_min=position(1);
    y_min=position(2);
    width=position(3);
    height=position(4);
    x_array=[x_min x_min+width x_min+width x_min];
    y_array=[y_min y_min y_min+height y_min+height];
end
       
function rectangle_moved(~,evt)
    global rectangle_pos;
    rectangle_pos=evt.CurrentPosition;  
end

function vp_moved(~,evt)
    global vp_pos;
    vp_pos=evt.CurrentPosition; 
end

function save(~, ~)
      global rectangle_pos;
      global vp_pos;
      global image_size;
      % TODO round values
     [inner_rect_x,inner_rect_y]=x_y_from_rect_pos(rectangle_pos);
      backend(vp_pos,[inner_rect_x;inner_rect_y],image_size);
end