% (C) Copyright 2019 bidspm developers

%% analyze localizers

clear;
clc;

bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

%changed it to absolute because there were erros.bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
bids_dir  ='/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/inputs/raw';
%changed it to absolute because there were erros.output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');
output_dir = '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives';

%% preprocess = STC, spatial normalization and smooth FWHM = 6 (default)
% A single task must be specified for preprocessing
% this will run preprocessing on all subjects. for a  %'participant_label', {subject_label}, ...

%,'002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil004','pil005'
taskList = {'visualLocalizer2','tactileLocalizer2','mtMstLocalizer'};
for iTask = 1%: length(taskList)
    taskName = char(taskList(iTask));
    bidspm(bids_dir, output_dir, 'subject', ... 
            'action', 'preprocess', ...
            'participant_label', {'^001$'}, ...
            'space', {'IXI549Space'}, ...
            'fwhm', 6,...
            'task', {taskName})
end

%%
%changed it to absolute because there were erros.preproc_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-preproc');
preproc_dir = '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/bidspm-preproc';

%taskList = {'visualLocalizer2','tactileLocalizer2','mtMstLocalizer'};
taskName = 'visualLocalizer2';

%changed it to absolute because there were erros. fullfile(output_dir, 'models', strcat('model-', taskName,'_smdl.json'));
model_file = strcat('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/models/','model-', taskName,'_smdl.json');

%% subject - level stats for localizers
% run the stats at subject-level
% action = 'stats' -> runs model specification / estimation, contrast computation, display results
% action = 'contrasts'-> runs contrast computation, display results
% action = 'results'-> displays results

% define the results to be saved as output
results = defaultResultsStructure();% do we need this and what does it do?
results.nodeName = 'subject_level';
if strcmp(taskName,'visualLocalizer2')==1 ||strcmp(taskName,'tactileLocalizer2')==1 
    results.name = {'motion','static','motion_gt_static','static_gt_motion'};
elseif strcmp(taskName,'mtMstLocalizer')==1
    results.name = {'motion_left','motion_right', 'motion_left_gt_motion_right','motion_right_gt_motion_left' };
end
% results.name = {'motion','static','motion_gt_static','static_gt_motion'};
% results.name = {'motion_left','motion_right', 'motion_left_gt_motion_right','motion_right_gt_motion_left' };
results.MC =  'none';
results.p = 0.01;
results.k = 0;
results.png = true();
results.csv = true();
results.binary = true; 
results.montage.do = true();
results.montage.slices = -12:4:60;
results.montage.orientation = 'axial';
results.montage.background = struct('suffix', 'T1w', ...
                                    'desc', 'preproc', ...
                                    'modality', 'anat');                                                             
opt.results = results;

bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil004','pil005'}, ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'space', {'IXI549Space'}, ...
       'fwhm', 6,...
       'ignore', {'qa','concat'},...
       'concatenate', false,...
       'options', opt);

%% group- level analyses for the localizers

% for group-level analyses with confwhm ~=0, a new pull request was merged with bidspm , 
% hence I made a new repo which is here: 

cd '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis_GroupSmoothing/code/src'
bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();
cd ('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/code/src')

%group-level GLm and contrasts - RESULTS to do separately

opt.fwhm.contrast = 8;
output_dir='/Users/shahzad/Files/fMRI/visTac/groupSmooth_21March2024';
preproc_dir='/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/bidspm-preproc_doneuntiIMRF_July2023';
bidspm(bids_dir, output_dir, 'dataset', ...
       'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil004','pil005'}, ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'space', {'IXI549Space'}, ...
       'fwhm', 6,...
       'ignore', {'qa','concat'},...
       'concatenate', false,...
       'options', opt);

% define the results to be saved as output
results = defaultResultsStructure();% do we need this and what does it do?
results.nodeName = 'dataset_level'; 
if strcmp(taskName,'visualLocalizer2')==1 ||strcmp(taskName,'tactileLocalizer2')==1 
    results.name = {'motion','static','motion_gt_static','static_gt_motion'};
elseif strcmp(taskName,'mtMstLocalizer')==1
    results.name = {'motion_left','motion_right', 'motion_left_gt_motion_right','motion_right_gt_motion_left' };
end
% results.name = {'motion','static','motion_gt_static','static_gt_motion'};
% results.name = {'motion_left','motion_right', 'motion_left_gt_motion_right','motion_right_gt_motion_left' };
results.MC =  'none';
results.p = 0.01;
results.k = 0;
results.png = true();
results.csv = true();
results.binary = true; 
results.montage.do = true();
results.montage.slices = -12:4:60;
results.montage.orientation = 'axial';
% results.montage.background = struct('suffix', 'T1w', ...
%                                     'desc', 'preproc', ...
%                                     'modality', 'anat');                                                             
% results.montage.background =[];
opt.results = results;

bidspm(bids_dir, output_dir, 'dataset', ...
       'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil004','pil005'}, ...
       'action', 'results', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'space', {'IXI549Space'}, ...
       'fwhm', 6,...
       'ignore', {'qa','concat'},...
       'concatenate', false,...
       'options', opt);
