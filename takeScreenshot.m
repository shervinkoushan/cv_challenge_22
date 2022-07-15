function [imgData] = takeScreenshot(left, top, width,height)
%TAKESCREENSHOT Summary of this function goes here
%   Detailed explanation goes here

robot = java.awt.Robot();
pos = [left top width height];

rect = java.awt.Rectangle(pos(1), pos(2), pos(3), pos(4));
cap = robot.createScreenCapture(rect);

rgb = typecast(cap.getRGB(0,0,cap.getWidth,cap.getHeight, [],0,cap.getWidth), 'uint8');
imgData = zeros(cap.getHeight, cap.getWidth, 3, 'uint8');
imgData(:,:,1) = reshape(rgb(3:4:end),cap.getWidth, [])';
imgData(:,:,2) = reshape(rgb(2:4:end),cap.getWidth, [])';
imgData(:,:,3) = reshape(rgb(1:4:end),cap.getWidth, [])';

end

