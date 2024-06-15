%% extract the beta parameters from ROIS

% spherical functional roi
% use subkect masks - lS1, lPC, rPC, lMTt, rMTt, lhMT, rhMT 
% VISUAL MOTION LOCALIZER
% take the avg of beta values from the roi
% example (1)lPC- motion_beta and (2) rPC -static_beta 
% across two runs

clear

roiType = 'subjectSphere';
radiusNb='8';
taskName= 'visualLocalizer2';

subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
    'sub-009','sub-010','sub-011', 'sub-013','sub-014','sub-015','sub-016','sub-017',...
    'sub-pil004','sub-pil005'}; %'sub-pil001','sub-pil002',

opt.roi = {'lS1','lPC','rPC','lMTt','rMTt','lhMT','rhMT' };


for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    
    %where is the glm
    glmDir =char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats-noResponses',char(subID),strcat('task-',taskName,'_space-IXI549Space_FWHM-6')));

    motionBetaA = load_nii(char(fullfile(glmDir,'beta_0001.nii')));
    
    staticBetaA = load_nii(char(fullfile(glmDir,'beta_0002.nii'))); 
    
    
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lS1','_radiusNb-',radiusNb,'.nii'); 
    roiName2 = strcat(subID,'_hemi-','L','_space-MNI_label-','lPC','_radiusNb-',radiusNb,'.nii');
    roiName3 = strcat(subID,'_hemi-','R','_space-MNI_label-','rPC','_radiusNb-',radiusNb,'.nii');
    roiName4 = strcat(subID,'_hemi-','l','_space-MNI_label-','lMTt','_radiusNb-',radiusNb,'.nii');
    roiName5 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMTt','_radiusNb-',radiusNb,'.nii');
    roiName6 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','_radiusNb-',radiusNb,'.nii');
    roiName7 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-',radiusNb,'.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
    roi6 = load_nii(char(fullfile(maskDir,roiName6)));
    roi7 = load_nii(char(fullfile(maskDir,roiName7)));
    
    %find the beta for roi1
    %take the indices of the voxels=1 in roi1
    activeVox1 = find(roi1.img == 1);
    %find the value of voxel at that index and then take the mean 
    %betaEstMotion1(iSub,1) = mean(motionBetaA.img(activeVox1))+mean(motionBetaB.img(activeVox1));
    betaEstMotion1(iSub,1) = mean(motionBetaA.img(activeVox1(~isnan(motionBetaA.img(activeVox1)))));
    betaEstStatic1(iSub,1) = mean(staticBetaA.img(activeVox1(~isnan(staticBetaA.img(activeVox1)))));
    findNan1(iSub,1)= sum(isnan(motionBetaA.img(activeVox1))); % taking sum because we want to count the number of 1s
    
    %repeat for all rois
    
    activeVox2 = find(roi2.img == 1);
    betaEstMotion2(iSub,1) = mean(motionBetaA.img(activeVox2(~isnan(motionBetaA.img(activeVox2)))));
    betaEstStatic2(iSub,1) = mean(staticBetaA.img(activeVox2(~isnan(staticBetaA.img(activeVox2)))));
    findNan2(iSub,1)= sum(isnan(motionBetaA.img(activeVox2)));
    
    activeVox3 = find(roi3.img == 1);
    betaEstMotion3(iSub,1) = mean(motionBetaA.img(activeVox3(~isnan(motionBetaA.img(activeVox3)))));
    betaEstStatic3(iSub,1) = mean(staticBetaA.img(activeVox3(~isnan(staticBetaA.img(activeVox3)))));
    findNan3(iSub,1)= sum(isnan(motionBetaA.img(activeVox3)));
    
    activeVox4 = find(roi4.img == 1);
    betaEstMotion4(iSub,1) = mean(motionBetaA.img(activeVox4(~isnan(motionBetaA.img(activeVox4)))));
    betaEstStatic4(iSub,1) = mean(staticBetaA.img(activeVox4(~isnan(staticBetaA.img(activeVox4)))));
    findNan4(iSub,1)= sum(isnan(motionBetaA.img(activeVox4)));
    
    activeVox5 = find(roi5.img == 1);
    betaEstMotion5(iSub,1) = mean(motionBetaA.img(activeVox5(~isnan(motionBetaA.img(activeVox5)))));
    betaEstStatic5(iSub,1) = mean(staticBetaA.img(activeVox5(~isnan(staticBetaA.img(activeVox5)))));
    findNan5(iSub,1)= sum(isnan(motionBetaA.img(activeVox5)));
    
    activeVox6 = find(roi6.img == 1);
    betaEstMotion6(iSub,1) = mean(motionBetaA.img(activeVox6(~isnan(motionBetaA.img(activeVox6)))));
    betaEstStatic6(iSub,1) = mean(staticBetaA.img(activeVox6(~isnan(staticBetaA.img(activeVox6)))));
    findNan6(iSub,1)= sum(isnan(motionBetaA.img(activeVox6)));
    
    activeVox7 = find(roi7.img == 1);
    betaEstMotion7(iSub,1) = mean(motionBetaA.img(activeVox7(~isnan(motionBetaA.img(activeVox7)))));
    betaEstStatic7(iSub,1) = mean(staticBetaA.img(activeVox7(~isnan(staticBetaA.img(activeVox7)))));
    findNan7(iSub,1)= sum(isnan(motionBetaA.img(activeVox7)));
    
    subName(iSub,1) = string(subID);
       
