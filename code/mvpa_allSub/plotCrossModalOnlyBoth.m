
im='beta';%'t_maps', 'beta'
smooth='2';
voxNb='100';

subList= {'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004','013','pil005'};%,,
         
roiList={'lhMT','rhMT','lS1','lPC', 'rPC', 'lMTt', 'rMTt'};
decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};

trainVis_lhMT=[]; trainVis_rhMT=[]; trainVis_lS1=[]; trainVis_lPC=[]; trainVis_rPC=[]; trainVis_lMTt=[]; trainVis_rMTt=[];
trainTac_lhMT=[]; trainTac_rhMT=[]; trainTac_lS1=[]; trainTac_lPC=[]; trainTac_rPC=[]; trainTac_lMTt=[]; trainTac_rMTt=[];
both_lhMT=[]; both_rhMT=[]; both_lS1=[]; both_lPC=[]; both_rPC=[]; both_lMTt=[]; both_rMTt=[];


for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
                if strcmp(char({accu(iAccu).mask}.'), 'lhMT')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_lhMT = [trainVis_lhMT;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_lhMT = [trainTac_lhMT;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_lhMT = [both_lhMT;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rhMT')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_rhMT = [trainVis_rhMT;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_rhMT = [trainTac_rhMT;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_rhMT = [both_rhMT;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'lS1')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_lS1 = [trainVis_lS1;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_lS1 = [trainTac_lS1;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_lS1 = [both_lS1;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'lPC')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_lPC = [trainVis_lPC;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_lPC = [trainTac_lPC;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_lPC = [both_lPC;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rPC')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_rPC = [trainVis_rPC;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_rPC = [trainTac_rPC;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_rPC = [both_rPC;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'lMTt')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_lMTt = [trainVis_lMTt;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_lMTt = [trainTac_lMTt;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_lMTt = [both_lMTt;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rMTt')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'trainVisual_testTactile' )==1
                        trainVis_rMTt = [trainVis_rMTt;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'trainTactile_testVision' )==1
                        trainTac_rMTt = [trainTac_rMTt;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'both' )==1
                        both_rMTt = [both_rMTt;[accu(iAccu).accuracy].'];
                    end
                end
            end    
       end
            

    end
end

decodAccu=[trainVis_lhMT,trainTac_lhMT,both_lhMT, trainVis_rhMT, trainTac_rhMT,both_rhMT,...
    trainVis_lS1, trainTac_lS1, both_lS1, trainVis_lPC, trainTac_lPC,both_lPC, trainVis_rPC, trainTac_rPC,both_rPC,...
    trainVis_lMTt, trainTac_lMTt, both_lMTt, trainVis_rMTt, trainTac_rMTt, both_rMTt ];

meanDecodAccu=mean(decodAccu);
seDecodAccu=std(decodAccu)/sqrt(length(subList));

T = array2table(decodAccu,...
    'VariableNames',{'trainVis_lhMT','trainTac_lhMT','both_lhMT', 'trainVis_rhMT', 'trainTac_rhMT','both_rhMT',...
    'trainVis_lS1', 'trainTac_lS1','both_lS1', 'trainVis_lPC', 'trainTac_lPC','both_lPC', 'trainVis_rPC', 'trainTac_rPC','both_rPC',...
    'trainVis_lMTt', 'trainTac_lMTt', 'both_lMTt', 'trainVis_rMTt', 'trainTac_rMTt','both_rMTt'});
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

figure(3)

model_series = [mean(both_lS1);...
       mean(both_lPC); mean(both_rPC);... 
       mean(both_lMTt); mean(both_rMTt);...
       mean(both_lhMT); mean(both_rhMT)];

model_error = [std(both_lS1)/sqrt(length(subList)); ...
    std(both_lPC)/sqrt(length(subList)); std(both_rPC)/sqrt(length(subList));...
     std(both_lMTt)/sqrt(length(subList)); std(both_rMTt)/sqrt(length(subList));...
     std(both_lhMT)/sqrt(length(subList)); std(both_rhMT)/sqrt(length(subList))];

% b = bar(model_series, 'grouped'); 
b = bar(model_series, 0.5, 'FaceColor','flat', 'LineWidth',LineWidthMean/2 );

% b(1).EdgeColor = darkGreen;
% b(2).EdgeColor = darkOrange;
b(1).EdgeColor = darkPurple;

% b(1).CData(1,:) = darkGreen; % group 1 1st bar
% b(1).CData(2,:) = darkGreen; % group 1 2nd bar
% b(1).CData(3,:) = darkGreen; % group 1 3rd bar
% b(1).CData(4,:) = darkGreen; % group 1
% b(1).CData(5,:) = darkGreen; % group 1
% b(1).CData(6,:) = darkGreen; % group 1
% b(1).CData(7,:) = darkGreen; % group 1
% b(2).CData(1,:) = darkOrange; % group 2 1st bar
% b(2).CData(2,:) = darkOrange; % group 2 2nd bar
% b(2).CData(3,:) = darkOrange; % group 2 3rd bar
% b(2).CData(4,:) = darkOrange; % group 2 
% b(2).CData(5,:) = darkOrange; % group 2 
% b(2).CData(6,:) = darkOrange; % group 2 
% b(2).CData(7,:) = darkOrange; % group 2 
b(1).CData(1,:) = 'w';%darkPurple; % group 3 1st bar
b(1).CData(2,:) = 'w';%darkPurple; % group 3 2nd bar
b(1).CData(3,:) = 'w';%darkPurple; % group 3 3rd bar
b(1).CData(4,:) = 'w';%darkPurple; % group 3 
b(1).CData(5,:) = 'w';%darkPurple; % group 3 
b(1).CData(6,:) = 'w';%darkPurple; % group 3 
b(1).CData(7,:) = 'w';%darkPurple; % group 3 


% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

sz=40;
scatter(repmat(x(1,1), length(both_lS1), 1),both_lS1,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,2), length(both_lPC), 1),both_lPC,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,3), length(both_rPC), 1),both_rPC,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,4), length(both_lMTt), 1),both_lMTt,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,5), length(both_rMTt), 1),both_rMTt,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,6), length(both_lhMT), 1),both_lhMT,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,7), length(both_rhMT), 1),both_rhMT,sz,'MarkerEdgeColor',darkPurple,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% Plot the errorbars
errorbar(x',model_series,model_error,'k','color',darkPurple,'linestyle','none','LineWidth',LineWidthMean/2);

hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)

hold off
ylim([0.45 0.54])
legend({'both' },'Location','northeast')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lS1','lPC', 'rPC', 'lMTt','rMTt','lhMT','rhMT'})
head1= 'CrossModal-Ext'; 
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