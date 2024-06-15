% (C) Copyright 2019 bidspm developers

%% analyze decoding experiments/runs

clear;
clc;

bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');

%% preprocess = STC, spatial normalization and smooth FWHM = 0,2,6 (default is 6)

taskList = {'handDown','handUp','visual'};
for iTask = 1: length(taskList)
    taskName = char(taskList(iTask));
    bidspm(bids_dir, output_dir, 'subject', ...
            'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
            'action', 'preprocess', ...
            'space', {'IXI549Space'}, ...
            'fwhm', 0,...
            'task', {taskName})

    bidspm(bids_dir, output_dir, 'subject', ...
            'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
            'action', 'smooth', ...
            'space', {'IXI549Space'}, ...
            'fwhm', 2,...
            'task', {taskName})

%     bidspm(bids_dir, output_dir, 'subject', ...
%             'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
%             'action', 'smooth', ...
%             'space', {'IXI549Space'}, ...
%             'fwhm', 6,...
%             'task', {taskName})
    
end    
%% preprocess with parallel processing
subject_label = {'001','002','003','004','005','006',...
    '010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'};% , '012',
parfor i = 1:length(subject_label)
    bidspm(bids_dir, output_dir, ...
           'participant_label', subject_label(i), ...
           'action', 'preprocess', ...
           'task', {'visual'}, ...
           'fwhm', 0,...
           'space', {'IXI549Space'});
end
parfor i = 1:length(subject_label)
    bidspm(bids_dir, output_dir, ...
           'participant_label', subject_label(i), ...
           'action', 'smooth', ...
           'task', {'visual'}, ...
           'fwhm', 2,...
           'space', {'IXI549Space'});
end
%% univariate analyses for the mvpa tasks
%changed it to absolute because there were erros. preproc_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-preproc');
preproc_dir = '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/bidspm-preproc';

%taskList = {'handDown', 'handUp','visual'};
taskName = 'handUp';

%changed it to absolute because there were erros. fullfile(output_dir, 'models', strcat('model-', taskName,'_smdl.json'));
model_file = strcat('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/models/','model-', taskName,'_smdl.json');

bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'space', {'IXI549Space'}, ...
       'fwhm', 6,...
       'ignore', {'qa','concat'},...
       'concatenate', false);

%% modelling the mvpa runs = preparing them for decoding (new mdoel files and conversion to 4-D maps)

%changed it to absolute because there were erros. preproc_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','bidspm-preproc');
preproc_dir = '/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/bidspm-preproc';

% %taskList = {'handDown', 'handUp','visual'};
% taskName = 'handUp';

taskList = {'handDown','handUp','visual'};
for iTask = 1: length(taskList)
    taskName = char(taskList(iTask));
    %changed it to absolute because there were erros. fullfile(output_dir, 'models', strcat('model-', taskName,'_smdl.json'));
    model_file = strcat('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/models-withResponses/','model-', taskName,'Mvpa_smdl.json');

    %smooth = 0
    bidspm(bids_dir, output_dir, 'subject', ...
           'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
           'action', 'stats', ...
           'preproc_dir', preproc_dir, ...
           'model_file', model_file,...
           'space', {'IXI549Space'}, ...
           'task', {taskName},...
           'fwhm', 0,...
           'concatenate', true); % not adding 'options', opt because I dont want to visualise
end

taskList = {'handDown','handUp','visual'};
for iTask = 1: length(taskList)
    taskName = char(taskList(iTask));
    %changed it to absolute because there were erros. fullfile(output_dir, 'models', strcat('model-', taskName,'_smdl.json'));
    model_file = strcat('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/outputs/derivatives/models-withResponses/','model-', taskName,'Mvpa_smdl.json');

    %smooth = 2
    bidspm(bids_dir, output_dir, 'subject', ...
           'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
           'action', 'stats', ...
           'preproc_dir', preproc_dir, ...
           'model_file', model_file,...
           'space', {'IXI549Space'}, ...
           'task', {taskName},...
           'fwhm', 2,...
           'concatenate', true); % not adding 'options', opt because I dont want to visualise
end

%% if you want to visualise
% define the results to be saved as output
results = defaultResultsStructure();% do we need this and what does it do?
results.nodeName = 'subject_level';
results.name = {'handDown_pinkyThumb','handDown_fingerWrist','handDown_pinkyThumb_gt_handDown_fingerWrist','handDown_fingerWrist_gt_handDown_pinkyThumb' };
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

% run the stats at subject-level
% action = 'stats' -> runs model specification / estimation, contrast computation, display results
% action = 'contrasts'-> runs contrast computation, display results
% 'action = results'-> displays results

bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', {'001','002','003','004','005','006','007','008','009','010','011','013','014','015','016','017','pil001','pil002','pil004','pil005'}, ...
       'action', 'results?', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file,...
       'task', {taskName},...
       'space', {'IXI549Space'}, ...
       'fwhm', 0,...
       'ignore', {'qa','concat'},...
       'concatenate', false,...
       'options', opt);
