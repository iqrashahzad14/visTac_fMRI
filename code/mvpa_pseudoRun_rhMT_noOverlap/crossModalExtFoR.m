function accu = crossModalExtFoR(opt)

% main function which loops through masks and subjects to calculate the
% decoding accuracies for given conditions.
% dependant on SPM + CPP_SPM and CosMoMvpa toolboxes

  % get the smoothing parameter for 4D map
  funcFWHM = opt.funcFWHM;

  % choose masks to be used
%   opt = chooseMaskNEW(opt);
    

  % set output folder/name
  savefileMat = fullfile(opt.pathOutput, ...
                         [opt.taskName, ...
                         '_CrossModalExt',...
                          '_radius', num2str(opt.maskRadiusNb), ...
                          '_smoothing', num2str(funcFWHM), ...
                          '_ratio', num2str(opt.mvpa.ratioToKeep), ...
                          '_', datestr(now, 'yyyymmddHHMM'), '.mat']);


  %% MVPA options
  
  % set cosmo mvpa structure
  condNb = [ 1 2 3 4 5 6];
  condName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_horizontal','visual_vertical' };
  directionNb = [1 2 2 1 2 1 ];
  directionName = {'vertical', 'horizontal','horizontal','vertical','horizontal','vertical', };
  modalityNb = [1 1 1 1 2 2];
  modalityName = {'tactile','tactile','tactile','tactile','visual','visual'};
  decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};

  %% let's get going!

  % set structure array for keeping the results
  accu = struct( ...
                'subID', [], ...
                'mask', [], ...
                'accuracy', [], ...
                'prediction', [], ...
                'maskVoxNb', [], ...
                'choosenVoxNb', [], ...
                'image', [], ...
                'ffxSmooth', [], ...
                'roiSource', [], ...
                'decodingCondition', [], ...
                'permutation', [], ...
                'imagePath', []);

  count = 1;

  for iSub = 1:numel(opt.subjects)

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
%     %'groupSphere'
%     radiusNb=opt.maskRadiusNb;
%     opt.maskPath = fullfile(fileparts(mfilename('fullpath')), '..','..','outputs','derivatives' ,'bidspm-roi','groupSphere','sub-ALL');
%     opt.maskName = {strcat('sub-','ALL','_hemi-L_space-MNI_label-lhMT_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-R_space-MNI_label-rhMT_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-L_space-MNI_label-lS1_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-L_space-MNI_label-lPC_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-R_space-MNI_label-rPC_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-L_space-MNI_label-lMTt_radiusNb-',num2str(radiusNb), '.nii'), ...
%         strcat('sub-','ALL','_hemi-R_space-MNI_label-rMTt_radiusNb-',num2str(radiusNb), '.nii'),...
%         };
%     %'glasserMotor'
%     opt.maskPath = fullfile(fileparts(mfilename('fullpath')), '..','..','outputs','derivatives' ,'bidspm-glasser-roi',...
%         'derivatives' ,'bidspm-roi','group');
%     opt.maskName = {strcat('r','hemi-L_space-MNI_label-4','_mask','.nii'), ...
%         strcat('r','hemi-R_space-MNI_label-4','_mask','.nii'), ...
%         };
%     
%     % 'subjectExpansion'
%     voxelNb=opt.maskVoxelNb;radiusNb=4;
%     opt.maskPath = fullfile(fileparts(mfilename('fullpath')), '..','..', '..','derivatives' ,'cpp_roi_glasser',strcat('voxelNb-',num2str(voxelNb)),strcat('sub-',subID));    
%     opt.maskName = {strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lhMT_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rhMT_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lS1_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lPC_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rPC_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lMTt_vox-',num2str(voxelNb), '.nii'), ...
%         strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rMTt_vox-',num2str(voxelNb), '.nii'),...
%         };

    % use in output roi name
    opt.maskLabel = {'lhMT', 'rhMT', 'lS1', 'lPC', 'rPC','lMTt', 'rMTt'};

    for iImage = 1:length(opt.mvpa.map4D)

      for iMask = 1:length(opt.maskName)

        % choose the mask
        mask = fullfile(opt.maskPath, opt.maskName{iMask});

        % display the used mask
        disp(opt.maskName{iMask});
        
        % 4D image
        imageName = ['sub-',num2str(subID),'_task-FoR2_space-IXI549Space_FWHM-', num2str(funcFWHM),'_desc-4D_', opt.mvpa.map4D{iImage},'.nii'];
        image=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID),imageName);
        
        
        for iCrossDecodType=1:3 %see the types in decoding conditionlist
            if iCrossDecodType==1
                test=1;
                decodingCondition=decodingConditionList(1);
            elseif iCrossDecodType==2
                test = 2;
                decodingCondition=decodingConditionList(2);
            elseif iCrossDecodType==3
                test = [];
                decodingCondition=decodingConditionList(3);
            end
            
                        
            % load cosmo input
            ds = cosmo_fmri_dataset(image, 'mask', mask);
            
            ds = cosmo_remove_useless_data(ds);

