%% create MT  = part of hMT+ which is not MST

%this script create rois MT  = part of hMT+ which is not MST

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


subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
             'sub-009','sub-010','sub-015','sub-016','sub-017',...
             'sub-pil004','sub-pil005'}; % sub-pil001 and sub-pil002 have no cluster/localizer
         %'sub-011','sub-013','sub-014', they do not have clusters for hMT+

opt.roi = {'lMst','lhMT','rMst','rhMT' };

roiPairList={'lMst-lhMT', 'rMst-rhMT'};

for iSub = 2%1:length(subjectList)
    subID= subjectList(iSub);
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method1','subjectCluster_base2pt6',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMst','.nii');
 
    roiName2 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','.nii');
    roiName3 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMst','.nii');
    
    roiName4 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    
    roiNameNewLeft =  strcat(subID,'_hemi-','L','_space-MNI_label-','lMT','.nii');
    roiNameNewRight = strcat(subID,'_hemi-','R','_space-MNI_label-','rMT','.nii');
    
    
    for iRoiPair = 2%1:length(roiPairList)
        roiPairLabel= roiPairList(iRoiPair);
        
        if strcmp(roiPairLabel,'lMst-lhMT')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlapMask = roi1.img + roi2.img;
            overlapIdx = find(overlapMask == 2);
            [overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3)] = ind2sub([61,73,61],overlapIdx);% 61,73,61 size of overlapMask
            roi1.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            roi2.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            %new mask size
            roi2Size(iSub,1) = length(find(roi2.img==1));
            % save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method1','subjectCluster',char(subID));
            save_nii(roi2,fullfile(opt.outputMask, char(roiNameNewLeft)));
                       
        elseif strcmp(roiPairLabel,'rMst-rhMT')==1
            %sum the masks: 0 is neither, 1 is either, 2 is both (overlap)
            overlapMask = roi3.img + roi4.img;
            overlapIdx = find(overlapMask == 2);
            [overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3)] = ind2sub([69,83,68],overlapIdx);% 61,73,61 size of overlapMask%69,83,68
            roi3.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            roi4.img(overlapIdx(:,1), overlapIdx(:,2), overlapIdx(:,3))=0;
            %new mask size
            roi4Size(iSub,1) = length(find(roi4.img==1));
            %save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi-method1','subjectCluster',char(subID));
            save_nii(roi4,fullfile(opt.outputMask, char(roiNameNewRight)));
                      
        end
                  
    end
    subName(iSub,1) = string(subID);
    
end
