clear; clc;

K = configuration.K;

fprintf('-- Save Signatures --\n\n');

load(['./mat/GMModel_K' int2str(K)]);
load('./mat/Cov_Gabor');
addpath utils;

d = GMModel.NDimensions;
    
image_number = configuration.image_number;
signatures = zeros(K * d , image_number);

fprintf('Image processed: 0 / 0.00 %% - Elapsed Time: 0.00 s\n');
start_time = clock;

for i=1:image_number
    tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
    signatures(:,i) = computeFisherTensors(tempM, GMModel);          
    fprintf('Image processed: %d / %.2f %%', i, ...
        (i * 100/image_number));
    fprintf(' - Elapsed time: %.2f s\n', etime(clock, start_time));
end

labels = TrainSet.labels;

save(['./mat/signaturesFV_K' int2str(K) ],'signatures','labels');
