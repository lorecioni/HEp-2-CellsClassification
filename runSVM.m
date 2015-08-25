clear; clc;
fprintf('-- SVM classifier --\n');
start_time = clock;

K = configuration.K;
load(['./mat/signaturesFV_K' int2str(K)]);

% SVM Classifier   
[msgStr,msgId] = lastwarn;
if (strcmp(msgId, '') ~= 1)
    warnStruct = warning('off',msgId); %Disable warnings for SVM
end

t = templateSVM('KernelFunction','gaussian');
kfolds = 12;
model = fitcecoc(signatures', labels, 'Learners', t, 'Prior', 'uniform', 'CrossVal', 'on', 'KFold', kfolds);

predictedLabels = kfoldPredict(model);

% Result evaluation
[confusionMatrix, classes] = confusionmat(labels, predictedLabels');

classFrequency = sum(confusionMatrix, 2);
classCorrectedPred = diag(confusionMatrix);
classCorrectRate = (classCorrectedPred .* 100) ./ classFrequency;
table(classes, classFrequency, classCorrectedPred, classCorrectRate, ...
    'VariableNames', {'Class', 'Total', 'Correct', 'Rate'})

correctClassifiedCells = sum(classCorrectedPred);
fprintf('Correct classified cells: %d / %d\n', correctClassifiedCells, configuration.image_number);

accuracy = correctClassifiedCells/configuration.image_number;
fprintf('Accuracy: %.2f %%\n', accuracy * 100);

fprintf('Elapsed time: %.2f s\n\n', etime(clock, start_time));
    
