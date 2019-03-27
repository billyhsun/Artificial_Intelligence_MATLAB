function [greedy_init] = initialize_greedy_n_queens(N)
% INITIALIZE_GREEDY_N_QUEENS Greedily minimize N-queens conflicts.
%
% Initialize the board for the N-queens problem using a greedy strategy
% to minimize conflicts with each new placement.
%
%  Inputs:
%  -------
%   N  - Number of queens (and hence size of the board).
%
%  Outputs:
%  --------
%   greedy_init - 1xN vector, where the ith entry is the row of the queen
%                 in the ith column.

greedy_init = zeros(1, N);
greedy_init(1) = 1;  % First queen goes at the upper left.
rows_remaining = 2:N;

% Insert your code here.
for i = 2:N    % column
    k = 1;
    status = true;
    conflicts = zeros(1, length(rows_remaining));   
    
    for j = 1:length(rows_remaining)    % row
        row = rows_remaining(j);
        greedy_init(i) = row;   % Set condition for checking
        
        % Check diagonal validity (rows and columns have already been taken care of in the for loops)
        for n = i-1:-1:1  
            % Count the number of conflicts in each row
            if(abs(i-n) == abs(greedy_init(n)-row))
                conflicts(j) = conflicts(j) + 1;
                status = false;
            end
        end
        if status == true  % If valid
            k = row;
            break
        end
        greedy_init(i) = 0;   % Set it back if it doesn't work
    end

    % If an entire row has conflicts, pick the one with the least number of conflicts 
    if status == false
        [min_conflicts, index] = min(conflicts);
        greedy_init(i) = rows_remaining(index);
        k = rows_remaining(index);
    end
   
    rows_remaining(rows_remaining == k) = [];   % Takes out k from the available rows
end

return

end