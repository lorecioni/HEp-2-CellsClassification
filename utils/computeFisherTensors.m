function g = computeFisherTensors(X , GMModel)
%Compute Fisher Tensors of X with a GMModel

    K = GMModel.NComponents;
    T = size(X,2);
    d = size(X,1);
    g = zeros(K * d,1);
    alfa = 0.5;

    %Self assignment vector
    gamma = posterior(GMModel, X');

    for i=1:K
        Xu = X' - repmat(GMModel.mu(i,:), T, 1) ;
        sig = repmat(GMModel.Sigma(1,:,i).^(-1), T , 1) .* Xu;
        sig = sig .* repmat(gamma(:,i), 1, d);
        S = sum(sig, 1);        
         mF = (1/(T * sqrt(GMModel.PComponents(i))) ) ;
        g((i - 1) * d + 1:i * d) = mF * S;
    end
    
    g = sign(g) .* abs(g).^ alfa;
    %L2 normalization
    g = g /norm(g,2);
end
