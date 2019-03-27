classdef TreeNode < handle

    properties
        parent
        attribute
        examples
        is_leaf
        label
        branches
    end

    methods
        function this = TreeNode(parent, attribute, examples, is_leaf, label)
            this.parent = parent;
            this.attribute = attribute;
            this.examples = examples; % Just to make it easy..not needed after training.
            this.is_leaf = is_leaf;
            this.label = label;
            this.branches = TreeNode.empty;
        end
    end
end