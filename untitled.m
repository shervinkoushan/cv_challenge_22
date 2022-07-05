I = imread("lib\oil-painting.png");

v = [900,489];
ir = [360,970,970,360; 197,197,661,661];
im_size = [829, 1152];

or = outer_rectangle(v, ir, im_size);

[back_rec, top_rec, bottom_rec, left_rec, right_rec] = create5rect(im_size, v, ir, or);

