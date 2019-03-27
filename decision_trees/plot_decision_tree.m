function plot_decision_tree(tree, goal)
% PLOT_DECISION_TREE Simple tree plotting routine.

if ~isa(tree,'TreeNode')
    error('Tree variable is of wrong type.');
end

% Make use of MATLAB's treeplot rountine.
p = zeros(1, count_tree_nodes(tree));

node_set = [tree];  % For plotting.
open_set = [tree];
open_idx = [1];
count = 1;

while ~isempty(open_set)
    % De-queue...
    node = open_set(1);
    
    for i = 1 : length(node.branches)
        count = count + 1;
        p(count) = open_idx(1);
        
        node_set(end + 1) = node.branches(i);
        open_set(end + 1) = node.branches(i);
        open_idx(end + 1) = count;     
    end

    open_set(1) = [];
    open_idx(1) = [];    
end

[x, y] = treelayout(p);
treeplot(p); hold on;

for j = 1: length(x)
    if ~isempty(node_set(j).attribute)
        text(x(j), y(j), node_set(j).attribute{1});
    else
        % Leaf node - indicate class/label.
        text(x(j), y(j), goal{2}{node_set(j).label})
    end
end
    
end