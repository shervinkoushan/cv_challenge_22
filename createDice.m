function [new_img] = createDice(top, left, right, bot, back)
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


end