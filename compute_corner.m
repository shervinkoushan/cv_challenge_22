function [corX,corY] = compute_corner(x1,y1,x2,y2,edgeX,edgeY)
% y = mx+b
m = (y1-y2)/(x1-x2);
b = y1-m*x1;

tempX = (edgeY-b)/m;
tempY = m*edgeX+b;

if(abs(tempX-x1) < abs(edgeX-x1))
    corX = tempX;
    corY = edgeY;
else    
    corX = edgeX;
    corY = tempY;
end  
end
