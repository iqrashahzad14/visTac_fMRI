%% create roi - Subject level
% create spherical ROIs using peak coordinates
% create 12mm group-masks
% from the localizers and the group masks, find the peak coordinates
% create 8mm spheres
% these rois will be used for decoding

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

subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
             'sub-009','sub-010','sub-011','sub-013','sub-014','sub-015','sub-016','sub-017',...
             'sub-pil001','sub-pil002','sub-pil004','sub-pil005'};
         
% roi names
opt.roi = {'lhMT','rhMT','lS1', 'lPC','rPC' 'lMTt', 'rMTt'};

% if this is empty new masks are saved in the current directory.
opt.save.roi = true;

%read the coordinates of each subject and each roi
% 19052023 coordinates3.xlsx 
r=readtable('coordinates3.xlsx');
%remove the first column which has subject labels
rNew=r(:,2:end);

%radius of spheres
radiusList=[6,7,8,10];

for iRadius=1:length(radiusList)
    opt.sphere.radius=radiusList(iRadius);

    for iSub = 1:length(subjectList)
        opt.subjects = subjectList(iSub);
        
        %create the folders corresponding to the radii and the subjects
        opt.outputDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6',char(opt.subjects));
        if ~exist(opt.outputDir)
               mkdir(opt.outputDir)
        end
        outputMaskDir=opt.outputDir;
        
        % 4-D image used for used for referencing 
        volumeDefiningImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats','sub-001','task-visualLocalizer2_space-IXI549Space_FWHM-6','beta_0001.nii'); 

        
        for iRoi = 1:length(opt.roi)

            % to create new names for rois for the renameMyRoi function
            subName = char(opt.subjects);
            roiName = char(opt.roi(iRoi));
            radiusNb= num2str(opt.sphere.radius);

            %this creates the new Rois by drawing a sphere around the peak
            %coordinate
            sphere.location=str2num(cell2mat(table2cell(rNew(iSub,iRoi)))); %#ok<*ST2NM> %this conversion is very complicated because it reads from a xlsx.One can try creating a .mat file of coordinates.
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
    fileInfo = dir(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6', subName, ext) );
    oldName = fileInfo.name;
    newName = strcat(subName,'_','hemi-',hemi,'_','space-MNI', '_','label-',label,'_', 'radiusNb-',radiusNb,fileFormat);
    movefile( fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6', subName, oldName),...
        char(fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-roi','subjectSphere_base2pt6', subName, newName) ));
    disp(hemi)
    disp(label)
    disp(oldName)
    disp(newName)
    
end