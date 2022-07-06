function [new_img] = createDice(top, left, right, bot, back)
[Y_1 ,X_1] = imsize(top);
[Y_2 ,X_2] = imsize(left);
[Y_3 ,X_3] = imsize(right);
[Y_4 ,X_4] = imsize(bot);
[Y_5 ,X_5] = imsize(back);

new_img = zeros(X_2 + X_3 + X_5, Y_1 + Y_5 + Y_4);

new_img(X_2:X1+X_2,0:Y_1) = top;

new_img(0:X_2,Y_1:Y_1+Y_2) = left;

new_img(X_1+X_2:X_1+X_2+X_3, Y_1:Y_1+Y_3) = right;

new_img(X_2:X_2+X_4, Y_1+Y_2:Y_1+Y_2+Y_4) = bot;

new_img(X_2:X_2+X_5, Y_1:Y_1+Y_5) = bot;


end