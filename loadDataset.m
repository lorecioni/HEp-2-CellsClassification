clear;
addpath 'utils';

% Load validation set from mat
%load(['./' configuration.train_labels]);
%load(['./' configuration.test_labels]);

%Read from csv
trnLabels = readCSV(configuration.train_labels, ';');
trnLabels = trnLabels(:, :);  

% Load training set
if configuration.extract_train
    trainSetSize = size(trnLabels, 1) - 1;
    trainSet = cell(trainSetSize * 3, 3);
    
    counter = 1;
    
    for i = 1:trainSetSize
        for p = 0:3
            filename = [configuration.train_path num2str(i, '%05i') '_p' num2str(p) '.tif'];
            mask = [configuration.train_path num2str(i, '%05i') '_p' num2str(p) '_Mask.tif'];

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

            if  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'homogeneous') == 1
                label = 1;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'speckled') == 1
                label = 2;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'nucleolar') == 1
                label = 3;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'centromere') == 1
                label = 4;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'golgi') == 1
                label = 5;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'numem') == 1
                label = 6;
            elseif  strcmp(strtrim(char(trnLabels(i + 1, 2))), 'mitsp') == 1
                label = 7;
            end

            trainSet{counter, 1} = char(filename);       
            trainSet{counter, 2} = char(mask);
            trainSet{counter, 3} = label;
            counter = counter + 1;
        end
    end
    save('./mat/trainSet', 'trainSet');
    fprintf('Training Set saved correctly!\n\n');
end

% Load test set 
if configuration.extract_test
    testSetSize = size(tstLabels, 1) - 1;
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
    save('./mat/testSet', 'testSet');
    fprintf('Test Set saved correctly!\n\n');
end

