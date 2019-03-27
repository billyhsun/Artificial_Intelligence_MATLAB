function result = check_free_space(point, map, obstacles)
% CHECK_FREE_SPACE Check if point is in open region on configuration space.
%
% Utility function to check if a point lies with a obstaclesgon or outside of
% the map (i.e., it must lie in open space).

% First, check for no *exact* matching points.
for i = 1:size(obstacles, 2)
    if (ismember(point, obstacles{i}, 'rows'))
        result = false;
        return;
    end
end

% Create a line to the right edge of the map plus one unit.
edge = [point(1), point(2); (map.centre(1) + map.width/2) + 1, point(2)];
collide_count = check_collision_count(edge, obstacles);

if(size(collide_count,2) > 1)
    % colinear, overlapping, check if point is on line or not
    left_pt = min([obstacles{collide_count(2)}(collide_count(3), 1), ...
                   obstacles{collide_count(2)}(collide_count(3) + 1, 1)]);
    right_pt = max([obstacles{collide_count(2)}(collide_count(3), 1);
                    obstacles{collide_count(2)}(collide_count(3) + 1, 1)]);
    if(left_pt<=point(1) && point(1)<=right_pt)
        result = false;
        return;
    end
end

if rem(collide_count, 2) ~= 0
    result = false;  % Inside obstacle - fail.
    return;
end

% Create a straight line to the "left" edge of the map plus one
edge = [point(1), point(2); (map.centre(1) - map.width/2) - 1, point(2)];
collide_count = check_collision_count(edge, obstacles);

if rem(collide_count, 2) ~= 0
    result = false;  % Inside obstacle - fail.
    return;
end

result = true;

end