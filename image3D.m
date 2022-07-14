function [bigim, back_b, top_b, bot_b, left_b, right_b] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, im, d)
%IMAGE3D Summary of this function goes here
%   Detailed explanation goes here
%The Function creat a Box with out of the 5 planes
%First a new image is created so all points have the rec have positive
%value
%Function 5 planes creat out of ech plane a rectangular 
%Function createDice will put all the planes falt together 

%% Create big image
[bigim, back_b, top_b, bot_b, left_b, right_b] = createBigim(back_rec, top_rec, bottom_rec, left_rec, right_rec, im);

%% Create 5 planes
%changed the get5Planes Function
[back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(bigim, back_b, top_b, bot_b, left_b, right_b, d);

%% Create flat dice 
[new_img] = createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);

end

