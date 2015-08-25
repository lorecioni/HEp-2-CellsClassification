function y = map2IDS_vectorize(input)
    input = logm(input);    
    offDiagonals = tril(input,-1) * sqrt(2);
    diagonals = diag(diag(input));
    vecInMat = diagonals + offDiagonals; 
    vecInds = tril(ones(size(input)));
    map2ITS = vecInMat(:);
    vecInds = vecInds(:);
    y = map2ITS(vecInds == 1) ;
end