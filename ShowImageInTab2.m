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
        roi = drawrectangle('StripeColor','y');
        pos = customWait(roi)
        


%         [rx, ry] = ginput(2) %origin is at top left corner (rx has x,y coordinates of the point)
%         plot(rx,ry,'*')
% 
%         %% draw the rectangle
% 
%         hold on;
%         irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
%         iry =  round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
%         plot(irx,iry,'b'); 
%         hold off;
%         
%         %% get vanishing point
%         [max_y, max_x, c] = size(I);
%         [vx, vy, button] = ginput(1); 
% 
%         if ~(isempty(button))
%             vp_x = vx(1); vp_y=vy(1);
% 
% 
%             cpx = [0 0 0 0];
%             cpy = [0 0 0 0];
%             [cpx(1), cpy(1)] = compute_corner(vp_x, vp_y, irx(1), iry(1), 1, 1); 
%             [cpx(2), cpy(2)] = compute_corner(vp_x, vp_y, irx(2), iry(2), max_x, 1); 
%             [cpx(3), cpy(3)] = compute_corner(vp_x, vp_y, irx(3), iry(3), max_x, max_y); 
%             [cpx(4), cpy(4)] = compute_corner(vp_x, vp_y, irx(4), iry(4), 1, max_y); 
% 
% 
%             imshow(I);
%             hold on;
%             plot(irx,iry,'b'); 
%             plot([vp_x cpx(1)],[vp_y cpy(1)],'r');
%             plot([vp_x cpx(2)],[vp_y cpy(2)],'r');
%             plot([vp_x cpx(3)],[vp_y cpy(3)],'r');
%             plot([vp_x cpx(4)],[vp_y cpy(4)],'r');
%             hold off;
%             
%             %% Call backend function (vp_x, vp_y), irx, iry
%     end


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