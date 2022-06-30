%read the 2D image
close all;
I=imread('./lib/simple-room.png');
%I = imresize(imread('bbb.jpg'), 0.5);   
imshow(I);
hold on
axis on
%[max_x, max_y, c] = size(I);
[max_y, max_x, c] = size(I);
[rx, ry] = ginput(2) %origin is at top left corner (rx has x,y coordinates of the point)
plot(rx,ry,'*')

%% draw the rectangle

hold on;
irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
iry =  round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
plot(irx,iry,'b'); 
hold off;

%% get vanishing point
while(1)
    [vx, vy, button] = ginput(1); 
    
    if (isempty(button))
      break;
    end
    vp_x = vx(1); vp_y=vy(1);

   
    cpx = [0 0 0 0];
    cpy = [0 0 0 0];
    [cpx(1), cpy(1)] = compute_corner(vp_x, vp_y, irx(1), iry(1), 1, 1); 
    [cpx(2), cpy(2)] = compute_corner(vp_x, vp_y, irx(2), iry(2), max_x, 1); 
    [cpx(3), cpy(3)] = compute_corner(vp_x, vp_y, irx(3), iry(3), max_x, max_y); 
    [cpx(4), cpy(4)] = compute_corner(vp_x, vp_y, irx(4), iry(4), 1, max_y); 
    
   
    imshow(I);
    hold on;
    plot(irx,iry,'b'); 
    plot([vp_x cpx(1)],[vp_y cpy(1)],'r');
    plot([vp_x cpx(2)],[vp_y cpy(2)],'r');
    plot([vp_x cpx(3)],[vp_y cpy(3)],'r');
    plot([vp_x cpx(4)],[vp_y cpy(4)],'r');
    hold off;
end 
