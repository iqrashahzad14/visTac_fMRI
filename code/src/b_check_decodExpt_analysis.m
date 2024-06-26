% (C) Copyright 2019 bidspm developers

%% sub13, pil005
% let's try it again here
    
%% analyze decoding experiments/runs
clear;
clc;

bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');

output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');

%% preprocess = STC, spatial normalization and smooth FWHM = 0,2,6 (default is 6)

taskName = 'visual';
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {'001'}, ...
        'action', 'preprocess', ...
        'space', {'IXI549Space'}, ... 
        'fwhm', 0,...
        'task', {taskName})
% 'ignore', {'unwarp'}, ...
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {'001'}, ...
        'action', 'smooth', ...
        'space', {'IXI549Space'}, ...
        'fwhm', 2,...
        'task', {taskName})

%% modelling the mvpa runs = preparing them for decoding (new mdoel files and conversion to 4-D maps)

%changed it to absolute because there were erros. preproc_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-preproc');
preproc_dir = '/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/bidspm-preproc';

%taskList = {'handDown', 'handUp','visual'};
taskName = 'visual';

%changed it to absolute because there were erros. fullfile(output_dir, 'models', strcat('model-', taskName,'_smdl.json'));
model_file = strcat('/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/models-noResponses-loweringThresholds/','model-', taskName,'Mvpa_smdl.json');

%choose smooth = 2
bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', {'001'}, ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'space', {'IXI549Space'}, ...
       'task', {taskName},...
       'fwhm', 2,...
       'concatenate', true); % not adding 'options', opt because I dont want to visualise
