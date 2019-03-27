function [solution] = min_conflicts_n_queens(initialization)
% MIN_CONFLICTS_N_QUEENS Solve the N-queens problem with no conflicts.
%
% Given an initialization for the N-queens problem, which may contain
% conflicts, this function uses the min-conflicts heuristic (see AIMA,
% pg. 221) to produce a conflict-free solution.
%
% The output 'solution' structure must contain two fields: assignment,
% which is a conflict-free assignment (a 1xN vector, just as for the
% initialization), and n_steps, which is the number of steps required
% by the local search to find a solution. If no solution is found, the
% assignment field should be an empty array.
%
% You may add any other fields that help you develop/debug your solution.
%
%  Inputs:
%  -------
%   initialization  - 1xN vector, where the ith entry is the row of the
%                     queen in the ith column (may contain conflicts).
%
%  Outputs:
%  --------
%   solution  - Struct - conflict-free solution to the problem.

N = length(initialization);
assignment = initialization;
max_steps = 10000;  % We should nou usually need this many steps...

% Insert your code here.
% Make a matrix representation of the NxN board, each entry representing the number of conflicts there
conflicts = zeros(N);

% Calculate the conflicts on the board for the current assignment
for c = 1:N
    r = assignment(c);
    conflicts(r,[1:c-1, c+1:N]) = conflicts(r,[1:c-1, c+1:N]) + ones(1, N-1);
    conflicts(1:r-1, 1:c-1) = conflicts(1:r-1, 1:c-1) + rot90(eye(r-1, c-1), 2);
    conflicts(r+1:N, 1:c-1) = conflicts(r+1:N, 1:c-1) + fliplr(eye(N-r, c-1));
    conflicts(1:r-1, c+1:N) = conflicts(1:r-1, c+1:N) + flipud(eye(r-1, N-c));
    conflicts(r+1:N, c+1:N) = conflicts(r+1:N, c+1:N) + eye(N-r, N-c);
end

% Main loop
for i = 1:max_steps
    attacked = arrayfun(@(x) conflicts(assignment(x), x) ~= 0, 1:N);
    indices = find(attacked);
    count = length(indices);
    
    % If no conflict, return
    if count == 0
        solution.n_steps = i;
        solution.assignment = assignment;
        return;
    end
    
    % Find spots with minimum number of conflicts
    var = indices(randi(count));
    argmins = find(conflicts(:, var) == min(conflicts(:, var)));
    value = argmins(randi(length(argmins)));
    r = assignment(var);
    
    % Remove previous assignment
    conflicts(r, [1:var-1, var+1:N]) = conflicts(r, [1:var-1, var+1:N]) - ones(1, N-1);
    conflicts(1:r-1, 1:var-1) = conflicts(1:r-1, 1:var-1) - rot90(eye(r-1, var-1), 2);
    conflicts(r+1:N, 1:var-1) = conflicts(r+1:N, 1:var-1) - fliplr(eye(N-r, var-1));
    conflicts(1:r-1, var+1:N) = conflicts(1:r-1, var+1:N) - flipud(eye(r-1, N-var));
    conflicts(r+1:N, var+1:N) = conflicts(r+1:N, var+1:N) - eye(N-r, N-var);
    
    % Update the board for the new assignment
    conflicts(value, [1:var-1, var+1:N]) = conflicts(value, [1:var-1, var+1:N]) + ones(1, N-1);
    conflicts(1:value-1, 1:var-1) = conflicts(1:value-1, 1:var-1) + rot90(eye(value-1, var-1),2);
    conflicts(value+1:N, 1:var-1) = conflicts(value+1:N, 1:var-1) + fliplr(eye(N-value, var-1));
    conflicts(1:value-1, var+1:N) = conflicts(1:value-1, var+1:N) + flipud(eye(value-1, N-var));
    conflicts(value+1:N, var+1:N) = conflicts(value+1:N, var+1:N) + eye(N-value, N-var);
    
    assignment(var) = value;
end

return

end
