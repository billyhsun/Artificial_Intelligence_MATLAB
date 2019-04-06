function [val] = dt_entropy(goal, examples) 
% DT_ENTROPY Compute entropy over discrete random varialbe for decision trees.
%
% Utility function to compute the entropy (wich is always over the 'decision'
% varaible, which is the last column in the examples).
%
% Inputs:
% -------
%  goal      - Decision variable (e.g., WillWait), cell array.
%  examples  - Training data; the final class is given by the last column.
%
% Outputs:
% --------
%  val  - Value of the entropy of the decision variable, given examples.

% Insert your code here. Be careful to check the number of examples and
% with NaN values!

labels = examples(:, end);
probability = zeros(length(goal{2}), 1);

for i = 1:length(labels)   % Count frequencies
    probability(labels(i)) = probability(labels(i)) + 1;
end
probability = probability / size(examples, 1);  % Normalize

val = 0;
for i = 1:length(probability)    % Apply formula to find entropy
    if probability(i) ~= 0
        val = val - probability(i) * log2(probability(i));
    end
end  

end
