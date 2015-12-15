clear; clc;

K = configuration.K;

fprintf('-- Save Signatures --\n\n');

load(['./mat/GMModel_K' int2str(K)]);
addpath utils;
d = GMModel.NDimensions;

counter = 1;

load('./mat/Cov_Gabor_Train');
load('./mat/Cov_Gabor_Test');
    
trainImages = length(TrainSet.labels);
testImages = length(TestSet.labels);
    
image_number = trainImages + testImages;
   
fprintf('Image processed: 0 / 0.00 %% - Elapsed Time: 0.00 s\n');
start_time = clock;
    
trainSignatures = zeros(K * d , trainImages);
for i=1:trainImages
    tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
    trainSignatures(:,i) = computeFisherTensors(tempM, GMModel);          
    fprintf('Image processed: %d / %.2f %%', counter, ...
            (counter * 100/image_number));
    fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
    counter = counter + 1;
end

trainLabels = TrainSet.labels;
    
testSignatures = zeros(K * d , testImages);
for i=1:testImages
    tempM = TestSet.X(:,1:TestSet.Nblocks(i),i);
    testSignatures(:,i) = computeFisherTensors(tempM, GMModel);          
    fprintf('Image processed: %d / %.2f %%', counter, ...
            (counter * 100/image_number));
    fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
    counter = counter + 1;
end

testLabels = TestSet.labels;

save(['./mat/signaturesFV_K' int2str(K) ],'trainSignatures', ...
        'testSignatures','trainLabels', 'testLabels');