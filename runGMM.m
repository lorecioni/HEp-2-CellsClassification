function runGMM(K)
    load('./mat/Cell_Gabor_B20');
    ind_matrices = 1;
    vectors  = [];
    for i=1:size(TrainSet.X,3)
        tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
        randN = randperm(TrainSet.Nblocks(i), 20);
        tempM = tempM(:,randN);
        vectors = cat(2 , vectors, tempM);  
    end
    vectors = vectors(:,randperm(size(vectors,2)));

    options = statset('Display','final','MaxIter', 500,'TolFun',1e-6);
    replicates = 1;
    covType = 'diagonal'; 
    obj = gmdistribution.fit(vectors', K, 'Regularize', eps, 'Options', options, 'Replicates', replicates, 'CovType', covType);    
    save(['./mat/obj_K' int2str(K)], 'obj'); 
end
