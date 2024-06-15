%% make a list of all pairwise decodings
%%
%list all the conditions
rowList={'VH', 'VV', 'HUPT', 'HUFW', 'HDPT', 'HDFW'};
connectStr = '_vs_';
colList = {'VH', 'VV', 'HUPT', 'HUFW', 'HDPT', 'HDFW'};

%create an empty cell array and pair them accrodingly in the empty cell
%array
pairCondition={};
for iCondition = 1:length(rowList)
    for iRow = 1:length(rowList)
        for iCol = 1:length(colList)
            pairCondition{iRow, iCol} = strcat(string(rowList(iRow)), connectStr, string(colList(iCol)));
        end
    end
end
decodingConditionList = reshape(pairCondition,[36,1])';
%%
% %list all the conditions acc to the FoR
% rowList={'VH', 'VV', 'HUPT_HDPT_pt', 'HUFW_HDFW_fw', 'HUPT_HDFW_hor', 'HUFW_HDPT_ver'};
% connectStr = '_vs_';
% colList = {'VH', 'VV', 'HUPT_HDPT_pt', 'HUFW_HDFW_fw', 'HUPT_HDFW_hor', 'HUFW_HDPT_ver'};

%%
%list all the conditions accroding to the conditions
rowList={'1', '2', '3', '4', '5', '6'};
connectStr = '_vs_';
colList = {'1', '2', '3', '4', '5', '6'};

%create an empty cell array and pair them accrodingly in the empty cell
%array
pairCondition={};
for iCondition = 1:length(rowList)
    for iRow = 1:length(rowList)
        for iCol = 1:length(colList)
%             condPair(iRow, iCol) = (str2num(string(iRow)), str2num(string(iCol)))
            condPair{iRow, iCol} = strcat(string(rowList(iRow)),',', string(colList(iCol)))
%             condPair{iRow, iCol} = strcat(string(rowList(iRow)),',', string(colList(iCol)))
        end
    end
end
