%%   Open Image File Callback
function open_image(~, ~)

    persistent start_directory;

    %   Initilize the StartPicDirectory if first time
    if isempty(start_directory)
        start_directory = cd;
    end

    %  Get the file name from the user
    [name, directory] = uigetfile({'*.jpg;*.tif;*.png', 'Image Files'}, ...
    'Select an image', start_directory);

    if name == 0
        %   If user cancels then return
        return
    end

    %  Set the default directory to the currently selected directory
    start_directory = directory;

    % Path to file
    path = strcat(directory, name);

    % Now that an image is selected, we can go to tab 2
    % We cant move to tab 3 yet though
    enable_tab2_disable_tab3;
    tab2(path);

end