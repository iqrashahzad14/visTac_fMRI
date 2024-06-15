%% check the within subject variance from pseudo run classifications


%% set which file, condition and roi label are we testing

% load the .mat file with decoding accuracies
clear all
load('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/decoding_pseudoRuns/FoR2_CrossModalExt_radius8_smoothing2_ratio100_pseudo_uncommentZero_202404160229.mat')

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
                        SubAccuPseudo(iAccu,iRoi) = {accu(iAccu).accuPseudo}.' ; % collect and orgnise the within sub DA
                    end
                end
            end
        end
    end
end

SubAccuPseudoNew = SubAccuPseudo(~cellfun(@isempty, SubAccuPseudo)); %remove the empty cells   
SubAccuPseudoNew=reshape(SubAccuPseudoNew,[20,5]); % reshape the cells

for iRoi = 1:length(roiList)
    xtick1=linspace(0.55,11.55, length(subList));
    for iSub=1:length(subList)
        subplot(2,3,iRoi) 
        scatter(repmat(xtick1(iSub),[1,45]),SubAccuPseudoNew{iSub,iRoi})
        scatter(xtick1(iSub), mean(SubAccuPseudoNew{iSub,iRoi}), '*')
        hold on        
        
        ylim([0.3, 0.7])
        title(cell2mat(roiList(iRoi)))
    end
    hold on
    scatter(xtick1(10), mean(SubAccuPseudoNew{iSub,iRoi}),10000, '_','MarkerEdgeColor','k','MarkerFaceColor','k')
    
end
sgtitle(strcat('withinSub'))
