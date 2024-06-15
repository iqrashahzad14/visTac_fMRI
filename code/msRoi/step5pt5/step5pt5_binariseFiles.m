%step5.5: binarise
maskDir='input_msRoi';
fileName=strcat('sub-ALL','_hemi-','R','_space-MNI_label-','rhMT','_radiusNb-','cluster','.nii');
file = load_nii(char(fullfile(maskDir,fileName)));
binarisedFile.img=file(find(file.img > 0)==1);
thresholdLevel=find(file.img >0);

% just check that rhMT cluster is already binarised.
% 271633-266175=5458
% find(file.img ~=2)-find(file.img ~=1)=5458
% find(file.img ~=2)-find(file.img ~=0)=5458