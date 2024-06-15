%%  extract the beta parameters in each clusters.

% use each mask - mt, mst, hMT on tactile motion Localizer
% take the avg of beta values from the roi
% (1)lmst- motion_beta and (2) lmst -static_beta 
% across two runs
clear

subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-007','sub-008'...
    'sub-009','sub-010','sub-015','sub-016','sub-017'...
    'sub-pil004','sub-pil005'};
%'sub-011','sub-013','sub-014', they do not have clusters for hMT+

opt.roi = {'lMst','lMT','lhMT','rMst','rMT','rhMT' };

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    %where is the glm
    glmDir =char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats-noResponses',char(subID),strcat('task-','tactileLocalizer2','_space-IXI549Space_FWHM-6')));

    %!!!Always check the betas here
    %if glm-noresponse: motion=1,9; static = 2,10
    %if glm-withresponse: then sub 14,15,16 dont have any repsonse
    %motion=1,10; static = 2,11
    motionBetaA = load_nii(char(fullfile(glmDir,'beta_0001.nii')));
    motionBetaB = load_nii(char(fullfile(glmDir,'beta_0009.nii')));
    staticBetaA = load_nii(char(fullfile(glmDir,'beta_0002.nii'))); 
    staticBetaB = load_nii(char(fullfile(glmDir,'beta_0010.nii')));
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method1','subjectCluster_base2pt6',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMst','.nii');
    roiName2 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMT','.nii');
    roiName3 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','.nii');
    roiName4 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMst','.nii');
    roiName5 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMT','.nii');
    roiName6 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
    roi6 = load_nii(char(fullfile(maskDir,roiName6)));
    
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
    
    activeVox6 = find(roi6.img == 1);
    betaEstMotion6(iSub,1) = mean([mean(motionBetaA.img(activeVox6(~isnan(motionBetaA.img(activeVox6))))),mean(motionBetaB.img(activeVox6(~isnan(motionBetaB.img(activeVox6)))))]);
    betaEstStatic6(iSub,1) = mean([mean(staticBetaA.img(activeVox6(~isnan(staticBetaA.img(activeVox6))))),mean(staticBetaB.img(activeVox6(~isnan(staticBetaB.img(activeVox6)))))]);
    findNan6(iSub,1)= sum(isnan(motionBetaA.img(activeVox6)))+sum(isnan((motionBetaB.img(activeVox6))));
    
    subName(iSub,1) = string(subID);
       
end

finalBetaResults = table(subName, betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6,...
   'VariableNames',{'subID', 'betaEstMotion1_lMst', 'betaEstStatic1_lMst','betaEstMotion2_lMT', 'betaEstStatic2_lMT',...
    'betaEstMotion3_lhMT', 'betaEstStatic3_lhMT','betaEstMotion4_rMst', 'betaEstStatic4_rMst',...
    'betaEstMotion5_rMT', 'betaEstStatic5_rMT','betaEstMotion6_rhMT', 'betaEstStatic6_rhMT'});

betaVal = [betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
    betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
    betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6];


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
    mean(betaEstMotion6), mean(betaEstStatic6)];


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

b(2).CData(1,:) = lightPurple;%'w';%Colors(4,:); % group 2 1st bar
b(2).CData(2,:) = lightPurple;%'w';%Colors(4,:); % group 2 2nd bar
b(2).CData(3,:) = lightPurple;%'w';%Colors(4,:); % group 2 3rd bar
b(2).CData(4,:) = lightPurple;%'w';%Colors(4,:); % group 2 
b(2).CData(5,:) = lightPurple;%'w';%Colors(4,:); % group 2 
b(2).CData(6,:) = lightPurple;%'w';%Colors(4,:); % group 2 


% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

