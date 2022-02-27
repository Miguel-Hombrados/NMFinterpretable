function [Mask] = mask_weekyear(index_weekday)


N = length(index_weekday);
Mask = zeros(53,N);

for woy=1:53
    Mask(woy,index_weekday==woy) = 1;
end
end