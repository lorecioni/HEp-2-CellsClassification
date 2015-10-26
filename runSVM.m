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

trainSignatures = signatures(:, 1:100);
testSignatures = signatures(:, 101:end);
trainLabels = labels(1:100);
testLabels = labels(101:end);

% SVM training options 
% SVR model for probability and radial basis function kernel
% Setting kFold number for cross validation
kFolds = configuration.kFolds;

% Cross validation
iterator = 1; 
bestC = 0;
bestGamma = 0;
bestAccuracy = 0;

for c = [1e-3 1e-4 1e-5 1e-6 1e+0 1e+1 1e+2 1e+3 1e+4]
    for gamma = [0.8 0.9 1.1 1.5]       
        options = ['-q -b 1 -t 2 -g ' num2str(gamma) ' -c ' num2str(c) ' -v ' num2str(kFolds)];
    	acc = svmtrain(trainLabels', trainSignatures', options);
        if(acc > bestAccuracy)
        	bestAccuracy = acc;
            bestC = c;
            bestGamma = gamma;
        end
        iterator = iterator + 1;
    end
end

fprintf('Cross Validation Best Accuracy: %.2f %%\n', bestAccuracy);
fprintf('Gamma: %.2f\n', bestGamma);
fprintf('C: %.2f\n', bestC);

% Train the model and test with optimal values of gamma and C
options = ['-q -b 1 -t 2 -g ' num2str(bestGamma) ' -c ' num2str(bestC)];
model = svmtrain(trainLabels', trainSignatures', options);


% Evaluate model (on the same dataset)
predictedLabels = svmpredict(testLabels', testSignatures', model, '-b 1');

% Generate and plot confusion matrix
[confusionMatrix, classes] = plotConfusionMatrix(num2classes(testLabels), num2classes(predictedLabels));

% Evaluate results
classFrequency = sum(confusionMatrix, 2);
classCorrectedPred = diag(confusionMatrix);
classCorrectRate = (classCorrectedPred .* 100) ./ classFrequency;
table(classes, classFrequency, classCorrectedPred, classCorrectRate, ...
    'VariableNames', {'Class', 'Total', 'Correct', 'Rate'})

correctClassifiedCells = sum(classCorrectedPred);

imageNumber = sum(confusionMatrix(:));
fprintf('Correct classified cells: %d / %d\n', correctClassifiedCells, imageNumber);

accuracy = correctClassifiedCells/imageNumber;
fprintf('Accuracy: %.2f %%\n', accuracy * 100);

fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    
