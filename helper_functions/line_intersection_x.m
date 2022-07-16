function [x] = line_intersection_x(van_point_xy, inner_rec_xy, y_inn)
    %This function creates a line from the vanishing point throught the
    %inner rectangle, and finds the intersection in x
    %coordinates.

    %M is the slope of the line
    m = (inner_rec_xy(2) - van_point_xy(2)) ./ (inner_rec_xy(1) - van_point_xy(1));
    %This is the crossing point of the line
    b = inner_rec_xy(2) - m * inner_rec_xy(1);

    %The y value you want to check the intersection for
    y = y_inn;
    %The intersecion of the x-axis based on the inputed y is calculated
    x = round((y - b) / m);
end
