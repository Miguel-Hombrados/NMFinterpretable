function [mask,template_holiday,label_holiday] = masknontradingdays(Dates)

% There are 10 categories for nontrading days.

N = length(Dates);
mask = zeros(10,N);
template_holiday_aux = cell(N,1);
for index=1:10
    [datesholidayselected,event_name] = selectholiday(index);
     holiday_days = datesholidayselected(:,1);
     
     for index2 = 1:length(holiday_days)
         day = holiday_days(index2,:);
         maski2 = strcmp(Dates,day);
         template_holiday_aux{maski2} = num2str(index);
         mask(index,:) = mask(index,:) +  maski2';
     end
     for s = 1:N
        if isempty(template_holiday_aux{s})
            template_holiday_aux{s} = '0';
        end
     end
     
    
end
weekN = 1:1:53;
template_holiday = cellfun(@(c)['h' c],cellstr(num2str(weekN')),'uni',false)';

label_holiday = cellfun(@(c)['h' c],template_holiday_aux,'uni',false)';
end