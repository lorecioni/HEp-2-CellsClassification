 function loadTrainingSet ()
%Load training set labels from CSV file and generate a mat file

    import configuration.*;
    addpath('./utils');
             
    %Read validation set
    validation_set = readCSV(configuration.validation_file, ';');
    validation_labels = validation_set(2:end, 5);
    image_ids = validation_set(2:end, 3);
    
    filenames = cell(length(validation_labels), 1);
    
    trainSet = cell(length(validation_labels), 2);
    for i = 1:length(validation_labels)     
        filename = strcat(configuration.image_path, configuration.image_prefix, ...
        image_ids(i), '.', configuration.image_ext);
        filenames(i) = filename;
        
        trainSet{i, 1} = cell2mat(image_ids(i));
        trainSet{i, 2} = char(validation_labels(i));
        trainSet{i, 3} = char(filename);   
    end

    table(image_ids, validation_labels, filenames, ...
    'VariableNames', {'ID', 'Label', 'Filename'})

    save('./mat/trainSet', 'trainSet');
    
    fprintf('Training Set saved correctly!\n\n');
end