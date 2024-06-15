
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '014','015','016','017',...
             'pil001','pil002','pil004'};%'013',,'pil005'

roiList={'lS2', 'rS2'};
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};

 anat_lS2=[]; anat_rS2=[];
ext_lS2=[]; ext_rS2=[]; 


for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'lhMT')==1
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
%                         anat_lhMT = [anat_lhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
%                         ext_lhMT = [ext_lhMT;[accu(iAccu).accuracy].'];
%                     end
%                 end
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'rhMT')==1
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
%                         anat_rhMT = [anat_rhMT;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
%                         ext_rhMT = [ext_rhMT;[accu(iAccu).accuracy].'];
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'lS1')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
%                         anat_lS1 = [anat_lS1;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
%                         ext_lS1 = [ext_lS1;[accu(iAccu).accuracy].'];
%                     end
%                 end
                
                if strcmp(char({accu(iAccu).mask}.'), 'lS2')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
                        anat_lS2 = [anat_lS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
                        ext_lS2 = [ext_lS2;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rS2')==1 
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
                        anat_rS2 = [anat_rS2;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
                        ext_rS2 = [ext_rS2;[accu(iAccu).accuracy].'];
                    end
                end
                
%                 if strcmp(char({accu(iAccu).mask}.'), 'lMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
%                         anat_lMTt = [anat_lMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
%                         ext_lMTt = [ext_lMTt;[accu(iAccu).accuracy].'];
%                     end
%                 end
%                 
%                 if strcmp(char({accu(iAccu).mask}.'), 'rMTt')==1 
%                     varDecodCond={accu(iAccu).decodingCondition}.';
%                     if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
%                         anat_rMTt = [anat_rMTt;[accu(iAccu).accuracy].'];
%                     elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
%                         ext_rMTt = [ext_rMTt;[accu(iAccu).accuracy].'];
%                     end
%                 end
            end    
       end
            

    end
end

decodAccu=[  anat_lS2, anat_rS2,...
ext_lS2, ext_rS2 ];
% meanDecodAccu=mean(decodAccu);
% seDecodAccu=std(decodAccu)/sqrt(length(subList));

T = array2table(decodAccu,...
    'VariableNames',{'anat_lS2', 'anat_rS2', ...
'ext_lS2', 'ext_rS2' });

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

figure(1)


model_series = [
    mean(anat_lS2), mean(ext_lS2);...
    mean(anat_rS2), mean(ext_rS2)];

model_error = [std(anat_lS2)/sqrt(length(subList)),std(ext_lS2)/sqrt(length(subList));...
    std(anat_rS2)/sqrt(length(subList)),std(ext_rS2)/sqrt(length(subList))];

% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2 );

b(1).EdgeColor = darkGreen;
b(2).EdgeColor = lightGreen;

b(1).CData(1,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 1st bar
b(1).CData(2,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 2nd bar
% b(1).CData(3,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 3rd bar
% b(1).CData(4,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(5,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(6,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1
% b(1).CData(7,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1
b(2).CData(1,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 1st bar
b(2).CData(2,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 2nd bar
% b(2).CData(3,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 3rd bar
% b(2).CData(4,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(5,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(6,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 
% b(2).CData(7,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 


% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

black = [0 0 0];
white = [1 1 1];
gray = (black + white)/2;%[0.7, 0.7, 0.7];%
darkGray = [0.25, 0.25, 0.25];
% % Plot connected lines
for iiSub=1:length(subList)
%     hold on 
%     plot([x(1,1), x(2,1)],[anat_lS1(iiSub), ext_lS1(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3 )
%    
    hold on 
    plot([x(1,1), x(2,1)],[anat_lS2(iiSub), ext_lS2(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
    hold on 
    plot([x(1,2), x(2,2)],[anat_rS2(iiSub), ext_rS2(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
    
%     hold on 
%     plot([x(1,6), x(2,6)],[anat_lMTt(iiSub), ext_lMTt(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     hold on 
%     plot([x(1,7), x(2,7)],[anat_rMTt(iiSub), ext_rMTt(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     
%     hold on 
%     plot([x(1,4), x(2,4)],[anat_lhMT(iiSub), ext_lhMT(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     hold on 
%     plot([x(1,5), x(2,5)],[anat_rhMT(iiSub), ext_rhMT(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
    
end 

sz=40;

% scatter(repmat(x(1,1), length(anat_lS1), 1),anat_lS1,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,1), length(ext_lS1), 1),ext_lS1,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,1), length(anat_lS2), 1),anat_lS2,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
scatter(repmat(x(2,1), length(ext_lS2), 1),ext_lS2,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

scatter(repmat(x(1,2), length(anat_rS2), 1),anat_rS2,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
scatter(repmat(x(2,2), length(ext_rS2), 1),ext_rS2,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);

% scatter(repmat(x(1,6), length(anat_lMTt), 1),anat_lMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,6), length(ext_lMTt), 1),ext_lMTt,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,7), length(anat_rMTt), 1),anat_rMTt,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,7), length(ext_rMTt), 1),ext_rMTt,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,4), length(anat_lhMT), 1),anat_lhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,4), length(ext_lhMT), 1),ext_lhMT,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% 
% scatter(repmat(x(1,5), length(anat_rhMT), 1),anat_rhMT,sz,'MarkerEdgeColor',darkGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);
% scatter(repmat(x(2,5), length(ext_rhMT), 1),ext_rhMT,sz,'MarkerEdgeColor',lightGreen,'MarkerFaceColor','w','LineWidth',LineWidthMarkers);


% Plot the errorbars
errorbar(x',model_series,model_error,'color',darkGreen,'linestyle','none','LineWidth',LineWidthMean/2);
%

hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)

hold off


ylim([0.25 1])
legend({'anat-HDPT-HUPT-vs-HDFW-HUFW','ext-HUPT-HDFW-vs-HDPT-HUFW'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lS2', 'rS2'})
head1= 'Across Hand Posture'; 
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
