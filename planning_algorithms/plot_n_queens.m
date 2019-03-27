function [h] = plot_n_queens(assignment)
% PLOT_N_QUEENS Plot the assignment of N queens on the chessboard.
%
%  Utility function to plot the N-queens solution (to check for validity).
%
%  Inputs:
%  -------
%   assignment  - 1xN vector, where the ith entry is the row of the queen
%                 in the ith column.
%
%  Outputs:
%  --------
%   h  - Handle to figure object.

N = length(assignment);
chessboard = ones(N);

for idx = 1:N
    chessboard(assignment(idx), idx) = 0;
end

% Plot grid.
h = figure;
colormap('gray');
image(0.5, 0.5, chessboard*255);
title('N-Queens Placement');

end