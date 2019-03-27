function [is_valid, row_conf, diag_conf] = check_n_queens(assignment)
% CHECK_N_QUEENS Check N-Queens solution for validity.
%
%  Utility function to verify the validity of a solution to the N-queens
%  problem.
%
%  Inputs:
%  -------
%   assignment  - 1xN vector, where the ith entry is the row of the queen
%                 in the ith column.
%
%  Outputs:
%  --------
%   is_valid    - True if there are no conflicts, false otherwise.
%  [row_conf]   - True if two queens are on the same row (invalid).
%  [diag_conf]  - True if two queens are on the same diagonal (invalid).

N = length(assignment);  % Gives size of board.
is_valid  = true;
row_conf  = false;
diag_conf = false;

% Check row and column constraints - no two queens in same row.
if ~all(sort(assignment) == 1:N)
    is_valid = false;
    
    if nargout >= 2
        row_conf = true;
    end

    return
end

% Check diagonal constraints - no two queens on same diagonal.
for idx = 1:N
    if sum(idx - 1:-1:1 == ...
           abs(assignment(1:idx - 1) - assignment(idx))) > 0
        is_valid = false;
            
        if nargout >= 3
            diag_conf = true;
        end
        
        return
    end
end

end