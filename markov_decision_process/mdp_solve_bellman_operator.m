function [U] = mdp_solve_bellman_operator(P, R, gamma, U_prev)
% MDP_SOLVE_BELLMAN_OPERATOR Use Bellman operator to solve an MDP.
%
% Applies the Bellman operator (update) to the previous utility (value) function
% to produce an updated utility function. Fewer than 10 lines of code are 
% required.
%
% Inputs:
% -------
%  P         - Matrix (SxSxA) transition matrix that defines transition
%              probability from state to state given an action.
%  R         - Vector (length S) of reward available in each state.
%  gamma     - Discount factor in range [0, 1).
%  U_prev    - Vector (length S) defining previous utility function.
%
% Outputs:
% --------
%  U  - Vector (length S) defining updated utility function.

% Insert your code here.
S = size(P, 1);
A = size(P, 3);
U = zeros(S, 1);

for s = 1:S
    n = zeros(A, 1);
    for i = 1:A    % Calculate probability of next action for each state
        n(i) = P(s, :, i) * U_prev;
    end
    a = max(n);    % Get next action (highest likelihood)
    
    U(s) = R(s) + gamma * a;
end


end
