function [name, rps] = roshambo(history, strategy)
% ROSHAMBO Play rock-paper-scissors.
%
% Agent that plays rock-paper-scissors. The function should return an integer
% value (from 1-3, for rock, paper, or scissors, respectively). To determine
% what choice to make, the agent can review/analyze the history provided (for
% the specific opponent).
%
% See the score_roshambo.m function for more details on scoring.
%
% Inputs:
% -------
%  history - 2xn array; top row contains past choices by your agent (recorded),
%            bottom row contains past choices by the opponent.
% 
% Outputs:
% --------
%  name  - String - the name of your agent (for the round robin tournament).
%  rps   - Integer choice for this game: '1' - rock, '2' - paper, '3' - scissors.

%===============================================================================
%
% Insert your algorithm description and notes here, 10-15 lines, 80 columns max.
%
%===============================================================================

num_games = size(history, 2);

% Insert your code here.


name = "I'm a wumpus";

% Frequency matrix for next action in history
prob = zeros(3, 3, 3);
length = size(history, 2);
next_win = [2, 3, 1];   % Next action to win for [1, 2, 3]

% Use random if there is no history
if isempty(history)
    rps = randi(3);
    return;
end

% Fill in the matrix by counting past moves
for i = 1:length-1
    if history(1, i) == next_win(history(2, i))
        prob(1, history(2, i), history(2, i+1)) = prob(1, history(2, i), history(2, i+1)) + 1;
    elseif history(1, i) == history(2, i)
        prob(2, history(2, i), history(2, i+1)) = prob(2, history(2, i), history(2, i+1)) + 1;
    else
        prob(3, history(2, i), history(2, i+1)) = prob(3, history(2, i), history(2, i+1)) + 1;
    end
end

% Make next move based on max likelihood from history
if history(1, end) == next_win(history(2, end))
    [~, j] = max(prob(1, history(2, end), :));
elseif history(1, end) == history(2, end)
    [~, j] = max(prob(2, history(2, end), :));
else
    [~, j] = max(prob(3, history(2, end), :));
end

rps = next_win(j);

return

end
