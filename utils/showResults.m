function showResults(trueLabels, predictedLabels, plot)
%Show classification results
    
    [confusionMatrix, classes] = plotConfusionMatrix(num2classes(trueLabels), ...
        num2classes(predictedLabels), plot);
    
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
    
end

