%% Set camera position and angle to initial values

function reset_camera()
    global x_b;
    global y_b;

    % set camera position
    camx = x_b / 2;
    camy = y_b / 2;
    camz = 4 * y_b;

    % set camera target
    tarx = x_b / 2;
    tary = y_b / 2;
    tarz = 0;

    % set camera on ground
    camup([0, 1, 0]);

    % Set view angle
    camva(30)

    campos([camx camy camz]);
    camtarget([tarx tary tarz]);
    camroll(180);

end
