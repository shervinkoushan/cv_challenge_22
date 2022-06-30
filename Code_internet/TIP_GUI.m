% 15-463, Computational Photography
% Project 4, Sample code by Alyosha Efros (likely buggy!)
%
% Tour Into The Picture Matlab GUI interface
%
% Given an image, lets the user pick the "inner rectangle" 
% and the vanishing point. The user must first click on the upper
% left corner of the rectangle, then the lower right corner.  Then,
% click on the vanishing point until you are satisfied.  When done, hit
% "ENTER".  
% The function returns the vanishing point (vx,vy) and the coordinates of
% the inner rectangle and the outer polygon.
function [vx, vy, irx, iry, orx, ory] = TIP_GUI(im);

[ymax,xmax,cdepth] = size(im);

im_size = size(im);

imshow(im);

% get the upper left and lower right corner of the inner rectangle
[rx,ry] = ginput(2);

% draw the rectangle
hold on;
irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
iry =  round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
plot(irx,iry,'b'); 
hold off;

% loop to get the user to specify the vanishing point
while 1,
  
  % get the vanishing point
  [vxnew,vynew,button] = ginput(1);

  % if pressed ENTER, quit the loop
  if (isempty(button)),
    break;
  end;
  vx = vxnew; vy=vynew;
  
  ir_xy = [irx; iry];
  v_xy = [vx, vy];

  or_xy = outer_rectangle(v_xy, ir_xy, im_size);

  orx = round(or_xy(1,:));
  ory = round(or_xy(2,:));

  % find where the line from VP thru inner rectangle hits the edge of image
%   [ox,oy] = find_corner(vx,vy,irx(1),iry(1),0,0);
%   orx(1) = ox;  ory(1) = oy;
%   [ox,oy] = find_corner(vx,vy,irx(2),iry(2),xmax,0);
%   orx(2) = ox;  ory(2) = oy;
%   [ox,oy] = find_corner(vx,vy,irx(3),iry(3),xmax,ymax);
%   orx(3) = ox;  ory(3) = oy;
%   [ox,oy] = find_corner(vx,vy,irx(4),iry(4),0,ymax);
%   orx(4) = ox;  ory(4) = oy;
%   orx = round(orx);
%   ory = round(ory);
 
  % draw everything
  imshow(im);
  hold on;
  irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
  iry =  round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
  plot(irx,iry,'b'); 
  plot([vx irx(1)], [vy iry(1)], 'r-.');
  plot([orx(1) irx(1)], [ory(1) iry(1)], 'r');
  plot([vx irx(2)], [vy iry(2)], 'r-.');
  plot([orx(2) irx(2)], [ory(2) iry(2)], 'r');
  plot([vx irx(3)], [vy iry(3)], 'r-.');
  plot([orx(3) irx(3)], [ory(3) iry(3)], 'r');
  plot([vx irx(4)], [vy iry(4)], 'r-.');
  plot([orx(4) irx(4)], [ory(4) iry(4)], 'r');
  hold off;
  drawnow;
end;