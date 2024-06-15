
im='beta';%'tmap', 'beta'
smooth='2';
voxNb='100';

subList={'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004','013','pil005'};% 
% subList={'011'};%'003', 005 """7""", 10 11 not good for anything
  
roiList={'lms','rms'};
decodingConditionList = {'handDown_pinkyThumb_vs_handDown_fingerWrist', 'handUp_pinkyThumb_vs_handUp_fingerWrist',...
      'visual_vertical_vs_visual_horizontal'};

visDir_lms=[]; visDir_rms=[]; visDir_lS1=[]; visDir_lPC=[]; visDir_rPC=[]; visDir_lMTt=[]; visDir_rMTt=[];
handDownDir_lms=[]; handDownDir_rms=[]; handDownDir_lS1=[]; handDownDir_lPC=[]; handDownDir_rPC=[]; handDownDir_lMTt=[]; handDownDir_rMTt=[];
handUpDir_lms=[]; handUpDir_rms=[]; handUpDir_lS1=[]; handUpDir_lPC=[]; handUpDir_rPC=[]; handUpDir_lMTt=[]; handUpDir_rMTt=[];

for iAccu=1:length(accu)
    for iSub=1:length(subList)
        subID=subList(iSub);
        if strcmp(char({accu(iAccu).subID}.'),char(subID))==1

            if strcmp(char({accu(iAccu).image}.'), im)==1 && strcmp(num2str([accu(iAccu).ffxSmooth].'),smooth)==1 && strcmp(num2str([accu(iAccu).choosenVoxNb].'),voxNb)==1
                
                
                if strcmp(char({accu(iAccu).mask}.'), 'lms')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
                        visDir_lms = [visDir_lms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
                        handDownDir_lms = [handDownDir_lms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
                        handUpDir_lms = [handUpDir_lms;[accu(iAccu).accuracy].'];
                    end
                end
                
                if strcmp(char({accu(iAccu).mask}.'), 'rms')==1
                    varDecodCond={accu(iAccu).decodingCondition}.';
                    if strcmp(varDecodCond{1}{1},'visual_vertical_vs_visual_horizontal' )==1
                        visDir_rms = [visDir_rms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handDown_pinkyThumb_vs_handDown_fingerWrist' )==1
                        handDownDir_rms = [handDownDir_rms;[accu(iAccu).accuracy].'];
                    elseif strcmp(varDecodCond{1}{1},'handUp_pinkyThumb_vs_handUp_fingerWrist' )==1
                        handUpDir_rms = [handUpDir_rms;[accu(iAccu).accuracy].'];
                    end
                end
                
                
            end    
       end
            

    end
end

decodAccu=[visDir_lms,handDownDir_lms,handUpDir_lms, visDir_rms, handDownDir_rms,handUpDir_rms ];
meanDecodAccu=mean(decodAccu);
seDecodAccu=std(decodAccu)/sqrt(length(subList));

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
jitterAmount=0.2;% for no jittering put 0 here (otherwise try 0.15/ to be adjusted according to the data)

%%set the size of the markers that represent one value
starting_size=400; % in the density_plot this will be the smallest marker size (= 1 sub), in the jittered plot all the markers will be of this size

%% 
figure(1)

model_series = [mean(visDir_lms); mean(visDir_rms)];

model_error = [std(visDir_lms)/sqrt(length(subList));...
    std(visDir_rms)/sqrt(length(subList))];

b = bar(model_series, 0.5,'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2); 

b(1).EdgeColor = darkOrange;

b(1).CData(1,:) = 'w';%darkPurple; % group 3 1st bar
b(1).CData(2,:) = 'w';%darkPurple; % group 3 2nd bar

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
hold on

sz=40;

[data_density,sizeN]=compute_density(visDir_lms,density_distance, starting_size);
scatter(repmat(x(1,1), length(visDir_lms), 1),data_density(:),sz,shape,'MarkerEdgeColor',darkOrange,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);

[data_density,sizeN]=compute_density(visDir_rms,density_distance, starting_size);
scatter(repmat(x(1,2), length(visDir_rms), 1),data_density(:),sz,shape,'MarkerEdgeColor',darkOrange,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);

% Plot the errorbars
errorbar(x',model_series,model_error,'color',darkOrange,'linestyle','none','LineWidth',LineWidthMean/2);

hold on
%plot chance level
yline(0.5, ':','color', 'k','LineWidth',LineWidthMean/2)

hold off
ylim([0.29 0.9])
legend({'vis-VerVsHor'},'Location','northeastoutside')
legend box off
xlabel('ROI') 
ylabel('Decoding Accuracy')
xticklabels({'lms','rms',})
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
