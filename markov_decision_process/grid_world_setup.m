% AIMA grid world.

% States are, in row-major order on grid (11 total):
% 
%           1      2      3      4      5      6 .    7      8      9 .   10     11
%  (c,r): (1,1), (2,1), (3,1), (4,1), (1,2), (3,2), (4,2), (1,3), (2,3), (3,3), (4,3).

% Actions are, {up, down, left, right} (1 to 4, respectively).
actions = (1:4).';
action_names = {'Up'; 'Down'; 'Left'; 'Right'};

% Encode states... #, x, y.
states = [1, 1, 1;
          2, 2, 1;
          3, 3, 1;
          4, 4, 1; 
          5, 1, 2;
          6, 3, 2;
          7, 4, 2;
          8, 1, 3;
          9, 2, 3;
         10, 3, 3;
         11, 4, 3];

state_names = {'(1,1)';
               '(2,1)';
               '(3,1)';
               '(4,1)';
               '(1,2)';
               '(3,2)';
               '(4,2)';
               '(1,3)';
               '(2,3)';
               '(3,3)';
               '(4,3)'};
     
terminal = [7; 11];  % Terminal states, so no probability out...