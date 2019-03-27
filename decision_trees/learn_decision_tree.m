function [node] = ...
    learn_decision_tree(parent, attributes, goal, examples, score_fun)
% LEARN_DECISION_TREE Recursively learn a decision tree from training data.
%
% Learn a decision tree from training data, using the specified scoring function
% to determine which attribute to split on at each step. This is an
% implementation of the algorithm on pg. 702 of AIMA.
%
% Inputs:
% -------
%  parent      - Parent node in tree or empty (if root of tree).
%  attributes  - Attributes avaialble for splitting at this node.
%  goal        - Goal, decision variable (classes/labels).
%  examples    - Subset of examples that reach this point in the tree.
%  score_fun   - Handle to scoring function (e.g., information gain) or 
%                double (1.0 for information gain, 2.0 for gain ratio).
%
% Outputs:
% --------
%  node  - Root node of tree structure.

% Hack - select scoring function.
if isa(score_fun, 'double')
    if score_fun == 1.0
        score_fun = @dt_info_gain;
    else
        score_fun = @dt_gain_ratio;
    end
end

% 1. Do any examples reach this point?

% 2. Or do all examples have same class/label? If so, we're done!

% 3. No attributes left? Choose the majority class/label.

% 4. Otherwise, need to choose an attribute to split on, but which one? Loop.

    % Best score?

    % NOTE: To pass the Grader tests, when breaking ties you should always
    % selected the attribute with the smallest (leftmost) column index!
	     
    % Create new internal node using the best attribute.

    % Now, recurse down each branch (operating on a subset of examples below).

end

function [label] = plurality_value(goal, examples)
% PLURALITY_VALUE Utility function to pick class/label from mode of examples.
vals  = zeros(1, size(goal{2}, 2));

% Get counts of number of examples in each possible attribute class first.
for i = 1 : size(goal{2}, 2)
    vals(i) = sum(examples(:, end) == i);
end

[~, label] = max(vals);

end
