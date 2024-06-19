clear all;close all;

% Set the base directory for the images
baseDir = 'data';
processedBaseDir = 'processed';

% Get a list of all subfolders in the base directory
imageFolders = dir(baseDir);

% Initialize an empty array to hold the image file paths
imageFiles = {};

% Loop through each folder in the base directory
for i = 1:length(imageFolders)
    % Skip '.' and '..' directories
    if imageFolders(i).isdir && ~strcmp(imageFolders(i).name, '.') && ~strcmp(imageFolders(i).name, '..')
        % Get the full path of the subfolder
        subFolderPath = fullfile(baseDir, imageFolders(i).name);
        
        % Get a list of all image files in the subfolder
        imageList = dir(fullfile(subFolderPath, '*.*'));
        
        % Filter the files to include only images with specified extensions
        for j = 1:length(imageList)
            [~, ~, ext] = fileparts(imageList(j).name);
            if ismember(lower(ext), {'.jpg', '.jpeg', '.png'})
                % Append the full file path to the imageFiles array
                imageFiles = [imageFiles; fullfile(subFolderPath, imageList(j).name)];
            end
        end
    end
end

% Loop through each image file
parfor k = 1:length(imageFiles)
    % Construct the full file path
    imageName = imageFiles{k};
    
    % Read the image
    image2dehaze = im2double(imread(imageName));
    
    % Process the image to estimate the airlight
    estimatedAirlight = AirlightUsingPatchRecurrence(image2dehaze);
    
    % Construct the save folder path in the processed directory
    [folderPath, name, ~] = fileparts(imageName);
    relativePath = strrep(folderPath, baseDir, ''); % Get the relative path from the base directory
    saveFolder = fullfile(processedBaseDir, relativePath);
    if ~exist(saveFolder, 'dir')
        mkdir(saveFolder);
    end
    
    % Save as text file
    saveFileTxt = fullfile(saveFolder, [name, '_estimatedAirlight.txt']);
    dlmwrite(saveFileTxt, estimatedAirlight, 'delimiter', '\t');
    
    % Save as CSV file
    saveFileCsv = fullfile(saveFolder, [name, '_estimatedAirlight.csv']);
    csvwrite(saveFileCsv, estimatedAirlight);
end

