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
opt.roi = {'lhMT','rhMT','lS1', 'lPC','rPC' 'lMTt', 'rMTt'};

% if this is empty new masks are saved in the current directory.
opt.save.roi = true;

% groupLocations = {[-44.20, -67.80, 5.40],[44.20,-65.20,0.20], [-41.60, -21.0, 54.80],...
%     [-26.0,-62.6,57.40],[18.20,-60.0,52.0], [-44.20,-70.40,8.0],[45.41,-59.77,5.90]}; %old ones with 16 subjectr

% groupLocations = {[-46.8, -70.40, 5.40],[46.80, -65.20, 2.80], [-44.20, -26.20, 62.60],...
%     [-33.80, -39.20, 60.0],[33.80, -36.60, 57.40], [-49.40, -70.40, 8.0],[41.60, -67.80, 0.20]}; %nearest max coords

% groupLocations = {[-43.27, -66.57, 2.70],[44.72, -61.29, 5.86], [-44.20, -20.11, 54.41],...
%     [-29.37, -41.23, 54.41],[33.80, -36.60, 57.40], [-47.49, -66.57, 6.92],[45.38, -63.41, 1.64]}; %finding on MTG at 0.01 uncor

%19thMay - bidspm - glm no response
groupLocations = {[-41.57, -64.79, 4.45],[47.55, -62.96, 0.77], [-44.20, -26.20, 59.57],...
    [-36.40, -39.20, 57.40],[39.0, -36.60, 52.20], [-44.33, -64.79, 6.29],[50.30, -64.79, 1.60]};

%radius of spheres
radiusList=[7,8,10,12];

for iRadius=1:length(radiusList)
    opt.sphere.radius=radiusList(iRadius);
    
    %create the folders corresponding to the radii and the subjects
    opt.outputDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere_base2pt6',char(opt.subjects));
    if ~exist(opt.outputDir)
           mkdir(opt.outputDir)
    end
    outputMaskDir=opt.outputDir;

    % 4-D image used for used for referencing 
    volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats','sub-001','task-visualLocalizer2_space-IXI549Space_FWHM-6','beta_0001.nii'); 


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
        case 'lhMT'
            hemi='L';
            label='lhMT';
        case 'rhMT'
            hemi='R';
            label='rhMT';
        case'lS1'
            hemi='L';
            label='lS1';
        case'lPC'
            hemi='L';
            label='lPC';
        case 'rPC'
            hemi='R';
            label='rPC';
        case'lMTt'
            hemi='L';
            label='lMTt';
        case 'rMTt'
            hemi='R';
            label='rMTt';
    end 
    
    switch fileFormat
        case '.nii'
            ext='*mask.nii';
        case '.json'
            ext='*mask.json';
    end
    
    subName=char(subName);
    fileInfo = dir(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere_base2pt6', subName, ext) );
    oldName = fileInfo.name;
    newName = strcat(subName,'_','hemi-',hemi,'_','space-MNI', '_','label-',label,'_', 'radiusNb-',radiusNb,fileFormat);
    movefile( fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere_base2pt6', subName, oldName),...
        char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','groupSphere_base2pt6', subName, newName) ));
    disp(hemi)
    disp(label)
    disp(oldName)
    disp(newName)
    
end