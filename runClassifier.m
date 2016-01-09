clear; clc;
addpath('./utils');
K = configuration.K;
show_plot = configuration.showConfusionMatrix;

load(['./mat/signaturesFV_K' int2str(K)]);

% Setting kFold number for cross validation
kFolds = configuration.kFolds;

%% Nearest Neighbour Classifier%%

if configuration.use_NN_classifier
    
    fprintf('-- Nearest Neighbour Classifier --\n');
    start_time = clock;
    if configuration.crossvalidate  
        
        datasetSignatures = cat(2, trainSignatures, testSignatures);
        datasetLabels = cat(2, trainLabels, testLabels);

        predictedLabels = zeros(size(datasetSignatures, 2), 1);

        % Split dataset into k folds
        splits = cvpartition(1:size(datasetSignatures, 2), 'kFold', kFolds);

        for k = 1:kFolds
            trnIndex = training(splits, k);
            tstIndex = test(splits, k);

            trnSet = datasetSignatures(:, trnIndex)';
            trnLbl = datasetLabels(trnIndex)';
            tstSet = datasetSignatures(:, tstIndex)';
            tstLbl = datasetLabels(tstIndex)';

            dist = pdist2(tstSet, trnSet);
            [~, id] = min(dist, [], 2);
            predictedLabels(tstIndex) = datasetLabels(id)';
        end

        showResults(datasetLabels', predictedLabels, show_plot, 'NN Classification');
        fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    else
        %Evaluate on test set
        dist = pdist2(testSignatures', trainSignatures');
        [~, id] = min(dist, [], 2);
        predictedLabels = trainLabels(id)';
        showResults(testLabels', predictedLabels, show_plot, 'NN Classification');
        fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    end
end

%% SVM Classifier %%

if configuration.use_SVM_classifier
    fprintf('-- SVM Classifier --\n');

    start_time = clock;
    % Using libsvm
    wdir = pwd;
    libsvmpath = [ wdir '/' fullfile('lib', 'libsvm-3.20', 'matlab')];
    addpath(libsvmpath)
    
    % SVM training options (radial basis kernel)
    % Cross validation parameters
    bestAccuracy = 0;
    SVM_c = 1e-3;
    SVM_gamma = 0.8;

    %%% CrossValidate SVM parameters
    if configuration.crossvalidate_SVM_parameters
        for c = [1e-4 1e-5 1e-6 1e+0 1e+1 1e+2 1e+3 1e+4]
            for gamma = [0.9 1.1 1.5]         
                options = ['-q -b 1 -t 2 -g ' num2str(gamma) ' -c ' num2str(c) ...
                    ' -v ' num2str(kFolds)];
                acc = svmtrain(trainLabels', trainSignatures', options);
                if(acc > bestAccuracy)
                    bestAccuracy = acc;
                    SVM_c = c;
                    SVM_gamma = gamma;
                end
            end
        end

        % Display parameters
        fprintf('SVM Gamma: %.2f\n', SVM_gamma);
        fprintf('SVM C: %.2f\n', SVM_c);
    end


    %%% SVM crossvalidation
    if configuration.crossvalidate  

        datasetSignatures = cat(2, trainSignatures, testSignatures);
        datasetLabels = cat(2, trainLabels, testLabels);
        
        predictedLabels = zeros(size(datasetSignatures, 2), 1);
        accuracies = zeros(kFolds, 1);

        % Split dataset into k folds
        splits = cvpartition(1:size(datasetSignatures, 2), 'kFold', kFolds);

        for k = 1:kFolds
           trnIndex = training(splits, k);
           tstIndex = test(splits, k);

           trnSet = datasetSignatures(:, trnIndex)';
           trnLbl = datasetLabels(trnIndex)';
           tstSet = datasetSignatures(:, tstIndex)';
           tstLbl = datasetLabels(tstIndex)';

           options = ['-q -b 1 -t 2 -g ' num2str(SVM_gamma) ' -c ' num2str(SVM_c)];
           models{k} = svmtrain(trnLbl, trnSet, options);
           [l, a, ~] = svmpredict(tstLbl, tstSet, models{k}, '-b 1');
           accuracies(k) = a(1);
           predictedLabels(tstIndex) = l;
        end

        fprintf('Cross Validation Accuracy: %.2f %%\n', mean(accuracies));

        % Show classification result
        showResults(datasetLabels, predictedLabels, show_plot, 'SVM Classification');

    else
        % Evaluate model on test set
        % Train the model and test
        options = ['-q -b 1 -t 2 -g ' num2str(SVM_gamma) ' -c ' num2str(SVM_c)];
        model = svmtrain(trainLabels', trainSignatures', options);

        % Evaluate model (on test)
        predictedLabels = svmpredict(testLabels', testSignatures', model, '-b 1');

        showResults(testLabels, predictedLabels, show_plot, 'SVM Classification');
    end

    fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
end  
