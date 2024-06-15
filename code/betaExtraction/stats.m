%% stats
% betaVal = [betaEstMotion1, betaEstStatic1,betaEstMotion2, betaEstStatic2,...
%     betaEstMotion3, betaEstStatic3,betaEstMotion4, betaEstStatic4,...
%     betaEstMotion5, betaEstStatic5,betaEstMotion6, betaEstStatic6, betaEstMotion7, betaEstStatic7];
%% one-sample ttest
clear h
clear p
for iCol=1:size(betaVal,2)
    [h(iCol), p(iCol)]=ttest(betaVal(:,iCol))
end

%% two-sample ttest
clear h
clear p
for iRoi=1:2:size(betaVal,2)
    [h(iRoi), p(iRoi)]=ttest(betaVal(:,iRoi),betaVal(:,iRoi+1))
end