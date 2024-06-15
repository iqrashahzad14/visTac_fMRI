%function [nbRun,chunkIdxMat,y] = createPseudoRun(nbRun)
    x = nchoosek(1:nbRun, 2); % creating unique pairs
    nbItr = size(x, 1); %total number of iterations depend on the number of unique pairs

    % Initialize result cell array
    % storing the order of runs after "randomly picking up two runs for
    % averaging)
    y = cell(1, 5); %order of runs/chunks to create pseudo runs

    for i = 1:nbItr % Repeat nbItr=45 times to choose 5 pairs
        % Randomly choose 5 pairs from x
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
    
    %store the new order of runs/chunks in as an array, such that each column
    %is a new ordered chunk
    % each column is a chunk
    for iPseudoRun=1:nbItr
        chunkIdxMat(:,iPseudoRun)=y{iPseudoRun}(:);
    end
    
%end
