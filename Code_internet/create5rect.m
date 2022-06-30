%Function has as input:
%1. vanishing point van_point
%2. inner rectangular inner_rec
%3. outer rectangular outer_rec

%With this 9 points the 5 rectuangulars are calculated 
%Starting point of the rectangular is always top left corner 

function [back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im, van_point, inner_rec, outer_rec)
%CREAT5RECT Summary of this function goes here
%   Detailed explanation goes here


%calculate the the 5 rectegulars: top_rec, bottom_rec, left_rec, right_rec,
%back_rec
[ymax,xmax,cdepth] = size(im);
ymin = 0;
xmin = 0;

%back_rec
back_rec = inner_rec;

%Top rectangular 
top_rec_x = [outer_rec(1,1), outer_rec(1,2), inner_rec(1,2), inner_rec(1,1)];
top_rec_y = [outer_rec(2,1), outer_rec(2,2), inner_rec(2,2), inner_rec(2,1)];
if(top_rec_y(1) ~= ymin)
    top_rec_x(1) = line_intersection_x(van_point, inner_rec(:,1), ymin);
    top_rec_y(1) = ymin;
end
if(top_rec_y(2) ~= ymin)
    top_rec_x(2) = line_intersection_x(van_point, inner_rec(:,2), ymin);
    top_rec_y(2) = ymin;
end
top_rec = [top_rec_x; top_rec_y];

%bottom rectangular 
bottom_rec_x = [inner_rec(1,3), inner_rec(1,4), outer_rec(1,3), outer_rec(1,4)];
bottom_rec_y = [inner_rec(2,3), inner_rec(2,4), outer_rec(2,3), outer_rec(2,4)];
if(bottom_rec_y(3) ~= ymax)
    bottom_rec_x(3) = line_intersection_x(van_point, inner_rec(:,3), ymax);
    bottom_rec_y(3) = ymax;
end
if(bottom_rec_y(4) ~= ymax)
    bottom_rec_x(4) = line_intersection_x(van_point, inner_rec(:,4), ymax);
    bottom_rec_y(4) = ymax;
end
bottom_rec = [bottom_rec_x; bottom_rec_y];

%left rectangular
left_rec_x = [outer_rec(1,1), inner_rec(1,1), inner_rec(1,4), outer_rec(1,4)];
left_rec_y = [outer_rec(2,1), inner_rec(2,1), inner_rec(2,4), outer_rec(2,4)];
if(left_rec_x(1) ~= xmin)
    left_rec_y(1) = line_intersection_y(van_point, inner_rec(:,1), xmin);
    left_rec_x(1) = xmin;
end
if(left_rec_x(4) ~= xmin)
    left_rec_y(4) = line_intersection_y(van_point, inner_rec(:,4), xmin);
    left_rec_x(4) = xmin;
end
left_rec = [left_rec_x; left_rec_y];


%right rectangular
right_rec_x = [inner_rec(1,1), outer_rec(1,2), outer_rec(1,3), inner_rec(1,3)];
right_rec_y = [inner_rec(2,1), outer_rec(2,2), outer_rec(2,3), inner_rec(2,3)];
if(right_rec_x(2) ~= xmax)
    right_rec_y(2) = line_intersection_y(van_point, inner_rec(:, 2), xmax);
    right_rec_x(2) = xmax;
end
if(right_rec_x(3) ~= xmax)
    right_rec_y(3) = line_intersection_y(van_point, inner_rec(:,3), xmax);
    right_rec_x(3) = xmax;
end
right_rec = [right_rec_x; right_rec_y];



end

