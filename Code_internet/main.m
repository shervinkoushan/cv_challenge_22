
% 15-463, Project 5, Tour Into the Picture
% Sample startup code by Alyosha Efros (so it's buggy!)
%
% We read in an image, get the 5 user-speficied points, and find
% the 5 rectangles.  

% read in sample inage
im = imread('oil-painting.png');

[x_max, y_max, depth] = size(im);



% Run the GUI in Figure 1
figure(1);
[vx,vy,irx,iry,orx,ory] = TIP_GUI(im);


v = [vx; vy];
ir = [irx; iry];
or = [orx; ory];

% Find the cube faces and compute the expended image
[bim,bim_alpha, v, ir, or] = TIP_get5rects(im, vx, vy, irx, iry, orx, ory);

%<<<<<<< HEAD
% [back_test, ceil, floor, left, right] = creat5rect(im, v, ir, or);
% 
% backrx = back_test(1,:);
% backry = back_test(2,:);
% 
% ceilrx = ceil(1,:);
% ceilry = ceil(2,:);
% 
% floorrx = floor(1,:);
% floorry = floor(2,:);
% 
% leftrx = left(1,:);
% leftry = left(2,:);
% 
% rightrx = right(1,:);
% rightry = right(2,:);
% 
% vx = v(1);
% vy = v(2);
% 
% irx = ir(1);
% iry = ir(2);
% 
% orx = or(1);
% ory = or(2);
% 

%=======
[back, ceil, floor, left, right] = create5rect(im, v, ir, or);

backrx = back(1,:);
backry = back(2,:);

ceilrx = ceil(1,:);
ceilry = ceil(2,:);

floorrx = floor(1,:);
floorry = floor(2,:);

leftrx = left(1,:);
leftry = left(2,:);

rightrx = right(1,:);
rightry = right(2,:);

vx = v(1);
vy = v(2);

irx = ir(1);
iry = ir(2);

orx = or(1);
ory = or(2);

%>>>>>>> 80ed726775db9bae8318290fdc6b4cb2cb788a43

% display the expended image
figure(2);
imshow(bim);
% Here is one way to use the alpha channel (works for 3D plots too!)
%%alpha(bim_alpha);

% Draw the Vanishing Point and the 4 faces on the image
figure(2);
hold on;
plot(vx,vy,'w*');
plot([ceilrx ceilrx(1)], [ceilry ceilry(1)], 'y-');
plot([floorrx floorrx(1)], [floorry floorry(1)], 'm-');
plot([leftrx leftrx(1)], [leftry leftry(1)], 'c-');
plot([rightrx rightrx(1)], [rightry rightry(1)], 'g-');
hold off;

% sample code on how to display 3D sufraces in Matlab
figure(3);
% define a surface in 3D (need at least 6 points, for some reason)
planex = [0 0 0; 0 0 0];
planey = [-1 0 1; -1 0 1];
planez = [1 1 1; 0 0 0];



% create the surface and texturemap it with a given image
warp(planex,planey,planez,bim);
% some alpha-channel magic to make things transparent
alpha(bim_alpha);
alpha('texture');

% Some 3D magic...
axis equal;  % make X,Y,Z dimentions be equal
axis vis3d;  % freeze the scale for better rotations
axis off;    % turn off the stupid tick marks
camproj('perspective');

% make it a perspective projection
% use the "rotate 3D" button on the figure or do "View->Camera Toolbar"
% to rotate the figure
% or use functions campos and camtarget to set camera location 
% and viewpoint from within Matlab code
