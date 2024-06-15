
im='beta';%'tmap', 'beta'
smooth='0';
voxNb='100';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004'};%'013',,'pil005'
  
roiList={'lS2', 'rS2'};
decodingConditionList = {'handDown_pinkyThumb_vs_handDown_fingerWrist', 'handUp_pinkyThumb_vs_handUp_fingerWrist',...
      'visual_vertical_vs_visual_horizontal'};

visDir_lS2=[]; visDir_rS2=[]; 
handDownDir_lS2=[]; handDownDir_rS2=[]; 
handUpDir_lS2=[]; handUpDir_rS2=[]; 

for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'lhMT')==1
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
%                         visDir_lhMT = [visDir_lhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
%                         handDownDir_lhMT = [handDownDir_lhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
%                         handUpDir_lhMT = [handUpDir_lhMT;[accu(iAccu).accuracy].'];
%                     end
%                 end
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'rhMT')==1
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
%                         visDir_rhMT = [visDir_rhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
%                         handDownDir_rhMT = [handDownDir_rhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
%                         handUpDir_rhMT = [handUpDir_rhMT;[accu(iAccu).accuracy].'];
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'lS1')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
%                         visDir_lS1 = [visDir_lS1;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
%                         handDownDir_lS1 = [handDownDir_lS1;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
%                         handUpDir_lS1 = [handUpDir_lS1;[accu(iAccu).accuracy].'];
%                     end
%                 end
%                 
                if strcmp(char({accu(iAccu).mask}.'), 'lS2')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
                        visDir_lS2 = [visDir_lS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
                        handDownDir_lS2 = [handDownDir_lS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
                        handUpDir_lS2 = [handUpDir_lS2;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rS2')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
                        visDir_rS2 = [visDir_rS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
                        handDownDir_rS2 = [handDownDir_rS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
                        handUpDir_rS2 = [handUpDir_rS2;[accu(iAccu).accuracy].'];
                    end
                end
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'lMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
%                         visDir_lMTt = [visDir_lMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
%                         handDownDir_lMTt = [handDownDir_lMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
%                         handUpDir_lMTt = [handUpDir_lMTt;[accu(iAccu).accuracy].'];
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'rMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
%                         visDir_rMTt = [visDir_rMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
%                         handDownDir_rMTt = [handDownDir_rMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
%                         handUpDir_rMTt = [handUpDir_rMTt;[accu(iAccu).accuracy].'];
%                     end
%                 end
            end    
       end
            

    end
end

decodAccu=[visDir_lS2, handDownDir_lS2,handUpDir_lS2, visDir_rS2, handDownDir_rS2, handUpDir_rS2 ];
meanDecodAccu=mean(decodAccu);
seDecodAccu=std(decodAccu)/sqrt(length(subList));

% T = array2table(decodAccu,...
%     'VariableNames',{'visDir_lhMT','handDownDir_lhMT','handUpDir_lhMT', 'visDir_rhMT', 'handDownDir_rhMT','handUpDir_rhMT',...
%     'visDir_lS1', 'handDownDir_lS1','handUpDir_lS1', 'visDir_lS2', 'handDownDir_lS2','handUpDir_lS2', 'visDir_rS2', 'handDownDir_rS2', 'handUpDir_rS2'...
%     'visDir_lMTt', 'handDownDir_lMTt', 'handUpDir_lMTt', 'visDir_rMTt', 'handDownDir_rMTt', 'handUpDir_rMTt'});

figure(1)

model_series = [ mean(visDir_lS2), mean(handDownDir_lS2),mean(handUpDir_lS2); mean(visDir_rS2), mean(handDownDir_rS2), mean(handUpDir_rS2)];

model_error = [ std(visDir_lS2)/sqrt(length(subList)), std(handDownDir_lS2)/sqrt(length(subList)),std(handUpDir_lS2)/sqrt(length(subList));...
    std(visDir_rS2)/sqrt(length(subList)), std(handDownDir_rS2)/sqrt(length(subList)), std(handUpDir_rS2)/sqrt(length(subList))];

b = bar(model_series, 'grouped'); 

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

% Plot the errorbars
errorbar(x',model_series,model_error,'k','linestyle','none');
% 
sz=20;
% scatter(repmat(x(1,1), length(visDir_lhMT), 1),visDir_lhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,1), length(handDownDir_lhMT), 1),handDownDir_lhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(3,1), length(handUpDir_lhMT), 1),handUpDir_lhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,2), length(visDir_rhMT), 1),visDir_rhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,2), length(handDownDir_rhMT), 1),handDownDir_rhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(3,2), length(handUpDir_rhMT), 1),handUpDir_rhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,3), length(visDir_lS1), 1),visDir_lS1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,3), length(handDownDir_lS1), 1),handDownDir_lS1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(3,3), length(handUpDir_lS1), 1),handUpDir_lS1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,1), length(visDir_lS2), 1),visDir_lS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,1), length(handDownDir_lS2), 1),handDownDir_lS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(3,1), length(handUpDir_lS2), 1),handUpDir_lS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,2), length(visDir_rS2), 1),visDir_rS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(2,2), length(handDownDir_rS2), 1),handDownDir_rS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
scatter(repmat(x(3,2), length(handUpDir_rS2), 1),handUpDir_rS2,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

% scatter(repmat(x(1,6), length(visDir_lMTt), 1),visDir_lMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,6), length(handDownDir_lMTt), 1),handDownDir_lMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(3,6), length(handUpDir_lMTt), 1),handUpDir_lMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,7), length(visDir_rMTt), 1),visDir_rMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,7), length(handDownDir_rMTt), 1),handDownDir_rMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(3,7), length(handUpDir_rMTt), 1),handUpDir_rMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');


