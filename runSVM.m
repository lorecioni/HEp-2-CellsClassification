clear; clc;
addpath('./utils');

fprintf('-- SVM classifier --\n');
start_time = clock;

% Using libsvm
wdir = pwd;
libsvmpath = [ wdir '/' fullfile('lib', 'libsvm-3.20', 'matlab')];
addpath(libsvmpath)

K = configuration.K;
load(['./mat/signaturesFV_K' int2str(K)]);

% SVM training options (radial basis kernel)
% Setting kFold number for cross validation
kFolds = configuration.kFolds;

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
    
    if configuration.full_images
        datasetSignatures = signatures;
        datasetLabels = labels;
        clear signatures;
        clear labels;
    else
        datasetSignatures = cat(2, trainSignatures, testSignatures);
        datasetLabels = cat(2, trainLabels, testLabels);
    end

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
    showResults(datasetLabels, predictedLabels, configuration.showConfusionMatrix);
      
else
    % Evaluate model on test set
    
    if configuration.full_images
        %If considering full images split dataset in train and test
        trainSignatures = signatures(:, 1:100);
        testSignatures = signatures(:, 101:end);
        trainLabels = labels(1:100);
        testLabels = labels(101:end);
    end
    
    % Train the model and test
    options = ['-q -b 1 -t 2 -g ' num2str(SVM_gamma) ' -c ' num2str(SVM_c)];
    model = svmtrain(trainLabels', trainSignatures', options);

    % Evaluate model (on test)
    predictedLabels = svmpredict(testLabels', testSignatures', model, '-b 1');
    
    showResults(testLabels, predictedLabels, configuration.showConfusionMatrix);
end

fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    
