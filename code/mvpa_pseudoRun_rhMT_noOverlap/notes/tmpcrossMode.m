% For CrossMod decoding

condLabelNb = [ 1 2 3 4 5 6];
condLabelName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_vertical', 'visual_horizontal'};;
dirLabelNb = [1 2 2 1 1 2 ];
dirLabelName = {'vertical', 'horizontal','horizontal','vertical','vertical', 'horizontal'};
modalityLabelNb = [1 1 1 1 2 2];
modalityLabelName = {'tactile','tactile','tactile','tactile','visual','visual'};
decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};

nbRun = 10;
betasPerCondition = 1;

% 1: hand down 2:hand up 3:Visual
modalityNb = [1 1 1 1 2 2];
modalityNb =  repmat(modalityNb,(nbRun*betasPerCondition),1);
modalityNb = modalityNb(:);
imagesc(modalityNb)

% modalityName = {'tactile','tactile','tactile','tactile','visual','visual'};
% modalityName=repmat(modalityName,(nbRun*betasPerCondition),1);
% modalityName = modalityName(:);
% imagesc(modalityName)

% 1: Vertical 2:Horizontal
directionNb = [1 2 2 1 1 2 ];
directionNb =  repmat(directionNb,(nbRun*betasPerCondition),1);
directionNb = directionNb(:);
imagesc(directionNb);

% directionName={'ver','hor', 'hor', 'ver', 'ver','hor'};
% directionName = repmat(directionName,(nbRun*betasPerCondition),1);
% directionName = directionName(:);
% imagesc(directionName)


chunks =  repmat(1 :(nbRun*betasPerCondition),1,6);
chunks = chunks(:);
imagesc(chunks)

% assign our 4D image design into cosmo ds git
ds.sa.chunks = chunks;
ds.sa.modality = modalityNb;
ds.sa.targets = directionNb;


% ds.sa.labels = directionName;


subplot(1,3,1); imagesc(ds.sa.modality);title('modality')
subplot(1,3,2); imagesc(ds.sa.targets);title('targets')
subplot(1,3,3); imagesc(ds.sa.chunks);title('chunks')
%%
condNb = [ 1 2 3 4 5 6];
condName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_vertical', 'visual_horizontal'};;
directionNb = [1 2 2 1 1 2 ];
directionName = {'vertical', 'horizontal','horizontal','vertical','vertical', 'horizontal'};
modalityNb = [1 1 1 1 2 2];
modalityName = {'tactile','tactile','tactile','tactile','visual','visual'};
decodingConditionList = {'trainVisual_testTactile','trainTactile_testVision','both'};

nbRun = 10;
betasPerCondition = 1;

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

subplot(1,3,1); imagesc(ds.sa.modality);title('modality')
subplot(1,3,2); imagesc(ds.sa.targets);title('targets')
subplot(1,3,3); imagesc(ds.sa.chunks);title('chunks')
