function accu = extractDSM(opt)

% main function which loops through masks and subjects to calculate the
% decoding accuracies for given conditions.
% dependant on SPM + CPP_SPM and CosMoMvpa toolboxes
% the output is compatible for R visualisation, it gives .csv file as well
% as .mat file 

  % get the smoothing parameter for 4D map
  funcFWHM = opt.funcFWHM;   

  % set output folder/name
  savefileMat = fullfile(opt.pathOutput, ...
                         [opt.taskName, ...
                         'dsm',...
                         '_radius', num2str(opt.maskRadiusNb), ...
                          '_smoothing', num2str(funcFWHM), ...
                          '_ratio', num2str(opt.mvpa.ratioToKeep), ...
                          '_', datestr(now, 'yyyymmddHHMM'), '.mat']);


  %% MVPA options

  % set cosmo mvpa structure
  condLabelNb = [1 2 3 4 5 6 ];
  condLabelName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_horizontal','visual_vertical' };
%   decodingConditionList = {'VH_vs_VV','VV_vs_VH','HUPT_vs_HUFW', 'HUFW_vs_HUPT','HDPT_vs_HDFW', 'HDFW_vs_HDPT'};
    
   %% the following snippet creates a list of pairwise decodings
    %list all the conditions accroding to the conditions
    rowList={'1', '2', '3', '4', '5', '6'};
%     connectStr = '_vs_';
    colList = {'1', '2', '3', '4', '5', '6'};

    %create an empty cell array and pair them accrodingly in the empty cell
    %array
%     pairCondition={};
    for iCondition = 1:length(rowList)
        for iRow = 1:length(rowList)
            for iCol = 1:length(colList)
                condPair{iRow, iCol} = strcat(string(rowList(iRow)),',', string(colList(iCol)))
            end
        end
    end

    decodingConditionList = reshape(condPair,[36,1])';
    
    %%
    [targets, chunks, labels] = setTargetChunksLabels(opt, condLabelNb, condLabelName);

  %% let's get going!

%   % set structure array for keeping the results
%   accu = struct( ...
%                 'subID', [], ...
%                 'mask', [], ...
%                 'accuracy', [], ...
%                 'prediction', [], ...
%                 'maskVoxNb', [], ...
%                 'choosenVoxNb', [], ...
%                 'image', [], ...
%                 'ffxSmooth', [], ...
%                 'roiSource', [], ...
%                 'decodingCondition', [], ...
%                 'permutation', [], ...
%                 'imagePath', []);

  count = 1;

  for iSub = 1%:numel(opt.subjects)

    % get FFX path
    subID = opt.subjects{iSub};
    ffxDir = getFFXdir(subID, funcFWHM, opt);
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

      for iMask = 1:length(opt.maskLabel)

        % choose the mask
        mask = fullfile(opt.maskPath, opt.maskName{iMask});
        
        % display the used mask
        disp(opt.maskName{iMask});
        
        % 4D image
        imageName = ['sub-',num2str(subID),'_task-FoR2_space-IXI549Space_FWHM-', num2str(funcFWHM),'_desc-4D_', opt.mvpa.map4D{iImage},'.nii'];
        image=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID),imageName);
        
        for iDecodingCondition=[2,3,4,5,6, 7,9,10,11,12,13,14,16,17,18,19,20,21,23,24,25,26,27,28,30,31,32,33,34,35]%1:length(decodingConditionList) %see the types in decoing conditionlist
            decodingCondition=decodingConditionList(iDecodingCondition);
            
            %% put everything here
            ds = cosmo_fmri_dataset(image, ...
                        'mask',mask,...
                        'targets',targets,...
                        'chunks',chunks);
                    
            ds.sa.labels = labels;
            
            % % compute average for each unique target, so that the dataset has X
                    % % samples - one for each target
            ds=cosmo_fx(ds, @(x)mean(x,1), 'targets', 1);
            
            % slice the ds according to your targers (choose your
            % train-test conditions
            ds = cosmo_slice(ds, ...
                ds.sa.targets == condLabelNb(str2num(decodingConditionList{iDecodingCondition}{1}(1))) | ...
                ds.sa.targets == condLabelNb(str2num(decodingConditionList{iDecodingCondition}{1}(3))));
            
            % remove constant features
            ds=cosmo_remove_useless_data(ds);

            % simple sanity check to ensure all attributes are set properly
            cosmo_check_dataset(ds);

            % Use pdist (or cosmo_pdist) with 'correlation' distance to get DSMs
            % in vector form.
            dsm = pdist(ds.samples, 'correlation');
            % get the euclidean distance
            dsmEuc = pdist(ds.samples);
            % get standardized euclidean distance by dividing to
            % standard deviation
            dsmSeuc = pdist(ds.samples, 'seuclidean');     
            
            %%%%%%%%%%%
            % add ROI/IMAGE/ saving structure
            % save into matrix according to the groups
            contVec(iSub,:) = dsm;
            contVecEuc(iSub,:) = dsmEuc;
            contVecSeuc(iSub,:) = dsmSeuc;
            
            

        end
      end
    end
  end
  
  %create a mean vector of all the sub values, and ive the matrix form
    contMeanDsm = squareform(mean(contVec));

    %% Save the mat fil with all the brain DSMs
    saveRoiName = opt.maskName{iMask}(1:end-9);
    saveOutputName = fullfile(outputPath, ...
        [opt.taskName, ...
        '_DSM_', ...
        saveRoiName, '_', ...
        'image-', opt.mvpa.map4D{iImage}, ...
        '_Slicing-', slicingCategory, ...
        '_s-', num2str(funcFWHM), ...
        '.mat']);

    save (saveOutputName,...
        'contVec','contMeanDsm', 'contVecEuc', 'contVecSeuc');

  %% save output

  % mat file
  save(savefileMat, 'accu');

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

function [targets, chunks, labels] = setTargetChunksLabels(opt, condLabelNb, condLabelName)
  % sets up the target, chunk, labels by stimuli condition labels, runs,
  % number labels.

  % design info from opt
  nbRun = opt.mvpa.nbRun;
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
  labels = repmat(condLabelName, betasPerCondition, 1);

end
