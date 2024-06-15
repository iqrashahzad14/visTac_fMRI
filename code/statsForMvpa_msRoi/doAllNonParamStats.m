
im='tmap'
decodTitle= 'anat';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
decodingCondition= 'HDPT_HUPT_vs_HDFW_HUFW';

run('nonParametricStats.m')

im='tmap'
decodTitle= 'ext';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
decodingCondition= 'HUPT_HDFW_vs_HDPT_HUFW';
run('nonParametricStats.m')

im='beta'
decodTitle= 'anat';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
decodingCondition= 'HDPT_HUPT_vs_HDFW_HUFW';

run('nonParametricStats.m')

im='beta'
decodTitle= 'ext';% anat='HDPT_HUPT_vs_HDFW_HUFW' ;ext='HUPT_HDFW_vs_HDPT_HUFW'
decodingConditionList = {'HDPT_HUPT_vs_HDFW_HUFW','HUPT_HDFW_vs_HDPT_HUFW'};
decodingCondition= 'HUPT_HDFW_vs_HDPT_HUFW';
run('nonParametricStats.m')



