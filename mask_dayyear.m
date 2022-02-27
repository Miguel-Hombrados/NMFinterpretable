function [Mask] = mask_dayyear(index_yearday)

% N = length(index_yearday);
% Mask = zeros(366,N);
% 
% for doy=1:366
%     Mask(doy,index_yearday==doy) = 1;
% end

N = length(index_yearday);
Mask = zeros(365,N);

for doy=1:366
    if doy ~=366
    Mask(doy,index_yearday==doy) = 1;
    end
    if doy ==355
    Mask(365,index_yearday==doy)  = 1 ; 
    end
end
% This is done due to the lack of leap days. The day 366 is considered the
% 355th day.

end