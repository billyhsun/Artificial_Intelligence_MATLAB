% Part 2 Example - N-Queens Problem
clear; close all; clc;

% Try a fairly small test case...
N = 10;
greedy_init = initialize_greedy_n_queens(N);
solution = min_conflicts_n_queens(greedy_init);

plot_n_queens(solution.assignment);
check_n_queens(solution.assignment)

fprintf('The solver required %d steps in total.\n', solution.n_steps);