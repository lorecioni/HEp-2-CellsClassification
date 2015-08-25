function [outCov, isSPD]=Compute_Gabor_Cov_Features(inColorImage,GR,GI, mskBlock, th)
isSPD = 1;
outCov = [];
if sum(mskBlock(:)) / (size(mskBlock,1) * size(mskBlock,2)) < th
    isSPD = 0;
    return;
end
inColorImage = double(inColorImage)/255.0;
inImage = inColorImage(:,:,2) .* mskBlock;
% inImage = rgb2gray(inColorImage);

[SizeX,SizeY]=size(inImage);

covSamples=[];

covSamples=[covSamples;...
    reshape(inImage,[1,SizeX*SizeY])];
% %Color information
% covSamples=[covSamples;...
%             reshape(inColorImage(:,:,1),[1,SizeX*SizeY])];
% covSamples=[covSamples;...
%             reshape(inColorImage(:,:,2),[1,SizeX*SizeY])];
% covSamples=[covSamples;...
%             reshape(inColorImage(:,:,3),[1,SizeX*SizeY])];

[posX,posY] = meshgrid(0:1/SizeX:1-1/SizeX,0:1/SizeY:1-1/SizeY);
covSamples=[covSamples;reshape(posX,[1,SizeX*SizeY])];
covSamples=[covSamples;reshape(posY,[1,SizeX*SizeY])];

covSamples = [covSamples; Apply_Gabor_Transform(inImage,1,GR, GI)'];

%Computing the covariance matrix
outCov=cov(covSamples');
outCov = outCov + eps * eye(size(outCov,1));
temp3 = eig(outCov);
p = find(temp3 <= 0);
if ~isempty(p)%Not SPD
    isSPD = 0;
end

% notSPD = 0;
% tempvec = reshape(outCov, 1, size(outCov,1)*size(outCov,2));
% if ~isempty(find(isnan(tempvec))) || ~isempty(find(isinf(tempvec)))%Not SPD
%     notSPD = 1;
% else
%     temp3 = eig(outCov);
%     p = find(temp3 <= 0);
%     if ~isempty(p)%Not SPD
%         notSPD = 1;
%     end
% end
