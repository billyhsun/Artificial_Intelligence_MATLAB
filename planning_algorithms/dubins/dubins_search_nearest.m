function [ind_closest, param_closest] = ... 
    dubins_search_nearest(verticies, init_point, turning_rad)
% DUBINS_SEARCH_NEAREST Find 'nearest' vectex to current vertex.
%
% Finds the nearest vertex to the initial point, given the Dubins turning 
% radius.

total = size(verticies,1);

% find parameter for the first one in the list
param = dubins_shortest(verticies(1, :), init_point, turning_rad);
cost = dubins_length(param);
param_closest = param;
ind_closest = 1;

for i = 2:total
    param = dubins_shortest(verticies(i, :), init_point, turning_rad);
    
    % If the new cost is lower, grab this vertex.
    if(dubins_length(param) < cost)
        cost = dubins_length(param);
        ind_closest = i;
        param_closest = param;
    end
end

end

function length = dubins_length(param)
% Calculate length of the Dubins curve.
    length = param.seg_param(1) + param.seg_param(2) + param.seg_param(3);
    length = length*param.r;
end