end

finalBetaResults = table(subName, betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6, betaEstMotion7, betaEstStatic7,...
   'VariableNames',{'subID', 'betaEstMotion1_lS1', 'betaEstStatic1_lS1',...
   'betaEstMotion2_lPC', 'betaEstStatic2_lPC','betaEstMotion3_rPC', 'betaEstStatic3_rPC',...
   'betaEstMotion4_lMTt', 'betaEstStatic4_lMTt','betaEstMotion5_rMTt', 'betaEstStatic5_rMTt',...
   'betaEstMotion6_lhMT', 'betaEstStatic6_lhMT','betaEstMotion6_rhMT', 'betaEstStatic6_rhMT'});

betaVal = [betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6, betaEstMotion7, betaEstStatic7];

%%
%settings for plots
shape='o';
%%set the size of the shape 
% sz=50;
%%set the width of the edge of the markers
LineWidthMarkers=1.5;
%%set the width of the edge of the mean line
LineWidthMean=4;
%%set the length of the mean line
LineLength=0.4; %the actual length will be the double of this value%%%set the transparency of the markers
Transparency=1;%0.7;
%%set the color for each condition in RGB (and divide them by 256 to be matlab compatible)
lightGreen=[105 170 153]/256; % Light green
darkGreen=[24 96 88]/256;% Dark green
lightOrange=[255 158 74]/256; % Light Orange
darkOrange=[208 110 48]/256;% Dark Orange
lightPurple=[198 131 239]/256;% Light Purple
darkPurple=[121 57 195]/256; %Dark Purple
Col_A=[105 170 153]/256; %
Col_B=[24 96 88]/256;%
Col_C=[255 158 74]/256; %
Col_D=[208 110 48]/256;%
Col_E=[198 131 239]/256;%
Col_F=[121 57 195]/256; %
Colors=[Col_A;Col_B;Col_C;Col_D;Col_E;Col_F];

%%set the font styles
FontName='Avenir'; %set the style of the labels
FontSize=17; %%set the size of the labels

figure(1)

model_series = [mean(betaEstMotion1), mean(betaEstStatic1);...
    mean(betaEstMotion2), mean(betaEstStatic2);...
    mean(betaEstMotion3), mean(betaEstStatic3);...
    mean(betaEstMotion4), mean(betaEstStatic4);...
    mean(betaEstMotion5), mean(betaEstStatic5);...
    mean(betaEstMotion6), mean(betaEstStatic6);...
    mean(betaEstMotion7), mean(betaEstStatic7)];


% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );

b(1).EdgeColor = darkPurple;
b(2).EdgeColor = lightPurple;

