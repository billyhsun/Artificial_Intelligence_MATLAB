%% ROB311 Assignment 1 Part 2 - A* for Grid Map Path Planning
clear; close all; clc;

%% Simple Random Test Cases with Visualization
N = 40;
% Go from the top left to the bottom right corner in our visualization
init_state = 1;
goal_states = [N^2];
p_occ = 0.2;

% 1 if occupied, 0 if free
grid_map = rand(N,N) <= p_occ;

% Make sure the start and goal spaces are free
grid_map(init_state) = 0;
grid_map(goal_states) = 0;
problem_grid = GridSearchProblem(init_state, goal_states, grid_map);

% We can compare with the breadth_first_search function from part 1
tic
solution_bfs = breadth_first_search(problem_grid);
toc
tic
solution = a_star_search(problem_grid);
toc

if ~isempty(solution.path)
    problem_grid.plot_solution(solution.path);
    problem_grid.plot_solution(solution_bfs.path);
    % These are fields you may want to track and add to your solution output:
    solution.num_nodes_expanded
    solution.max_frontier_size
    solution_bfs.num_nodes_expanded
    solution_bfs.max_frontier_size
    
    % They should both be optimal and therefore the same length
    assert(length(solution.path) == length(solution_bfs.path));
else
    % Plot just the grid if there's no solution
    problem_grid.plot_solution([]);
end