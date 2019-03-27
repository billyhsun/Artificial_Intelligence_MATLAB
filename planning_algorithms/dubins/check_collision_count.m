function count = check_collision_count(line, obstacles)
% CHECK_COLLISION_COUNT Check number of collisions with obstacles.
%
% Utility function to check number of collisions with obstacles.

count = 0;

for i = 1:size(obstacles, 2)
    crnt_obstacle = obstacles{i};
    obstacle_size = size(crnt_obstacle);  % ith obstacle.
    seg_count = obstacle_size(1) - 1;     % Number of line segments.
    
    % Intersection check (borrowed from online).
    dA = line(2,:) - line(1,:);  % Dimension should be [1, 2]    
    dB = crnt_obstacle(2:obstacle_size(1), :) - ...
         crnt_obstacle(1:obstacle_size(1)-1, :);

    dA1B1 = repmat(line(1,:), [seg_count, 1]) - ...
                   crnt_obstacle(1:seg_count, :);
    denominator = dB(:, 2).* dA(1) - dB(:, 1).*dA(2);  % dA cross dB
    
    % If twwo lines are very close to parallel...
    parallel_ind = find(abs(denominator) < 0.000001);     

    ua = dB(:, 1).* dA1B1(:, 2) - dB(:, 2).* dA1B1(:, 1); % dAB cross dB
    ub = dA1B1(:, 2).* dA(1) - dA1B1(:, 1).* dA(2);       % dAB cross dA
   
    for j = 1:size(parallel_ind, 1)
        if(abs(ua(parallel_ind(j))) > 0.000001)  
            % parallel, do nothing
        else
            if( (min(line(:, 1)) <= crnt_obstacles(parallel_ind(j), 1)) && ...
                (max(line(:, 1)) >= crnt_obstacles(parallel_ind(j), 1))...
             || (min(line(:, 1)) <= crnt_obstacles(parallel_ind(j) + 1, 1)) && ...
                (max(line(:,1)) >= crnt_obstacles(parallel_ind(j) + 1, 1)))
                % Overlapping segment
                count = [1000001, i, j];
                return;
            else
                % Non-overlapping
            end
        end

        % Ensure we won't count as having a intersection...
        denominator(parallel_ind(j)) = ...
            min([abs(ua(parallel_ind(j))), abs(ub(parallel_ind(j)))])/2;
    end

    ua = ua./denominator;
    ub = ub./denominator;
    cond = ~(((ua<0)|(ua>1))|((0>ub) | (ub>1)));
    count = count + sum(cond);
end

end
