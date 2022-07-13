function [bigim, back_b, top_b, bot_b, left_b, right_b] = createBigim(back, top, bot, left, right, im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
minyval = [top(2,:), left(2,:), right(2,:)];
maxyval = [bot(2,:), left(2,:), right(2,:)];

[ymax, xmax, depth] = size(im);

negymarg = -min(minyval);
posymarg = max(maxyval) - ymax;

minxval = [top(1,:), left(1,:), bot(1,:)];
maxxval = [top(1,:), right(1,:), bot(1,:)];

negxmarg = -min(minxval);
posxmarg = max(maxxval) - xmax;


bigim = zeros(negymarg + posymarg + ymax, negxmarg + posxmarg + xmax, depth);

bigim(negymarg+1:negymarg+ymax,negxmarg+1:xmax+negxmarg, :) = im2double(im);

back_b = back;
top_b = top;
bot_b = bot;
left_b = left;
right_b = right;


back_b(1,:) = back(1,:) + negxmarg;
back_b(2,:) = back(2,:) + negymarg;

top_b(1,:) = top(1,:) + negxmarg;
top_b(2,:) = top(2,:) + negymarg;

bot_b(1,:) = bot(1,:) + negxmarg;
bot_b(2,:) = bot(2,:) + negymarg;

left_b(1,:) = left(1,:) + negxmarg;
left_b(2,:) = left(2,:) + negymarg;

right_b(1,:) = right(1,:) + negxmarg;
right_b(2,:) = right(2,:) + negymarg;

end