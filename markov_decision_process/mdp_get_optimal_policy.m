function [policy] = mdp_get_optimal_policy(P, U)
% MDP_GET_OPTIMAL_POLICY Given MDP and utility function, find optimal policy.
%
% This short utility function implements Eqn. 17.4 from the textbook - given
% a transition model and a utility function, it selects the optimal policy.
%
% Note that the policy for terminal states should be zero (i.e., no action is
% selected, becasue once one of those states is reached, nothing happens).
%
% Inputs:
% -------
%  P  - Matrix (SxSxA) transition matrix that defines transition probability
%       from state to state given an action.
%  U  - Vector (length S) of converged utility values for each state.
%
% Outputs:
% --------
%  policy  - Vector(length S) of optimal action to take in any state, from 
%            set of possible actions.

% Insert your code here.

S = size(P, 1);
A = size(P, 3);
policy = zeros(S, 1);

for s = 1:S
    if sum(P(s, :)) ~= 0    % If probability of a state is not zero
        n = zeros(A, 1);
        for i = 1:A    % Calculate probability of next action for each state
            n(i) = P(s, :, i) * U;
        end
        [~, policy(s)] = max(n);    % Get optimal action
    end
end

end
