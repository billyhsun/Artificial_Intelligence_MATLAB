function [val] = dt_info_gain(attribute, col_idx, goal, examples)
% DT_INFO_GAIN Compute information gain for attribute.
%
% Utility function to compute the information gain after splitting on 
% attribute.
%
% Inputs:
% -------
%  attribute  - Dataset attribute, cell array.
%  col_idx    - Column index in examples corresponing to attribute.
%  goal       - Decision variable, cell array.
%  examples   - Training data; the final class is given by the last column.
%
% Outputs:
% --------
%  val  - Value of the information gain, given the attribute and examples.

% Insert your code here.
  
% Debug
% fprintf('Gain for %s is %f\n', attribute{1}, val);

end
