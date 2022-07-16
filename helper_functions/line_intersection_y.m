function [y] = line_intersection_y(van_point_xy, inner_rec_xy, x_inn)
    %This function creates a line from the vanishing point throught the
    %inner rectangle, and finds the intersection in y
    %coordinates.
    
    %M is the slope of the line
    m = (inner_rec_xy(2) - van_point_xy(2)) ./ (inner_rec_xy(1) - van_point_xy(1));
    %This is the crossing point of the line
    b = inner_rec_xy(2) - m * inner_rec_xy(1);

     %The x value you want to check the intersection for
    x = x_inn;
    %The intersecion of the x-axis based on the inputed x is calculated
    y = round(m * x + b);
end
