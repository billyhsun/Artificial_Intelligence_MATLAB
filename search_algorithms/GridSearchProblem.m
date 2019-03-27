classdef GridSearchProblem < SearchProblem
   % Creates a gridmap problem for an MxN map, where the x-dimension
   % indexes the rows (up to M), and y-dimension indexes columns (up to N)
   properties
%       init_state
%       goal_states
      grid_map
      M
      N
   end
   methods
      function obj = GridSearchProblem(init_state, goal_states, grid_map)
          obj = obj@SearchProblem(init_state, goal_states);
          obj.grid_map = grid_map;
          obj.M = size(grid_map, 1);
          obj.N = size(grid_map, 2);
      end
      
      function action_list = actions(obj, state)
          assert(obj.grid_map(state) == 0, 'Entered an occupied cell');
          [x,y] = obj.get_position(state);
          action_list = {};
          if x+1 <= obj.M && ~obj.grid_map(x+1, y)
              action_list{end+1} = [state ((y-1)*obj.M + x + 1)];% (x+1)*y];
          end
          if x-1 >= 1 && ~obj.grid_map(x-1, y)
              action_list{end+1} = [state ((y-1)*obj.M + x - 1)]; %(x-1)*y];
          end
          if y+1 <= obj.N && ~obj.grid_map(x, y+1) 
              action_list{end+1} = [state (y*obj.M + x)];
          end
          if y-1 >= 1 && ~obj.grid_map(x, y-1) 
              action_list{end+1} = [state ((y-2)*obj.M + x)];
          end
      end
      
      function [x,y] = get_position(obj, state)
          assert(state <= obj.M*obj.N, 'State out of range');
          x = mod(state-1, obj.M)+1;
          y = floor((state-1)/obj.M)+1;
      end
      
      function [h] = heuristic(obj, state)
          h = obj.manhattan_heuristic(state, obj.goal_states(1));
      end
      
      function [h] = manhattan_heuristic(obj, state1, state2)
          [x1, y1] = obj.get_position(state1);
          [x2, y2] = obj.get_position(state2);
          h = abs(x1-x2) + abs(y1-y2);
      end
      
      function [h] = plot_solution(obj, trajectory)
          h = figure;
          font_size = 14;
          set(h,'defaulttextinterpreter','latex');
          colormap('gray');
          % Plot grid
          % Transpose so that first indices are x
          image((1-obj.grid_map.')*255);
          hold on;
          % Plot trajectory
          x = zeros(1, length(trajectory));
          y = zeros(size(x));
          for idx = 1:length(trajectory)
              [xi,yi] = obj.get_position(trajectory(idx));
              x(idx) = xi;
              y(idx) = yi;
          end
          plot(x,y, 'LineWidth', 2.5, 'Color', [1 0 0]);
          title('Grid Search Solution','FontSize', font_size, 'Interpreter', 'latex');
          xlabel('x','FontSize', font_size, 'Interpreter', 'latex');
          ylabel('y','FontSize', font_size, 'Interpreter', 'latex');
      end

   end
end