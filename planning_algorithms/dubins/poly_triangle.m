function [points] = poly_triangle(ulc, width, height)
% POLY_TRIANGLE Generate vertex list for right triangle (polygon).

points = [ulc; ulc + [0, height]; ulc + [width, height]; ulc];

end