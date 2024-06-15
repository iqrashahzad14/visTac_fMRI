%create non overlapping ROI
% by removing the overlap
% eg. rhMT minus rMTt
clear all

subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
             'sub-009','sub-010', 'sub-011', 'sub-013','sub-014', 'sub-015','sub-016','sub-017',...
             'sub-pil001', 'sub-pil002', 'sub-pil004','sub-pil005'}; 

opt.roi = {'lhMT', 'lMTt','rhMT', 'rMTt' };

roiPairList={'lhMT-lMTt','rhMT-rMTt'};

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);
    
    % where to read the rois
    opt.maskDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere',char(subID));
    maskDir = opt.maskDir;
    
    roiName1 = strcat(subID,'_hemi-','L','_space-MNI_label-','lhMT','_radiusNb-8','.nii');
    roiName2 = strcat(subID,'_hemi-','L','_space-MNI_label-','lMTt','_radiusNb-8','.nii');
    roiName3 = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-8','.nii');
    roiName4 = strcat(subID,'_hemi-','R','_space-MNI_label-','rMTt','_radiusNb-8','.nii');

    roi1 = load_nii(char(fullfile(maskDir,roiName1)));
    roi2 = load_nii(char(fullfile(maskDir,roiName2)));
    roi3 = load_nii(char(fullfile(maskDir,roiName3)));
    roi4 = load_nii(char(fullfile(maskDir,roiName4)));
    
    roiNameNewLeft =  strcat(subID,'_hemi-','L','_space-MNI_label-','lhMTo','.nii');
    roiNameNewRight = strcat(subID,'_hemi-','R','_space-MNI_label-','rhMTo','.nii');
    
    
    for iRoiPair = 1:length(roiPairList)
        roiPairLabel= roiPairList(iRoiPair);
        
        if strcmp(roiPairLabel,'lhMT-lMTt')==1
            % new mask is rhMT minus rMst
            roi1.img = roi1.img - roi2.img;
            roi1.img(find(roi1.img==-1))=0;
%             count_lhMTo = length(find(roi1.img==1));
%             dispRoi = 'lhMTo contains %4.2f voxels \n';
%             fprintf(dispRoi,count_lhMTo )

            %calculate the nmbr of overlapping voxels
%             overlapMask_lhMTo = roi1.img + roi2.img;
%             overlapIdx_lhMTo = length(find(overlapMask_lhMTo == 2));
%             dispRoi = 'lhMTo contains %4.2f voxels \n';
%             fprintf(dispRoi,overlapIdx_lhMTo )

            %save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_noOverlap',char(subID));
            save_nii(roi1,fullfile(opt.outputMask, char(roiNameNewLeft)));
                       
        elseif strcmp(char(roiPairLabel),'rhMT-rMTt')==1
            % new mask is rhMT minus rMst
            roi3.img = roi3.img - roi4.img;
            roi3.img(find(roi3.img==-1))=0;
            
%             count_rhMTo = length(find(roi3.img==1));
%             dispRoi = 'rhMTo contains %4.2f voxels \n';
%             fprintf(dispRoi,count_rhMTo )
            
            %calculate the nmbr of overlapping voxels
%             overlapMask_rhMTo = roi3.img + roi4.img;
%             overlapIdx_rhMTo = length(find(overlapMask_rhMTo == 2));
%             dispRoi = 'rhMTo contains %4.2f voxels \n';
%             fprintf(dispRoi,overlapIdx_rhMTo )

            %save new ROIs    
            opt.outputMask = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_noOverlap',char(subID));
            save_nii(roi3,fullfile(opt.outputMask, char(roiNameNewRight)));
                      
        end
                  
    end
    subName(iSub,1) = string(subID);
    
end