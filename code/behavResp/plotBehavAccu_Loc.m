% plot accuracies
%reads the excel sheet "behav Accu" which contains the behav accu
%subject-wise for all the tasks

% NOTE THE ORDER OF SUBJECTS IN ALL THE TABLES
subList ={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '013','014','015','016','017',...
             'pil004','pil005'}; %'pil001','pil002',

tab=readtable("behavAccu.xlsx");

%to plot the localizer tasks
a=tab.visMot; b= tab.visStat;
c=tab.tacMot; d=tab.tacStat;
e=tab.motLeft; f=tab.motRight;

a=[a(1:16);a(19:20)];b=[b(1:16);b(19:20)];
c=[c(1:16);c(19:20)];d=[d(1:16);d(19:20)];
e=[e(1:16);e(19:20)];f=[f(1:16);f(19:20)];

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
black = [0 0 0];
white = [1 1 1];
gray = (black + white)/2;%[0.7, 0.7, 0.7];%
darkGray = [0.25, 0.25, 0.25];
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
jitterAmount=0.07;% for no jittering put 0 here (otherwise try 0.15/ to be adjusted according to the data)

%%set the size of the markers that represent one value
starting_size=400; % in the density_plot this will be the smallest marker size (= 1 sub), in the jittered plot all the markers will be of this size
%%
figure(1)

model_series = [
    mean(a), mean(b);...
    mean(c), mean(d);...
    mean(e), mean(f)];

model_error = [
    std(a)/sqrt(length(a)),std(b)/sqrt(length(b));...
    std(c)/sqrt(length(c)),std(d)/sqrt(length(d));...
    std(e)/sqrt(length(e)),std(f)/sqrt(length(f))];

% b = bar(model_series, 'grouped');
bplot = bar(model_series, 'grouped','FaceColor','flat', 'LineWidth',LineWidthMean/2,'BarWidth', 0.9 );

bplot(1).EdgeColor = darkGray;
bplot(2).EdgeColor = darkGray;

bplot(1).CData(1,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 1st bar
bplot(1).CData(2,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 2nd bar
bplot(1).CData(3,:) = 'w';%lightGreen;%'w';%Colors(2,:); % group 1 3rd bar

bplot(2).CData(1,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 1st bar
bplot(2).CData(2,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 2nd bar
bplot(2).CData(3,:) = 'w';%lightOrange;%'w';%Colors(4,:); % group 2 3rd bar

% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(model_series);

% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = bplot(i).XEndPoints;
end
hold on


% % Plot connected lines
for iiSub=1:length(subList)
    hold on 
    plot([x(1,1), x(2,1)],[a(iiSub), b(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3 )
    hold on 
    plot([x(1,2), x(2,2)],[c(iiSub), d(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
    hold on 
    plot([x(1,3), x(2,3)],[e(iiSub), f(iiSub)],'color',gray);%,'LineWidth',LineWidthMean/3)
    
end 

sz=40;

%to plot dots in a single line
scatter(repmat(x(1,1), length(a), 1),a,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);
scatter(repmat(x(2,1), length(b), 1),b,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);

scatter(repmat(x(1,2), length(c), 1),c,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);
scatter(repmat(x(2,2), length(d), 1),d,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);

scatter(repmat(x(1,3), length(e), 1),e,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);
scatter(repmat(x(2,3), length(f), 1),f,sz,shape,'MarkerEdgeColor',gray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers);


% %to plot dots spread within the bar
% [data_density,sizeN]=compute_density(a,density_distance, starting_size);
% scatter(repmat(x(1,1), length(a), 1),data_density(:),sz,sizeN,shape,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% [data_density,sizeN]=compute_density(b,density_distance, starting_size);
% scatter(repmat(x(2,1), length(b), 1),data_density(:),sz,shape,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% 
% [data_density,sizeN]=compute_density(c,density_distance, starting_size);
% scatter(repmat(x(1,2), length(c), 1),data_density(:),sz,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% [data_density,sizeN]=compute_density(d,density_distance, starting_size);
% scatter(repmat(x(2,2), length(d), 1),data_density(:),sz,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% 
% [data_density,sizeN]=compute_density(e,density_distance, starting_size);
% scatter(repmat(x(1,3), length(e), 1),data_density(:),sz,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);
% [data_density,sizeN]=compute_density(f,density_distance, starting_size);
% scatter(repmat(x(2,3), length(f), 1),data_density(:),sz,'MarkerEdgeColor',darkGray,'MarkerEdgeAlpha',Transparency,'LineWidth',LineWidthMarkers,'jitter','on', 'jitterAmount', jitterAmount);

% Plot the errorbars
err = errorbar(x',model_series,model_error,'color',darkGreen,'linestyle','none','LineWidth',LineWidthMean/2);
err(1).Color = darkGray;
err(2).Color = darkGray;
%

hold on
%plot chance level
% yline(0.5, ':','color', 'k','LineWidth',LineWidthMean/2)
hold off

ylim([0.35 1.06])
% legend({'anat-HDPT-HUPT-vs-HDFW-HUFW','ext-HUPT-HDFW-vs-HDPT-HUFW'},'Location','northeastoutside')
% legend box off
xlabel('Tasks') 
ylabel('Performance Accuracy')
xticklabels({'visLoc','tacLoc', 'mtMst'})
title('Behavioural task')

%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off

