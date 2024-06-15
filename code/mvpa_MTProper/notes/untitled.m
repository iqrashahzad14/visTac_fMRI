

% LOAD DS

DEFINE YOUR DS 
CHUNKS 
TARGETS
LABELS
MODALITYY


#MAKE SURE ALL ARE CORRECT
PLOT ALL OF THEM NEXT TO  EAHC OTHER
EACH MODALITY SHOULD HAVE ALL CONDITIONS


FOR ONLY 1 TEST MODALITY (1)


% RUNNING THE CLASSIFICATION


            partitions=cosmo_nchoosek_partitioner(ds, 1, 'modality',testModality);

            
            % remove constant features
            ds = cosmo_remove_useless_data(ds);

            % calculate the mask size
            maskVoxel = size(ds.samples, 2);

            

            % use the ratios, instead of the voxel number:
            opt.mvpa.feature_selection_ratio_to_keep = opt.mvpa.ratioToKeep;

            % ROI mvpa analysis
            [pred, accuracy] = cosmo_crossvalidate(ds, ...
                                       @cosmo_classify_meta_feature_selection, ...
                                       partitions, opt.mvpa);

                                   subplot(1,2,1); imagesc(ds.sa.modality)

subplot(1,3,1); imagesc(ds.sa.modality);title('modality')
subplot(1,3,2); imagesc(ds.sa.targets);title('targets')
subplot(1,3,3); imagesc(ds.sa.chunks);title('chunks')