function [solution] = breadth_first_search(problem)
%breadth_first_search Implement a breadth_first_search algorithm. Your 
% solution should be optimal and complete.
%
% problem - an instance of SearchProblem or one of its subclasses.
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

t = 1;
frontier = DoubleQueue;
firstnode = Node(nan, problem.init_state,problem.actions(problem.init_state), 1);
frontier.add(firstnode);
frontierA = [firstnode.state];

while true
    if frontier.isEmpty()
        solution.path = 'Failure'
        return
    end
    node = frontier.remove();
    frontierA(frontierA == node.state) = [];
    solution.explored(t) = node.state;

    t = t + 1;
    actionlist = problem.actions(node.state);
    
    for idx = 1:size(actionlist)
        child = problem.get_child_node(node,actionlist{idx});
        if ~ismember(child.state, solution.explored)||~ismember(child.state, frontierA)
            if problem.goal_test(child.state) == 1
                solution.path = problem.solution(child);
                return
            end
            frontier.add(child);
            frontierA = [frontierA child.state];
        end
    end
end

end