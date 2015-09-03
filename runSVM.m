clear; clc;
fprintf('-- SVM classifier --\n');
start_time = clock;

K = configuration.K;
load(['./mat/signaturesFV_K' int2str(K)]);

image_number = length(labels);

% Using gaussian kernel
t = templateSVM('KernelFunction','gaussian');

% Fit SVM model. Using matlab function for multiclass training
model = fitcecoc(signatures', labels, 'Learners', t, ...
    'Prior', 'uniform', 'CrossVal', 'on', 'KFold', 10);

% Predict labels on the model
predictedLabels = kfoldPredict(model);

% Generate confusion matrix
[confusionMatrix, classes] = confusionmat(labels, predictedLabels');

confusionMatrix
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
    