% Plot the errorbars
%errorbar(x',model_series,model_error,'k','linestyle','none','LineWidth',LineWidthMean/2);


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
end

hold on
%plot chance level
% yline(0.5, '--','LineWidth',LineWidthMean/3)

hold off


% ylim([0.25 1])
legend({'motion','static'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Beta values')
xticklabels({'lMst','lMT','lhMT','rMst','rMT','rhMT'})
head1= 'Tactile motion and static beta estimates in Mt, Mst, hMT+ '; 
head2='';
title(head1, head2)


%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off


figureName=strcat('betaEstimates','clusterRoi','.png');
% derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))

% %%
% %settings for plots
% shape='o';
% %%set the size of the shape 
% % sz=50;
% %%set the width of the edge of the markers
% LineWidthMarkers=1.5;
% %%set the width of the edge of the mean line
% LineWidthMean=4;
% %%set the length of the mean line
% LineLength=0.4; %the actual length will be the double of this value%%%set the transparency of the markers
% Transparency=1;%0.7;
% %%set the color for each condition in RGB (and divide them by 256 to be matlab compatible)
% lightGreen=[105 170 153]/256; % Light green
% darkGreen=[24 96 88]/256;% Dark green
% lightOrange=[255 158 74]/256; % Light Orange
% darkOrange=[208 110 48]/256;% Dark Orange
% lightPurple=[198 131 239]/256;% Light Purple
% darkPurple=[121 57 195]/256; %Dark Purple
% Col_A=[105 170 153]/256; %
% Col_B=[24 96 88]/256;%
% Col_C=[255 158 74]/256; %
% Col_D=[208 110 48]/256;%
% Col_E=[198 131 239]/256;%
% Col_F=[121 57 195]/256; %
% Colors=[Col_A;Col_B;Col_C;Col_D;Col_E;Col_F];
% 
% %%set the font styles
% FontName='Avenir'; %set the style of the labels
% FontSize=17; %%set the size of the labels
% 
% figure(2)
% 
% model_series = [mean(betaEstMotion1), mean(betaEstStatic1);...
%     mean(betaEstMotion2), mean(betaEstStatic2);...
%     mean(betaEstMotion4), mean(betaEstStatic4);...
%     mean(betaEstMotion5), mean(betaEstStatic5);...
%     ];
% 
% model_error = [std(betaEstMotion1)/sqrt(length(subjectList)), std(betaEstStatic1)/sqrt(length(subjectList));...
%     std(betaEstMotion2)/sqrt(length(subjectList)), std(betaEstStatic2)/sqrt(length(subjectList));...
%     std(betaEstMotion4)/sqrt(length(subjectList)), std(betaEstStatic4)/sqrt(length(subjectList));...
%     std(betaEstMotion5)/sqrt(length(subjectList)), std(betaEstStatic5)/sqrt(length(subjectList));...
%     ];
% 
% % b = bar(model_series, 'grouped');
% b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );
% 
% b(1).EdgeColor = darkPurple;
% b(2).EdgeColor = lightPurple;
% 
% b(1).CData(1,:) = darkPurple;%'w';%Colors(2,:); % group 1 1st bar
% b(1).CData(2,:) = darkPurple;%'w';%Colors(2,:); % group 1 2nd bar
% b(1).CData(3,:) = darkPurple;%'w';%Colors(2,:); % group 1 3rd bar
% b(1).CData(4,:) = darkPurple;%'w';%Colors(2,:); % group 1
% 
% b(2).CData(1,:) = lightPurple;%'w';%Colors(4,:); % group 2 1st bar
% b(2).CData(2,:) = lightPurple;%'w';%Colors(4,:); % group 2 2nd bar
% b(2).CData(3,:) = lightPurple;%'w';%Colors(4,:); % group 2 3rd bar
% b(2).CData(4,:) = lightPurple;%'w';%Colors(4,:); % group 2 
% 
% % Calculate the number of groups and number of bars in each group
% [ngroups,nbars] = size(model_series);
% 
% % Get the x coordinate of the bars
% x = nan(nbars, ngroups);
% for i = 1:nbars
%     x(i,:) = b(i).XEndPoints;
% end
% hold on
% 
% % Plot the errorbars
% % errorbar(x',model_series,model_error,'k','linestyle','none','LineWidth',LineWidthMean/2);
% % 
% 
% % sz=20;
% % scatter(repmat(x(1,1), length(betaEstMotion1), 1),betaEstMotion1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % scatter(repmat(x(2,1), length(betaEstStatic1), 1),betaEstStatic1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % 
% % scatter(repmat(x(1,2), length(betaEstMotion2), 1),betaEstMotion2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % scatter(repmat(x(2,2), length(betaEstStatic2), 1),betaEstStatic2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % 
% % scatter(repmat(x(1,3), length(betaEstMotion3), 1),betaEstMotion3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % scatter(repmat(x(2,3), length(betaEstStatic3), 1),betaEstStatic3,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % 
% % scatter(repmat(x(1,4), length(betaEstMotion4), 1),betaEstMotion4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % scatter(repmat(x(2,4), length(betaEstStatic4), 1),betaEstStatic4,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% % 
% % % Plot connected lines
% % for iiSub=1:length(subjectList)
% %     hold on 
% %     plot([x(1,1), x(2,1)],[betaEstMotion1(iiSub), betaEstStatic1(iiSub)],'k')
% %     hold on 
% %     plot([x(1,2), x(2,2)],[betaEstMotion2(iiSub), betaEstStatic2(iiSub)],'k') 
% %     hold on 
% %     plot([x(1,3), x(2,3)],[betaEstMotion3(iiSub), betaEstStatic3(iiSub)],'k')  
% %     hold on 
% %     plot([x(1,4), x(2,4)],[betaEstMotion4(iiSub), betaEstStatic4(iiSub)],'k')
% %   
% % end
% 
% hold on
% %plot chance level
% % yline(0.5, '--','LineWidth',LineWidthMean/3)
% 
% hold off
% 
% % ylim([0.25 1])
% legend({'motion','static'},'Location','northeastoutside')
% xlabel('ROI') 
% ylabel('Beta values')
% xticklabels({'lMst','lMT','rMst','rMT'})
% head1= 'Tactile motion and static beta estimates in Mt, Mst '; 
% head2='';
% title(head1, head2)
% 
% 
% %format plot
% set(gcf,'color','w');
% ax=gca;
% 
% set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
%     'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
%     'FontSize',FontSize);
% box off
% 
% 
% figureName=strcat('betaEstimates','clusterRoi','.png');
% % derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% % saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))
% 

%% stats
for i =1:2:11
[h(i),p(i)]=ttest(betaVal(:,i),betaVal(:,i+1))
end

fdrCorrPVal=mafdr([p(1),p(3),p(5),p(7),p(9),p(11)], 'BHFDR', 'true')