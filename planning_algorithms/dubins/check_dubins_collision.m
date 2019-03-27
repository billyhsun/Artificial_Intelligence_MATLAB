function collide = check_dubins_collision(param, map, obstacles, exp_dist)
% CHECK_DUBINS_COLLISION Check collisions between Dubins curve and polygon.
%
% Utiltity function to check collisions between Dubins curve and polygons 
% in the map.
%
% Inputs:
% -------
%  param      - Dubins parameters.
%  map        - Struct with fields: width, height, centre (tuple).
%  obstacles  - Cell array of polygonal obstacles (one per row).
%  exp_dist   - Expansion distance (buffer around obstacles). 
%
%  Note:
%  -----
%   Parameter struct contains:
%
%      param.p_init = p1;              % Initial point
%      param.seg_param = [0, 0, 0];    % lengths of three segments
%      param.r = r;                    % turning radius
%      param.type = -1;                % path type. one of LSL, LSR, ... 
%      param.flag = 0;

%---------- Definitions ----------
% The three segment types a path can be composed of.
L_SEG = 1; S_SEG = 2; R_SEG = 3;

% The segment types for each of the path types.
DIRDATA = [ L_SEG, S_SEG, L_SEG ;...
            L_SEG, S_SEG, R_SEG ;...
            R_SEG, S_SEG, L_SEG ;...
            R_SEG, S_SEG, R_SEG ;...
            R_SEG, L_SEG, R_SEG ;...
            L_SEG, R_SEG, L_SEG ];

last_end = param.p_init;
arc.x = 0;
arc.y = 0;
arc.ang_init = 0;
arc.ang_end = 0;
arc.r = param.r;
    
for seg_i = 1:3
    seg_type = DIRDATA(param.type, seg_i);
    this_end = dubins_get_xyt(param.seg_param(seg_i), last_end, seg_type, param.r);
    if(check_map_range(this_end, map, exp_dist) == 0)
        collide = true;
        return;
    end
        
    if(seg_type == L_SEG)
        arc.x = last_end(1) - param.r*sin( last_end(3) );
        arc.y = last_end(2) + param.r*cos( last_end(3) );
        arc.ang_init = last_end(3) - pi/2;
        arc.ang_end = last_end(3)+param.seg_param(seg_i) - pi/2;
        collide = check_arc_polygon_collision(arc, obstacles, exp_dist);
    elseif(seg_type == R_SEG)
        arc.x = last_end(1) + param.r*sin( last_end(3) );
        arc.y = last_end(2) - param.r*cos( last_end(3) );
        arc.ang_init = (last_end(3)-param.seg_param(seg_i)) + pi/2;
        arc.ang_end = last_end(3) + pi/2;
        collide = check_arc_polygon_collision(arc, obstacles, exp_dist);
    elseif(seg_type == S_SEG)
        collide = ...
            check_line_collision([last_end(1:2);this_end(1:2)], obstacles, exp_dist);
    else
        error("Wrong segment type!");
        return;
    end
    
    if(collide)
        return;
    end
    
    last_end = this_end; % next segment
end

collide = false;

end

function seg_end = dubins_get_xyt(seg_param, seg_init, seg_type, r)
% Return the end point (x,y,theta) of a segment.
    L_SEG = 1; S_SEG = 2; R_SEG = 3;

    if( seg_type == L_SEG ) 
        seg_end(1) = seg_init(1) + r*( sin(seg_init(3)+seg_param) - sin(seg_init(3)) );
        seg_end(2) = seg_init(2) - r*( cos(seg_init(3)+seg_param) - cos(seg_init(3)) );
        seg_end(3) = seg_init(3) + seg_param;
    elseif( seg_type == R_SEG )
        seg_end(1) = seg_init(1) - r*( sin(seg_init(3)-seg_param) - sin(seg_init(3)) );
        seg_end(2) = seg_init(2) + r*( cos(seg_init(3)-seg_param) - cos(seg_init(3)) );
        seg_end(3) = seg_init(3) - seg_param;
    elseif( seg_type == S_SEG ) 
        seg_end(1) = seg_init(1) + cos(seg_init(3)) * seg_param * r;
        seg_end(2) = seg_init(2) + sin(seg_init(3)) * seg_param * r;
        seg_end(3) = seg_init(3);
    end
end

function in_range = check_map_range(point, map, exp)
% Check if point is inside the map or not.

if( (point(1) < (map.centre(1) - map.width/2 + exp))  ||...
    (point(1) > (map.centre(1) + map.width/2 - exp))  ||...
    (point(2) < (map.centre(2) - map.height/2 + exp)) ||...
    (point(2) > (map.centre(2) + map.height/2 - exp)) )
    in_range = false;
else
    in_range = true;
end

end