b(1).CData(1,:) = darkPurple;%'w';%Colors(2,:); % group 1 1st bar
b(1).CData(2,:) = darkPurple;%'w';%Colors(2,:); % group 1 2nd bar
b(1).CData(3,:) = darkPurple;%'w';%Colors(2,:); % group 1 3rd bar
b(1).CData(4,:) = darkPurple;%'w';%Colors(2,:); % group 1
b(1).CData(5,:) = darkPurple;%'w';%Colors(2,:); % group 1
b(1).CData(6,:) = darkPurple;%'w';%Colors(2,:); % group 1
b(1).CData(7,:) = darkPurple;%'w';%Colors(2,:); % group 1

b(2).CData(1,:) = lightPurple;%'w';%Colors(4,:); % group 2 1st bar
b(2).CData(2,:) = lightPurple;%'w';%Colors(4,:); % group 2 2nd bar
b(2).CData(3,:) = lightPurple;%'w';%Colors(4,:); % group 2 3rd bar
b(2).CData(4,:) = lightPurple;%'w';%Colors(4,:); % group 2 
b(2).CData(5,:) = lightPurple;%'w';%Colors(4,:); % group 2 
b(2).CData(6,:) = lightPurple;%'w';%Colors(4,:); % group 2 
b(2).CData(7,:) = lightPurple;%'w';%Colors(4,:); % group 2 

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

% Plot the errorbars
% errorbar(x',model_series,model_error,'k','linestyle','none','LineWidth',LineWidthMean/2);

sz=20;
scatter(repmat(x(1,1), length(betaEstMotion1), 1),betaEstMotion1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,1), length(betaEstStatic1), 1),betaEstStatic1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,2), length(betaEstMotion2), 1),betaEstMotion2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,2), length(betaEstStatic2), 1),betaEstStatic2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,3), length(betaEstMotion3), 1),betaEstMotion3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,3), length(betaEstStatic3), 1),betaEstStatic3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,4), length(betaEstMotion4), 1),betaEstMotion4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,4), length(betaEstStatic4), 1),betaEstStatic4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,5), length(betaEstMotion5), 1),betaEstMotion5,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,5), length(betaEstStatic5), 1),betaEstStatic5,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,6), length(betaEstMotion6), 1),betaEstMotion6,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,6), length(betaEstStatic6), 1),betaEstStatic6,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,7), length(betaEstMotion7), 1),betaEstMotion7,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,7), length(betaEstStatic7), 1),betaEstStatic7,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

% Plot connected lines
for iiSub=1:length(subjectList)
    hold on 
    plot([x(1,1), x(2,1)],[betaEstMotion1(iiSub), betaEstStatic1(iiSub)],'k')
    hold on 
    plot([x(1,2), x(2,2)],[betaEstMotion2(iiSub), betaEstStatic2(iiSub)],'k') 
    hold on 
    plot([x(1,3), x(2,3)],[betaEstMotion3(iiSub), betaEstStatic3(iiSub)],'k')  
    hold on 
    plot([x(1,4), x(2,4)],[betaEstMotion4(iiSub), betaEstStatic4(iiSub)],'k')
    hold on 
    plot([x(1,5), x(2,5)],[betaEstMotion5(iiSub), betaEstStatic5(iiSub)],'k')    
    hold on 
    plot([x(1,6), x(2,6)],[betaEstMotion6(iiSub), betaEstStatic6(iiSub)],'k')
    hold on 
    plot([x(1,7), x(2,7)],[betaEstMotion7(iiSub), betaEstStatic7(iiSub)],'k')
end

hold on
%plot chance level
% yline(0.5, '--','LineWidth',LineWidthMean/3)

hold off


% ylim([0.25 1])
legend({'motion','static'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Beta values')
xticklabels({'lS1','lPC','rPC','lMTt','rMTt','lhMT','rhMT'})
head1= strcat('motion and static beta estimates in spherical Rois (radius-',radiusNb,') for task- ',taskName); 
head2='';
title(head1, head2)


%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off


figureName=strcat('betaEstimates','spherical','.png');
% derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))

