%% to create pseudo run
% label the chunks from 1 to 10
% reorder the labels of the chunks depending on the unique pairs
% Iqra Shahzad; 11 April 2024
% for 5 PseudoRuns

function [chunkMatrix,nbRun,nbItr]=createPseudoRun(nbRun)

%%
% nbRun = 10;
x = nchoosek(1:nbRun, 2); % creating unique pairs
nbItr = size(x, 1); %total number of iterations depend on the number of unique pairs

%%
% Initialize result cell array
% storing the order of runs after "randomly picking up two runs for
% averaging)
y = cell(1, 5); %order of runs/chunks to create 5 pseudo runs 

for i = 1:nbItr % Repeat nbItr times to choose 5 pairs
    % Randomly choose 5 pairs (= 5 pseudoruns) from x
    chosen_indices = randperm(nbItr, 5);
    chosen_pairs = x(chosen_indices, :);
    
    % Check if chosen pairs are not repeated
    while numel(unique(chosen_pairs(:))) < nbRun %unique elements in chosen pairs must total to nbRun
        chosen_indices = randperm(nbItr, 5);
        chosen_pairs = x(chosen_indices, :);
    end
    
    % Store chosen pairs in result cell array
    y{i} = chosen_pairs;
end

%%
b = repmat((1:nbRun)', 1, nbItr); % Actual order of the chunk
b_o = zeros(size(b)); % Empty vector to store the re-ordered labels of chunks

for k = 1:nbItr
    c = b(:, k);
    c_o = b_o(:, k); % Initialize c_o from b_o
    
    chosen_pairs = y{k};
    
    for i = 1:size(chosen_pairs, 1)
        % Get the current pair and its partner
        pair = chosen_pairs(i, :);
        pairRow=i;
        partner = pair(2:-1:1); % Reverse the pair
        
        if c_o(pair(1)) == 0 && c_o(pair(2)) == 0
        c_o(pair(1)) = i; c_o(pair(2)) = i;
        
        elseif c_o(pair(1)) ~= 0 && c_o(pair(2)) == 0 %first one has been assigned
            pair(1) = pair(2); %the first one takes that of the second
            c_o(pair(1)) = i;
        elseif c_o(pair(1)) == 0 && c_o(pair(2)) ~= 0
            pair(2) = pair(1); % the second one takes that of first
            c_o(pair(2)) = i;     
        end

    end
    
    % Update b_o with c_o
    b_o(:, k) = c_o;
end

chunkMatrix= b_o;
end