%             % Getting rid off zeros
%             zeroMask = all(ds.samples == 0, 1);
%             ds = cosmo_slice(ds, ~zeroMask, 2);

            % set cosmo structure
            ds = setCosmoStructure(opt, nbRun,ds, modalityNb, directionNb );

            % Demean  every pattern to remove univariate effect differences
            meanPattern = mean(ds.samples,2);  % get the mean for every pattern
            meanPattern = repmat(meanPattern,1,size(ds.samples,2)); % make a matrix with repmat
            ds.samples  = ds.samples - meanPattern; % remove the mean from every every point in each pattern

            % Slice the dataset accroding to modality
            modIdx = (ds.sa.modality==1) | (ds.sa.modality==2) ;
            ds = cosmo_slice(ds,modIdx) ;
            
            % Slice the dataset accroding to motion direction  
            %slice according to directions
            ds = cosmo_slice(ds,(ds.sa.targets==1) | (ds.sa.targets==2)) ;
%             ds = cosmo_slice(ds,strcmp(ds.sa.targets,'vertical') | strcmp(ds.sa.labels,'horizontal')) ;
            
            % partitioning, for test and training : cross validation
            %partitions = cosmo_nfold_partitioner(ds);
            partitions=cosmo_nchoosek_partitioner(ds, 1, 'modality',test);

            
            % remove constant features
            %ds = cosmo_remove_useless_data(ds);

            % calculate the mask size
            maskVoxel = size(ds.samples, 2);

            

            % use the ratios, instead of the voxel number:
            opt.mvpa.feature_selection_ratio_to_keep = opt.mvpa.ratioToKeep;

            % ROI mvpa analysis
            [pred, accuracy] = cosmo_crossvalidate(ds, ...
                                       @cosmo_classify_meta_feature_selection, ...
                                       partitions, opt.mvpa);
            % show targets, chunks, and predictions labels for each of the
            %     % four folds
%             a={ds.sa.targets,ds.sa.chunks,pred}
%                 cosmo_disp({ds.sa.targets,ds.sa.chunks,pred},'threshold',inf)
%                 cosmo_disp({ds.sa.targets,ds.sa.chunks},'threshold',inf)

            %% store output
            accu(count).subID = subID;
            accu(count).mask = opt.maskLabel{iMask};
            accu(count).maskVoxNb = maskVoxel;
            accu(count).choosenVoxNb = opt.mvpa.feature_selection_ratio_to_keep;
           % accu(count).choosenVoxNb = round(maskVoxel * maxRatio);
           % accu(count).maxRatio = maxRatio;
            accu(count).image = opt.mvpa.map4D{iImage};
            accu(count).ffxSmooth = funcFWHM;
            accu(count).accuracy = accuracy;
%             accu(count).radius = opt.radius;
            accu(count).prediction = pred;
            accu(count).imagePath = image;
    %         accu(count).roiSource = roiSource;
            accu(count).decodingCondition = decodingCondition;

            %% PERMUTATION PART
            if opt.mvpa.permutate  == 1
              % number of iterations
              nbIter = 100;

              % allocate space for permuted accuracies
              acc0 = zeros(nbIter, 1);

              % make a copy of the dataset
              ds0 = ds;

              % for _niter_ iterations, reshuffle the labels and compute accuracy
              % Use the helper function cosmo_randomize_targets
              for k = 1:nbIter
                      % manaully randomize the targets (because of cross-modal error)
                        % In every modality seperatly and in every chunk ,
                        % randomize the directions
                    for iChunk=1:max(ds.sa.chunks)
                        for iTestModality = 1:max(ds.sa.modality)
                            ds0.sa.targets(ds.sa.chunks==iChunk & ds.sa.modality==iTestModality) = Shuffle(ds.sa.targets(ds.sa.chunks==iChunk & ds.sa.modality==iTestModality));
                        end
                    end
%                 ds0.sa.targets = cosmo_randomize_targets(ds);
                [~, acc0(k)] = cosmo_crossvalidate(ds0, ...
                                                   @cosmo_meta_feature_selection_classifier, ...
                                                   partitions, opt.mvpa);
              end

              p = sum(accuracy < acc0) / nbIter;
              fprintf('%d permutations: accuracy=%.3f, p=%.4f\n', nbIter, accuracy, p);

              % save permuted accuracies
              accu(count).permutation = acc0';
            end

            % increase the counter and allons y!
            count = count + 1;

            fprintf(['Sub'  subID ' - area: ' opt.maskLabel{iMask} ...
                     ', accuracy: ' num2str(accuracy) '\n\n\n']);

        end
      end
    end
  end
  %% save output

  % mat file
  save(savefileMat, 'accu');

  % csv but with important info for plotting
%   csvAccu = rmfield(accu, 'permutation');
%   csvAccu = rmfield(csvAccu, 'prediction');
%   csvAccu = rmfield(csvAccu, 'imagePath');
%   writetable(struct2table(csvAccu), savefileCsv);

end

function ds = setCosmoStructure(opt, nbRun,ds, modalityNb, directionNb )
  % sets up the target, chunk, labels by stimuli condition labels, runs,
  % number labels.

  % design info from opt
%   nbRun = opt.mvpa.nbRun;
  betasPerCondition = opt.mvpa.nbTrialRepetition;

  chunks =  repmat(1 :(nbRun*betasPerCondition),1,6);
  chunks = chunks(:);
  
  modalityNb =  repmat(modalityNb,(nbRun*betasPerCondition),1);
  modalityNb = modalityNb(:);
  
  directionNb =  repmat(directionNb,(nbRun*betasPerCondition),1);
  directionNb = directionNb(:);
  
  % assign our 4D image design into cosmo ds git
  ds.sa.chunks = chunks;
  ds.sa.modality = modalityNb;
  ds.sa.targets = directionNb;

end
