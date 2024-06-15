
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '014','015','016','017',...
             'pil001','pil002','pil004','013','pil005'};%

roiList={'lms','rms'};
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};

anat_lms=[]; anat_rms=[]; 
ext_lms=[]; ext_rms=[]; 


for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
                if strcmp(char({accu(iAccu).mask}.'), 'lms')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
                        anat_lms = [anat_lms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
                        ext_lms = [ext_lms;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rms')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'HDPT_HUPT_vs_HDFW_HUFW' )==1
                        anat_rms = [anat_rms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'HUPT_HDFW_vs_HDPT_HUFW' )==1
                        ext_rms = [ext_rms;[accu(iAccu).accuracy].'];
                    end
                end
                
            end    
       end
            

    end
end

decodAccu=[anat_lms, anat_rms,...
ext_lms, ext_rms, ];
% meanDecodAccu=mean(decodAccu);
% seDecodAccu=std(decodAccu)/sqrt(length(subList));

T = array2table(decodAccu,...
    'VariableNames',{'anat_lms', 'anat_rms',...
'ext_lms', 'ext_rms'});

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
% % set the density_distance for clustering (all the values that are
% % within the density distance will be plotted as one marker, the size
% % of the marker will increase according to the number of values that it
% % represents) 
density_distance=-0.1; %if not density clustering put -0.1 here. With a value >0 you will have a baloon dot plot

%%%%set jittering (normally to be used when the density clustering is not implemented)
jitterAmount=0.09;% for no jittering put 0 here (otherwise try 0.15/ to be adjusted according to the data)

%%set the size of the markers that represent one value
starting_size=400; % in the density_plot this will be the smallest marker size (= 1 sub), in the jittered plot all the markers will be of this size
%%
figure(1)


model_series = [ mean(anat_lms),mean(ext_lms);...
    mean(anat_rms), mean(ext_rms)];

model_error = [ std(anat_lms)/sqrt(length(subList)),std(ext_lms)/sqrt(length(subList));...
    std(anat_rms)/sqrt(length(subList)),std(ext_rms)/sqrt(length(subList))];

% b = bar(model_series, 'grouped');
b = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2,'BarWidth', 0.8 );

b(1).EdgeColor = darkGreen;
b(2).EdgeColor = lightGreen;

b(1).CData(1,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 1st bar
b(1).CData(2,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 2nd bar

b(2).CData(1,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 1st bar
b(2).CData(2,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 2nd bar

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
% for iiSub=1:length(subList)
%     hold on 
%     plot([x(1,1), x(2,1)],[anat_lS1(iiSub), ext_lS1(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3 )
%    
%     hold on 
%     plot([x(1,2), x(2,2)],[anat_lPC(iiSub), ext_lPC(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     hold on 
%     plot([x(1,3), x(2,3)],[anat_rPC(iiSub), ext_rPC(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     
%     hold on 
%     plot([x(1,6), x(2,6)],[anat_lMTt(iiSub), ext_lMTt(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     hold on 
%     plot([x(1,7), x(2,7)],[anat_rMTt(iiSub), ext_rMTt(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     
%     hold on 
%     plot([x(1,4), x(2,4)],[anat_lms(iiSub), ext_lms(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     hold on 
%     plot([x(1,5), x(2,5)],[anat_rms(iiSub), ext_rms(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
%     
% end 

sz=40;
[data_density,sizeN]=compute_density(anat_lms,density_distance, starting_size);
scatter(repmat(x(1,1), length(anat_lms), 1),data_density(:),sz,'MarkerEdgeColor',darkGreen,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
[data_density,sizeN]=compute_density(ext_lms,density_distance, starting_size);
scatter(repmat(x(2,1), length(ext_lms), 1),data_density(:),sz,'MarkerEdgeColor',lightGreen,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% 
[data_density,sizeN]=compute_density(anat_rms,density_distance, starting_size);
scatter(repmat(x(1,2), length(anat_rms), 1),data_density(:),sz,'MarkerEdgeColor',darkGreen,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
[data_density,sizeN]=compute_density(ext_rms,density_distance, starting_size);
scatter(repmat(x(2,2), length(ext_rms), 1),data_density(:),sz,'MarkerEdgeColor',lightGreen,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);

% Plot the errorbars
e = errorbar(x',model_series,model_error,'color',darkGreen,'linestyle','none','LineWidth',LineWidthMean/2);
e(1).Color = darkGreen;
e(2).Color = lightGreen;

%

hold on
%plot chance level
yline(0.5, '--','color', 'k','LineWidth',LineWidthMean/2)
hold off

ylim([0.44 0.74])
legend({'anat-HDPT-HUPT-vs-HDFW-HUFW','ext-HUPT-HDFW-vs-HDPT-HUFW'},'Location','northeastoutside')
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lms','rms'})
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
