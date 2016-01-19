clear;
addpath utils;

% Load validation set
trnLabels = readCSV(configuration.train_labels, ',');

% Compute sizes
trainSetSize = size(trnLabels, 1) - 1;

% Load training set
trainSet = cell(trainSetSize, 3);
for i = 1:trainSetSize
    filename = [configuration.train_path num2str(i, '%05i') '.png'];
    mask = [configuration.train_path num2str(i, '%05i') '_Mask.png'];
    
    if(exist(char(filename), 'file') ~= 2 ...
        || exist(char(mask), 'file') ~= 2)
           warning('Image %s not found. Will not be processed.\n', char(filename));
    end
    
    if(ischar(filename))
        filename = cellstr(filename);
    end
    
    if(ischar(mask))
        mask = cellstr(mask);
    end
        
    if  strcmp(char(trnLabels(i + 1, 2)), 'homogeneous') == 1
        label = 1;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'speckled') == 1
        label = 2;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'nucleolar') == 1
        label = 3;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'centromere') == 1
        label = 4;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'numem') == 1
        label = 5;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'golgi') == 1
        label = 6;
    end
    
    trainSet{i, 1} = char(filename);       
    trainSet{i, 2} = char(mask);
    trainSet{i, 3} = label;
end

save('./mat/trainSet', 'trainSet');

fprintf('Training Set saved correctly!\n\n');