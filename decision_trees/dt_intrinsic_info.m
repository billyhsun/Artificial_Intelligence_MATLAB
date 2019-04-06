function [val] = dt_intrinsic_info(attribute, col_idx, examples) 
% DT_INTRINSIC_INFO Compute the intrinsic information for attribute.
%
% Utility function to compute the intrinsic information of a speciifed
% attribute.
%
% Inputs:
% -------
%  attribute  - Dataset attribute, cell array.
%  col_idx    - Column index in examples corresponing to attribute.
%  examples   - Training data; the final class is given by the last column.
%
% Outputs:
% --------
%  val  - Value of the intrinsic information for the attribute and examples.

% Insert your code here. Be careful to check the number	of examples and
% with NaN values!

apps = examples(:, col_idx);
patt = zeros(length(attribute{2}), 1);

for i = 1:length(apps)    % Count frequencies
   patt(apps(i)) = patt(apps(i)) + 1;
end

patt = patt / size(examples, 1);   % Normalize

val = 0;
for i = 1:length(attribute{2})    % Calculate using formula
    if patt(i) ~= 0
        val = val - patt(i) * log2(patt(i));
    end
end 

end
