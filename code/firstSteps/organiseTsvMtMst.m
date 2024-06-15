function organiseTsvMtMst
% it is a mini function to 
% to change the trial type
% the originial tsv files have the trial types named "motion"
% we change it to motion_right or motion left depending on the aperture
% position

  deleteSuffix = 1;
  

 % add bids repo
  bidsPath = '/Users/shahzad/GitHubCodes/CPP_BIDS';
  addpath(genpath(fullfile(bidsPath,'src')));
  addpath(genpath(fullfile(bidsPath,'lib')));
  
  % raw data path
  rawDir=fullfile(fileparts(mfilename('fullpath')),'..','..','..','raw');
  
  % define
  subjectNames = { 'sub-014','sub-015','sub-016','sub-017'};
  sessionNames = { 'ses-001'};
  
  % define the task names
  %Since we change the type of trial, we do this for all mtmstLocalizer tasks
  taskNames = { 'mtMstLocalizer'};
  
  for iSubject = 1:length(subjectNames)
      for iSession = 1:length(sessionNames)
          
          % tsv file location
          rawFuncDir = fullfile(rawDir, subjectNames{iSubject}, sessionNames{iSession}, 'func');

          % remove the suffix
          if deleteSuffix
            removeAllDateSuffix(rawDir, subjectNames{iSubject}, sessionNames{iSession});
          end

          % Create output file name
          outputTag = '.tsv';

          for iTask = 1:length(taskNames)

              % create a pattern to look for in the folder
              FilePattern = ['*', taskNames{iTask}, '*_events.tsv'];
              % find all the .tsv files
              tsvFiles = dir(fullfile(rawFuncDir, FilePattern));

              % read, modify and save tsv  in a for loop
              for iFile = 1:length(tsvFiles)

                  tsvFileName = tsvFiles(iFile).name;
                  tsvFileFolder = tsvFiles(iFile).folder;

                  % create output file name
                  outputFileName = strrep(tsvFileName, '.tsv', outputTag);

                  % read the tsv file
                  output = bids.util.tsvread(fullfile(tsvFileFolder,tsvFileName));
                  
                  for i=1:length(output.onset)
                    if strcmp(output.trial_type(i),'response')==0 && output.aperturePosition(i)==7%if the aperture position = 7
                        output.trial_type(i)=strcat(output.trial_type(i), '_right');
                    elseif strcmp(output.trial_type(i),'response')==0 && output.aperturePosition(i)== -7
                        output.trial_type(i)=strcat(output.trial_type(i), '_left');
                    end  
                 end
                  
                  % convert to tsv structure
                  output = convertStruct(output);

                  % save as tsv
                  bids.util.tsvwrite(fullfile(tsvFileFolder,outputFileName), output);

              end

          end
      end
  end

end


function structure = convertStruct(structure)
    % changes the structure
    % from struct.field(i,1) to struct(i,1).field(1)

    fieldsList = fieldnames(structure);
    tmp = struct();

    for iField = 1:numel(fieldsList)
        for i = 1:numel(structure.(fieldsList{iField}))
            tmp(i, 1).(fieldsList{iField}) =  structure.(fieldsList{iField})(i, 1);
        end
    end

    structure = tmp;

end