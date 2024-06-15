%% step 6: use the intersection of the spherical and cluster roi to first create group-level cluster left hMT
% use imCalc function
% a. sum the two masks (i1+i2, data type float 32), 
% b. make the mask binary (i1==2, data type float 32)

% !! I used imcalc to do these two steps .
% and them moved back the new rhMT cluster proper back to the dir
% input_msRoi manually. Done!

% the crip below is in progress but is intended to do the same thing.

clear all

maskDir='input_msRoi';
fileName1=strcat('sub-ALL','_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-','cluster','.nii');
fileName2=strcat('sub-ALL','_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-','12','.nii');

file1 = load_nii(char(fullfile(maskDir,fileName1)));
file2 = load_nii(char(fullfile(maskDir,fileName2)));

overlapMask = file1.img + file2.img;
overlapIdx = find(overlapMask == 2);
[overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3)] = ind2sub([69,83,68],overlapIdx);% 69,83,68 size of overlapMask

file1.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
roi2.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
%new mask size
roi2Size(iSub,1) = length(find(roi2.img==1));
% save new ROIs    
opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method1','subjectCluster',char(subID));
% save_nii(roi2,fullfile(opt.outputMask, char(roiNameNewLeft)));
            
