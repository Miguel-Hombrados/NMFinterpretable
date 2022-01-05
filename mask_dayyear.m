function [Mask] = mask_dayyear(index_yearday)

N = length(index_yearday);
Mask = zeros(366,N);

for doy=1:366
    Mask(doy,index_yearday==doy) = 1;
end

end