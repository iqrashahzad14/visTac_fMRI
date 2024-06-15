% (C) Copyright 2019 bidspm developers

clear;
clc;

bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');


%% preprocess = STC, spatial normalization and smooth FWHM = 6 (default)
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'preprocess', ...
        'space', {'IXI549Space'}, ...
        'fwhm', 6,...
        'task', {'visualLocalizer2','tactileLocalizer2','mtmstLocalizer'})
    
%% preprocess the mvpa runs
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'preprocess', ...
        'space', {'IXI549Space'}, ...
        'fwhm', 0,...
        'task', {'handDown','handUp', 'visual'})
    
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'smooth', ...
        'space', {'IXI549Space'}, ...
        'fwhm', 2,...
        'task', {'handDown','handUp', 'visual'})
    
bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', {subject_label}, ...
        'action', 'smooth', ...
        'space', {'IXI549Space'}, ...
        'fwhm', 6,...
        'task', {'handDown','handUp', 'visual'})