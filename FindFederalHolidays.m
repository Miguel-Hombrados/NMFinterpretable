function [Index,Holidays]=  FindFederalHolidays(Dates)
% Description: Function that takes an array of dates (array of chars) and 
%               generates a vector of 0s and 1s, each value for each day.
%               It will assign a "1" if the day is a federal holiday.

H = holidays(datetime(Dates(1,:),'Locale','en_US'),datetime(Dates(end,:),'Locale','en_US'));
Holidays = datestr(H);
Index = ismember(Dates,Holidays,'rows');


end