load('./mat/Cov_Gabor');
load('./mat/trainSet.mat');

image_number = length(TrainSet.labels);
TrainSet.labels = [];

for i=1:image_number
    TrainSet.labels(i) = cell2mat(trainSet(i, 2));
    
end

save('./mat/Cov_Gabor','TrainSet');