function [d] = getDistanceRatio(V ,inn_rect, im_size)

f = 1;

% Top and bottom calculations
l = V(2) - 0; % l = h1-Vy
h = im_size(1) - V(2); % h = Vy-h2
b = V(2) - inn_rect(2,2);
a = inn_rect(2,3) - V(2);

d_top = (l*f/b)-f;
d_bottom = (h*f/a)-f;

% Right and left calculations
l = V(1) - 0; % l = h1-Vy
h = im_size(2) - V(1); % h = Vy-h2
b = V(1) - inn_rect(1,1);
a = inn_rect(1,2) - V(1);

d_left = (l*f/b)-f;
d_right = (h*f/a)-f;

d = [d_top, d_bottom, d_left, d_right];

ind_max = find(d == max(d));
ind_min = find(d == min(d));

d_new = d(d~=max(d));
d_new = d_new(d_new~=min(d_new));

d(ind_max) = max(d_new);
d(ind_min) = min(d_new);

end