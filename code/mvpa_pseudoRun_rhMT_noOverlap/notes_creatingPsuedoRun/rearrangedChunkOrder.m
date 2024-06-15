%% to create pseudo run
% label the chunks from 1 to 10
% reorder the labels of the chunks depending on the unique pairs
% Iqra Shahzad; 11 April 2024

clear all
nbRun = 10;
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

% Display the result cell array
% disp(y);

%store the new order of runs/chunks in as an array, such that each column
%is a new ordered chunk
% each column is a chunk
for iPseudoRun=1:nbItr
    chunkIdxMat(:,iPseudoRun)=y{iPseudoRun}(:);
end

%%
%checking the sum of indices
for i= 1:size(chunkIdxMat,2)
    sumChunkIdx(i)=sum(chunkIdxMat(:,i));
end

%%
% when nbRun=10, To check if the elements in each cell of y are unique
% when nbRun=9, To check which elements are not unique and how many times they are repeated in each cell of y
if nbRun == 10
    % when nbRun=10, To check if the elements in each cell of y are unique
    for i = 1:length(y)
        % Flatten the matrix into a single vector
        elements = y{i}(:);

        % Check for uniqueness using the unique function
        unique_elements = unique(elements);

        % If the lengths are different, there are repeated elements
        if numel(elements) ~= numel(unique_elements)
            disp(['Elements in cell ', num2str(i), ' are not unique.']);
        else
            disp(['Elements in cell ', num2str(i), ' are unique.']);
        end
    end
elseif nbRun == 9
    % when nbRun=9, To check which elements are not unique and how many times they are repeated in each cell of y
    for i = 1:length(y)
        % Flatten the matrix into a single vector
        elements = y{i}(:);

        % Count the occurrences of each element
        [unique_elements, ~, counts] = unique(elements);
        counts = histcounts(counts, 1:max(counts)+1);

        % Find the elements that are not unique
        non_unique_elements = unique_elements(counts > 1);

        % Display the non-unique elements and their counts
        if ~isempty(non_unique_elements)
            disp(['In cell ', num2str(i), ':']);
            for j = 1:length(non_unique_elements)
                disp(['Element ', num2str(non_unique_elements(j)), ' is repeated ', num2str(counts(counts > 1)), ' times.']);
    %             disp(['Element ', num2str(non_unique_elements(j)), ' is repeated ', num2str(counts(counts > 1)(j)), ' times.']);
            end
        else
            disp(['In cell ', num2str(i), ': All elements are unique.']);
        end
    end
end

