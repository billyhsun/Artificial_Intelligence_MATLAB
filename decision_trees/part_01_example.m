% Part 1 Example - Decision Tree Learning
clear; close all; clc;

% We'll use the AIMA restaurant problem (in SR's head) as an example...

% First, let's input the attributes from AIMA, and associated possible values.
A1  = {'Alternate'; {'No', 'Yes'}};
A2  = {'Bar'; {'No', 'Yes'}};
A3  = {'Fri-Sat'; {'No', 'Yes'}};
A4  = {'Hungry'; {'No', 'Yes'}};
A5  = {'Patrons'; {'None', 'Some', 'Full'}};
A6  = {'Price'; {'$', '$$', '$$$'}};
A7  = {'Raining'; {'No', 'Yes'}};
A8  = {'Reservation'; {'No', 'Yes'}};
A9  = {'Type'; {'French', 'Italian', 'Thai', 'Burger'}};
A10 = {'WaitEstimate'; {'0-10', '10-30', '30-60', '>60'}};

goal = {'WillWait'; {'No', 'Yes'}};

% Set of attributes available at the start...
attributes = {A1, A2, A3, A4, A5, A6, A7, A8, A9, A10};

% Now, let's input the training data we have (12 examples) - all data is 
% represented numerically; every column represents an attribute (as above), 
% each row is an example. Attribute values are mapped to numbers from left
% to right (above), starting at 1. So Type = Thai is represented by a 3 in 
% column 9.
examples = zeros(12, 11); % Last column is the goal / decision variable!

examples(1, :)  = [2, 1, 1, 2, 2, 3, 1, 2, 1, 1, 2];
examples(2, :)  = [2, 1, 1, 2, 3, 1, 1, 1, 3, 3, 1];
examples(3, :)  = [1, 2, 1, 1, 2, 1, 1, 1, 4, 1, 2];
examples(4, :)  = [2, 1, 2, 2, 3, 1, 2, 1, 3, 2, 2];
examples(5, :)  = [2, 1, 2, 1, 3, 3, 1, 2, 1, 4, 1];
examples(6, :)  = [1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 2];
examples(7, :)  = [1, 2, 1, 1, 1, 1, 2, 1, 4, 1, 1];
examples(8, :)  = [1, 1, 1, 2, 2, 2, 2, 2, 3, 1, 2];
examples(9, :)  = [1, 2, 2, 1, 3, 1, 2, 1, 4, 4, 1];
examples(10, :) = [2, 2, 2, 2, 3, 3, 1, 2, 2, 2, 1];
examples(11, :) = [1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1];
examples(12, :) = [2, 2, 2, 2, 3, 1, 1, 1, 4, 3, 2];

% Build our tree...
tree = learn_decision_tree(TreeNode.empty, attributes, goal, examples, @dt_info_gain);

% Plot our tree (if you feel like it)...
% plot_decision_tree(tree, goal);

% Query the tree with an unseen test example - should be classified as 'Yes'!
test_query = [1, 1, 2, 2, 3, 1, 1, 1, 3, 4];
[~, test_class] = query_decision_tree(tree, attributes, goal, test_query);

fprintf('For the test example, the tree says: %s\n', test_class);