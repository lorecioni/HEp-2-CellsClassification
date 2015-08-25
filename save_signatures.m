clear; clc;
load(['./mat/GMModel_K' int2str(K)]);
load('./mat/Cov_Gabor');

d = GMModel.NDimensions;
    
image_number = configuration.image_number;
signatures = zeros(K * d , image_number);

for i=1:image_number
    tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
    signatures(:,i) = computeMuEff(tempM,GMModel);          
    i
end

    labels = TrainSet.labels;

    save(['./mat/signaturesFV_K' int2str(K) ],'signatures','labels');
end