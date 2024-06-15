
im='beta';%'tmap', 'beta'
smooth='0';
voxNb='100';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004'};%'013',,'pil005'
  
roiList={'M1'};
decodingConditionList = {'HUPT_HUFW_vs_HDPT_HDFW'};

visDir_M1=[];
% visDir_lhMT=[]; visDir_rhMT=[]; visDir_lS1=[]; visDir_lPC=[]; visDir_rPC=[]; visDir_lMTt=[]; visDir_rMTt=[];
% handDownDir_lhMT=[]; handDownDir_rhMT=[]; handDownDir_lS1=[]; handDownDir_lPC=[]; handDownDir_rPC=[]; handDownDir_lMTt=[]; handDownDir_rMTt=[];
% handUpDir_lhMT=[]; handUpDir_rhMT=[]; handUpDir_lS1=[]; handUpDir_lPC=[]; handUpDir_rPC=[]; handUpDir_lMTt=[]; handUpDir_rMTt=[];

for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
                if strcmp(char({accu(iAccu).mask}.'), 'M1')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
                        visDir_M1 = [visDir_M1;[accu(iAccu).accuracy].'];
%                         visDir_lhMT = [visDir_lhMT;[accu(iAccu).accuracy].'];
                    
                    end
                end
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'rhMT')==1
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_rhMT = [visDir_rhMT;[accu(iAccu).accuracy].'];
%                     
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'lS1')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_lS1 = [visDir_lS1;[accu(iAccu).accuracy].'];
%                     
%                         
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'lPC')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_lPC = [visDir_lPC;[accu(iAccu).accuracy].'];
%                     
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'rPC')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_rPC = [visDir_rPC;[accu(iAccu).accuracy].'];
%                     
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'lMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_lMTt = [visDir_lMTt;[accu(iAccu).accuracy].'];
%                     
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'rMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
%                         visDir_rMTt = [visDir_rMTt;[accu(iAccu).accuracy].'];
%                     
%                     end
%                 end
            end    
       end
            

    end
end

% decodAccu=[visDir_lhMT, visDir_rhMT,...
%     visDir_lS1,  visDir_lPC,  visDir_rPC,...
%     visDir_lMTt, visDir_rMTt ];
decodAccu=[visDir_M1];

meanDecodAccu=mean(decodAccu);
seDecodAccu=std(decodAccu)/sqrt(length(subList));

% T = array2table(decodAccu,...
%     'VariableNames',{'visDir_lhMT','handDownDir_lhMT','handUpDir_lhMT', 'visDir_rhMT', 'handDownDir_rhMT','handUpDir_rhMT',...
%     'visDir_lS1', 'handDownDir_lS1','handUpDir_lS1', 'visDir_lPC', 'handDownDir_lPC','handUpDir_lPC', 'visDir_rPC', 'handDownDir_rPC', 'handUpDir_rPC'...
%     'visDir_lMTt', 'handDownDir_lMTt', 'handUpDir_lMTt', 'visDir_rMTt', 'handDownDir_rMTt', 'handUpDir_rMTt'});

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

% model_series = [
%     mean(visDir_lS1),; mean(visDir_lPC); mean(visDir_rPC);...
%     mean(visDir_lMTt); mean(visDir_rMTt);...
%     mean(visDir_lhMT); mean(visDir_rhMT)];
% 
% model_error = [ std(visDir_lS1)/sqrt(length(subList)); ...
%     std(visDir_lPC)/sqrt(length(subList));...
%     std(visDir_rPC)/sqrt(length(subList));...
%     std(visDir_lMTt)/sqrt(length(subList));...
%     std(visDir_rMTt)/sqrt(length(subList));...
%     std(visDir_lhMT)/sqrt(length(subList));...
%     std(visDir_rhMT)/sqrt(length(subList))];

model_series=mean(visDir_M1);
model_error = [std(visDir_M1)/sqrt(length(subList))];
% b = bar(model_series, 0.5,'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2); 
b = bar(mean(visDir_M1));
b.LineWidth=LineWidthMean/2;
b.FaceColor='w';

b(1).EdgeColor = darkGreen;
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


% 
sz=40;
scatter(repmat(x(1,1), length(visDir_lS1), 1),visDir_M1,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);


% scatter(repmat(x(1,2), length(visDir_lPC), 1),visDir_lPC,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,3), length(visDir_rPC), 1),visDir_rPC,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,4), length(visDir_lMTt), 1),visDir_lMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,5), length(visDir_rMTt), 1),visDir_rMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,6), length(visDir_lhMT), 1),visDir_lhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% 
% scatter(repmat(x(1,7), length(visDir_rhMT), 1),visDir_rhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% Plot the errorbars
errorbar(x',model_series,model_error,'color',darkGreen,'linestyle','none','LineWidth',LineWidthMean/2);


hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)

hold off
ylim([0.2 0.9])
legend({'handUp-vs-handDown'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'M1',})
head1= 'Proprioceptive Activity'; 
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
