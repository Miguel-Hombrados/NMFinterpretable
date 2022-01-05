function [Mask] = mask_week(index_weekday)

N = length(index_weekday);
Mask = zeros(7,N);

for dow=1:7
    Mask(dow,index_weekday==dow) = 1;
end

end