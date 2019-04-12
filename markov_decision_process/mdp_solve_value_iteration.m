function [policy, utils, iters] = ...
    mdp_solve_value_iteration(P, R, gamma, epsilon, max_iters)
% MDP_SOLVE_VALUE_ITERATION Solve an MDP via value iteration.
%
% An implementation of a value iteration-based MDP solver. A transition model
% and a reward function are required as inputs. See pg. 652 of AIMA for more
% information.
%
% Inputs:
% -------
%  P         - Matrix (SxSxA) transition matrix that defines transition
%              probability from state to state given an action.
%  R         - Vector (S) of reward available in each state.
%  gamma     - Discount factor in range [0, 1).
%  epsilon   - Epsilon-optimal policy bound, greater than 0.
%  max_iters - Maximum number of iterations to run.
%
% Outputs:
% --------
%  policy  - Vector of actions (length S) for epsilon-optimal policy.
%  utils   - Vector (length S) defining the utility function (i.e. per state).
%  iters   - Total number of iterations needed to converge (<= max_iters).

S = size(P, 1);

% Insert your code here.
A = size(P, 3);
utils = zeros(S, 1);
U_p = zeros(S, 1);

for iters = 1:max_iters
    utils = U_p;
    
    U_p = mdp_solve_bellman_operator(P, R, gamma, utils);
    delta = max([0; abs(U_p - utils)]);    % Difference between Bellman solution and prior 
    
    threshold = epsilon * (1 - gamma) / gamma;
    if delta < threshold     % End if difference is smaller than threshold
        break
    end
end

policy = mdp_get_optimal_policy(P, utils);
    
end


