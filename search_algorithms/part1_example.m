%% ROB311 Assignment 1 Part 1 - Social Network Search
clear; close all; clc;

%% Load Data
% Add 1 for Matlab indexing
E = 1 + importdata('../data/stanford_large_network_facebook_combined.txt');

%% Try breadth-first search - define problem first

% Test: 1 -> 350 should give the following path: (1, 35, 349, 350)
init_state = 1;
goal_states = [350]; %Other states to try: [350, 4000, 2000, 4039];%

[problem_network] = NetworkSearchProblem(init_state, goal_states, E);
solution = breadth_first_search(problem_network);
