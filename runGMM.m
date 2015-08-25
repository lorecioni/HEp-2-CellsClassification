clear; clc;
load('./mat/Cov_Gabor');

K = configuration.K;

vectors  = [];

for i=1:size(TrainSet.X,3)
    tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
	randN = randperm(TrainSet.Nblocks(i), 20);
	tempM = tempM(:,randN);
	vectors = cat(2 , vectors, tempM);  
end
vectors = vectors(:,randperm(size(vectors,2)));

covType = 'diagonal'; 
options = statset('Display', 'final','MaxIter', 500, 'TolFun', 1e-6);

GMModel = fitgmdist(vectors', K, 'Regularize', eps, 'Options', options, ...
                    'CovarianceType', covType, 'Replicates', 1);

save(['./mat/GMModel_K' int2str(K)], 'GMModel'); 
