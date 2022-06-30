%%   Open Image File Callback
function OpenImageCallback(~,~)

%   Get TabHandles from guidata and set some varables
    TabHandles = guidata(gcf);
    NumberOfTabs = size(TabHandles,1)-2;
    PanelWidth = TabHandles{NumberOfTabs+1,2};
    PanelHeight = TabHandles{NumberOfTabs+1,3};

    persistent StartPicDirectory

%   Initilize the StartPicDirectory if first time through
    if isempty(StartPicDirectory)
        StartPicDirectory = cd;
    end

%   Get the file name from the user
    [PicNameWithTag, PicDirectory] = uigetfile({'*.jpg;*.tif;*.png','Image Files'},...
        'Select an image file',StartPicDirectory);

    if PicNameWithTag == 0,
        %   If User canceles then display error message
            errordlg('You should select an Image File');
        return
    end

%   Set the default directory to the currently selected directory
    StartPicDirectory = PicDirectory;

%   Build path to file
    PicFilePath = strcat(PicDirectory,PicNameWithTag);

    ShowImageInTab2(PicFilePath);

end
    
    