function [verticies, edges, ind_nearest] = ...
    rrt_dubins(map, obstacles, start_point, turning_rad, iters)
% RRT_DUBINS RRT algorithm for Dubins vehicles.
%
% An implementation of the RRT algorithm for Dubins-type vehicles, where
% verticies in the RRT are connected by Dubins curves. This means that
% branches from a vertex are 'smooth' in the targent space (and hence
% this is more realistic for nonholonomic vehicles).
%
% The basic algorithm is as follows:
%
%  1. Generate a random (x, y, theta) point.
%  2. Find the 'closest' vertex in an existing vertex list (in terms of
%     the length of the Dubins path, not the Euclidean distance).
%  3. Check for collision violation. Note the border of the map is not checked
%     for collisions.
%  4. Connect the new vertex to the closest existing vertex using a
%     Dubins curve.
%  5. Add the new vertex to the existing vertex list.
%
% Note that we use the 2D plane, and the code does not check/is not
% required to check for collisions at the boundary.
%
% Inputs:
% -------
%  map          - Struct with fields: width, height, centre (tuple).
%  obstacles    - Cell array of polygonal obstacles (one per row).
%  start_point  - Starting pose, (x, y, theta); must be in bounds.
%  turning_rad  - Dubins turning radius (i.e., tightest possible curve).
%  iterations   - Number of iternations to run.
%
% Outputs:
% --------
%  vertices     - An array of vertices (position and heading).
%  edges        - Start and end of each edge (corresponding to vertices).
%  edges.param  - Dubins parameters for each edge.
%  ind_nearest  - Array of indices of nearest points.

% Define iterations count.
iterations = iters;

offset = map.centre - [map.width, map.height]./2;
th_rng = 2*pi;
th_offset = 0;
exp_dist = 0.2;  % We set this as a constant for now.

% Preallocate space...
edges.x  = zeros(iterations, 2);
edges.y  = zeros(iterations, 2);
edges.th = zeros(iterations, 2);
edges.param(iterations).p_init = [0, 0, 0];      % the initial configuration
edges.param(iterations).seg_param = [0, 0, 0];   % the lengths of the three segments
edges.param(iterations).r = turning_rad;         % turning radius
edges.param(iterations).r = turning_rad;         % turning radius
edges.param(iterations).type = -1;               % path type. one of LSL, LSR, ...
edges.param(iterations).flag = 0;

verticies = start_point;
vert_count = 1;
ind_nearest = zeros(iterations, 1);
edge_count = 0;

% Vertex number
vertex_num = 1;

% Main RRT loop.
for i= 1:iterations
    % Randomly generate new point in configuration space.
    x_rand  = map.width*rand + offset(1);
    y_rand  = map.height*rand + offset(2);
    th_rand = th_rng*rand + th_offset;
    
    % Randomly find closest points
    p = [x_rand y_rand th_rand];
    [ind_closest, param_closest] = dubins_search_nearest(verticies, p, turning_rad);
    collision = check_dubins_collision(param_closest, map, obstacles, exp_dist);
        
    % Update the edges, verticies and ind_nearest if no collision
    if collision == false
        edges.x(vertex_num, 1) = verticies(ind_closest, 1);
        edges.x(vertex_num, 2) = x_rand;
        edges.y(vertex_num, 1) = verticies(ind_closest, 2);
        edges.y(vertex_num, 2) = y_rand;
        edges.th(vertex_num, 1) = verticies(ind_closest, 1);
        edges.th(vertex_num, 2) = th_rand;
        edges.param(vertex_num) = param_closest;
        
        verticies = vertcat(verticies, p);
        ind_nearest(vertex_num) = ind_closest;

        vert_count = vert_count + 1;
        edge_count = edge_count + 1;
        vertex_num = vertex_num + 1;
    end

end

end