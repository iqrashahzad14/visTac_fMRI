% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOptionMvpa()
  % returns a structure that contains the options chosen by the user to run
  % decoding with cosmo-mvpa.

  if nargin < 1
    opt = [];
  end

  % suject to run in each group
  opt.subjects = {'001','002','003','004','005','006','007','008',...
             '009','010','011','014','015','016','017',...
             'pil001','pil002','pil004'};%,'013','pil005'
         
  % Uncomment the lines below to run preprocessing
  % - don't use realign and unwarp
  opt.realign.useUnwarp = true;

  % we stay in native space (that of the T1)
  opt.space ='MNI';

  % The directory where the data are located
%   opt.dataDir = fullfile(fileparts(mfilename('fullpath')), ...
%                          '..', '..', '..', 'raw');
%   opt.derivativesDir = fullfile(opt.dataDir, '..', 'derivatives', 'cpp_spm-stats'); %%??which data is it reading?
% 
%   opt.pathOutput = fullfile(opt.dataDir, '..', 'derivatives', 'cosmoMvpa');

  opt.pathOutput = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
      'decoding');
  
  % multivariate
  opt.model.file = fullfile(fileparts(mfilename('fullpath')), '..', ...
                            'model', 'model-FoR2mvpa_smdl.json');
  

  % task to analyze
  opt.taskName = 'FoR2';

  opt.parallelize.do = false;
  opt.parallelize.nbWorkers = 1;
  opt.parallelize.killOnExit = true;

  %% DO NOT TOUCH
  opt = checkOptions(opt);
  saveOptions(opt);
  % we cannot save opt with opt.mvpa, it crashes

  %% mvpa options
  % mask/ROIs used
  opt.maskVoxelNb = 100;
  
  opt.maskRadiusNb=8;

  % define the 4D maps to be used
  opt.funcFWHM = 2;

%   % take the most responsive xx nb of voxels
%   opt.mvpa.ratioToKeep = 120; % 120, 224, 368, 100 150 250 350 420

  % set which type of ffx results you want to use
  opt.mvpa.map4D = {'beta','tmap'};

  % design info
  opt.mvpa.nbRun = 10;
  opt.mvpa.nbTrialRepetition = 1;%

  % cosmo options
  opt.mvpa.tool = 'cosmo';
  % opt.mvpa.normalization = 'zscore';
  opt.mvpa.child_classifier = @cosmo_classify_libsvm; 
  opt.mvpa.feature_selector = @cosmo_anova_feature_selector;

  % permute the accuracies ?
  opt.mvpa.permutate = 1; 
  
end
