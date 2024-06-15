
% For Spherical Rois
for iSmooth = [0,2]
    opt.funcFWHM = iSmooth;
    for iRadius = [8]
       opt.maskRadiusNb=iRadius;
       if iRadius == 6
           for iFeature =[50]
               opt.mvpa.ratioToKeep = iFeature;
               accuDirSel = calculateMvpaDirSelectivity(opt);
               accuracyFoR = calculateMvpaAcrossHandAnatExt(opt);
               accuCrossModExt = crossModalExtFoR(opt);
               accuCrossModAnat = crossModalAnatFoR(opt);
               accuPropinSubjectSphere = calculateMvpaPropinSubjectSphere(opt);
               accuPropinGlasserMotor = calculateMvpaPropInGlasserMotor(opt);
           end
       elseif iRadius ==7
           for iFeature =[50,75]
               opt.mvpa.ratioToKeep = iFeature; 
               accuDirSel = calculateMvpaDirSelectivity(opt);
               accuracyFoR = calculateMvpaAcrossHandAnatExt(opt);
               accuCrossModExt = crossModalExtFoR(opt);
               accuCrossModAnat = crossModalAnatFoR(opt);
               accuPropinSubjectSphere = calculateMvpaPropinSubjectSphere(opt);
               accuPropinGlasserMotor = calculateMvpaPropInGlasserMotor(opt);
           end   
       elseif iRadius == 8
           for iFeature =[100]
               opt.mvpa.ratioToKeep = iFeature;
               accuDirSel = calculateMvpaDirSelectivity(opt);
               accuracyFoR = calculateMvpaAcrossHandAnatExt(opt);
               accuCrossModExt = crossModalExtFoR(opt);
               accuCrossModAnat = crossModalAnatFoR(opt);
               accuPropinSubjectSphere = calculateMvpaPropinSubjectSphere(opt);
               accuPropinGlasserMotor = calculateMvpaPropInGlasserMotor(opt);
           end

       end
    end
end