function backend(vanishing_point, inner_rectangle, image_size)

%Take care to round the values no 12.12312 something insted 12.0
%gui ouput replaces these values:
vanishing_point = [778,489];
inner_rectangle = [360,970,970,360; 197,197,661,661];
image_size = [829, 1152];

%Use Function outer_rectangular.m to calculate the outer rectangular 
%Refer to Report Tour into the picture: Figure 4 c, outer rectangular are 
%the points 11, 10, 4, 5 
or = outer_rectangle(vanishing_point, inner_rectangle, image_size);

%Call function create5rect.m which gives 5 arrays for the five rectangulares
%Top, bottom, left, right and back
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(image_size, vanishing_point, inner_rectangle, or);

%Expected ouput from create5rect:
%Result back_rec = [360,970,970,360,360;197,197,661,661,197]
%Result top_rec = [78,1100,970,360;0,0,197,197]
%Result Bottom = [360,970,1158,-48;661,661,829,829]
%Result Left = [0,360,360,0;-54,197,661,809]
%Result right = [970,1152,1152,970;197,-80,824,661]

%Creat new plot like example image "Show the five planes.png"
%Which creats the big image with shifted cordinates and shows the five
%planes
end