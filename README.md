# A Tour Into the Picture

A project for the course EI70110 Computer Vision offered during SS 2022 at the Technical Univerity of Munich.

![example](https://user-images.githubusercontent.com/59822141/179567454-7e4e1d34-80fa-4ca2-8215-228acf929c6a.png)

## Goal

Create different views of a scene from a single image.


## Overview

The program is for creating and visualizing different perspectives of a scene from a single image. The methodology is based on creating
a box model from the image, where the user can change the view.


## Project description

The program is based on the paper [1], which describes the main steps of the method, but does not provide an exact implementation.
After the user selects the background rectangle and the vanishing point, a 3D box model is created where the user can move using the keyboard.
Once the user is satisfied with the new viewing angle, the image can be exported to a .png file.
For this MATLAB 2022a and the Image Processing Toolbox is used, both provided by MathWorks.


## Details

Using the GUI the user can choose an image and then select the inner rectangle and the vanishing point. 
The program calculates the corners of the five planes and plots them on the original image. The algorithm 
uses these points to calculate an estimation of projective transformation for each plane based on the 
similar triangles method from [2]. The depth of the images is also estimated with this method.
Then the planes are cropped and the transformation is made. As the last step, the planes are put 
together into a 3D box where the user can move the camera with the keyboard. 

## Code

The GUI is modularized into 3 tabs. The backend functionality dealing with each tab is put in the corresponding folder. Functions which are used more than one place is found in the `helper_functions` folder. The GUI consists of one figure with three ui-panels attached, one for each tab. The logic is based on callbacks. For example, when the user moves the vanishing point, the corners of the five planes are recalculated.

## How to use the program

To use the app, the program has to be started through the `main.m` file, which creates the GUI and initializes the necessary variables.
In the app, the steps are well explained, and a help page is added to explain how the user can move in the picture. 


## Sources

[1] Youichi Horry, Ken-Ichi Anjyo, and Kiyoshi Arai. Tour into the picture: using a spidery mesh interface to make animation from a single image.
http://graphics.cs.cmu.edu/courses/15-463/2006_fall/www/Papers/TIP.pdf

[2] yli262, tour-into-the-picture
https://github.com/yli262/tour-into-the-picture
