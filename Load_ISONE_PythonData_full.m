function [Load,Temperature,Dew,Dates,WeekDay,DoY] =ReadPythonfileISONE_PythonData_full(filename)

data = load(filename);



Load = data.Load;
Temperature = data.Temperature;
Dew = data.DewPoint;

Dates =  data.Date;

DoY = data.DayOfYear;


WeekDay = data.Weekday;






end