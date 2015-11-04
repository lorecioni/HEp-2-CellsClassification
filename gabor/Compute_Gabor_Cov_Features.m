function [outCov, isSPD] = Compute_Gabor_Cov_Features(img, GR, GI, mskBlock, th)
    isSPD = 1;
    outCov = [];
    if sum(mskBlock(:)) / (size(mskBlock, 1) * size(mskBlock, 2)) < th
        isSPD = 0;
        return;
    end
    
    %Image normalization
    img = double(img)/255.0;
    
    %Considering only foreground pixels
    img = img .* mskBlock;
    
    [SizeX, SizeY] = size(img);

    covSamples = [];

    covSamples = [covSamples; reshape(img,[1, SizeX * SizeY])];

    [posX,posY] = meshgrid(0:1/SizeX:1-1/SizeX,0:1/SizeY:1-1/SizeY);
    covSamples = [covSamples;reshape(posX,[1, SizeX * SizeY])];
    covSamples = [covSamples;reshape(posY,[1, SizeX * SizeY])];

    covSamples = [covSamples; Apply_Gabor_Transform(img, 1, GR, GI)'];    
    
    %TOPHAT
    %for diskSize = [10 20]
    %   st = strel('disk', diskSize);
    %   imgTmp = imtophat(img, st);
    %   covSamples = [covSamples; Apply_Gabor_Transform(imgTmp, 1, GR, GI)'];
    %end    

    %Computing the covariance matrix
    outCov = cov(covSamples');
    outCov = outCov + eps * eye(size(outCov,1));
    temp3 = eig(outCov);
    if ~isempty(find(temp3 <= 0, 1)) %Not SPD
        isSPD = 0;
    else 
        outCov = map2IDS_vectorize(outCov);       
    end
    
end


function y = map2IDS_vectorize(input)
    input = logm(input);    
    offDiagonals = tril(input, -1) * sqrt(2);
    diagonals = diag(diag(input));
    vecInMat = diagonals + offDiagonals; 
    vecInds = tril(ones(size(input)));
    map2ITS = vecInMat(:);
    vecInds = vecInds(:);
    y = map2ITS(vecInds == 1);
end