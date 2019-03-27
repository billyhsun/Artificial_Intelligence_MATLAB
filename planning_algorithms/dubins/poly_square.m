function [points] = poly_square(ulc, side)
% POLY_SQUARE Generate vertex list for square (polygon).

points = [ulc; ulc + [0, side]; ulc + [side, side]; ulc + [side, 0]; ulc];

end