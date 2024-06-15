clear ;
%% set paths
% spm
warning('off');
addpath(genpath('/Users/shahzad/Documents/MATLAB/spm12'));

% cosmo
cosmo = '~/Documents/MATLAB/CoSMoMVPA';
addpath(genpath(cosmo));
cosmo_warning('once');

% libsvm
libsvm = '~/Documents/MATLAB/libsvm';
addpath(genpath(libsvm));
% verify it worked.
cosmo_check_external('libsvm'); % should not give an error

% add cpp repo
% run ../../visTacMotion_fMRI_analysis/src/../lib/CPP_SPM/initCppSpm.m;

% bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
% addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
% bidspm();

%%% ATTENTION %%%
% With bidspm the same piece of code was not running 
% Therefore, Inititalise the cpp_spm v1.1.4 which is here 
% '/Users/shahzad/Files/fMRI/visTacMotionFoR/code/visTacMotion_ROI/src' and then run this code

cd ('/Users/shahzad/Files/fMRI/visTacMotionFoR/code/visTacMotion_ROI/src')
run '../lib/CPP_SPM/initCppSpm.m'
cd ('/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/mvpa_pseudoRun_rhMT_noOverlap')

%% run mvpa 
% load your options
opt = getOptionMvpa();

% find the size of the masks used
maskSizeVoxel = calculateMaskSize(opt);

% take the most responsive xx nb of voxels
opt.mvpa.ratioToKeep = 40;

opt.pathOutput = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives',...
      'decoding_pseudoRuns_noOverlap');
  
% accuDirSel = calculateMvpaDirSelectivity(opt);
accuDirSel = calculateMvpaDirSelectivityPseudoRun(opt);

% accuracyFoR = calculateMvpaAcrossHandAnatExt(opt);
accuracyFoR = calculateMvpaAcrossHandAnatExtPseudoRun(opt);
accuDirSel = calculateMvpaDirSelectivityPseudoRun(opt);

% accuCrossModExt = crossModalExtFoR(opt);
accuCrossModExt = crossModalExtFoRPseudoRun(opt);
accuCrossModExt=crossModalExtFoRPseudoRun_uncommentZero(opt);

% accuCrossModAnat = crossModalAnatFoR(opt);
accuCrossModAnat = crossModalAnatFoRPseudoRun(opt);
accuCrossModAnat = crossModalAnatFoRPseudoRun_uncommentZero(opt);
