% 
% clear
% chosen_pairs = [3,8; 1,4; 5,6; 2,5; 7,9];
% c = (1:10)';
% c_o = zeros(size(c));
% 
% for i = 1:size(chosen_pairs, 1)
%     % Get the current pair
%     pair = chosen_pairs(i, :);
%     
%     for j = 1:2
%         % Pick the j-th element in the pair
%         element_index = pair(j);
%         
%         % Check if the element has been picked before
%         if c_o(element_index) ~= 0
%             % If the element has been picked before, use the same value as
%             % its partner
%             c_o(element_index) = c_o(pair(3 - j));
%         else
%             % If the element has not been picked before, assign it a new value
%             c_o(element_index) = i;
%         end
%     end
% end
% 
% disp(c_o);

%%
nbRun = 9;
chosen_pairs = [3,8; 1,4; 5,6; 2,5; 7,9];
c = (1:nbRun)';
c_o = zeros(size(c));

% Iterate through chosen pairs
for i = 1:size(chosen_pairs, 1)
    % Get the current pair and its partner
    pair = chosen_pairs(i, :);
    partner = pair(2:-1:1); % Reverse the pair
    
    % Check if the element is already picked
    if c_o(pair(1)) == 0
        c_o(pair(1)) = i;
    else
        % If already picked, find the partner and assign the same number
        partner_idx = find(chosen_pairs(:, 1) == pair(1));
        c_o(pair(1)) = c_o(chosen_pairs(partner_idx, 2));
    end
    
    if c_o(pair(2)) == 0
        c_o(pair(2)) = i;
    else
        % If already picked, find the partner and assign the same number
        partner_idx = find(chosen_pairs(:, 2) == pair(2));
        c_o(pair(2)) = c_o(chosen_pairs(partner_idx, 1));
    end
end

disp(c_o);
