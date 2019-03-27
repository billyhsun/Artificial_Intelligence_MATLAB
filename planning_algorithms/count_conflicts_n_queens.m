function [num_conf] = count_conflicts_n_queens(assignment)
% COUNT_CONFLICTS_N_QUEENS Count number of conflicts for N-queens problem.
%
%  Utility function to count number of conflicts for the N-queens problem.
%
%  Inputs:
%  -------
%   assignment  - 1xN vector, where the ith entry is the row of the queen
%                 in the ith column.
%
%  Outputs:
%  --------
%   num_conf  - Total number of conflicts found.

N = length(assignment);

% Start with row conflicts.
num_row_conf = N - length(unique(assignment));  % Number of duplicate rows.

% Now handle diagonal conflicts.
num_diag_conf = 0;

% Could even be smarter here...
for var_idx = 1:N
    % Is there an entry in assignment that is the same num of row/colums 
    % above right, below right, above left, or below left?
    col_dists = (1:N) - var_idx;  % (var_idx:N) - var_idx;
    row_dists = assignment - assignment(var_idx); % assignment(var_idx:end) 
    
    % The subtraction is here because a queen is in conflict with itself.
    num_diag_conf = num_diag_conf + ...
        sum(abs(col_dists) == abs(row_dists)) - 1;
end

% The above double-counts diagonal conflicts (to make the code easy)
% so we just divide by 2!
num_conf = num_row_conf + num_diag_conf/2;