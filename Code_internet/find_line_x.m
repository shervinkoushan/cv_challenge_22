% given two points (x1,y1) and (y1,y2) and a value of x, find y that 
% makes (x,y) belong to the line.
function x = find_line_x(x1,y1,x2,y2,y);

m = (y1-y2)./(x1-x2);
b = y1 - m*x1;
x = (y-b)/m;