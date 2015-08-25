function save_signatures (K)
    load(['./mat/obj_K' int2str(K)]);
    d = obj.NDimensions;
    
     load('./mat/Cell_Gabor_B20');
     Number_Train_Samples = length(TrainSet.labels);
     signatures = zeros(K*d , Number_Train_Samples);

     for i=1:Number_Train_Samples
         tempM = TrainSet.X(:,1:TrainSet.Nblocks(i),i);
         signatures(:,i) = computeMuEff(tempM,obj);          
        i
     end

    labels = TrainSet.labels;

    save(['./mat/signaturesFV_K' int2str(K) ],'signatures','labels');
end