    % Create a window to hold an image of size 512x512 pixels
    figure('Position',[100 100 512 512]);
    % Define the XYZ location of a point with respect to camera
    X = 2*(rand-0.5);   % Generate random location in X, -1..+1
    Y = 2*(rand-0.5);   % Generate random location in Y, -1..+1
    P = [X; Y; 10];
    % This creates the rendered image of the point
    plot3(P(1),P(2),P(3),'.');
    fov = 15;   % Define field of view of the camera in degrees
    camva(15);  % Set the camera field of view
    campos([0 0 0]);  % Put the camera at the origin
    camtarget([0 0 1]);  % The camera looks along the +Z axis
    camproj('perspective');
    axis image
    axis off;
    set(gca, 'Units', 'pixels', 'Position', [1 1 512 512]);
    set(gcf, 'Color', [1 1 1]); % Sets figure background (optional)
    F = getframe(gcf);      % Grab the rendered frame
    I=rgb2gray(F.cdata);    % This is the rendered image
    figure, imshow(I,[]), impixelinfo;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Detect the centroid of the point in the rendered image
    region = regionprops(I<255);
    disp('Point detected at: '), disp(region.Centroid);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculate where I expect the point to appear
    % Calculate effective focal length using pinhole camera model.
    focal = 256/tand(fov/2);
    % Use perspective projection equations to predict image point (x,y)
    disp('Point should be at: ');
    x = focal * P(1)/P(3) + 256.5e
    y = focal * P(2)/P(3) + 256.5