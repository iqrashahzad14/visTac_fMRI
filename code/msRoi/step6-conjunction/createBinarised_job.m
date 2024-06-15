%-----------------------------------------------------------------------
% Job saved on 08-Apr-2024 11:04:46 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.imcalc.input = {'/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/msRoi/step6-sum/sub-ALL_hemi-R_space-MNI_label-rms_radiusNb-cluster_desc-sum.nii,1'};
matlabbatch{1}.spm.util.imcalc.output = 'sub-ALL_hemi-R_space-MNI_label-rms_radiusNb-cluster';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1==2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 16;
