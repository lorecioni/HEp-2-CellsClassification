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

    covSamples = [covSamples; reshape(img,[1,SizeX * SizeY])];

    [posX,posY] = meshgrid(0:1/SizeX:1-1/SizeX,0:1/SizeY:1-1/SizeY);
    covSamples = [covSamples;reshape(posX,[1, SizeX * SizeY])];
    covSamples = [covSamples;reshape(posY,[1, SizeX * SizeY])];

    covSamples = [covSamples; Apply_Gabor_Transform(img, 1, GR, GI)'];

    %Computing the covariance matrix
    outCov = cov(covSamples');
    outCov = outCov + eps * eye(size(outCov,1));
    temp3 = eig(outCov);
    p = find(temp3 <= 0);
    if ~isempty(p) %Not SPD
        isSPD = 0;
    end
end