function accu = calculateMvpaAcrossHandAnatExtPseudoRun(opt)

% main function which loops through masks and subjects to calculate the
% decoding accuracies for given conditions.
% dependant on SPM + CPP_SPM and CosMoMvpa toolboxes
% the output is compatible for R visualisation, it gives .csv file as well
% as .mat file 

% conditions are named 'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist'
%, 'visual_vertical', 'visual_horizontal' in the same order

% classify 'HDPT+HUPT_vs_HDFW+HUFW','HUPT+HDFW_vs_HDPT+HUFW'

  % get the smoothing parameter for 4D map
  funcFWHM = opt.funcFWHM;

  % set output folder/name
  savefileMat = fullfile(opt.pathOutput, ...
                         [opt.taskName, ...
                         '_AnatExt',...
                         '_radius', num2str(opt.maskRadiusNb), ...
                          '_smoothing', num2str(funcFWHM), ...
                          '_ratio', num2str(opt.mvpa.ratioToKeep), ...
                          '_pseudo'...
                          '_', datestr(now, 'yyyymmddHHMM'), '.mat']);

  %% MVPA options

  % set cosmo mvpa structure
%   condLabelNb = [1 2 3 4 5 6 ]; [1 2 1 2 5 6 ];[2 1 1 2 5 6 ];[ 1 1 2256]
  condLabelName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_horizontal','visual_vertical' };
  decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW','HDPT_HDFW_vs_HUPT_HUFW'};

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
        strcat('sub-',num2str(subID),'_hemi-L_space-MNI_label-lMTt_radiusNb-',num2str(radiusNb), '.nii'), ...
        strcat('sub-',num2str(subID),'_hemi-R_space-MNI_label-rMTt_radiusNb-',num2str(radiusNb), '.nii'),...
        };

    % use in output roi name
    opt.maskLabel = {'lhMT', 'rhMT','lS1', 'lMTt', 'rMTt'};

    for iImage = 1:length(opt.mvpa.map4D)

      for iMask = 1:length(opt.maskLabel)

        % choose the mask
        mask = fullfile(opt.maskPath, opt.maskName{iMask});

        % display the used mask
        disp(opt.maskName{iMask});
        
        % 4D image
        imageName = ['sub-',num2str(subID),'_task-FoR2_space-IXI549Space_FWHM-', num2str(funcFWHM),'_desc-4D_', opt.mvpa.map4D{iImage},'.nii'];
        image=fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','mvpaVol',strcat('sub-',subID),imageName);
        
        for iDecodingCondition=1:length(decodingConditionList) %see the types in decoding conditionlist
            decodingCondition=decodingConditionList(iDecodingCondition);
            if strcmp (decodingCondition, decodingConditionList(1))==1
            % set cosmo mvpa structure
                condLabelNb = [1 2 1 2 5 6 ]; 
                targets_of_interest = [1,2];
            elseif strcmp (decodingCondition, decodingConditionList(2))==1
            % set cosmo mvpa structure
                condLabelNb = [2 1 1 2 5 6 ]; 
                targets_of_interest = [1,2];
            elseif strcmp (decodingCondition, decodingConditionList(3))==1
            % set cosmo mvpa structure
                condLabelNb = [1 1 2 2 5 6 ]; 
                targets_of_interest = [1,2];
            end
            
            %%%%%%% Always cehck with the funciton createPseudoRuns
            x = nchoosek(1:nbRun, 2); % creating unique pairs
            nbItr = size(x, 1);
            %%%%%%%
            for itrPseudo=1:nbItr
                fprintf('%d pseudoItr: \n', itrPseudo);

            % load cosmo input
            ds = cosmo_fmri_dataset(image, 'mask', mask);
            
            ds = cosmo_remove_useless_data(ds);
            
            % Getting rid off zeros
            zeroMask = all(ds.samples == 0, 1);
            ds = cosmo_slice(ds, ~zeroMask, 2);

            % set cosmo structure
            ds = setCosmoStructure(opt,nbRun, ds, condLabelNb, condLabelName);
            
            %%%%
            % PSEUDORUNS - by averaging two chunks
            %randomise the order of chunks
            [chunkMatrix,~,~]=createPseudoRun(nbRun);
            chunkMatIdx=chunkMatrix(:,nbItr);
            chunkMatIdx=repmat(chunkMatIdx, 6,1); % 6 because I have 6 unique betas/conditions and to match my ds.sa.chunks
            %assign the pseudoRuns
            ds.sa.chunks=chunkMatIdx;
            %average the pseudoRuns and assign to a new one
            dsPseudo=cosmo_fx(ds,@(x)mean(x,1),{'targets','chunks'});
            ds=dsPseudo;
            %%%%
            
            % slice the ds according to your targers (choose your
            % train-test conditions
%             ds = cosmo_slice(ds, ds.sa.targets == condLabelNb(1) | ds.sa.targets == condLabelNb(2));
            ds = cosmo_slice(ds, ds.sa.targets == targets_of_interest(1) | ds.sa.targets == targets_of_interest(2));               
            
            % remove constant features
            ds = cosmo_remove_useless_data(ds);

            % calculate the mask size
            maskVoxel = size(ds.samples, 2);

            % partitioning, for test and training : cross validation
            partitions = cosmo_nfold_partitioner(ds);

            % define the voxel number for feature selection
            % set ratio to keep depending on the ROI dimension

            % use the ratios, instead of the voxel number:
            opt.mvpa.feature_selection_ratio_to_keep = opt.mvpa.ratioToKeep;

            % ROI mvpa analysis
            [pred, accuPseudo] = cosmo_crossvalidate(ds, ...
                                       @cosmo_classify_meta_feature_selection, ...
                                       partitions, opt.mvpa);
                                   
            accuPseduoVec(itrPseudo)=accuPseudo;
            end
            accuPseduoVec
            accuracy=mean(accuPseduoVec);                       
            %% store output
            accu(count).subID = subID;
            accu(count).mask = opt.maskLabel{iMask};
            accu(count).maskVoxNb = maskVoxel;
            accu(count).maskRadiusNb = radiusNb;
            accu(count).choosenVoxNb = opt.mvpa.feature_selection_ratio_to_keep;
            accu(count).image = opt.mvpa.map4D{iImage};
            accu(count).ffxSmooth = funcFWHM;
            accu(count).accuPseudo = accuPseduoVec;
            accu(count).accuracy = accuracy;
            accu(count).prediction = pred;
            accu(count).imagePath = image;
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
                ds0.sa.targets = cosmo_randomize_targets(ds);
                [~, acc0(k)] = cosmo_crossvalidate(ds0, ...
                                                   @cosmo_meta_feature_selection_classifier, ...
                                                   partitions, opt.mvpa);
              end

              p = sum(accuracy < acc0) / nbIter;
              fprintf('%d permutations: accuracy=%.3f, p=%.4f\n', nbIter, accuracy, p);

              % save permuted accuracies
              accu(count).permutation = acc0';
              accu(count).pValue = p;
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
  
end

function ds = setCosmoStructure(opt, nbRun,ds, condLabelNb, condLabelName)
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