hold on
%plot chance level
yline(0.5, '--')

hold off
ylim([0.3 0.9])
legend({'vis-VerVsHor','handDown-VerVsHor','handUp-VerVsHor'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lS2', 'rS2'})
head1= 'Within-HandPosture Direction Selectivity'; 
head2=strcat('image=', im,' smoothing=',smooth,' ', ' voxelNb=',voxNb);
title(head1, head2)

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
%%set the font styles
FontName='Avenir'; %set the style of the labels
FontSize=17; %%set the size of the labels

%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off


figureName=strcat('dirSelWithinModality','_','image_',im,'_','smoothing',smooth,'_','voxelNb',voxNb,'.png');
derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))

%%
%%
%settings for plots
shape='o';
%%set the size of the shape 
% sz=50;
%%set the width of the edge of the markers
LineWidthMarkers=1.5;
%%set the width of the edge of the mean line
LineWidthMean=5;
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

%% 
figure(2)

model_series = [mean(visDir_lS2); mean(visDir_rS2)];

model_error = [ std(visDir_lS2)/sqrt(length(subList));...
    std(visDir_rS2)/sqrt(length(subList))];

b = bar(model_series, 0.5,'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2); 

b(1).EdgeColor = darkOrange;
% 
% b(1).CData(1,:) = lightPurple; % group 1 1st bar
% b(1).CData(2,:) = lightPurple; % group 1 2nd bar
% b(1).CData(3,:) = lightPurple; % group 1 3rd bar
% b(1).CData(4,:) = lightPurple; % group 1
% b(1).CData(5,:) = lightPurple; % group 1
% b(1).CData(6,:) = lightPurple; % group 1
% b(1).CData(7,:) = lightPurple; % group 1
b(1).CData(1,:) = 'w';%darkPurple; % group 3 1st bar
b(1).CData(2,:) = 'w';%darkPurple; % group 3 2nd bar
% b(1).CData(3,:) = 'w';%darkPurple; % group 3 3rd bar
% b(1).CData(4,:) = 'w';%darkPurple; % group 3 
% b(1).CData(5,:) = 'w';%darkPurple; % group 3 
% b(1).CData(6,:) = 'w';%darkPurple; % group 3 
% b(1).CData(7,:) = 'w';%darkPurple; % group 3 


% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on


% 
sz=40;
% scatter(repmat(x(1,1), length(visDir_lS1), 1),visDir_lS1,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);


scatter(repmat(x(1,1), length(visDir_lS2), 1),visDir_lS2,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);


scatter(repmat(x(1,2), length(visDir_rS2), 1),visDir_rS2,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);


% scatter(repmat(x(1,4), length(visDir_lMTt), 1),visDir_lMTt,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,5), length(visDir_rMTt), 1),visDir_rMTt,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,6), length(visDir_lhMT), 1),visDir_lhMT,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,7), length(visDir_rhMT), 1),visDir_rhMT,sz,'MarkerEdgeColor',darkOrange,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% Plot the errorbars
errorbar(x',model_series,model_error,'color',darkOrange,'linestyle','none','LineWidth',LineWidthMean/2);


hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)

