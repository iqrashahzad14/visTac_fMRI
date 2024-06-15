% install wb
% open termial
% run this : export PATH=$PATH:/Applications/workbench/bin_macosx64
% open matlab from terminal: /Applications/MATLAB_R2020b.app/bin/matlab

% add path to the matworkbench repo
addpath(genpath('/Users/shahzad/GitHubCodes/matworkbench'));

% Set the directory where your files are
ffxDir = '/Users/shahzad/Downloads/tryImagesInWorkbench'; %the directory where the maps are stored

% select the files
%outputFiles = spm_select('FPList', ffxDir, '^sub-.*.GtAll_.*spmT.nii$');
% outputFiles = spm_select('FPList', ffxDir, '^sub-.*.Gt_.*mask.nii$');
outputFiles = spm_select('list', pwd, '^sub-.*.motionGtStatic_.*mask.nii$');
outputFiles = spm_select('list', pwd, '^sub.*nii');

outputFiles = spm_select('list', pwd, '^.*nii');
% open the files
opennii(outputFiles);
