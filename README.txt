Create different views of a space from a single image

Main points:
-Main goal of project/Overview
-Project description(what app does, what technology we used, challenes we faced)
-Details(methodology like: transformaton estimation, caclulating the depth, building up the 3D model)
-How to run it(through main.m), how to use it
-Sources

# Overview

The program is for creating and visualizeing different perspectives of a space from a single image. The methodology is based on creating
a box model from the image, where the user can change the view.


# Project description

The program is based on the paper from XYZ what describes the main steps of the method, but does not provide an exact implementation.
After the user selected the background points and the vanishign point, a box model is created where the uuser can move using the keys.
Once the user is satisfied with the image view, the image can be exported to a .png file.
For this MATLAB 2022a and the Image Processing Toolbox is used provided by MathWorks.


# Details
1) get points from gui
2) calculate plane corners
3) estimate projective transformation
4) create planes as separate images
5) put planes to a 3d box


# How to use the program


# Sources
 




