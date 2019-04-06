function [val] = dt_cond_entropy(attribute, col_idx, goal, examples) 
% DT_COND_ENTROPY Compute the conditional entropy for attribute.
%
% Utility function to compute the conditional entropy (wich is always over the 
% 'decision' varaible or goal), given a speciifed attribute.
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
%  val  - Value of the conditional entropy, given the attribute and examples.

% Insert your code here. Be careful to check the number	of examples and
% with NaN values!

apps = examples(:,col_idx);
labels = examples(:,end);
card = length(apps)

M = length(goal{2})
N = length(attribute{2})

patt = zeros(N, 1);  % Probability distribution of attribute
joint = zeros(N, M);  % Joint probability distribution

for i = 1:card   % Count frequencies
   patt(apps(i)) = patt(apps(i)) + 1;
   joint(apps(i), labels(i)) = joint(apps(i), labels(i)) + 1;
end

joint = joint / size(examples,1);    % Normalize
patt = patt / size(examples,1);

val = 0;
for i = 1:N        % Apply formula to find entropy
    for j = 1:M
        if joint(i,j) ~= 0
            val = val - joint(i,j) * (log2(joint(i,j)) - log2(patt(i)));
        end
    end
end    

end
