function [is_inferred] = inference_method(n_symbols, KB_facts, KB_def, q)
% INFERENCE_METHOD Determine whether KB entails query.
%
% The function returns a Boolean value indicating whether the knowledge
% base KB entails the query, a propositional symbol q.
%
% The input 'n_symbols' determines the total number of symbols in KB. Each
% symbol will be uniquely identified by an integer from 1 to n_symbols.
%
% KB_facts is a 1xK row vector with integers from 1 to n_symbols,
% representing known positive literals in the knowledge base.
%
% KB_def is a cell array of M definite clauses. Definite clauses are
% represented by 1x(N+1) row vectors where the first N elements are symbols
% identified by integers from 1 to n_symbols representing the body (i.e.
% negated literals in the definite clause), and the N+1th integer
% represents the head/conclusion (i.e. the one positive literal in the
% clause).
%
% Finally, 'q' is an integer from 1 to n_symbols representing the query
% we are trying to entail from the clauses of KB.
%
%  Outputs:
%  --------
%   is_inferred  - A Boolean indicating whether KB entails q.

% Initialize variables.
M = length(KB_def);
agenda = DoubleQueue;
K = length(KB_facts);
count = zeros(1, M);
inferred = zeros(1, n_symbols); % Initially all false
is_inferred = false;

% Initialize agenda with known positive literals
for i = 1:K
    agenda.add(KB_facts(i))
end

% Count number of premises in each inference
for i = 1:M
    count(i) = length(cell2mat(KB_def(i))) - 1;
end

% Main loop
while agenda.isEmpty() == false
    p = agenda.pop();
    if p == q    % Return true if there is a match
       is_inferred = true;
       return
    end
    if inferred(p) == false
        inferred(p) = true; 
        for j = 1:M   % All clauses
            c = cell2mat(KB_def(j));
            premise = c(1:end-1);
            if ismember(p, premise) == true  
                count(j) = count(j) - 1;
                if count(j) == 0
                    agenda.add(c(end))
                end
            end
        end
    end 
end

return

end
