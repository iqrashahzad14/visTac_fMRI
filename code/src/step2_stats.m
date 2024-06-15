% (C) Copyright 2019 bidspm developers

clear;
clc;

% set your directories and initiate bidspm
bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');

subject_label = '001';

% choose your directories
preproc_dir= fullfile(output_dir, 'bidspm-preproc');

%% create default model
% bidspm(bids_dir, output_dir, 'dataset', ...
%         'action', 'default_model', ...
%         'verbosity', 2, ...
%         'space', {'IXI549Space'}, ...
%         'options', struct([]), ...,
%         'ignore', {}, ...
%         'task', {})

%% univariate analyses for the localizer tasks

% model_file = fullfile(output_dir, 'models', 'model-visualLocalizer2_smdl.json');
% taskName = 'visualLocalizer2';

model_file = fullfile(output_dir, 'models', 'model-tactileLocalizer2_smdl.json');
taskName = 'tactileLocalizer2';

% define the results to be saved as output
results = defaultResultsStructure();% do we need this and what does it do?
results.nodeName = 'subject_level';
results.name = {'motion_gt_static'};
results.MC =  'none';
results.p = 0.01;
results.k = 0;
results.png = true();
results.csv = true();
results.binary = true; % what is this?
results.montage.do = true();
results.montage.slices = -12:4:60;
results.montage.orientation = 'axial';
results.montage.background = struct('suffix', 'T1w', ...
                                    'desc', 'preproc', ...
                                    'modality', 'anat');                                                             
opt.results = results;

% run the stats st subject-level
% action = 'stats' -> runs model specification / estimation, contrast computation, display results
% action = 'contrasts'-> runs contrast computation, display results
% 'action = results'-> displays results

bidspm(bids_dir, output_dir, 'subject', ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'fwhm', 6,...
       'ignore', {'qa','concat'},...
       'concatenate', false,...
       'options', opt);

%% univariate analyses for the mvpa tasks
model_file = fullfile(output_dir, 'models', 'model-handDown_smdl.json');
taskName = 'handDown';

% define the results to be saved as output
results = defaultResultsStructure();% do we need this and what does it do?
results.nodeName = 'subject_level';
results.name = {'handDown_pinkyThumb_gt_handDown_fingerWrist','handDown_fingerWrist_gt_handDown_pinkyThumb' };
results.MC =  'none';
results.p = 0.01;
results.k = 0;
results.png = true();
results.csv = true();
results.binary = true; % what is this?
results.montage.do = true();
results.montage.slices = -12:4:60;
results.montage.orientation = 'axial';
results.montage.background = struct('suffix', 'T1w', ...
                                    'desc', 'preproc', ...
                                    'modality', 'anat');                                                             
opt.results = results;

% run the stats st subject-level
% action = 'stats' -> runs model specification / estimation, contrast computation, display results
% action = 'contrasts'-> runs contrast computation, display results
% 'action = results'-> displays results

bidspm(bids_dir, output_dir, 'subject', ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'fwhm', 6,...
       'concatenate', false,...
       'options', opt);
