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
figure(4);
% labels={'pt', 'fw', 'th', 'tv', 'vh','vv'};
labels={'pt', 'fw', '\leftrightarrow', '\leftrightarrow', '\leftrightarrow','\leftrightarrow'}; % {'pt', 'fw', 'hor', 'ver', 'visHor','visVer'};
F = cmdscale(squareform(compromise_matrix));
t=text(F(:,1), F(:,2), labels);

% x=F(:,1); y= F(:,2);
% dx = 0.001 ; dy = 0.001 ;       % size of the image/ icon
% xmin = x-dx ; xmax = x+dx ;
% ymin = y-dy ; ymax = y+dy ;
% % Make background transperent
% [img, map, alpha] = imread('/Users/shahzad/Desktop/aa.png');
% img = flipud(img) ;
% for i = 1:length(x)
%     h = image([xmin(i) xmax(i)],[ymin(i) ymax(i)],img);        %# P`lot the image
%     set(h,'AlphaData',0.1);
% end
t(1).Color = lightGreen; t(1).FontSize = 35; %t(1).FontWeight = 'bold'; 
t(2).Color = lightGreen; t(2).FontSize = 35; %t(2).FontWeight = 'bold';

t(3).Color = darkGreen; t(3).FontSize = 50; t(3).FontWeight = 'bold'; t(3).LineWidth = 5;
t(4).Color = darkGreen; t(4).FontSize = 50; t(4).FontWeight = 'bold'; t(4).Rotation = 90;

t(5).Color = darkOrange; t(5).FontSize = 50; t(5).FontWeight = 'bold'; 
t(6).Color = darkOrange; t(6).FontSize = 50; t(6).FontWeight = 'bold'; t(6).Rotation = 90;


title(strcat('2D MDS plot ROI: ',string(opt.maskLabel{iMask})));
mx = max(abs(F(:)));
xlim([-mx mx]); ylim([-mx mx]);
xlim([-0.4 0.65]); ylim([-0.07 0.07]);
%%
%format plot
set(gcf,'color','w');
ax=gca;
% set(gca,'XTick',[])
% set(gca,'YTick',[])

set(ax,'FontName',FontName,'FontSize',FontSize, 'FontWeight','bold',...
    'LineWidth',2.5,'TickDir','out', 'TickLength', [0,0],...
    'FontSize',FontSize);
box off