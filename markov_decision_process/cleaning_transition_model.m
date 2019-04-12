function [P] = cleaning_transition_model(states, terminal, actions)
% Utility function to generate transition model for cleaning robot.
% 
% Given a set of states (size S) and actions (size A), generate the SxSxA state
% transition matrix, using knowledge of the problem domain.
%
% Inputs
% ------
%  states    - Set of states in the problem (integer ids).
%  terminal  - Subset of states that are terminal (absorbing).
%  actions   - Set of possible actions (integer ids).
%
% Ouputs
% ------
%  P  - Matrix of size (SxSxA) specifying all of the transition probabilities.

P = zeros(size(states, 1), size(states, 1), size(actions, 1));

% Insert your code here.

transition_probs = [0.05, 0.15, 0.8];  % [left, stay, right]
for i = setdiff(1:size(states, 1), terminal)    % For all states not in terminal state
    % Set transition probabilities
    P(i, i-1:i+1, 1) = transition_probs(end:-1:1);    % Left
    P(i, i-1:i+1, 2) = transition_probs;    % Right
end

end 
