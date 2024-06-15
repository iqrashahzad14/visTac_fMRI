%% create masks from glasser atlas

%% step 1
% download neuroparc from github and go tot he glasser atlas
% find the label .csv file. 
% Define your rois
% Here, S1= area 1 | area 2|area3a, parietal = vip complex, motor = motor
% spm fmri -> imcalc - > define expressions like i1==51|i2==52|i3==53
% this creates outputs : source-glasser_label-S1

% outputs from spm imcalc are here :
% '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/glasser-roi/glasserImages'

% next, check whether the images hare binarised 
% check if they have the right resolution

%% step2 binarise and reslice the maps

% the following script is adapted from CPP_ROI demo for Neurosynth
glasserImages = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','glasser-roi','glasserImages');
%list of masks in the folder
imageList = {'source-glasser_label-motor.nii', 'source-glasser_label-S1.nii','source-glasser_label-vipComp.nii'};

% 4-D image used for used for referencing 
volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats','sub-001','task-visual_space-IXI549Space_FWHM-0','beta_0001.nii'); 

%place to save the new binarised masks
binarisedGlasserImages = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','glasser-roi','glasserMasks');

%for each mask, you binarise them ny thresholding them
for iImage = 1: length(imageList)
    zMap = fullfile(glasserImages,char(imageList(iImage)));
    volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats',...
        'sub-001','task-visual_space-IXI549Space_FWHM-0','beta_0001.nii'); 
    opt.unzip.do = true;
    opt.save.roi = true;
    opt.outputDir = []; % if this is empty new masks are saved in the current directory.
    if opt.save.roi
      opt.reslice.do = false;
    else
      opt.reslice.do = false;
    end
    [roiName, zMap] = prepareDataAndROI(opt, volumeDefiningImage, zMap);
end
% NOTE: the output masks are saved in the directory where it is reading the
% images from i.e.glasserImages To Do: define the output dir

%% Functions
function [roiName, zMap] = prepareDataAndROI(opt, volumeDefiningImage, zMap)

%   if opt.unzip.do
%     gunzip(fullfile('inputsGlasser', '*.gz'));
%   end

  % give the neurosynth map a name that is more bids friendly
  %
  % space-MNI_label-neurosynthKeyWordsUsed_probseg.nii
  %
%   zMap = renameNeuroSynth(zMap);

  if opt.reslice.do
    % If needed reslice probability map to have same resolution as the data image
    %
    % resliceImg won't do anything if the 2 images have the same resolution
    %
    % if you read the data with spm_summarise,
    % then the 2 images do not need the same resolution.
    zMap = resliceRoiImages(volumeDefiningImage, zMap);
  end

  % Threshold probability map into a binary mask
  % to keep only values above a certain threshold
  threshold = 0; 
  roiName = thresholdToMask(zMap, threshold);
  roiName = removeSpmPrefix(roiName, spm_get_defaults('realign.write.prefix'));

end

