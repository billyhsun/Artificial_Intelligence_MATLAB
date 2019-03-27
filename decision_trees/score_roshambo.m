function [total] = score_roshambo(history)
% SCORE_ROSHAMBO Scoring for rock-paper-scissors.
%
% Utility function to score performance of a roshambo agent. The total score
% (one point for a win, zero points for a tie, minus one point for a loss).
%
% Here, the total returned is for the agent who made the moves given by the
% top row of the history array (not the bottom).
%
% 1 - rock
% 2 - paper
% 3 - scissors
%
% Inputs:
% -------
%  history - 2xn array; the score is calculated for the agent that made the
%            choices specified by the *top* row of the array.
% 
% Outputs:
% --------
%  total  - Overall score for agent.

% Rock beats scissors. Paper beats rock. Scissors beats paper.
total = 0;

if size(history, 2) > 0
    % Rock.
    total = total + sum(history(1, :) == 1 & history(2, :) == 3);
    total = total - sum(history(1, :) == 1 & history(2, :) == 2);

    % Paper.
    total = total + sum(history(1, :) == 2 & history(2, :) == 1);
    total = total - sum(history(1, :) == 2 & history(2, :) == 3);

    % Scissors.
    total = total + sum(history(1, :) == 3 & history(2, :) == 2);
    total = total - sum(history(1, :) == 3 & history(2, :) == 1);
end

end