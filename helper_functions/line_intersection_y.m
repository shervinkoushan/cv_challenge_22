function [y] = line_intersection_y(van_point_xy, inner_rec_xy, x_inn)

    m = (inner_rec_xy(2) - van_point_xy(2)) ./ (inner_rec_xy(1) - van_point_xy(1));
    b = inner_rec_xy(2) - m * inner_rec_xy(1);

    x = x_inn;
    y = round(m * x + b);
end
