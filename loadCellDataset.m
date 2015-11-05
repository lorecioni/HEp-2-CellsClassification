clear all;

% Load validation set
load(['./' configuration.train_labels]);
load(['./' configuration.test_labels]);

% Compute sizes
trainSetSize = size(trnLabels, 1) - 1;
testSetSize = size(tstLabels, 1) - 1;

% Load training set
trainSet = cell(trainSetSize, 3);
for i = 1:trainSetSize
    filename = [configuration.train_path num2str(i, '%03i') '.png'];
    mask = [configuration.train_path num2str(i, '%03i') '_Mask.png'];
    
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
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'coarse_speckled') == 1
        label = 2;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'fine_speckled') == 1
        label = 3;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'centromere') == 1
        label = 4;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'nucleolar') == 1
        label = 5;
    elseif  strcmp(char(trnLabels(i + 1, 2)), 'cytoplasmatic') == 1
        label = 6;
    end
    
    trainSet{i, 1} = char(filename);       
    trainSet{i, 2} = char(mask);
    trainSet{i, 3} = label;
end

% Load test set 
testSet = cell(testSetSize, 3);
for i = 1:testSetSize
    filename = [configuration.test_path num2str(i, '%03i') '.png'];
    mask = [configuration.test_path num2str(i, '%03i') '_Mask.png'];
    
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
        
    if  strcmp(char(tstLabels(i + 1, 2)), 'homogeneous') == 1
        label = 1;
    elseif  strcmp(char(tstLabels(i + 1, 2)), 'coarse_speckled') == 1
        label = 2;
    elseif  strcmp(char(tstLabels(i + 1, 2)), 'fine_speckled') == 1
        label = 3;
    elseif  strcmp(char(tstLabels(i + 1, 2)), 'centromere') == 1
        label = 4;
    elseif  strcmp(char(tstLabels(i + 1, 2)), 'nucleolar') == 1
        label = 5;
    elseif  strcmp(char(tstLabels(i + 1, 2)), 'cytoplasmatic') == 1
        label = 6;
    end
    
    testSet{i, 1} = char(filename);       
    testSet{i, 2} = char(mask);
    testSet{i, 3} = label;
end

save('./mat/trainSet', 'trainSet');
save('./mat/testSet', 'testSet');

fprintf('Training Set saved correctly!\n\n');
