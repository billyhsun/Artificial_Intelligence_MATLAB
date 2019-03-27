classdef Node < handle

       properties
           parent
           state
           action
           path_cost
       end

       methods
            function this = Node(parent, state, action, path_cost)
                this.parent = parent;
                this.state = state;
                this.action = action;
                this.path_cost = path_cost;
            end
       end
 end 