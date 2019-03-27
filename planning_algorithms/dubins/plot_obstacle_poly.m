function plot_obstacle_poly(ax, polygon, color)
% PLOT_OBSTACLE_POLY Plot polygonal obstacle on map.

shape_count = size(polygon, 2);

for i = 1:shape_count
    crnt_poly = polygon{i};
    poly_size = size(crnt_poly);
    
    if poly_size(2) ~= 2
        return;
    end

    % Check line segement return to start...
    if any(crnt_poly(poly_size(1), :) ~= crnt_poly(1, :))
        poly_size(1) = poly_size(1)+1;
        crnt_poly(poly_size(1), :) = crnt_poly(1, :);    
    end
    
    if( nargin == 2 )
        plot(ax, crnt_poly(:,1), crnt_poly(:, 2)); hold on;
    else
        plot(ax, crnt_poly(:,1), crnt_poly(:, 2), color); hold on;
    end
end

end