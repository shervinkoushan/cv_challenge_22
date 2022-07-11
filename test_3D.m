I = imread('lib/oil-painting.png');

%back
[y_b, x_b, ~] = size(I);

%given plane
[y, x, ~] = size(I);

%back
[X_1,Y_1] = meshgrid(1:y_b,1:x_b);
Z_1 = zeros(x_b,y_b);

%top
[X_2,Z_2] = meshgrid(1:y,1:x);
Y_2 = zeros(x,y);

%bot
[X_3,Z_3] = meshgrid(1:y,1:x);
Y_3 = x_b.* ones(x,y); 

%left
[Y_4,Z_4] = meshgrid(1:x,1:x);
X_4 = zeros(x_b,x_b);

%right
[Y_5,Z_5] = meshgrid(1:x_b,1:x_b);
X_5 = y_b.* ones(x_b,x_b);

figure
%back
warp(X_1, Y_1, Z_1, I);
hold on
%top
warp(X_2, Y_2, Z_2, I);
hold on
%bot
warp(X_3, Y_3, Z_3, I);
hold on
%left
warp(X_4, Y_4, Z_4, I);
hold on
%right
warp(X_5, Y_5, Z_5, I);