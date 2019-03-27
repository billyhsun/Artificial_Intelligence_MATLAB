classdef NetworkSearchProblem < SearchProblem
   properties
      G
   end
   methods
      function obj = NetworkSearchProblem(init_state, goal_states, E)
          obj = obj@SearchProblem(init_state, goal_states);
          if ~isempty(E)
              [G,~] = obj.get_graph_from_edges(E);
              obj.G = G;
          else
              obj.G = [];
          end
      end

      function action_list = actions(obj, state)
          neighbours = obj.G(state).neighbours;
          action_list = cell(1, length(neighbours));
          for idx=1:length(neighbours)
              action_list{idx} = [state neighbours(idx)];
          end
      end
      
      function [G,V] = get_graph_from_edges(obj, E)
      %get_graph_from_edges 
          V = sort(unique(E));
          G = [];
          for idx=1:length(V)
              node_idx.id = V(idx);
              node_idx.neighbours = [];
              G = [G node_idx];
          end
          for idx=1:size(E,1)
              e = E(idx,:);
              G(e(1)).neighbours = [G(e(1)).neighbours e(2)];
              G(e(2)).neighbours = [G(e(2)).neighbours e(1)];
          end
      end
      
   end
end