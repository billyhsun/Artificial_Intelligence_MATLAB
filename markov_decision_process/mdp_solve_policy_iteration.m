function [policy, utils, iters] = ...
    mdp_solve_policy_iteration(P, R, gamma, policy_def, max_iters)
% MDP_SOLVE_POLICY_ITERATION Solve an MDP via policy iteration.
%
% An implementation of a policy iteration-based MDP solver. A transition model
% and a reward function are required as inputs. See pg. 656 of AIMA for more
% information.
%
% Inputs:
% -------
%  P           - Matrix (SxSxA) transition matrix that defines transition
%                probability from state to state given an action.
%  R           - Vector (length S) of reward available in each state.
%  gamma       - Discount factor in range [0, 1).
%  policy_def  - Vector (length S), default policy (possibly random).
%  max_iters   - Maximum number of iterations to run.
%
% Outputs:
% --------
%  policy  - Vector of actions (length S) for optimal policy.
%  utils   - Vector (length S) defining the utility function (i.e., per state).
%  iters   - Total number of iterations needed to converge (<= max_iters).

S = size(P, 1);
A = size(P, 3);
policy_prev = policy_def; % Copy default policy.

% Insert your code here.
utils = zeros(S, 1);
policy = policy_prev;

for iters = 1:max_iters
    unchanged = true;
    utils = mdp_solve_policy_evaluation(P, R, gamma, utils, policy);    % Check previous policy
    
    for s = 1:S    % Check if there is a better policy, if so, change it
        n = zeros(A, 1);
        for i = 1:A
            n(i) = dot(P(s, :, i), utils);
        end
        [mm, am] = max(n);
        
        if policy(s) > 0 && mm > dot(P(s, :, policy(s)), utils)   % Check if better than previous
            policy(s) = am;
            unchanged = false;
        end
    end
    
    if unchanged == true    % End if policy not changed in this iteration
        break
    end
end

end
