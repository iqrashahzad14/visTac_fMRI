
load ('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/multiDimensionalScaling/FoR2_pairwiseDA_radius8_smoothing2_ratio100_202310161702.mat')
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

roiLabel = 'rMTt';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004','013','pil005'};% 
  
roiList={'lhMT','rhMT','lS1','lPC', 'rPC', 'lMTt', 'rMTt'};

%list all the conditions accroding to the conditions
rowList={'1', '2', '3', '4', '5', '6'};
%     connectStr = '_vs_';
colList = {'1', '2', '3', '4', '5', '6'};
%create an empty cell array and pair them accrodingly in the empty cell
%array
for iCondition = 1:length(rowList)
    for iRow = 1:length(rowList)
        for iCol = 1:length(colList)
            condPair{iRow, iCol} = strcat(string(rowList(iRow)),',', string(colList(iCol)))
        end
    end
end

decodingConditionList = reshape(condPair,[36,1])';

emptyDAMatrix = zeros(6,6,length(subList));

for iAccu=1:length(accu)
    
    for iSub=1:length(subList)
        subID=subList(iSub);
        
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1
            if strcmp(char({accu(iAccu).mask}.'),char(roiLabel))==1
                if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                   decodingCondition = str2num(string({accu(iAccu).decodingCondition}.'));
                   a=decodingCondition(1);
                   b=decodingCondition(2);
                   emptyDAMatrix(a,b,iSub)= [accu(iAccu).accuracy].';

        %                    decodingCondition = {accu(1).decodingCondition}.'
        %                    decodingCondition=string(decodingCondition)
        %                    decodingCondition=str2num(decodingCondition)
        %                    a=decodingCondition(1)
        %                    b=decodingCondition(2)
        %                    emptyDAMatrix(a,b)
                end    
            end    
        end
    end 
end


avgDAMatrix=mean(emptyDAMatrix,3)
H = imagesc(avgDAMatrix);
labels = ...
{'handDownPinkyThumb', 'handDownFingerWrist', 'handUpPinkyThumb', 'handUpFingerWrist', 'visualHorizontal','visualVertical'};
labels = ...
    {'pt', 'fw', 'hor', 'ver', 'visHor','visVer'};
[Y,eigvals]  = cmdscale(avgDAMatrix)
plot(Y(:,1),Y(:,2),'.')
text(Y(:,1),Y(:,2),labels)
xlabel('dim1')
ylabel('dim2')
ylim([-0.3 0.3]);
xlim([-0.9 0.9]);
title(roiLabel)

