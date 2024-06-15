%% statistical significance in mvpa
% non-parametric technique by combining permutations and bootstrapping

% step1: 
% For each subject, the labels of the different conditions (eg. motion_vertical and motion_horizontal) were permuted,
% and the same decoding analysis was performed. 
% The previous step was repeated 100 times for each subject.

% DONE in our decoding scripts

% step2:
% A bootstrap procedure was applied in order to obtain a group-level null distribution 
% that was representative of the whole group. 
% From each subject’s null distribution, one value was randomly chosen (with replacement) 
% and averaged across all participants. 
% This step was repeated 100,000 times resulting in a group-level null distribution of 100,000 values. 

% step3:
% The statistical significance of the MVPA results was estimated by comparing the observed result 
% to the group-level null distribution. This was done by calculating the proportion of observations 
% in the null distribution that had a classification accuracy higher than the one obtained in the real test.

% step4:
% To account for the multiple comparisons, all p values were corrected using false discovery rate (FDR) correction 

%% set which file, condition and roi label are we testing

% load the .mat file with decoding accuracies

% decodTitle= 'visDirSel';
% decodingConditionList = {'handDown_pinkyThumb_vs_handDown_fingerWrist',...
%     'handUp_pinkyThumb_vs_handUp_fingerWrist',...
%       'visual_vertical_vs_visual_horizontal'};
% decodingCondition='visual_vertical_vs_visual_horizontal';


% decodTitle= 'anat';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
% decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
% decodingCondition= 'HDPT_HUPT_vs_HDFW_HUFW';

% decodTitle= 'ext';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
% decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
% decodingCondition= 'HUPT_HDFW_vs_HDPT_HUFW';

decodTitle= 'crossMod_Anat';
decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};
decodingCondition= 'trainVisual_testTactile';

% decodTitle= 'crossMod_Ext';
% decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};
% decodingCondition= 'trainVisual_testTactile';

% decodTitle= 'prop';
% decodingConditionList = {'HUPT_HUFW_vs_HDPT_HDFW'};
% decodingCondition= 'HUPT_HUFW_vs_HDPT_HDFW';

roiList={'lS1','lPC', 'rPC', 'lMTt', 'rMTt','lhMT','rhMT'};

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '014','015','016','017',...
             'pil001','pil002','pil004','013','pil005'};%,
         
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

% number of iterations for group level null distribution
nbIter = 100000;

groupNullDistr=zeros(length(roiList),nbIter);
subAccu=zeros(length(subList),length(roiList));

for iRoi=1:length(roiList)
roiLabel=roiList(iRoi);
  disp(roiList(iRoi))

%% STEP 1: DONE

%% STEP 2: create group null distribution
timeStart=datestr(now,'HH:MM')
subSamp = zeros(length(subList), nbIter);
for iIter = 1:nbIter
%     disp(iIter)
    for iAccu=1:length(accu)
        
        for iSub=1:length(subList)
            subID=subList(iSub);
            if strcmp(char({accu(iAccu).subID}.'),char(subID))==1
                %check if all the parameters and conditions match             
                if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1   
                    if strcmp(string({accu(iAccu).decodingCondition}.'),decodingCondition)==1  
                        if strcmp(string({accu(iAccu).mask}.'),roiLabel)==1
                            
                            %read the subject level permutations = accu(iAccu).permutation;
                            %pick one decoding accuracy randomly with replacement
                            subSamp(iSub, iIter) = datasample(accu(iAccu).permutation,1); 

                        end

                    end
                end
            end
        end
    end
end

timeEnd=datestr(now,'HH:MM')
groupNullDistr(iRoi,:) = mean(subSamp);

%% STEP 3: check where does the avg accu of the group falls in the group level null ditribution
% calculate the proportion of values in the group null ditribution which are above the actual decoding
% accuracy for a one-tailed test. accordingly change for two-tailed test.
% p = sum(accuracy < acc0) / nbIter; %from Ceren
% pValue = (sum(Pooled_Perm>accuracy)+1)/(1+NrPermutations); % from Mohamed

for iAccu=1:length(accu)     
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1
            %check if all the parameters and conditions match             
            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1   
                if strcmp(string({accu(iAccu).decodingCondition}.'),decodingCondition)==1  
                    if strcmp(string({accu(iAccu).mask}.'),roiLabel)==1

                        %read the actual decoding accuracy 
                        subAccu(iSub,iRoi)=[accu(iAccu).accuracy].';
                        
                    end
                end
            end
        end
    end
end

subObsPVal(iRoi) = sum(mean(subAccu(:,iRoi))<groupNullDistr(iRoi,:))/nbIter;

end

%% STEP 4: correct the obtained p-value 

% function mafdr([vector of pvalues], BHFDR, 'true') % from Stefania
fdrCorrPVal=mafdr(subObsPVal, 'BHFDR', 'true')
% fdrCorrPValBasic=mafdr(subObsPVal);

%% save the outout

% set output folder/name
pathOutput='/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/mvpaStats';
savefileMat = fullfile(pathOutput, ...
                     ['stats', '_',decodTitle,'_',decodingCondition,'_',im,'_', datestr(now, 'yyyymmddHHMM'), '.mat']);
                 
% set structure array for keeping the results
% mvpaStats = struct( ...
%             'decodTitle', [], ...
%             'decodCondition', [], ...
%             'roiList', [], ...
%             'groupNullDis', [], ...
%             'obsPVal', [], ...
%             'fdrCorPVal', []);
            
%store output
mvpaStats.decodTitle = decodTitle;
mvpaStats.decodCondition = decodingCondition;
mvpaStats.imageType = im;
mvpaStats.roiList = roiList; % this tells the order of corresponding p-values
mvpaStats.groupNullDistr = groupNullDistr; % the rows are in the order of Roi list
mvpaStats.subAccu = subAccu;
mvpaStats.obsPVal = subObsPVal; % in the order of roi list
mvpaStats.fdrCorPVal = fdrCorrPVal;

% mat file
save(savefileMat, 'mvpaStats');