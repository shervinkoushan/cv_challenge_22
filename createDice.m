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
[back_x,back_y] = meshgrid(1:y_b,1:x_b);
back_z = zeros(x_b,y_b);

[y, x, ~] = size(top);
[top_x,top_z] = meshgrid(1:y,1:x);
top_y = zeros(x,y);

[y, x, ~] = size(bot);
[bot_x,bot_z] = meshgrid(1:y,1:x);
bot_y = x_b.* ones(x,y); 

[y, x, ~] = size(left);
[left_y,left_z] = meshgrid(1:x,1:x);
left_x = zeros(x_b,x_b);


[y, x, ~] = size(right);
[right_y,right_z] = meshgrid(1:x_b,1:x_b);
right_x = y_b.* ones(x_b,x_b);

figure
%back
warp(back_x, back_y, back_z, back);
hold on
%top
warp(top_x, top_y, top_z, top);
hold on
%bot
warp(bot_x, bot_y, bot_z, bot);
hold on
%left
warp(left_x, left_y, left_z, left);
hold on
%right
warp(right_x, right_y, right_z, right);










end