hold off
ylim([0.2 0.9])
legend({'vis-VerVsHor'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lS2', 'rS2'})
head1= 'Visual Direction Selectivity'; 
head2=strcat('image=', im,' smoothing=',smooth,' ', ' voxelNb=',voxNb);
title(head1, head2)

%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off

% saveas(gcf,strcat('V_HD_', 'CrossModal','_','image_',im,'_','smoothing',smooth,'_','voxelNb',voxNb,'.png'))

%%
%%
%settings for plots
shape='o';
%%set the size of the shape 
% sz=50;
%%set the width of the edge of the markers
LineWidthMarkers=1.5;
%%set the width of the edge of the mean line
LineWidthMean=5;
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


figure(3)

model_series = [mean(handDownDir_lS2),mean(handUpDir_lS2); ...
     mean(handDownDir_rS2), mean(handUpDir_rS2)];

model_error = [std(handDownDir_lS2)/sqrt(length(subList)),std(handUpDir_lS2)/sqrt(length(subList));...
    std(handDownDir_rS2)/sqrt(length(subList)), std(handUpDir_rS2)/sqrt(length(subList))];

b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2); 

b(1).EdgeColor = darkGreen;
b(2).EdgeColor = lightGreen;

b(1).CData(1,:) = 'w';%darkGreen; % group 1 1st bar
b(1).CData(2,:) = 'w';%darkGreen; % group 1 2nd bar
% b(1).CData(3,:) = 'w';%darkGreen; % group 1 3rd bar
% b(1).CData(4,:) = 'w';%darkGreen; % group 1
% b(1).CData(5,:) = 'w';%darkGreen; % group 1
% b(1).CData(6,:) = 'w';%darkGreen; % group 1
% b(1).CData(7,:) = 'w';%darkGreen; % group 1
b(2).CData(1,:) = 'w';%lightGreen; % group 2 1st bar
b(2).CData(2,:) = 'w';%lightGreen; % group 2 2nd bar
% b(2).CData(3,:) = 'w';%lightGreen; % group 2 3rd bar
% b(2).CData(4,:) = 'w';%lightGreen; % group 2 
% b(2).CData(5,:) = 'w';%lightGreen; % group 2 
% b(2).CData(6,:) = 'w';%lightGreen; % group 2 
% b(2).CData(7,:) = 'w';%lightGreen; % group 2 

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on


sz=40;

% scatter(repmat(x(1,1), length(handDownDir_lhMT), 1),handDownDir_lhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,1), length(handUpDir_lhMT), 1),handUpDir_lhMT,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,2), length(handDownDir_rhMT), 1),handDownDir_rhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,2), length(handUpDir_rhMT), 1),handUpDir_rhMT,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,3), length(handDownDir_lS1), 1),handDownDir_lS1,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,3), length(handUpDir_lS1), 1),handUpDir_lS1,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,1), length(handDownDir_lS2), 1),handDownDir_lS2,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
scatter(repmat(x(2,1), length(handUpDir_lS2), 1),handUpDir_lS2,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,2), length(handDownDir_rS2), 1),handDownDir_rS2,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
scatter(repmat(x(2,2), length(handUpDir_rS2), 1),handUpDir_rS2,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% scatter(repmat(x(1,6), length(handDownDir_lMTt), 1),handDownDir_lMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,6), length(handUpDir_lMTt), 1),handUpDir_lMTt,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,7), length(handDownDir_rMTt), 1),handDownDir_rMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,7), length(handUpDir_rMTt), 1),handUpDir_rMTt,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% Plot the errorbars
errorbar(x',model_series,model_error,'color',darkGreen,'linestyle','none','LineWidth',LineWidthMean/2);

hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)

hold off
ylim([0.2 0.9])
legend({'handDown-PTvsFW','handUp-PTvsFW'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lS2', 'rS2'})
head1= 'Within-HandPosture Direction Selectivity'; 
head2=strcat('image=', im,' smoothing=',smooth,' ', ' voxelNb=',voxNb);
title(head1, head2)

%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off


figureName=strcat('dirSelWithinModality','_','image_',im,'_','smoothing',smooth,'_','voxelNb',voxNb,'.png');
derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))

