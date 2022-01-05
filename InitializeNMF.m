function [Wini,Hini] = InitializeNMF(X,F,N,K,option,NInit,normW,sigma)
% Description: Function that initializes NMF using ALS or just a random initialization
% Inputs: *F: Number of Features.
%         *N: Number of Samples.
%         *K: Number of latent variables.
%         *NInit: Number of initializations.
%         *option: 'r' or 'als' corresponding to random or Alternating
%                   Least Squares
%         *normW: 'y' or 'n'. It states whether the columns are normalized
%         or not.
% NOTE: This version of the function includes intialiaztion for the bias
% parameters of H.
Errors = zeros(NInit,1);
Wall = zeros(F,K,NInit);
Hall = zeros(K,N,NInit);
for i=1:NInit
    if strcmp(option,'r')
        Wini = sigma*rand(F,K);
        Hini = sigma*rand(K,N);
    end

    if strcmp(option,'als')
        H0 = sigma*rand(K,N);
        Wini = max(eps,(X*H0')*pinv(H0*H0'));
        
        if normW == 'y'
            Wini = NormalizeW(Wini,1);
        end
        
        Hini = max(eps,pinv(Wini'*Wini)*(Wini'*X));
    end
    Errors(i) = norm(X-Wini*Hini,'fro');
    Wall(:,:,i) = Wini;
    Hall(:,:,i) = Hini;   
end
[~,indOpt] = min(Errors);
Wini = Wall(:,:,indOpt);
Hini = Hall(:,:,indOpt);
end