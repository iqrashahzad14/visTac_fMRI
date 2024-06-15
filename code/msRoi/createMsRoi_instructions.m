%% creating multisensory roi - msRoi
% step 1: go to the visual motion localizer and save the group-level cluster manually at p=0.001 uncor -> hMT
% step 2: go to the tactile motion localizer and save the group-level cluster manually at p=0.01 uncor -> MTt
% step 3: visualise -> the right hMT cluster include portions from v1 etc.
% step 4: use bidSpm group -level spherical Rois of 12mm radius for both bilateral hMT and MTt
% step 5: move them to a single folder input_msRoi
% step 6: use the intersection of the spherical and cluster left hMT roi to first create group-level cluster left hMT
% now it will be possible to have the  msRoi
% step 7: now that we have the cluster of bilateral hMT and MTt, find the intersection of 
% (a) left cluster hMT and MTt -> left msRoi = lMs = sub-ALL_hemi-L_space-MNI_label-lms_radiusNb-cluster
% (b) right cluster hMT and MTt -> rightt msRoi = rMs = sub-ALL_hemi-R_space-MNI_label-rms_radiusNb-cluster
% note they were created in the dir 'code/msRoi'. So move them manually to
% the dir 'output/derivatives/ms-roi'

%% step 5.5: first binarise the masks
% to binarise
% use imcalc function and do it manually 
% threshold at >=1

%-> just check that rhMT-cluster is binarised

%% step 5.5.5
%  reslice manually to match the dimensions of the roi to the decoding
%  sequence
% do it manually as the functions are not giving nice results
% http://rfmri.org/node/88

% https://rfmri.org/node/88
% use SPM5:
% a. Click "Coregister"
% b. Click "New "Coreg: Reslice""
% c. "Image Defining Space": choose one of your functional image. e.g. your normalized functional image or image after Detrend and Filter.
% d. "Images to Reslice": choose the mask file or ROI definition file. e.g. BrainMask_05_61x73x61.img
% e. "Reslice Options" -> "Interpolation": choose "Nearest neighbour"
% f. Just click "Run". Then you will get the resmapled mask or ROI file with a surfix of "r".

%-> checked that all the files are in the same space and dimensions

%% step5.5.5.5
% the code compalins that the cluster mask files are in unit8 data type and
% the bodspm roi are single/float 32 data type.
% so, i used the imcal function:
%   -for each file, evaluate i1~=0 and chnage the data type to float32.
%   save the new cluster mask files
%the batch is saved , so, run binarisingUsingImcalc.m

% -> done and saved everything in dir input_msRoi
