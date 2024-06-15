
condLabelName = {'handDown_pinkyThumb', 'handDown_fingerWrist', 'handUp_pinkyThumb', 'handUp_fingerWrist', 'visual_vertical', 'visual_horizontal'};
  
numRuns = 9;

% 1: hand down 2:hand up 3:Visual;
modality =  repmat([1 1,2,2,3,3],numRuns,1);
modality = modality(:);

imagesc(modality)

% 1: Vertical 2:Horizontal
condition =  repmat([1 2,2,1,1,2],numRuns,1);
condition = condition(:);
imagesc(condition)
% extDirLabelName=['ver','hor', 'hor', 'ver', 'ver','hor'];


% 1: Vertical 2:Horizontal
chunks =  repmat([1 :numRuns],1,6);
chunks = chunks(:);
imagesc(chunks)

%%
numRuns = 9;

% 1: hand down 2:hand up 3:Visual;
modality =  repmat([1 1,2,2,3,3],numRuns,1);
modality = modality(:);

imagesc(modality)

% 1: Vertical 2:Horizontal
direction =  repmat([1 2,2,1,1,2],numRuns,1);
direction = direction(:);
imagesc(direction)
% extDirLabelName=['ver','hor', 'hor', 'ver', 'ver','hor'];


% 1: Vertical 2:Horizontal
chunks =  repmat([1 :numRuns],1,6);
chunks = chunks(:);
imagesc(chunks)

%%
subplot(1,3,1); imagesc(ds.sa.modality);title('modality')
subplot(1,3,2); imagesc(ds.sa.targets);title('targets')
subplot(1,3,3); imagesc(ds.sa.chunks);title('chunks')
