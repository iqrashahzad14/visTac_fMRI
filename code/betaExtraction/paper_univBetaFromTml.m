%% Plot the beta parameters from a ROI

% spherical functional roi
% use subject masks - lS1, lPC, rPC, lMTt, rMTt, lhMT, rhMT 
% from TACTILE MOTION LOCALIZER 
% take the avg of beta values from the roi
% example (1)lS1- motion_beta and (2) rS1 -static_beta 
% across two runs

%% extract beta estimates from TML task and hMT
clear

roiType = 'subjectSphere';
radiusNb='8';
subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
    'sub-009','sub-010','sub-011', 'sub-013','sub-014','sub-015','sub-016','sub-017',...
    'sub-pil004','sub-pil005'}; %'sub-pil001','sub-pil002',,

opt.roi = {'lS1''lMTt','rMTt','lhMT','rhMT' };

%%
taskName= 'tactileLocalizer2';

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    %where is the glm
    glmDir =char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats-noResponses',char(subID),strcat('task-',taskName,'_space-IXI549Space_FWHM-6')));

    %!!!Always check the betas here
    %if glm-noresponse: motion=1,9; static = 2,10
    %if glm-withresponse: then sub 14,15,16 dont have any repsonse
    %motion=1,10; static = 2,11
    motionBetaA = load_nii(char(fullfile(glmDir,'beta_0001.nii')));
    motionBetaB = load_nii(char(fullfile(glmDir,'beta_0009.nii')));
    staticBetaA = load_nii(char(fullfile(glmDir,'beta_0002.nii'))); 
    staticBetaB = load_nii(char(fullfile(glmDir,'beta_0010.nii')));
    
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lS1','_radiusNb-',radiusNb,'.nii');
    roiName2 = strcat(subID,'_hemi-','l','_space-MNI_label-','lMTt','_radiusNb-',radiusNb,'.nii');
    roiName3 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMTt','_radiusNb-',radiusNb,'.nii');
    roiName4 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','_radiusNb-',radiusNb,'.nii');
    roiName5 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-',radiusNb,'.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
  
    
    %find the beta for roi1
    %take the indices of the voxels=1 in roi1
    activeVox1 = find(roi1.img == 1);
    %find the value of voxel at that index and then take the mean 
    %betaEstMotion1(iSub,1) = mean(motionBetaA.img(activeVox1))+mean(motionBetaB.img(activeVox1));
    betaEstMotion1(iSub,1) = mean([mean(motionBetaA.img(activeVox1(~isnan(motionBetaA.img(activeVox1))))),mean(motionBetaB.img(activeVox1(~isnan(motionBetaB.img(activeVox1)))))]);
    betaEstStatic1(iSub,1) = mean([mean(staticBetaA.img(activeVox1(~isnan(staticBetaA.img(activeVox1))))),mean(staticBetaB.img(activeVox1(~isnan(staticBetaB.img(activeVox1)))))]);
    findNan1(iSub,1)= sum(isnan(motionBetaA.img(activeVox1)))+sum(isnan((motionBetaB.img(activeVox1))));
    
    %repeat for all rois
    
    activeVox2 = find(roi2.img == 1);
    betaEstMotion2(iSub,1) = mean([mean(motionBetaA.img(activeVox2(~isnan(motionBetaA.img(activeVox2))))),mean(motionBetaB.img(activeVox2(~isnan(motionBetaB.img(activeVox2)))))]);
    betaEstStatic2(iSub,1) = mean([mean(staticBetaA.img(activeVox2(~isnan(staticBetaA.img(activeVox2))))),mean(staticBetaB.img(activeVox2(~isnan(staticBetaB.img(activeVox2)))))]);
    findNan2(iSub,1)= sum(isnan(motionBetaA.img(activeVox2)))+sum(isnan((motionBetaB.img(activeVox2))));
    
    activeVox3 = find(roi3.img == 1);
    betaEstMotion3(iSub,1) = mean([mean(motionBetaA.img(activeVox3(~isnan(motionBetaA.img(activeVox3))))),mean(motionBetaB.img(activeVox3(~isnan(motionBetaB.img(activeVox3)))))]);
    betaEstStatic3(iSub,1) = mean([mean(staticBetaA.img(activeVox3(~isnan(staticBetaA.img(activeVox3))))),mean(staticBetaB.img(activeVox3(~isnan(staticBetaB.img(activeVox3)))))]);
    findNan3(iSub,1)= sum(isnan(motionBetaA.img(activeVox3)))+sum(isnan((motionBetaB.img(activeVox3))));
    
    activeVox4 = find(roi4.img == 1);
    betaEstMotion4(iSub,1) = mean([mean(motionBetaA.img(activeVox4(~isnan(motionBetaA.img(activeVox4))))),mean(motionBetaB.img(activeVox4(~isnan(motionBetaB.img(activeVox4)))))]);
    betaEstStatic4(iSub,1) = mean([mean(staticBetaA.img(activeVox4(~isnan(staticBetaA.img(activeVox4))))),mean(staticBetaB.img(activeVox4(~isnan(staticBetaB.img(activeVox4)))))]);
    findNan4(iSub,1)= sum(isnan(motionBetaA.img(activeVox4)))+sum(isnan((motionBetaB.img(activeVox4))));
    
    activeVox5 = find(roi5.img == 1);
    betaEstMotion5(iSub,1) = mean([mean(motionBetaA.img(activeVox5(~isnan(motionBetaA.img(activeVox5))))),mean(motionBetaB.img(activeVox5(~isnan(motionBetaB.img(activeVox5)))))]);
    betaEstStatic5(iSub,1) = mean([mean(staticBetaA.img(activeVox5(~isnan(staticBetaA.img(activeVox5))))),mean(staticBetaB.img(activeVox5(~isnan(staticBetaB.img(activeVox5)))))]);
    findNan5(iSub,1)= sum(isnan(motionBetaA.img(activeVox5)))+sum(isnan((motionBetaB.img(activeVox5))));
    
    subName(iSub,1) = string(subID);
       
end

%%
% finalBetaResults = table(subName, betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
%     betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
%     betaEstMotion5, betaEstStatic5,...
%    'VariableNames',{'subID', 'betaEstMotion1_lS1', 'betaEstStatic1_lS1',...
%    'betaEstMotion4_lMTt', 'betaEstStatic4_lMTt','betaEstMotion5_rMTt', 'betaEstStatic5_rMTt',...
%    'betaEstMotion6_lhMT', 'betaEstStatic6_lhMT','betaEstMotion6_rhMT', 'betaEstStatic6_rhMT'});

betaVal = [betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5];

T=array2table(betaVal,...
    'VariableNames',{'Motion_lS1', 'Static_lS1',...
   'Motion_lMTt', 'Static_lMTt','Motion_rMTt', 'Static_rMTt',...
   'Motion_lhMT', 'Static_lhMT','Motion_rhMT', 'Static_rhMT'});
 
cd('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/univar')
writetable(T,'betaFromTML.xlsx')
cd('/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/betaExtraction')