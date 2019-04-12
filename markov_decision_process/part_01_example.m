% Example code for simple 1D cleaning robot MDP.
clear; clc;

% States are just cells 1:6;
states = (1:6).';
state_names = {'0'; '1'; '2'; '3'; '4'; '5'};

actions = [1; 2];
action_names = {'Left', 'Right'};

terminal = [1; 6];  % Terminal states, so no probability of getting out...

% Rewards per state...
R = [1, 0, 0, 0, 0, 5].';

% Transition matrix...
P = cleaning_transition_model(states, terminal, actions);

[policy, utils, iters] = mdp_solve_value_iteration(P, R, 0.8, 0.001, 1000);

fprintf('The optimal policy is:\n');

for i = 1 : length(states)
    if ismember(i, terminal)
        continue;
    end
    
    fprintf('%s : %s\n', state_names{i}, action_names{policy(i)});
end