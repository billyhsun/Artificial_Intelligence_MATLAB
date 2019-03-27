function [solution] = a_star_search(problem,N)
% a_star_search Implement A* here. Your solution should be optimal and
% complete - use the Manhattan heuristic method built into the 
% GridSearchProblem class.
%
%  problem - an instance of GridSearchProblem.
%  N       - starting size of the Priority Queue
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

% Initialize
frontier = PriorityQueue(N);
cost = 0;
solution.num_nodes_expanded = 0;
frontier_array = zeros(4039);
solution.explored = zeros(4039);

% First node
firstnode = Node(nan, problem.init_state, problem.actions(problem.init_state), 0);
frontier_array(firstnode.state) = 1;
frontier.push(problem.heuristic(firstnode.state), firstnode);

% Initial check: Terminate if initial state is equal to the final state
if problem.goal_test(problem.init_state)
    solution.path = [problem.init_state];
    solution.max_frontier_size = 0;
    solution.num_node_expanded = 0;
    return
end

% Main loop
while frontier.is_empty() == false  
    [node, cost_node] = frontier.pop();
    frontier_array(node.state) = 0;
    
    % Check if goal state is reached
    if problem.goal_test(node.state)
        solution.path = problem.solution(node);
        return 
    end
     
    % Otherwise explore all possible children
    solution.explored(node.state) = 1;
    actions = problem.actions(node.state);
    s = size(actions);
    
    % Iterate through all possible actions
    for i = 1:length(actions)
        child =  problem.get_child_node(node, (actions{i}));
        cost = cost_node + 1 + problem.heuristic(child.state) - problem.heuristic(child.parent.state); % Update cost
       
        % Explore node if not already explored
        if solution.explored(child.state) == 0 && frontier_array(child.state) == 0      
            frontier.push(cost, child);
            frontier_array(child.state) = 1;
            solution.num_nodes_expanded  = solution.num_nodes_expanded + 1;    
            
        elseif frontier_array(child.state) == 1
            frontier_array(child.state) = 1;       
            frontier.push(cost, child);
            solution.num_nodes_expanded = solution.num_nodes_expanded + 1;
        end 
    end
end