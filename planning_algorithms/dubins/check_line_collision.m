function collide = check_line_collision(line, obstacles, exp_dist)
% CHECK_LINE_COLLISION Check collision between ploygon and inflated line.
%
% Utitity function to check collisions of straight lines with obstaclesgons.

per_vec = line(2,:)-line(1,:);
per_vec(1, [1 2]) = per_vec(1, [2 1]);
per_vec(2) = -per_vec(2);
per_vec = per_vec./norm(per_vec);

left_line  = line + repmat(per_vec.*exp_dist, [2, 1]);
right_line = line - repmat(per_vec.*exp_dist, [2, 1]);

% Obstacles should be a cell array.
shape_count = size(obstacles, 2);

for i = 1:shape_count
    crnt_obstacles = obstacles{i};
    seg_count = size(crnt_obstacles, 1) - 1;
    
    if (check_line_collision_obs(left_line, crnt_obstacles, seg_count) ||...
         check_line_collision_obs(right_line, crnt_obstacles, seg_count) ||...
         check_line_collision_obs(line, crnt_obstacles, seg_count) )
        collide = true;
        return;
    end
    
end

collide = false;

end

function collide = check_line_collision_obs(line, crnt_obstacles, seg_count)
% Check collision between single polygon and obstacle.

dA = line(2,:) - line(1,:);                             
dB = crnt_obstacles(2:seg_count+1, :) - crnt_obstacles(1:seg_count, :);     
dA1B1 = repmat(line(1,:), [seg_count, 1]) - crnt_obstacles(1:seg_count, :);
denominator = dB(:, 2) .* dA(1) - dB(:, 1) .*dA(2);

if all(denominator == 0)  % Not possible...
    collide = false;
    return;
end

ua = dB(:, 1).*dA1B1(:, 2) - dB(:, 2).*dA1B1(:, 1);
ub = dA1B1(:, 2).*dA(1) - dA1B1(:, 1).*dA(2);
ua = ua./denominator;
ub = ub./denominator;

if (all(((ua < 0)|(ua > 1))|((0 > ub)|(ub > 1))))
    collide = false;
else
    collide = true;
end

end