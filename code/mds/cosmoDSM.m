%% this script is adapted to run RSA and MDS 
% https://cosmomvpa.org/_static/publish/demo_fmri_distatis.html
% choose which mask/ROI to use

%% load all the parameters
opt = getOptionMvpa();
% get the smoothing parameter for 4D map
funcFWHM = opt.funcFWHM;   

%% MVPA options
% set cosmo mvpa structure
condLabelNb = [1 2 3 4 5 6 ];
condLabelName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist',...
    'visual_horizontal','visual_vertical' };
%% Preprocessing for DISTATIS: RSM analysis
for iSub = 1:numel(opt.subjects)

% get FFX path
subID = opt.subjects{iSub};
if strcmp(subID,'pil001')==1 || strcmp(subID,'pil002')==1 || strcmp(subID,'pil005')==1
    nbRun=9;
else
    nbRun=10;
end

%get the masks/ROIs to be used
% their location

%'subjectSphere'
radiusNb=opt.maskRadiusNb;
opt.maskPath = fullfile(fileparts(mfilename('fullpath')), '..','..', 'outputs','derivatives' ,'bidspm-roi','subjectSphere',strcat('sub-',subID));
opt.maskName = {strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lhMT_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rhMT_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lS1_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lPC_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rPC_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lMTt_radiusNb-',num2str(radiusNb), '.nii'), ...
    strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rMTt_radiusNb-',num2str(radiusNb), '.nii'),...
    };

% use in output roi name
opt.maskLabel = {'lhMT', 'rhMT', 'lS1', 'lPC', 'rPC','lMTt', 'rMTt'};

for iImage = 1:length(opt.mvpa.map4D)

  for iMask = 7

    % choose the mask
    mask = fullfile(opt.maskPath, opt.maskName{iMask});

    % display the used mask
    disp(opt.maskName{iMask});

    % 4D image
    imageName = ['sub-',num2str(subID),'_task-FoR2_space-IXI549Space_FWHM-', num2str(funcFWHM),'_desc-4D_', opt.mvpa.map4D{iImage},'.nii'];
    image=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID),imageName);

    % load cosmo input
    ds = cosmo_fmri_dataset(image, 'mask', mask);

    % Getting rid off zeros
    zeroMask = all(ds.samples == 0, 1);
    ds = cosmo_slice(ds, ~zeroMask, 2);
    
    % remove constant features
    ds = cosmo_remove_useless_data(ds);

    % set cosmo structure
    ds = setCosmoStructure(opt,nbRun, ds, condLabelNb, condLabelName);

    % % compute average for each unique target, so that the dataset has X
    % % samples - one for each target
    %   .sa.targets should be permutation of unique targets; to average samples with the same targets, consider
    ds_mean=cosmo_fx(ds,@(x)mean(x,1),'targets');

    ds_rsm=cosmo_dissimilarity_matrix_measure(ds_mean);

    % set chunks (one chunk per subject)
    ds_rsm.sa.chunks=iSub*ones(size(ds_rsm.samples,1),1);
    ds_rsms{iSub}=ds_rsm;

   end
end
end

all_ds=cosmo_stack(ds_rsms);

%% Run DISTATIS
distatis=cosmo_distatis(all_ds);

%% show compromise distance matrix
[compromise_matrix,dim_labels,values]=cosmo_unflatten(distatis,1);

labels={'handDownPinkyThumb', 'handDownFingerWrist', 'handUpPinkyThumb', 'handUpFingerWrist', 'visualHorizontal','visualVertical'};
n_labels=numel(labels);
figure();
imagesc(compromise_matrix)
title(strcat('DSM ROI: ', string(opt.maskLabel{iMask})));
set(gca,'YTick',1:n_labels,'YTickLabel',labels);
set(gca,'XTick',1:n_labels,'XTickLabel',labels);
ylabel(dim_labels{1});
xlabel(dim_labels{2});
colorbar

% skip if stats toolbox is not present
if cosmo_check_external('@stats',false)
    figure();
    hclus = linkage(compromise_matrix);
    dendrogram(hclus,'labels',labels,'orientation','left');
    title(strcat('dendrogram ROI: ',string(opt.maskLabel{iMask})));

    figure();
    F = cmdscale(squareform(compromise_matrix));
    text(F(:,1), F(:,2), labels);
    title(strcat('2D MDS plot ROI: ',string(opt.maskLabel{iMask})));
    mx = max(abs(F(:)));
    xlim([-mx mx]); ylim([-mx mx]);
end


function ds = setCosmoStructure(opt,nbRun, ds, condLabelNb, condLabelName)
  % sets up the target, chunk, labels by stimuli condition labels, runs,
  % number labels.

  % design info from opt
%   nbRun = opt.mvpa.nbRun;
  betasPerCondition = opt.mvpa.nbTrialRepetition;

  % chunk (runs), target (condition), labels (condition names)
  conditionPerRun = length(condLabelNb);
  betasPerRun = betasPerCondition * conditionPerRun;

  chunks = repmat((1:nbRun)', 1, betasPerRun);
  chunks = chunks(:);

  targets = repmat(condLabelNb', 1, nbRun)';
  targets = targets(:);
  targets = repmat(targets, betasPerCondition, 1);

  condLabelName = repmat(condLabelName', 1, nbRun)';
  condLabelName = condLabelName(:);
  condLabelName = repmat(condLabelName, betasPerCondition, 1);

  % assign our 4D image design into cosmo ds git
  ds.sa.targets = targets;
  ds.sa.chunks = chunks;
  ds.sa.labels = condLabelName;

end
