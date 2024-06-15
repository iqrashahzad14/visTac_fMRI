%% create roi 
% create spherical ROIs using group peak coordinates

%% ATTENTION: 
% With bidspm the same piece of code was not creating the rois 
% of the right dimensions (i.e. the same as that of decoding sequence)
% Therefore, Inititalise the cpp_spm v1.1.4 which is here 
% '/Users/shahzad/Files/fMRI/visTacMotionFoR/code/visTacMotion_ROI/src' and then run this code
%%
clear;

cd ('/Users/shahzad/Files/fMRI/visTacMotionFoR/code/visTacMotion_ROI/src')
run '../lib/CPP_SPM/initCppSpm.m'
cd ('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/code/roi')

% bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
% addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
% bidspm();

opt.subjects={'sub-ALL'};

% roi names
opt.roi = {'lS2','rS2' };

% if this is empty new masks are saved in the current directory.
opt.save.roi = true;

groupLocations = {[-47.09, -15.80, 14.55],[49.38, -10.66, 12.72]};

%radius of spheres
radiusList=[7,8,10,12];

for iRadius=1:length(radiusList)
    opt.sphere.radius=radiusList(iRadius);
    
    %create the folders corresponding to the radii and the subjects
    opt.outputDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere',char(opt.subjects));
    if ~exist(opt.outputDir)
           mkdir(opt.outputDir)
    end
    outputMaskDir=opt.outputDir;

    % 4-D image used for used for referencing 
    volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats','sub-001','task-visual_space-IXI549Space_FWHM-0','beta_0001.nii'); 


    for iSub = 1:length(opt.subjects)
        for iRoi = 1:length(opt.roi)

            % to create new names for rois for the renameMyRoi function
            subName=char(opt.subjects(iSub));
            roiName = char(opt.roi(iRoi));
            radiusNb= num2str(opt.sphere.radius);

            %this creates the new Rois by expansion. expansion srarts from the
            %given peak coordinate
            sphere.location=cell2mat(groupLocations(iSub,iRoi));
            sphere.radius = opt.sphere.radius;

            mask = createRoi('sphere', sphere, volumeDefiningImage, opt.outputDir, opt.save.roi);

            %this function renames the saved rois
            renameMyRoi(subName, roiName,'.nii',radiusNb)
            renameMyRoi(subName, roiName,'.json',radiusNb)

            data_sphere = spm_summarise(volumeDefiningImage, mask);

        end
    end
end


function renameMyRoi(subName, roiName,fileFormat,radiusNb)

    switch roiName
        case 'lS2'
            hemi='L';
            label='lS2';
        case 'rS2'
            hemi='R';
            label='rS2';
    end 
    
    switch fileFormat
        case '.nii'
            ext='*mask.nii';
        case '.json'
            ext='*mask.json';
    end
    
    subName=char(subName);
    fileInfo = dir(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere', subName, ext) );
    oldName = fileInfo.name;
    newName = strcat(subName,'_','hemi-',hemi,'_','space-MNI', '_','label-',label,'_', 'radiusNb-',radiusNb,fileFormat);
    movefile( fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere', subName, oldName),...
        char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere', subName, newName) ));
    disp(hemi)
    disp(label)
    disp(oldName)
    disp(newName)
    
end