%% statistical significance in mvpa
% non-parametric technique by combining permutations and sign reversal

% step1: 
% for a ROI, 
% we have 20 subjects.
% step 0: calculate the actual mean the decod accu of 20 subjects
% %%%% Repeat nbItr = 10,000 times
% step 1:choose a random number nRan between 1 and 20
% step 2:Reverse the sign of the nRan subjects
% step 3:Calculate the new mean after the reverse 
% Repeat step 1,2,3 10,000 times
% step 1,2,3 creates the null distribution
% pval= proportion of values in the null distribution that are above the actual mean (=area under the curve)
% pval = count(nmbr of iterations when the new mean is greater than actual mean)/nbItr

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

% decodTitle= 'crossMod_Anat';
% decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};
% decodingCondition= 'both';

decodTitle= 'crossMod_Ext';
decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};
decodingCondition= 'both';

% decodTitle= 'prop';
% decodingConditionList = {'HUPT_HUFW_vs_HDPT_HDFW'};
% decodingCondition= 'HUPT_HUFW_vs_HDPT_HDFW';

%%
roiList={'lS1','lMTt','rMTt','lhMT','rhMT'};

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '013','014','015','016','017',...
             'pil001','pil002','pil004','pil005'};%,
         
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

% number of iterations for group level null distribution
nbIter = 10000;

% groupNullDistr=zeros(length(roiList),nbIter);
% subAccu=zeros(length(subList),length(roiList));

subArray=[1:length(subList)];
subDaArray=zeros(length(subList),length(roiList));
for iRoi=1:length(roiList)
roiLabel=roiList(iRoi);
  disp(roiList(iRoi))
    subDa=[];
    for iAccu=1:length(accu)
        %check if all the parameters and conditions match             
        if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1   
            if strcmp(string({accu(iAccu).decodingCondition}.'),decodingCondition)==1  
                if strcmp(string({accu(iAccu).mask}.'),roiLabel)==1
                    %SUBJECT DA for the ROI
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},decodingCondition )==1
                    subDa = [subDa;[accu(iAccu).accuracy].'];
%                     subDa(:,iRoi) = [accu(iAccu).accuracy].';
                    end
                end
            end
        end
    end
    
subDaArray(:,iRoi)=subDa;% DA for across subjects for a Roi
subDa=subDa-0.5;% subtracting the chance level, so that we test against 0 from now
%%%%
    %for iIter times, randomly pick nRand sub DA
    for iIter = 1:nbIter
        nRand=randi(length(subList));
        randomSubOrder = randperm(length(subList)); %randomise the order fo subjects
        pickedSub = subArray(randomSubOrder(1:nRand)); % pick the first nRand subjects
        nonPickedSub=subArray(randomSubOrder(nRand+1:end));
        pickedDa = -1*subDa(pickedSub); %reverse the sign of the picked subjects
        nonPickedDa = subDa(nonPickedSub);
        newMeanDa(iIter)=mean([pickedDa;nonPickedDa]); %take the mean of the picked and non-picked subjects
    end
%%%%
groupNullDistr(iRoi,:) = newMeanDa;
% groupNullDistr(iRoi,:) = mean(subSamp);
% obsPVal(iRoi) = sum(mean(subAccu(:,iRoi))<groupNullDistr(iRoi,:))/nbIter;
obsPVal(iRoi) = length(find(newMeanDa>mean(subDa)))/nbIter;

end
%%
for iRRoi = 1:5
    subplot(2,3,iRRoi)
    histogram(groupNullDistr(iRRoi,:))
    title(cell2mat(roiList(iRRoi)))
end
sgtitle(strcat('groupNullDis', '-',decodTitle,'-',decodingCondition))
% saveas(gcf,strcat('groupNullDis', '_',decodTitle,'_',decodingCondition,'_',im,'.png'))
%% STEP : correct the obtained p-value 

obsPVal 
fdrCorrPVal=mafdr(obsPVal, 'BHFDR', 'true')


%% save the outout

% set output folder/name
pathOutput='/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/mvpaStats_pseudo';
savefileMat = fullfile(pathOutput, ...
                     ['stats','Pseudo', '_',decodTitle,'_',decodingCondition,'_',im,'_', datestr(now, 'yyyymmddHHMM'), '.mat']);
                             
%store output
mvpaStats.decodTitle = decodTitle;
mvpaStats.decodCondition = decodingCondition;
mvpaStats.imageType = im;
mvpaStats.roiList = roiList; % this tells the order of corresponding p-values
mvpaStats.groupNullDistr = groupNullDistr; % the rows are in the order of Roi list
mvpaStats.subAccu = subDaArray;
mvpaStats.obsPVal = obsPVal; % in the order of roi list
mvpaStats.fdrCorPVal = fdrCorrPVal;

% mat file
% save(savefileMat, 'mvpaStats');