%% create roi with bidspm

% Bidspm will throw a warning when you do so because this atlas is not ideal for volumetric analysis.

% intitalise the bidspm here
% '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis_GlasserUpdate/code/src'

cd '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis_GlasserUpdate/code/src'
bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();
cd '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis_GlasserUpdate/code/src'


%changed it to absolute because there were erros.bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
bids_dir  ='/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/inputs/raw';
%changed it to absolute because there were erros.output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');
output_dir = '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/bidspm-glasser-roi';


% % Area of interest
% Area_1	1
% Area_2	2
% Area_3a	3a
% Primary_Sensory_Cortex 3b
% MT MT
% MST MST
% Primary_Motor_Cortex 4
% IntraParietal_Sulcus_Area_1	IPS1
% Ventral_IntraParietal_Complex	VIP
     
 bidspm(bids_dir, output_dir, 'subject', ...
    'action', 'create_roi', ...
    'participant_label', {'001'}, ...
    'verbosity', 2, ...
    'roi_atlas', 'glasser', ...
    'roi_name', {'MT', 'MST', '4', }, ...
    'hemisphere', {'L', 'R'}, ...
    'space', {'IXI549Space'})

%% reslice

% 4-D image used for used for referencing 
% %base  2pt3
volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
    'bidspm-stats','sub-001','task-visual_space-IXI549Space_FWHM-0','beta_0001.nii'); 
% %base 2pt6
% volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
%     'bidspm-stats','sub-001','task-visualLocalizer2_space-IXI549Space_FWHM-6','beta_0001.nii'); 

roiPath = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
    'bidspm-glasser-roi','derivatives','bidspm-roi', 'group');

roiLabelList = {'4'};
hemiLabelList={'L','R'};
for iRoi = 1:length(roiLabelList)
    roiLabel = char(roiLabelList(iRoi));
    for iHemi=1:length(hemiLabelList)
        hemiLabel=char(hemiLabelList(iHemi));
        roiImage = fullfile(roiPath, strcat('hemi-',hemiLabel,'_space-MNI_atlas-glasser_label-',roiLabel,'_mask.nii'));
        reslicedImages = resliceRoiImages(volumeDefiningImage, roiImage);
    end
end

%% reslice
% 4-D image used for used for referencing 
% %base 2pt6
volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
    'bidspm-stats','sub-001','task-visualLocalizer2_space-IXI549Space_FWHM-6','beta_0001.nii'); 

roiPath = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
    'bidspm-glasser-roi','derivatives','bidspm-roi', 'group');

roiLabelList = {'MT','MST'};
hemiLabelList={'L','R'};
for iRoi = 1:length(roiLabelList)
    roiLabel = char(roiLabelList(iRoi));
    for iHemi=1:length(hemiLabelList)
        hemiLabel=char(hemiLabelList(iHemi));
        roiImage = fullfile(roiPath, strcat('hemi-',hemiLabel,'_space-MNI_atlas-glasser_label-',roiLabel,'_mask.nii'));
        reslicedImages = resliceRoiImages(volumeDefiningImage, roiImage);
    end
end

