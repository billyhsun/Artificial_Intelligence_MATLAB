function [solution] = bidirectional_search(problem)
%bidirectional_search Implement a bidirectional search strategy. Your 
% solution should be optimal and complete.
%
%  problem - an instance of SearchProblem or one of its subclasses.
%
% Returns:
% 
% solution - a struct with a field called path (i.e. solution.path) which
% is a row vector describing the state trajectory. Note that: 
% solution.path(1) = problem.init_state, 
% solution.path(end) = problem.goal_states(1).
%
% You may find it useful to return other values as fields of solution that
% can help with debugging and testing: number of nodes expanded,
% maximum frontier size, etc. 

% Use two frontiers (Double Queues)
frontier1 = DoubleQueue;
frontier2 = DoubleQueue;

% Temporary buffer
temp_frontier = DoubleQueue;

% Initial states
init_node = Node(nan, problem.init_state, problem.actions(problem.init_state), 0);
final_node = Node(nan, problem.goal_states(1), problem.actions(problem.goal_states(1)), 0);
frontier1_array = [init_node.state];
frontier2_array = [final_node.state];
frontier1.add(init_node);
frontier2.add(final_node);

% Pre-allocate arrays to store visited nodes (adding to an empty array increases runtime)
visited1 = zeros(4039);
visited2 = zeros(4039);

% Initial check: if initial state is the goal state then terminate immediately
if problem.goal_test(init_node.state)
    solution.path = problem.solution(init_node);
    return
end

% Main loop
while (~(frontier1.isEmpty() && frontier2.isEmpty()))
    
    % Step from the left side
    while frontier1.isEmpty() == false
        node1 = frontier1.remove();
        frontier1_array(node1.state) = 0;
        visited1(node1.state) = 1;
        actions = problem.actions(node1.state); 
        
        % Iterate through all possible actions
        for i = 1:length(actions)
            child_node = problem.get_child_node(node1, actions{i});
            
            % Access only when the node has yet to be accessed
            if visited1(child_node.state) == 0
                frontier2_node = frontier2.get(child_node.state);
                
                % Check if this node reaches the frontier of the other side, if so, end and return path
                if isempty(frontier2_node) == false
                    path_1 = problem.solution(child_node);
                    path_2 = flip(problem.goal_solution(frontier2_node.parent));
                    solution.path = [path_1 path_2];
                    return
                else
                    visited1(child_node.state) = 1;
                    temp_frontier.add(child_node);
                end
            end
        end
    end
    
    % Update frontier of this side
    while ~temp_frontier.isEmpty()
        node = temp_frontier.remove();
        frontier1.add(node);
        frontier1_array(node.state) = 1;
    end
    
    % Step from the right side
    while frontier2.isEmpty() == false
        node2 = frontier2.remove();
        frontier2_array(node2.state) = 0;
        visited2(node2.state) = 1;
        actions = problem.actions(node2.state);
        
        % Iterate through all possible actions
        for i = 1:length(actions)
           child_node2 = problem.get_child_node(node2, actions{i});
           
           % Access only when the node has yet to be accessed
           if visited2(child_node2.state) == 0
                frontier1_node = frontier1.get(child_node2.state)
                
                % Check if this node reaches the frontier of the other side, if so, end and return path
                if isempty(frontier1_node) == false
                    path_1 = flip(problem.goal_solution(child_node2));
                    path_2 = problem.solution(frontier1_node.parent);
                    solution.path = [path_2 path_1]
                    return
                else
                    visited2(child_node2.state) = 1;
                    temp_frontier.add(child_node2);
                end
            end
        end
    end
    
    % Update frontier of other side
    while ~temp_frontier.isEmpty()
        node = temp_frontier.remove();
        frontier2.add(node);    
        frontier2_array(node.state) = 1;
    end
end
solution.path = []

end
