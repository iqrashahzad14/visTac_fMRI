%% create Roi which are non-overlapping

% This script takes the Mt and Mst rois which are created using method2
% and removes the overlapping volume to create non-overlapping MT and Mst Rois
% 
% Method2:
% it is important to use these masks so that we identify the clusters which are not connected to other regions
% hMT+: from visual Motion Localizer
% 1. open each individual subject 
% 2. In each individual , open spm.mat with a mask of bidspm-roi (functional and spherical radius 12mm) at p=0.001 uncorr
% 3. save the cluster
% 4. note the threshold and the coordinates
% 
% MST: from MtMst Localizer
% 1. open each individual spm.mat
% 2. conjunction of motion_left and motion_right
% 3. masked by the individually localised clusters of hMT+
% 1. def: is a part of individually localised cluster of hMT+
% 2. def: responds to ipsilateral stimulation
% 
% MT: 
% motion_left>motion_right gives rMT
% motion_right>motion_left gives lMT

subjectList={'sub-002','sub-004','sub-005','sub-009','sub-010','sub-015','sub-016','sub-017','sub-pil004','sub-pil005'};
%             {'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
%              'sub-009','sub-010','sub-011','sub-013','sub-014','sub-015','sub-016','sub-017',...
%              'sub-pil004','sub-pil005'}; % sub-pil001 and sub-pil002 have no localizer
         
opt.roi = {'lMst','lMT','lhMT','rMst','rMT','rhMT' };

roiPairList={'lMst-lMT', 'rMst-rMT'};

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);

    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method2','subjectCluster_base2pt6',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMst','.nii');
    roiName2 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMT','.nii');
    roiName3 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','.nii');
    roiName4 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMst','.nii');
    roiName5 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMT','.nii');
    roiName6 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    roi5 = load_nii(char(fullfile(maskDir,roiName5)));
    roi6 = load_nii(char(fullfile(maskDir,roiName6)));
    
    for iRoiPair = 1:length(roiPairList)
        roiPairLabel= roiPairList(iRoiPair);
        
        if strcmp(roiPairLabel,'lMst-lMT')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlapMask = roi1.img + roi2.img;
            overlapIdx = find(overlapMask == 2);
            [overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3)] = ind2sub([61,73,61],overlapIdx);% 61,73,61 size of overlapMask
            roi1.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            roi2.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            %new mask size
            roi1Size(iSub,1) = length(find(roi1.img==1));
            roi2Size(iSub,1) = length(find(roi2.img==1));
            % save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method2-noOverlap','subjectCluster_base2pt6',char(subID));
            save_nii(roi1,fullfile(opt.outputMask, char(roiName1)));
            save_nii(roi2,fullfile(opt.outputMask, char(roiName2)));
            
        elseif strcmp(roiPairLabel,'rMst-rMT')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlapMask = roi4.img + roi5.img;
            overlapIdx = find(overlapMask == 2);
            [overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3)] = ind2sub([61,73,61],overlapIdx);% 61,73,61 size of overlapMask
            roi4.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            roi5.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            %new mask size
            roi4Size(iSub,1) = length(find(roi4.img==1));
            roi5Size(iSub,1) = length(find(roi5.img==1));
            
            %save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method2-noOverlap','subjectCluster_base2pt6',char(subID));
            save_nii(roi4,fullfile(opt.outputMask, char(roiName1)));
            save_nii(roi5,fullfile(opt.outputMask, char(roiName2)));
            
        end
                  
    end
    subName(iSub,1) = string(subID);
  
end

