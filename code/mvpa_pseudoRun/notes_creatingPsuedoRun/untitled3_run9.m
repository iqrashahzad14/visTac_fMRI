%% to create pseudo run
% label the chunks from 1 to 10
% reorder the labels of the chunks depending on the unique pairs
% Iqra Shahzad; 11 April 2024

clear all
nbRun = 9;
x = nchoosek(1:nbRun, 2); % creating unique pairs
nbItr = size(x, 1); %total number of iterations depend on the number of unique pairs

% Initialize result cell array
% storing the order of runs after "randomly picking up two runs for
% averaging)
y = cell(1, 5); %order of runs/chunks to create 5 pseudo runs 

for i = 1:nbItr % Repeat nbItr=45 times to choose 5 pairs
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
% now, rearrange the order of chunks based on the pairs
% the indices of the elements in a pair are used to reorder the chunk
c=repmat([1:nbRun]',1,nbItr); %actual order of the chunk
c_o=zeros(size(c)); %empty vector to store the re-ordered labels of chunks
for j=1:nbRun
    for i = 1:nbItr
            yInd = find(y{i}==j)
            cInd = find(c(:,i)==j)
            c_o(cInd,i) = yInd(1)
    end
end
chunkIdxMat=c_o;

%% for nbRun=9
% elements in the same row of chosen_pairs are called partners
% pick the 3rd element in c and make it 1
% pick the 8th element in c and make it 1
% pick the 1st element in c amd make it 2
% pick the 4th element in c and make it 2
% pick the 5th element in c amd make it 3
% pick the 6th element in c and make it 3
% pick the 2th element in c amd make it 4
% pick the 5th element in c and make it 4
% pick the 7th element in c amd make it 5
% pick the 9th element in c and make it 5
% 
% since 5th element is picked twice, so, when we pick it the second time ,do the same as what u do for its partner