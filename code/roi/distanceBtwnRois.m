% compute distance between two points in a 3-D system
% 
% 
% location1 = {[-44.20, -67.80, 5.40],[44.20,-65.20,0.20], [-41.60, -21.0, 54.80],...
%     [-26.0,-62.6,57.40],[18.20,-60.0,52.0], [-44.20,-70.40,8.0],[45.41,-59.77,5.90]};
% 
% location2 = {[-46.8, -70.40, 5.40],[46.80, -65.20, 2.80], [-44.85,-19.32, 54.94],...
%     [-33.80, -39.20, 60.0],[33.80, -36.60, 57.40], [-49.40, -70.40, 8.0],[41.60, -67.80, 0.20]};
% 
% location1 = {[44.72, -61.29, 5.86]};
% location2 ={[45.38, -63.41, 1.64]};
% r1=readtable('coordinates1.xlsx'); r1=r1(:,2:end);
r1=readtable('groupCoordinates.xlsx'); r1=r1(:,2:end);
% r1=readtable('groupCoordinates_vmlUnivar.xlsx'); r1=r1(:,2:end);
r2=readtable('coordinates2.xlsx'); r2=r2(:,2:end);

for iSub =1:20
for iRoi = 1:7
    location1=str2num(cell2mat(table2cell(r1(iSub,iRoi)))); 
    location2=str2num(cell2mat(table2cell(r2(iSub,iRoi)))); 
    diff{iSub, iRoi} = [location1-location2];
    dis(iSub,iRoi) = norm(location1-location2)
%     (location1{iRoi}-location2{iRoi})
%     dis(iSub,iRoi)=norm(location1{iRoi}-location2{iRoi})
    
end
end


% dis = sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);