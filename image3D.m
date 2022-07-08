function [outputArg1,outputArg2] = image3D(back_rec, top_rec, bottom_rec, left_rec, right_rec, im)
%IMAGE3D Summary of this function goes here
%   Detailed explanation goes here
%The Function creat a Box with out of the 5 planes
%First a new image is created so all points have the rec have positive
%value
%Function 5 planes creat out of ech plane a rectangular 
%Function createDice will put all the planes falt together 

%% Creat big image
%function


%% Creat 5 planes
%changed the get5Planes Function
[back_plane, top_plane, bottom_plane, left_plane, right_plane] = get5Planes(image,back_rec, top_rec, bottom_rec, left_rec, right_rec);


%% Create flat dice 
[new_img] = createDice(back_plane, top_plane, bottom_plane, left_plane, right_plane);

%% Put the planes to 3D dice together 

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

