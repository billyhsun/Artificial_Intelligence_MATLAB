% Part 1 Example - Inference Over Definite Clauses
clear; close all; clc;

% This implicitly defines propositions P1, P2, P3, P4, and P5.
n_symbols = 5;

% This means that the KB asserts P1 and P3 are true.
KB_facts = [1 3];

% This means that the KB knows P1 => P2, P2 & P3 => P4.
KB_def = {[1 2], [2 3 4]};

% Easy to verify manually that P5 is not entailed by KB.
q1 = 5;
is_inferred_false = inference_method(n_symbols, KB_facts, KB_def, q1)

% Easy to verify manually that P4 is entailed by KB.
q2 = 4;
is_inferred_true = inference_method(n_symbols, KB_facts, KB_def, q2)