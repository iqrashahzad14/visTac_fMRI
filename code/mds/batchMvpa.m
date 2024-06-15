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
cd ('/Users/shahzad/Files/fMRI/visTac/fMRI_analysis/code/mvpa')

%% run mvpa 
% load your options
opt = getOptionMvpa();

% take the most responsive xx nb of voxels
opt.mvpa.ratioToKeep = 100;

accu = mvpa_pairwise(opt);

accu = mvpa_pairwiseDA_AcrossHand(opt);