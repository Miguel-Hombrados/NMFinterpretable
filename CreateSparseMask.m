function [Mask,TemplateMasks] = CreateSparseMask(Dates,option)

%{
Description: Function that creates a mask (binary matrix) of size (K x N)
where K is the number of latent variables selected and N is the number of
training samples. 

Input: * Dates (char array)
Outputs: * Template: cell array with names of the identifier of each latent
           variable.
%}
% 
[IndexHolidays,HolidaysDates] = FindFederalHolidays(Dates); 
[IndexWeekday,WeekdayName] = weekday(datetime(Dates,'Locale','en_US'));
IndexDayYear = day(datetime(Dates),'dayofyear');
YearIndex = year(datetime(Dates))-min(year(datetime(Dates))) +1;
YearName = year(datetime(Dates))';
IndexWeekOfYearIndex = weeknum(datetime(Dates));
%=========================================
[mfy,template_doy] = mask_dayyear(IndexDayYear);
mh = mask_holidays(IndexHolidays);
mw = mask_week(IndexWeekday);
my = mask_year(YearIndex);
[mholiday_ind,template_holiday,labels_holiday] = masknontradingdays(Dates);
wy = mask_weekyear(IndexWeekOfYearIndex);
labels_woy = cellfun(@(c)['w' c],cellstr(num2str(weeknum(datetime(Dates)))),'uni',false);
weeks_y_index = 1:1:53;
template_woy = cellfun(@(c)['w' c],cellstr(num2str(weeks_y_index')),'uni',false)';
M0 = [mfy;mw;my;mholiday_ind;wy];

M1 = [mfy;mw;my;double(IndexHolidays');wy];
M2 = [mw;my;double(IndexHolidays');wy];
M3 = [mfy;mw;my;double(IndexHolidays')];
M4 = [mfy;mw;double(IndexHolidays');wy];
WeekTemplate ={'Sun','Mon','Tue','Wed','Thu','Fri','Sat'};
YearTemplate = {'2011','2012','2013','2014','2015','2016','2017'};

if option == '1'
Template0 = [template_doy,WeekTemplate,YearTemplate,template_holiday,template_woy];
Mask = M1;
TemplateMasks = Template0;
end

end

