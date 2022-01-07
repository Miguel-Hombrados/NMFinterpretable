function [Mask] = mask_year(index_year)

N = length(index_year);
Y = max(index_year);
Mask = zeros(Y,N);

for y=1:Y
    Mask(y,index_year==y) = 1;
end

end