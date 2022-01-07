function [Mask] = mask_holidays(index_holidays)

N = length(index_holidays);
H = max(index_holidays);
Mask = zeros(H,N);

for hd=1:N
    Mask(hd,index_holidays==hd) = 1;
end

end