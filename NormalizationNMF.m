
function [Xnorm,Stds_train] = NormalizationNMF(X)
%{
Description: It normalized the data by dividing each feature by its
variance.


Input: X (Features x Samples)
Output: Xnorm (Features x Samples)
%}
N = size(X,2);
Stds_train = std(X,1,2);
Xnorm = X./repmat(Stds_train,1,N);

end