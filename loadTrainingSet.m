 function loadTrainingSet ()
%Load training set labels from CSV file and generate a mat file

    import configuration.*;
    addpath('./utils');
             
    %Read validation set
    validation_set = readCSV(configuration.validation_file, ';');
    validation_set = validation_set(2:end, 5);
    
    trainSet = cell(length(validation_set), 2);
    for i = 1:length(validation_set)
        trainSet{i, 1} = i;
        trainSet{i, 2} = char(validation_set(i));
    end

    save('./mat/trainSet', 'trainSet');
end