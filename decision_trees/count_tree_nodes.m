function [num] = count_tree_nodes(tree)
% COUNT_TREE_NODES Count number of nodes in decision tree.

if ~isa(tree,'TreeNode')
    error('Tree variable is of wrong type.');
end

num = 1 + child_nodes(tree);

end

function [num] = child_nodes(root)
% Return number of child nodes below root.

num = 0;

for i = 1 : length(root.branches)
    num = num + (child_nodes(root.branches(i)) + 1);
end

end