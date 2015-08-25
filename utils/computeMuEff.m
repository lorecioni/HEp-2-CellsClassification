function g = computeMuEff(X , obj)
    K = obj.NComponents;
    T = size(X,2);
    d = size(X,1);
    g = zeros(K*d,1);
    alfa = 0.5;

    gamma = posterior(obj, X');

    for i=1:K
        XMMu = X' - repmat(obj.mu(i,:), T, 1) ;
        SigMXMMu = repmat(obj.Sigma(1,:,i).^(-1), T , 1) .* XMMu;
        SigMXMMu = SigMXMMu .* repmat(gamma(:,i), 1, d);
        S = sum(SigMXMMu,1);        
         mF = (1/(T*sqrt(obj.PComponents(i))) ) ;
        g((i-1)*d+1:i*d) = mF * S;
    end
    g = sign(g) .* abs(g).^ alfa;
    %L2 normalization
    g = g /norm(g,2);
end
