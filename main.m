% Group Reperban approach

%Start 

%Calling the gui 
%   1.Selecting a Image
%   2.Draw vanishing point and inner rectangular
%   3.Give back the values v and ir

%Take care to round the values no 12.12312 something insted 12.0
%gui ouput replaces these values:
v = [778,489];
ir = [360,970,970,360; 197,197,661,661];
im_size = [829, 1152];

%Use Function outer_rectangular.m to calculate the outer rectangular 
%Refer to Report Tour into the picture: Figure 4 c, outer rectangular are 
%the points 11, 10, 4, 5 
or = outer_rectangle(v, ir, im_size);

%Call function create5rect.m which gives 5 arrays for the five rectangulares
%Top, bottom, left, right and back
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);


big_im = zeros([ymax+tmargin+bmargin xmax+lmargin+rmargin cdepth]);
big_im_alpha = zeros([size(big_im,1) size(big_im,2)]);
big_im(tmargin+1:end-bmargin,lmargin+1:end-rmargin,:) = im2double(im);
big_im_alpha(tmargin+1:end-bmargin,lmargin+1:end-rmargin) = 1;

%Expected ouput from create5rect:
%Result back_rec = [360,970,970,360,360;197,197,661,661,197]
%Result top_rec = [78,1100,970,360;0,0,197,197]
%Result Bottom = [360,970,1158,-48;661,661,829,829]
%Result Left = [0,360,360,0;-54,197,661,809]
%Result right = [970,1152,1152,970;197,-80,824,661]

%Creat new plot like example image "Show the five planes.png"
%Which creats the big image with shifted cordinates and shows the five
%planes