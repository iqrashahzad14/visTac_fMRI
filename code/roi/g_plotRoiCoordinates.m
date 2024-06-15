%% plot the coordinates of spherical rois

r=readtable('coordinates4.xlsx');
rt = table2cell(r(:,2:8));

% figure()
% hold on
% plot3(r1(:,1)'or');
% a=rt(:,1);
% c=str2num(char(a(:,:)))

roi1 = rt(:,1); roi2 = rt(:,2); roi3 = rt(:,3); roi4 = rt(:,4); roi5 = rt(:,5); roi6 = rt(:,6); roi7 = rt(:,7);

roi1=str2num(char(roi1)); %#ok<*ST2NM>
roi2=str2num(char(roi2));
roi3=str2num(char(roi3));
roi4=str2num(char(roi4));
roi5=str2num(char(roi5));
roi6=str2num(char(roi6));
roi7=str2num(char(roi7));

%%
%settings for plots
shape='o';
%%set the size of the shape 
sz=6.5;
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

markerLineWidth =1.5;
%%

for iSub= 1:size(rt,1)
    p=plot3(roi1(iSub,1),roi1(iSub,2), roi1(iSub,3),'o');%,'MarkerEdgeColor',red, 'MarkerFaceColor',red)
    hold on
    p.MarkerSize = sz;
    p.MarkerEdgeColor = darkOrange;
    p.LineWidth = markerLineWidth;
%     p.MarkerFaceColor = darkOrange;
    
    p=plot3(roi2(iSub,1),roi2(iSub,2), roi2(iSub,3),'o')
    hold on
    p.MarkerSize = sz;
    p.MarkerEdgeColor = darkOrange;
    p.LineWidth = markerLineWidth;
%     p.MarkerFaceColor = darkOrange;
    
    p=plot3(roi3(iSub,1),roi3(iSub,2), roi3(iSub,3),'o')
    hold on
    p.MarkerSize = sz;
    p.MarkerEdgeColor = darkGreen;
    p.MarkerEdgeColor = darkGreen;
    p.LineWidth = markerLineWidth;
%     p.MarkerFaceColor = darkGreen;
    
%     p=plot3(roi4(iSub,1),roi4(iSub,2), roi4(iSub,3),'o')
%     hold on
%     p.MarkerSize = sz;
%     p.MarkerEdgeColor = darkGreen;
% %     p.MarkerFaceColor = darkGreen;
%     
%     p=plot3(roi5(iSub,1),roi5(iSub,2), roi5(iSub,3),'o')
%     hold on
%     p.MarkerSize = sz;
%     p.MarkerEdgeColor = darkGreen;
% %     p.MarkerFaceColor = darkGreen;
    
    p=plot3(roi6(iSub,1),roi6(iSub,2), roi6(iSub,3),'o')
    hold on
    p.MarkerSize = sz;
    p.MarkerEdgeColor = darkGreen;
    p.LineWidth = markerLineWidth;
%     p.MarkerFaceColor = darkGreen;
    
    p=plot3(roi7(iSub,1),roi7(iSub,2), roi7(iSub,3),'o')
    hold on
    p.MarkerSize = sz;
    p.MarkerEdgeColor = darkGreen;
    p.LineWidth = markerLineWidth;
%     p.MarkerFaceColor = darkGreen;
    
end

roiLabels = {'lhMT', 'rhMT', 'lS1' , 'lPC', 'rPC' , 'lMTt', 'rMTt' };
% legend(roiLabels)
xlabel('x') 
ylabel('y')
zlabel('z')
head1= 'subject coordinates'; 
title(head1)

%%
%format plot
set(gcf,'color','w');
ax=gca;

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off

