%% plot group coordinates from TML and VML

% {'lhMT','rhMT','lS1', 'lPC','rPC' 'lMTt', 'rMTt'};
groupLocations = {[-41.57, -64.79, 4.45],[47.55, -62.96, 0.77], [-44.20, -26.20, 59.57],...
    [-36.40, -39.20, 57.40],[39.0, -36.60, 52.20], [-44.33, -64.79, 6.29],[50.30, -64.79, 1.60]};
%S2
% groupLocations = {[-47.09, -15.80, 14.55],[49.38, -10.66, 12.72]};

roi1=[-41.57, -64.79, 4.45];%hMT
roi2=[47.55, -62.96, 0.77];%hMT
roi3=[-44.20, -26.20, 59.57];
roi4=[-36.40, -39.20, 57.40];
roi5=[39.0, -36.60, 52.20];
roi6=[-44.33, -64.79, 6.29];
roi7=[50.30, -64.79, 1.60];
% roi8=[-47.09, -15.80, 14.55];
% roi9=[49.38, -10.66, 12.72];


%%
%settings for plots
shape='o';
%%set the size of the shape 
sz=12;
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

%%set the font styles
FontName='Avenir'; %set the style of the labels
FontSize=17; %%set the size of the labels

black = [0 0 0];
white = [1 1 1];
gray = (black + white)/2;%[0.7, 0.7, 0.7];%
darkGray = [0.25, 0.25, 0.25];

blue = [0 0.4470 0.7410];
orange = [0.8500 0.3250 0.0980];
yellow = [0.9290 0.6940 0.1250];
purple= [0.4940 0.1840 0.5560];
green = [0.4660 0.6740 0.1880];
lightblue = [0.3010 0.7450 0.9330];
red = [0.6350 0.0780 0.1840];

%%
hold on
p=plot3(roi1(1),roi1(2), roi1(3),shape);%,'MarkerEdgeColor',red, 'MarkerFaceColor',red)
hold on
p.MarkerSize = sz;
p.MarkerEdgeColor = darkOrange;
p.MarkerFaceColor = darkOrange;

p=plot3(roi2(1),roi2(2), roi2(3),shape)
hold on
p.MarkerSize = sz;
p.MarkerEdgeColor = darkOrange;
p.MarkerFaceColor = darkOrange;

p=plot3(roi3(1),roi3(2), roi3(3),shape)
hold on
p.MarkerSize = sz;
p.MarkerEdgeColor = darkGreen;
p.MarkerFaceColor = darkGreen;


% p=plot3(roi4(1),roi4(2), roi4(3),shape)
% hold on
% p.MarkerSize = sz;
% p.MarkerEdgeColor = darkGreen;
% p.MarkerFaceColor = darkGreen;
% 
% 
% p=plot3(roi5(1),roi5(2), roi5(3),shape)
% hold on
% p.MarkerSize = sz;
% p.MarkerEdgeColor = darkGreen;
% p.MarkerFaceColor = darkGreen;


p=plot3(roi6(1),roi6(2), roi6(3),shape)
hold on
p.MarkerSize = sz;
p.MarkerEdgeColor = darkGreen;
p.MarkerFaceColor = darkGreen;


p=plot3(roi7(1),roi7(2), roi7(3),shape)
p.MarkerSize = sz;
p.MarkerEdgeColor = darkGreen;
p.MarkerFaceColor = darkGreen;

% p=plot3(roi8(1),roi8(2), roi8(3),shape)
% hold on
% p.MarkerSize = sz;
% p.MarkerEdgeColor = darkGreen;
% p.MarkerFaceColor = darkGreen;
% 
% 
% p=plot3(roi9(1),roi9(2), roi9(3),shape)
% p.MarkerSize = sz;
% p.MarkerEdgeColor = darkGreen;
% p.MarkerFaceColor = darkGreen;

% ylim([0.25 1])
% legend({'anat-HDPT-HUPT-vs-HDFW-HUFW','ext-HUPT-HDFW-vs-HDPT-HUFW'},'Location','northeastoutside')
xlabel('x (mm)') 
ylabel('y (mm)')
zlabel('z (mm)')
% xticklabels({'lS1','lPC', 'rPC', 'lMTt', 'rMTt','lhMT','rhMT'})
head1= 'group coordinates'; 
title(head1)

%%
%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off

xlabel('x') 
ylabel('y')
zlabel('z')