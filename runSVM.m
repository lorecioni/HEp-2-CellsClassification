function runSVM (K)
    load(['./mat/signaturesFV_K' int2str(K)]);

    % SVM Classifier   
    t = templateSVM('KernelFunction','gaussian');
    model = fitcecoc(signatures', labels, 'Learners', t, 'Prior', 'uniform', 'CrossVal', 'on');
    predictedLabels = kfoldPredict(model);
    
    correctClassifiedCells = sum(strcmp(labels, predictedLabels'))
    accuracy = correctClassifiedCells/configuration.image_number    
    confusionMatrix = confusionmat(labels, predictedLabels')
       
end
    

