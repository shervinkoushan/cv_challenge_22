%% script to test the functions

img = imread("lib\oil-painting.png");

%% Define parameters we will get later from GUI
v = [775, 500];
ir = [340, 960, 960, 340; 182, 182, 661, 661];
im_size = [829, 1152];

%%
% imshow(img);
% hold on;
% plot()

% Create 5 rect
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = backend(v, ir, im_size);

% Create the big image with
[bigim, back_b, top_b, bot_b, left_b, right_b] = createBigim(back_rec, top_rec, bottom_rec, left_rec, right_rec, img);

% Get the depth of the 5 planes
[d] = getDistanceRatio(v, ir, im_size);

% Create planes
[back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(bigim, back_b, top_b, bot_b, left_b, right_b, d);

new_img = createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);
%imshow(new_img);
