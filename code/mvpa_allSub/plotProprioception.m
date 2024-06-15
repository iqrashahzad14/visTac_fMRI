
im='beta';%'tmap', 'beta'
smooth='0';
voxNb='90';

subList={'001','002','003','004','005','006','007','008',...
    '009','010','011','013','pil001','pil002','pil004','pil005'}; 

roiList={'M','S1','PC'};
decodingConditionList = {'HUPT_HUFW_vs_HDPT_HDFW'};

prop_M=[]; prop_PC=[]; prop_S=[];
% anat_lhMT=[]; anat_rhMT=[]; anat_lS1=[]; anat_lPC=[]; anat_rPC=[]; anat_lMTt=[]; anat_rMTt=[];
% ext_lhMT=[]; ext_rhMT=[]; ext_lS1=[]; ext_lPC=[]; ext_rPC=[]; ext_lMTt=[]; ext_rMTt=[];


for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
                if strcmp(char({accu(iAccu).mask}.'), 'M1')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
                        prop_M = [prop_M;[accu(iAccu).accuracy].'];
                    
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'S1')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
                        prop_S = [prop_S;[accu(iAccu).accuracy].'];
                    
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'PC')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HUPT_HUFW_vs_HDPT_HDFW' )==1
                        prop_PC = [prop_PC;[accu(iAccu).accuracy].'];
                    
                    end
                end
                
                
            end    
       end
            

    end
end

decodAccu=[prop_M, prop_S, prop_PC];
% meanDecodAccu=mean(decodAccu);
% seDecodAccu=std(decodAccu)/sqrt(length(subList));

T = array2table(decodAccu,'VariableNames',{'prop_M', 'prop_S', 'prop_PC' });

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


model_series = [mean(prop_M);...
    mean(prop_S);...
    mean(prop_PC)];

model_error = [std(prop_M)/sqrt(length(subList));...
    std(prop_S)/sqrt(length(subList));...
    std(prop_PC)/sqrt(length(subList))];

% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );

% b(1).EdgeColor = Colors(2,:);
% b(2).EdgeColor = Colors(4,:);
% 
% b(1).CData(1,:) = lightGreen;%'w';%Colors(2,:); % group 1 1st bar
% b(1).CData(2,:) = lightGreen;%'w';%Colors(2,:); % group 1 2nd bar
% b(1).CData(3,:) = lightGreen;%'w';%Colors(2,:); % group 1 3rd bar
% b(1).CData(4,:) = lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(5,:) = lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(6,:) = lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(7,:) = lightGreen;%'w';%Colors(2,:); % group 1
% b(2).CData(1,:) = lightOrange;%'w';%Colors(4,:); % group 2 1st bar
% b(2).CData(2,:) = lightOrange;%'w';%Colors(4,:); % group 2 2nd bar
% b(2).CData(3,:) = lightOrange;%'w';%Colors(4,:); % group 2 3rd bar
% b(2).CData(4,:) = lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(5,:) = lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(6,:) = lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(7,:) = lightOrange;%'w';%Colors(4,:); % group 2 


% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

% Plot the errorbars
errorbar(x',model_series,model_error,'k','linestyle','none','LineWidth',LineWidthMean/2);
% 

sz=20;
scatter(repmat(x(1,1), length(prop_M), 1),prop_M,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,1), length(ext_lhMT), 1),ext_lhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');


scatter(repmat(x(1,2), length(prop_S), 1),prop_S,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,2), length(ext_rhMT), 1),ext_rhMT,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

scatter(repmat(x(1,3), length(prop_PC), 1),prop_PC,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,3), length(ext_lS1), 1),ext_lS1,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');


% scatter(repmat(x(1,4), length(anat_lPC), 1),anat_lPC,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,4), length(ext_lPC), 1),ext_lPC,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% scatter(repmat(x(1,5), length(anat_rPC), 1),anat_rPC,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,5), length(ext_rPC), 1),ext_rPC,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% 
% scatter(repmat(x(1,6), length(anat_lMTt), 1),anat_lMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,6), length(ext_lMTt), 1),ext_lMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% 
% 
% scatter(repmat(x(1,7), length(anat_rMTt), 1),anat_rMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');
% scatter(repmat(x(2,7), length(ext_rMTt), 1),ext_rMTt,sz,'MarkerEdgeColor','k','MarkerFaceColor','k');

% % Plot connected lines
% for iiSub=1:length(subList)
%     hold on 
%     plot([x(1,1), x(2,1)],[prop_M(iiSub), ext_lhMT(iiSub)],'k')
%     hold on 
%     plot([x(1,2), x(2,2)],[prop_S(iiSub), ext_rhMT(iiSub)],'k')
%     
%     hold on 
%     plot([x(1,3), x(2,3)],[prop_PC(iiSub), ext_lS1(iiSub)],'k')
%    
%     hold on 
%     plot([x(1,4), x(2,4)],[anat_lPC(iiSub), ext_lPC(iiSub)],'k')
%     hold on 
%     plot([x(1,5), x(2,5)],[anat_rPC(iiSub), ext_rPC(iiSub)],'k')
%     
%     hold on 
%     plot([x(1,6), x(2,6)],[anat_lMTt(iiSub), ext_lMTt(iiSub)],'k')
%     hold on 
%     plot([x(1,7), x(2,7)],[anat_rMTt(iiSub), ext_rMTt(iiSub)],'k')
%     
% end

hold on
%plot chance level
yline(0.5, '--','LineWidth',LineWidthMean/3)

hold off


ylim([0.25 1])
% legend({''},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'M','S','PC'})
head1= 'Proprioceptive'; 
head2=strcat('image=', im,' smoothing=',smooth,' ', ' featureNb=',voxNb);
% head3 = strcat('roiType=', roiType, ' rad=',rad, ' expandVox=', expandVox);
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


figureName=strcat('AcrossHandAnatExt','_','image_',im,'_','smoothing',smooth,'_','voxelNb',voxNb,'.png');
derivativeDir= fullfile(fileparts(mfilename('fullpath')),'..','..','..','derivatives');
% saveas(gcf,fullfile(derivativeDir,'cosmoMvpa', 'figure',figureName))
