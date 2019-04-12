function [U] = mdp_solve_policy_evaluation(P, R, gamma, U, policy)
% MDP_SOLVE_POLICY_EVALUATION Generate updated utilities for each MDP state.
%
% Utility function to generate updated utility mapping, using an approximation
% (this is modified policy iteration in AIMA).
%
% Inputs:
% -------
%  P       - Matrix (SxSxA) transition matrix that defines transition
%            probability from state to state given an action.
%  R       - Vector (length S) of reward available in each state.
%  gamma   - Discount factor in range [0, 1).
%  U_prev  - Vector (length S), defining current utility function.
%  policy  - Vector (length S), defining policy (possibly random).
%
% Outputs:
% --------
%  U   - Vector (length S) defining updated utility function.

S = size(P, 1);
U_p = zeros(S, 1);

% Loop for 50 iterations - this is the approximation. DO NOT CHANGE.
    U = U_p;
    for s = 1:S
        cum = 0;
        if policy(s) ~= 0    % Calculate likelihood for this policy
            cum = dot(P(s, :, policy(s)), U);
        end
        
        U_p(s) = R(s) + gamma * cum;    % Update to previous utility
    end
end


end
