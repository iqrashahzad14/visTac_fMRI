%%
%2X5
anatData = [anat_lS1, anat_lMTt, anat_rMTt,anat_lhMT, anat_rhMT];
extData = [ext_lS1, ext_lMTt, ext_rMTt,ext_lhMT, ext_rhMT];

dataMat=[anatData;extData]

subjNb=20 ; %number of replications
[p,tbl,stats] = anova2(dataMat,subjNb);

c1 = multcompare(stats);

%%
anatData = [anat_lS1, anat_lMTt, anat_rMTt,anat_lhMT, anat_rhMT];
extData = [ext_lS1, ext_lMTt, ext_rMTt,ext_lhMT, ext_rhMT];

dataMat=[anatData,extData]

% x = readtable('mack_data.txt');
% T = array2table( dataMat);
% x.Properties.VariableNames = {'o1','o2','o3','o4','o5','m1','m2','m3','m4','m5'};
T = array2table(dataMat,...
    'VariableNames',{'anat_lS1', 'anat_lMTt', 'anat_rMTt','anat_lhMT', 'anat_rhMT'...
'ext_lS1','ext_lMTt', 'ext_rMTt','ext_lhMT', 'ext_rhMT' });

withinDesign = table([1 1 1 1 1 2 2 2 2 2]',[1:5 1:5]','VariableNames',{'FoR','Roi'});
withinDesign.FoR = categorical(withinDesign.FoR);
withinDesign.Roi = categorical(withinDesign.Roi);

% rm = fitrm(x,'o1-m5~1','WithinDesign',withinDesign);
% ranova(rm,'WithinModel','Layout*Trial') 
rm = fitrm(T,'anat_lS1-ext_rhMT~1','WithinDesign',withinDesign);
ranova(rm,'WithinModel','FoR*Roi') 

% frame= [repmat(1,[1,18]), repmat(2,[1,18])]';
% t = table(frame,dataMat(:,1),dataMat(:,2),dataMat(:,3),dataMat(:,4),dataMat(:,5),...
% 'VariableNames',{'FoR','lS1','lMTt','rMTt','lhMT','rhMT'});
% dataTab = table([1 2 3 4 5]','VariableNames',{'DA'});
% 
% rm = fitrm(t,'lS1-rhMT~frame','WithinDesign',dataTab)
%% anova output(image = tmap)
% no effect of for
% effect of roi
% interaction fo For and Roi
%% post hoc ttests (image = tmap)
[h,p,~,~]=ttest(anat_lS1, ext_lS1) % p= 0.0010
[h,p,~,~]=ttest(anat_lMTt, ext_lMTt)% p= 0.8948
[h,p,~,~]=ttest(anat_rMTt, ext_lMTt)% p= 0.1461
[h,p,~,~]=ttest(anat_lhMT, ext_lhMT)% p= 0.3495
[h,p,~,~]=ttest(anat_rhMT, ext_lhMT)% p= 0.2181
%% post hoc ttests (image =  beta)
[h,p,~,~]=ttest(anat_lS1, ext_lS1) % p= 0.0053
[h,p,~,~]=ttest(anat_lMTt, ext_lMTt)% p= 0.2468
[h,p,~,~]=ttest(anat_rMTt, ext_rMTt)% p=   0.4063 or 0.7400
[h,p,~,~]=ttest(anat_lhMT, ext_lhMT)% p= 0.3233
[h,p,~,~]=ttest(anat_rhMT, ext_lhMT)% p=  0.0105

%% with PC
anatData = [anat_lPC, anat_rPC,];
extData = [ext_lPC, ext_rPC];

dataMat=[anatData;extData]

subjNb=20 ; %number of replications
[p,tbl,stats] = anova2(dataMat,subjNb);

c1 = multcompare(stats);
