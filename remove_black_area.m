function [New_im] = remove_black_area(Image)
%REMOVE_BLACK_AREA Summary of this function goes here
%   Detailed explanation goes here

Image( ~any(Image,2), : ) = [];  %rows
Image( :, ~any(Image,1) ) = [];  %columns
New_im = Image;
end

