% Part 3 Example - Motion Planning for Dubbins Vehicles
clear; close all; clc;
tic;

% Basic setup - define map and intial parameters.
map.height = 20;
map.width  = 20;
map.centre = [0, 0];

start_point = [-1, -1, 20*pi/180];  % [x, y, direction]
turning_rad = 0.5;                % Dubins turning radius.
iters = 500;

% Define some simple obstacles.
obstacles = {poly_square([3, 3], 3)};

% Call RRT to search configuration space.
[verticies, edges, ind_nearest] = ...
    rrt_dubins(map, obstacles, start_point, turning_rad, iters);

% Plot the results for viewing.
figure('Name', 'RRT with Dubins Paths');

% Plot map bounds.
offset = map.centre - [map.width, map.height]./2;
bounds = [offset; offset + [map.width 0]; offset + [map.width, map.height];
          offset + [0 map.height];
          offset];  
plot(bounds(:, 1), bounds(:, 2), '--r'); hold on;

% Plot obstacles.
plot_obstacle_poly(gca, obstacles);

% Plot RRT paths.
plot_rrt_dubins(gca, verticies, edges);

xlim([offset(1) - 1, offset(1) + map.width + 1]);
ylim([offset(2) - 1, offset(2) + map.height + 1]);
toc;