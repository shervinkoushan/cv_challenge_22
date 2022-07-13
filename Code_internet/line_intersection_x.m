function [x] = line_intersection_x(van_point_xy,inner_rec_xy, y_inn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m = (inner_rec_xy(2) - van_point_xy(2))./(inner_rec_xy(1) - van_point_xy(1));
b = inner_rec_xy(2) - m * inner_rec_xy(1);

y = y_inn;
x = round((y - b)/m);
end