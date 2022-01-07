function [Wn] = NormalizeW(W,normP)

Wn = W./vecnorm(W,normP);

end