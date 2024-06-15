%% prepare 4-D images for decoding
% this project has a run-wise design for mvpa.
% we have three tasks : handDown, handUp, visual
% and each task has a concatenated 4-D map
% the idea here is to concatenate the 4-D images from the three tasks
% together and make one 4-D image with all conditions coming from the three
% tasks. 
% so we create a new 4-D image with the new task name : "FoR"
% this code concatenates the 4-D maps in the order as below
% handDown, handUp, visual
% handDown_pinkyThumb; handDown_fingerWrist
% handUp_pinkyThumb;handUp_fingerWrist
% visual_horizontal, visual_vertical (this is not tha same as cpp_spmv1.4)

% spm_vol % read hdr
% spm_read_vols % read img from hdr
% spm_write_vol % writes an img

%%

%%
clear

% ONLY for beta images
imageType='beta';

subjectList={'001','002','003','004','005','006','007','008',...
             '009','010','011','013','014','015','016','017',...
             'pil001','pil002','pil004','pil005'};
smoothingList = {'0','2'};
         
for iSub = 1:length(subjectList)
        subID = char(subjectList(iSub));
for iSmooth = 1: length(smoothingList)
        smoothing = char(smoothingList(iSmooth));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get the different 4-D beta images
    betaFileA=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats',...
        strcat('sub-',subID),strcat('task-handDown_space-IXI549Space_FWHM-',smoothing),...
        strcat('sub-',subID,'_task-handDown_space-IXI549Space_desc-4D_',imageType,'.nii')); 
    betaFileB=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats',...
        strcat('sub-',subID),strcat('task-handUp_space-IXI549Space_FWHM-',smoothing),...
        strcat('sub-',subID,'_task-handUp_space-IXI549Space_desc-4D_',imageType,'.nii')); 
    betaFileC=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-stats',...
        strcat('sub-',subID),strcat('task-visual_space-IXI549Space_FWHM-',smoothing),...
        strcat('sub-',subID,'_task-visual_space-IXI549Space_desc-4D_',imageType,'.nii')); 

    %read the header
    hdr_betaFileA = spm_vol(betaFileA);
    hdr_betaFileB = spm_vol(betaFileB);
    hdr_betaFileC = spm_vol(betaFileC);

    %get their volumes
    vol_betaFileA = spm_read_vols(hdr_betaFileA);
    vol_betaFileB = spm_read_vols(hdr_betaFileB);
    vol_betaFileC = spm_read_vols(hdr_betaFileC);

    %concatenate them
    betaFoR_4D = cat(4, vol_betaFileA, vol_betaFileB, vol_betaFileC);

    % split 4-D images and then merge them back
    for i = 1:size(betaFoR_4D, 4)
        hdr_betaFoR_4D = hdr_betaFileA(1); %use the hdr from any of the previous 4-D images
        %new split betas start with "C"
        hdr_betaFoR_4D.fname = ['C' sprintf('%02.0f', i) '.nii']; %rename the hdr so that we create and save a new file/image and not overwrite

        spm_write_vol(hdr_betaFoR_4D, betaFoR_4D(:,:,:,i));

    end

    %choose all the images that start with C and end with .nii
    images = spm_select('FPlist', pwd , '^C.*.nii'); 
    %merge the images into one
    spm_file_merge(images, strcat('sub-', subID,'_task-FoR2_space-IXI549Space_FWHM-',smoothing,'_desc-4D_',imageType,'.nii'))

    mvpaVolDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID));
    if ~exist(mvpaVolDir)
        mkdir(mvpaVolDir)
    end

    %then move the new 4-D image to a new folder for organisation
    movefile( strcat('sub-', subID,'_task-FoR2_space-IXI549Space_FWHM-',smoothing,'_desc-4D_',imageType,'.nii'),...
            char(fullfile(mvpaVolDir, strcat('sub-', subID,'_task-FoR2_space-IXI549Space_FWHM-',smoothing,'_desc-4D_',imageType,'.nii'))));

    %delete the extra images
    delete *.nii
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

end
end

    
% % now we need to make the accompanying tsv
% % this is more like a manual step, where I create the tsv of one subject
% % manually and then copy-paste for other subjects.
% % Note that sub-pil001, sub-pil002, sub-pil005 have 9 runs and others have 10 runs
% % so we copy the tsv of sub-001 to others and then rename the tsv file
% % !!! make changes for sub-pil001, 2, 5; mvpa runs =9 
% % the tsv files from cpp_spm 1.1.4 and bidspm v3.0 were a bit different,
% % such that cpp-spm lists fold number from 1 to 10 and bidpsm list them
% % with 1 only. Please check the tsv.
% for iSub = 2:length(subjectList)
%     subID = char(subjectList(iSub));
%     sourceFile=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-','001'), 'sub-001_task-FoR2_space-IXI549Space_labelfold.tsv');
%     destination=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID));%
%     copyfile( sourceFile, destination);
%     movefile( fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID), 'sub-001_task-FoR2_space-IXI549Space_labelfold.tsv'),...
%             fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID), strcat('sub-',subID,'_task-FoR2_space-IXI549Space_labelfold.tsv')));
% 
% end