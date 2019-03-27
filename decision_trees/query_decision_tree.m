function [label_val, label_txt] = ...
    query_decision_tree(tree, attributes, goal, query)
% QUERY_DECISION_TREE Query a decision tree at test time.
%
% Query a decision tree at test time. Returns the integer class label specified
% by the tree and the associated label text (if you 
%
% Inputs:
% -------
%  tree        - Root node of decision tree.
%  attributes  - Attributes avaialble for splitting at this node.
%  goal        - Goal, decision variable (classes/labels).
%  query       - A test query (1xn vector of attribute values, same format as 
%                examples but with the final class label).
% 
% Outputs:
% --------
%  label_val   - Integer class label specified by the tree.
% [label_txt]  - Class label in text form. 

if ~isa(tree,'TreeNode')
    error('Tree variable is of wrong type.');
end

% Walk down the tree until we reach a leaf, then return the integer
% classification defined by the leaf.
node = tree;

while ~node.is_leaf
    % Select branch to descend.
    b = get_branch(node, attributes, query);
    node = node.branches(b);
end

label_val = node.label;

if nargout == 2
    label_txt = goal{2}{label_val};
end

end

function [branch] = get_branch(node, attributes, query)
% Find attribute in set of attributes - determine branch.

branch = 0;  % Will cause failure.

for i = 1 : length(attributes)
    if strcmp(node.attribute{1}, attributes{i}{1})
        branch = query(i);
        break;
    end
end

end