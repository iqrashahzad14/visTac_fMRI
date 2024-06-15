%% stats

%% visDir

[h1,p1]=ttest(visDir_lS1,0.5);
[h2,p2]=ttest(visDir_lPC,0.5);
[h3,p3]=ttest(visDir_rPC,0.5);
[h4,p4]=ttest(visDir_lMTt,0.5);
[h5,p5]=ttest(visDir_rMTt,0.5);
[h6,p6]=ttest(visDir_lhMT,0.5);
[h7,p7]=ttest(visDir_rhMT,0.5);

stats.h=[h1,h2,h3,h4,h5,h6,h7]
stats.p=[p1,p2,p3,p4,p5,p6,p7]

% bonnstats.p=[p1,p2,p3,p4,p5,p6,p7]*(1/7)
%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

fdrCorrPVal=mafdr(stats.p, 'BHFDR', 'true')

%% anatExt

[h1,p1]=ttest(anat_lS1,0.5);
[h2,p2]=ttest(anat_lPC,0.5);
[h3,p3]=ttest(anat_rPC,0.5);
[h4,p4]=ttest(anat_lMTt,0.5);
[h5,p5]=ttest(anat_rMTt,0.5);
[h6,p6]=ttest(anat_lhMT,0.5);
[h7,p7]=ttest(anat_rhMT,0.5);

stats.h=[h1,h2,h3,h4,h5,h6,h7]
stats.p=[p1,p2,p3,p4,p5,p6,p7]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

fdrCorrPVal=mafdr(stats.p, 'BHFDR', 'true')

[h1,p1]=ttest(ext_lS1,0.5);
[h2,p2]=ttest(ext_lPC,0.5);
[h3,p3]=ttest(ext_rPC,0.5);
[h4,p4]=ttest(ext_lMTt,0.5);
[h5,p5]=ttest(ext_rMTt,0.5);
[h6,p6]=ttest(ext_lhMT,0.5);
[h7,p7]=ttest(ext_rhMT,0.5);

stats.h=[h1,h2,h3,h4,h5,h6,h7]
stats.p=[p1,p2,p3,p4,p5,p6,p7]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

fdrCorrPVal=mafdr(stats.p, 'BHFDR', 'true')

%
[h1,p1]=ttest(anat_lS1,ext_lS1);
[h2,p2]=ttest(anat_lPC,ext_lPC);
[h3,p3]=ttest(anat_lPC,ext_rPC);
[h4,p4]=ttest(anat_lPC,ext_lMTt);
[h5,p5]=ttest(anat_lPC,ext_rMTt);
[h6,p6]=ttest(anat_lPC,ext_lhMT);
[h7,p7]=ttest(anat_lPC,ext_rhMT);

stats.h=[h1,h2,h3,h4,h5,h6,h7]
stats.p=[p1,p2,p3,p4,p5,p6,p7]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

fdrCorrPVal=mafdr(stats.p, 'BHFDR', 'true')

%% crossModal -Anat/EXT

[h1,p1]=ttest(both_lS1,0.5);
[h2,p2]=ttest(both_lPC,0.5);
[h3,p3]=ttest(both_rPC,0.5);
[h4,p4]=ttest(both_lMTt,0.5);
[h5,p5]=ttest(both_rMTt,0.5);
[h6,p6]=ttest(both_lhMT,0.5);
[h7,p7]=ttest(both_rhMT,0.5);

stats.h=[h1,h2,h3,h4,h5,h6,h7]
stats.p=[p1,p2,p3,p4,p5,p6,p7]

% stats.h=[h4,h5,h6,h7]
% stats.p=[p4,p5,p6,p7]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

fdrCorrPVal=mafdr(stats.p, 'BHFDR', 'true')

%% univar
%beta from vml on all tactile defined rois
[h1,p1]=ttest2(betaEstMotion1,betaEstStatic1);
[h2,p2]=ttest2(betaEstMotion2,betaEstStatic2);
[h3,p3]=ttest2(betaEstMotion3,betaEstStatic3);
[h4,p4]=ttest2(betaEstMotion4,betaEstStatic4);
[h5,p5]=ttest2(betaEstMotion5,betaEstStatic5);
% [h6,p6]=ttest2(betaEstMotion6,betaEstStatic6);
% [h7,p7]=ttest2(betaEstMotion7,betaEstStatic7);

stats.h=[h1,h2,h3,h4,h5]%,h6,h7]
stats.p=[p1,p2,p3,p4,p5]%,p6,p7]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

% beta from TML on lhmt and rhmt
[h6,p6]=ttest2(betaEstMotion6,betaEstStatic6);
[h7,p7]=ttest2(betaEstMotion7,betaEstStatic7);
stats.h=[h6,h7]
stats.p=[p6,p7]
%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)

%% mt mst

%beta from vml on all tactile defined rois
[h1,p1]=ttest2(betaEstMotion1,betaEstStatic1);
[h2,p2]=ttest2(betaEstMotion2,betaEstStatic2);
[h3,p3]=ttest2(betaEstMotion3,betaEstStatic3);
[h4,p4]=ttest2(betaEstMotion4,betaEstStatic4);
[h5,p5]=ttest2(betaEstMotion5,betaEstStatic5);
[h6,p6]=ttest2(betaEstMotion6,betaEstStatic6);
% [h7,p7]=ttest2(betaEstMotion7,betaEstStatic7);

stats.h=[h1,h2,h3,h4,h5,h6]
stats.p=[p1,p2,p3,p4,p5,p6]

%Holm's sequential Bonferroni correction
[cor_p, cor_h]=bonf_holm(stats.p,.05)