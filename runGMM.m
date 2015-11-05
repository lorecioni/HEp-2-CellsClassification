clear; clc;
fprintf('-- Gaussian Mixtures Model fitting --\n\n');

if configuration.full_images
    load('./mat/Cov_Gabor');
elseif configuration.cell_images
    load('./mat/Cov_Gabor_Train');
end

start_time = clock;

K = configuration.K;

vectors  = [];

for i=1:size(TrainSet.X,3)
    tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
	randN = randperm(TrainSet.Nblocks(i), 20);
	tempM = tempM(:,randN);
	vectors = cat(2 , vectors, tempM);  
end
vectors = vectors(:, randperm(size(vectors, 2)));

covType = 'diagonal'; 
options = statset('Display', 'final','MaxIter', 500, 'TolFun', 1e-6);

GMModel = gmdistribution.fit(vectors', K, 'Regularize', eps, 'Options', options, 'Replicates', 1, 'CovType', covType);    
                
save(['./mat/GMModel_K' int2str(K)], 'GMModel'); 

fprintf('\nElapsed time: %.2f s\n', etime(clock, start_time));
