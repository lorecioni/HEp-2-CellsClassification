clear; clc;
addpath('./utils');

fprintf('-- SVM classifier --\n');
start_time = clock;

wdir = pwd;
libsvmpath = [ wdir '/' fullfile('lib', 'libsvm-3.20', 'matlab')];
addpath(libsvmpath)

K = configuration.K;
load(['./mat/signaturesFV_K' int2str(K)]);

image_number = length(labels);

% Fit SVM model. Using matlab function for multiclass training
kFolds = configuration.kFolds;

% Cross validation
iterator = 1; 
bestC = 0;
bestGamma = 0;
bestAccuracy = 0;

for c = 1e-3 %Testing optimal value [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6 1e+0 1e+1 1e+2 1e+3 1e+4 1e+5 1e+6]
    for gamma = [0.8 0.9 1.1 1.5]
    	acc = svmtrain(labels', signatures', sprintf('-q -b 1 -t 2 -g %f -c %f -v %f',gamma, c, kFolds));
        if(acc > bestAccuracy)
        	bestAccuracy = acc;
            bestC = c;
            bestGamma = gamma;
        end
        iterator = iterator + 1;
    end
end

% Train the model and test with optimal values of gamma and C
model = svmtrain(labels', signatures',sprintf('-q -b 1 -t 2 -g %f -c %f', bestGamma, bestC));
predictedLabels = svmpredict(labels',signatures',model, '-b 1');

% Generate and plot confusion matrix
[confusionMatrix, classes] = plotConfusionMatrix(num2classes(labels), num2classes(predictedLabels));

% Evaluate results
classFrequency = sum(confusionMatrix, 2);
classCorrectedPred = diag(confusionMatrix);
classCorrectRate = (classCorrectedPred .* 100) ./ classFrequency;
table(classes, classFrequency, classCorrectedPred, classCorrectRate, ...
    'VariableNames', {'Class', 'Total', 'Correct', 'Rate'})

correctClassifiedCells = sum(classCorrectedPred);
fprintf('Correct classified cells: %d / %d\n', correctClassifiedCells, image_number);

accuracy = correctClassifiedCells/image_number;
fprintf('Accuracy: %.2f %%\n', accuracy * 100);

fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    
