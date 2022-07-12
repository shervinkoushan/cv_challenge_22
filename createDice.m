function [new_img] = createDice(back, top, bot, left, right)
[Y_1 ,X_1, Z] = size(top);
[Y_2 ,X_2, ~] = size(left);
[Y_3 ,X_3, ~] = size(right);
[Y_4 ,X_4, ~] = size(bot);
[Y_5 ,X_5, ~] = size(back);

new_img = zeros(Y_1 + Y_5 + Y_4, X_2 + X_3 + X_5, Z);

new_img(1:Y_1, X_2:(X_1+X_2)-1, :) = im2double(top);

new_img(Y_1:(Y_1+Y_2)-1, 1:X_2, :) = im2double(left);

new_img(Y_1:(Y_1+Y_3)-1, (X_1+X_2):(X_1+X_2+X_3)-1, :) = im2double(right);

new_img((Y_1+Y_2):(Y_1+Y_2+Y_4)-1, X_2:(X_2+X_4)-1, :) = im2double(bot);

new_img(Y_1:(Y_1+Y_5)-1, X_2:(X_2+X_5)-1, :) = im2double(back);

[y_b, x_b, ~] = size(back);
[back_x,back_y] = meshgrid(1:x_b,1:y_b);
back_z = zeros(y_b,x_b);

[y, x, ~] = size(top);
[top_x,top_z] = meshgrid(1:x,1:y);
top_y = zeros(y,x);
top = imrotate(top, 180);

[y, x, ~] = size(bot);
[bot_x,bot_z] = meshgrid(1:x,1:y);
bot_y = y_b.* ones(y,x); 

[y, x, ~] = size(left);
[left_y,left_z] = meshgrid(1:y,1:x);
left_x = zeros(x,y);
left = imrotate(left, 90);


[y, x, ~] = size(right);
[right_y,right_z] = meshgrid(1:x,1:y);
right_x = x_b.* ones(x,x);
% view = figure('name','3DViewer: Directions[W-S-A-D] Zoom[Q-E] Exit[ESC]');
% set(view,'windowkeypressfcn','set(gcbf,''Userdata'',get(gcbf,''CurrentCharacter''))') ;
% set(view,'windowkeyreleasefcn','set(gcbf,''Userdata'','''')') ;
% set(view,'Color','black')
% hold on



%figure
%imshow(new_img);

figure
hold on

warp(back_x, back_y, back_z, back);

warp(top_x, top_y, top_z, top);

%bot
%warp(bot_x, bot_y, bot_z, bot);

%left
warp(left_x, left_y, left_z, left);


%right
%warp(right_x, right_y, right_z, right);


% axis equal;  % make X,Y,Z dimentions be equal
% axis vis3d;  % freeze the scale for better rotations
% axis off;    % turn off the stupid tick marks
% camproj('perspective');  % make it a perspective projection
% 
% % set camera position
% camx = 60;
% camy = 145;
% camz = 38.8;
% 
% % set camera target
% tarx = 28.5;
% tary = 112;
% tarz = 117.5;
% 
% % set camera step
% stepx = 0.05;
% stepy = 0.05;
% stepz = 0.05;
% 
% % set camera on ground
% camup([0,0,1]);
% campos([camx camy camz]);
% 
% key = 0;
% while (~key),
%     waitforbuttonpress;
%     key = get(view, 'currentch');
%     
%     switch key
%         case 'd'
%             camdolly(-stepx,0,0,'fixtarget');
%         case 'a'
%             camdolly(stepx,0,0,'fixtarget');
%         case 's'
%             camdolly(0,stepy,0,'fixtarget');
%         case 'w'
%             camdolly(0,-stepy,0,'fixtarget');
%         case 'q'
%             camdolly(0,0,stepz,'fixtarget');
%         case 'e'
%             camdolly(0,0,-stepz,'fixtarget');
% 
%         case 'b'
%             break;
%     end
%     
%     key = 0;
% 
%     pause(.001);
% 
%     %campos([camx camy camz]);
%     %camtarget([tarx tary tarz]);
%     pos = campos;
%     target = camtarget;
%     
% end










end
