% Analyse behvioural responses 
%
% For all those subjects where they have been recorded, calculate responses
% to the task. 

clear;
clc;

warning('off');

% % add spm to the path
% initiate bidspm

% Initialize report
% Start a new report
report = {'subject','run','trial_type','keyPress','response_type'};

reportExtraPress = {'subject','run','nbTarget','nbKeyPress','nbExtraPress'};

opt.subjects ={'001','002','003','004','005','006','007','008',...
             '009','010','011',...
             '013','014','015','016','017',...
             'pil001','pil002','pil004','pil005'};
         
opt.dir.raw = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');

%% 
for iSub = 1:numel(opt.subjects)

    subName = ['sub-' opt.subjects{iSub}];
    
    taskName = 'mtMstLocalizer';

    % func Dir where the runs are stored
    dataDir = dir(fullfile(opt.dir.raw, subName, 'ses-00*', 'func', [subName '_ses-00*_task-',taskName,'_run-*_events.tsv']));  

    % for each event, lookup 'target' and 'response' events to identify:
    % - correct responses
    % - false positives
    % - misses
    accuMotLeft=[];accuMotRight=[];
    for iRun = 1:numel(dataDir)

        % load events.tsv file
        thisEvent = readtable(fullfile(dataDir(iRun).folder, dataDir(iRun).name), "FileType","text","Delimiter","\t");
        thisEvent.Properties.VariableNames = {'onset', 'duration', 'trial_type','direction',	'speedDegVA','target', 'event', 'block', 'keyName', 'fixationPosition', 'aperturePosition'};
        
        %check if there are key presses in absence of targets
        % call them missed responses
        targetCol = thisEvent{:,6}; 
        nbTarget(iRun) = length(find(targetCol == 1))/2; 
        nbKeyPress(iRun) = sum(isnan(targetCol));
        extraPress(iRun) = nbKeyPress(iRun)-nbTarget(iRun);
        reportExtraPress = vertcat(reportExtraPress, ...
                            {subName, iRun,nbTarget(iRun),nbKeyPress(iRun) extraPress(iRun)'});
                        
        
        for iRow = 1:size(thisEvent,1)-1 %add -1 so that the index does not exceed the last trial
            
            % because matlab tables are tricky to deal with, pre-extract
            % trial_type
            thisTarget = thisEvent{iRow, 'target'}; sameTarget = thisEvent{iRow+1, 'target'};
            
            % check if this and the next trial is a target trial 
            if thisTarget == 1 %&& sameTarget == 1

                % keep the trial_type
                thisTrial = thisEvent{iRow, 'trial_type'};
                
                if strcmp(char(thisTrial),'motion_left')==1  
                % in the next 2 trials, is there a button press? 
                % 5 trials = 2 stimuli: left +1->left 2resp 3right 4right 5resp
                %if iRow+1<=size(thisEvent,1) 
                if strcmp(char(thisEvent{iRow+1, 'trial_type'}),'response')==1 ||...
                        strcmp(char(thisEvent{iRow+2, 'trial_type'}),'response') ==1 
%                         strcmp(char(thisEvent{iRow+4, 'trial_type'}),'response') ==1 || ...
%                         strcmp(char(thisEvent{iRow+5, 'trial_type'}),'response') ==1 
                    thisKey = thisEvent{iRow+1, 'keyName'};
                    thisAccu=1;
                else
                    thisKey = 0;
                    thisAccu=0;  
                end
                %end
                accuMotLeft=[accuMotLeft;thisAccu];
                end
                
                if strcmp(char(thisTrial),'motion_right')==1     
                % in the next 5 trials, is there a button press? 
                % 5 trials = 2 stimuli: left +1->left 2resp 3right 4right 5resp
%                 if iRow+1<=size(thisEvent,1) 
                if strcmp(char(thisEvent{iRow+1, 'trial_type'}),'response')==1 ||...
                        strcmp(char(thisEvent{iRow+2, 'trial_type'}),'response') ==1 
%                         strcmp(char(thisEvent{iRow+4, 'trial_type'}),'response') ==1 || ...
%                         strcmp(char(thisEvent{iRow+5, 'trial_type'}),'response') ==1 
                    thisKey = thisEvent{iRow+1, 'keyName'};
                    thisAccu=1;
                else
                    thisKey = 0;
                    thisAccu=0;  
                end
%                 end
                accuMotRight=[accuMotRight;thisAccu];
                end
                
            end
        end
    end
    subID(iSub,:)=string(subName);
    accuMotLeftSub(iSub,:)=sum(accuMotLeft)/length(accuMotLeft);
    accuMotRightSub(iSub,:)=sum(accuMotRight)/length(accuMotRight);
end

% save report
% writecell(report,'behaviouralReport.txt');

varNames = ["VisMotLeft","VisMotRight"];
mtMstAccu = table(accuMotLeftSub,accuMotRightSub,'VariableNames', varNames);
writetable(mtMstAccu, "mtMstLoc.xlsx")
