classdef SearchProblem
    %SearchProblem 
    
    properties
        init_state
        goal_states
    end
    
    methods
        function obj = SearchProblem(init_state, goal_states)
            obj.init_state = init_state;
            obj.goal_states = goal_states;
        end
        
        function [child_node] = get_child_node(obj, parent_node, action)
            child_state = obj.transition(parent_node.state, action);
            child_path_cost = parent_node.path_cost + ...
                                   obj.step_cost(parent_node.state, action);
            child_node = Node(parent_node, child_state, action, child_path_cost);
        end
        
        function g = goal_test(obj, state)
            g = ismember(state, obj.goal_states);
        end
        
        function state_out = transition(obj, state, action)
            assert(ismember(state, action));
            if action(1) == state
                state_out = action(2);
            else
                state_out = action(1);
            end
        end
        
        function sol = solution(obj, node)
            % Trace back to the solution, forming a path
            sol = [node.state];
            node_current = node;
            while node_current.state ~= obj.init_state
              node_current = node_current.parent;
              sol = [node_current.state sol];
            end
        end
        
        function sol = goal_solution(obj, node)
            % Trace back to the goal, forming a path for bidirectional search
            sol = [node.state];
            node_current = node;
            while node_current.state ~= obj.goal_states(1)
              node_current = node_current.parent;
              sol = [node_current.state sol];
            end
        end
        
        function c = step_cost(~, ~, ~)
            % Uniform step cost
            c = 1;
        end
        
    end
end

