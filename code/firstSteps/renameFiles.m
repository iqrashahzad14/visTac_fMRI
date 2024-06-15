clear
% GO TO THE SUBJECT'S FOLDER AND EXECUTE LINE BY LINE

% Get all text files in the current folder
files = dir('*.json');

% Loop through each file 
for iFile = 1:length(files)
    % Get the file name 
    [~, f,ext] = fileparts(files(iFile).name);
    %remove the last 18 characters which include date and time, so put 18
    %filenames in MRI data are like "_date-...."
    f=f(1:end-18);
    %rename the filename with its extension
    rename = strcat(f,ext) ; 
    %save the file
    movefile(files(iFile).name, rename); 
end

% Get all text files in the current folder
files = dir('*.tsv');

% Loop through each file 
for iFile = 1:length(files)
    % Get the file name 
    [~, f,ext] = fileparts(files(iFile).name);
    %remove the last 18 characters which include date and time, so put 18
    %filenames in MRI data are like "_date-...."
    f=f(1:end-18);
    %rename the filename with its extension
    rename = strcat(f,ext) ; 
    %save the file
    movefile(files(iFile).name, rename); 
end