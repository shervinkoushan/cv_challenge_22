function [back_rec, top_rec, bottom_rec, left_rec, right_rec] = backend(vanishing_point, inner_rectangle, image_size)

%Use Function outer_rectangular.m to calculate the outer rectangular 
%Refer to Report Tour into the picture: Figure 4 c, outer rectangular are 
%the points 11, 10, 4, 5 
or = outer_rectangle(vanishing_point, inner_rectangle, image_size);

%Call function create5rect.m which gives 5 arrays for the five rectangulares
%Top, bottom, left, right and back
[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(image_size, vanishing_point, inner_rectangle, or);

end