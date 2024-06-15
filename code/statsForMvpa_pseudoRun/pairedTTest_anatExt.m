%paired comparisons ttest
clear all

load('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/mvpaStats_pseudo/statsPseudo_anat_HDPT_HUPT_vs_HDFW_HUFW_beta_202404182045.mat')
anatSubAccu=mvpaStats.subAccu ;
roiList=mvpaStats.roiList  

load('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/mvpaStats_pseudo/statsPseudo_ext_HUPT_HDFW_vs_HDPT_HUFW_beta_202404182047.mat')
extSubAccu=mvpaStats.subAccu ;
roiList=mvpaStats.roiList  

%%
% % distribution of paired differences
% for iRoi=1:length(roiList)
%     diff(:,iRoi)=[anatSubAccu(:,iRoi)-extSubAccu(:,iRoi)];
% end
% for iRRoi = 1:length(roiList)
%     subplot(2,3,iRRoi)
%     histogram(diff(:,iRRoi))
%     title(cell2mat(roiList(iRRoi)))
% end
% sgtitle(strcat('pairedTTest', '-','distribution'))
% saveas(gcf,strcat('groupNullDis', '_',decodTitle,'_',decodingCondition,'_',im,'.png'))
%%
%paired t-test %%wilcoxon
for iRoi=1:length(roiList)
    [h(iRoi),p(iRoi), ci{iRoi}, stats{iRoi}]=ttest(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
%     [p(iRoi),h(iRoi),stats{iRoi}]=signrank(anatSubAccu(:,iRoi),extSubAccu(:,iRoi),0.5);
end

%fdr correction
fdrCorrPVal=mafdr(p, 'BHFDR', 'true');

%%%%%
% RESULTS paired ttest
% h = 1     0     0     0     0
% p = 0.0005    0.6520    0.1945    0.7760    0.1850
% fdrCorrPVal=  0.0023    0.7760    0.3241    0.7760    0.3241
%%%%%
% wilconx signrank
% p =0.0017    0.6541    0.1305    0.8563    0.2041
% fdrCorrPVal =0.0086    0.8176    0.3262    0.8563    0.3402