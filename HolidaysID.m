function [datesholidayselected] = selectholiday(index)

    INDICES = containers.Map({1,2,3,4,5,6,7,8,9,10}, { 'New Year or Monday after New Year', 'Martin Luther King,''Jr. Day'
             , 'Washington''s Birthday ','Good Friday (Fri)','Memorial Day ','Independence Day ','Labor Day ','Thanksgiving'
             ,  'Christmas or Monday after Christmas', 'Special metheorological events or other events' });


    Hnames={ 734504 ,'01-Jan-2011', 'Saturday (Sat)',1;
	734520 ,'17-Jan-2011','Martin Luther King,''Jr. Day (Mon)',2;
	734555 ,'21-Feb-2011','Washington''s Birthday (Mon)',3 ;
	734615 ,'22-Apr-2011','Good Friday (Fri)',4;
	734653 ,'30-May-2011','Memorial Day (Mon)',5;
	734688 ,'04-Jul-2011','Independence Day (Mon)',6 ;
	734751 ,'05-Sep-2011','Labor Day (Mon)',7 ;
	734831 ,'24-Nov-2011','Thanksgiving (Thu)',8 ;
	734863 ,'26-Dec-2011','Monday after Christmas (Mon)',9;
	734870 ,'02-Jan-2012','Monday after New Year''s Day (Mon)',1;
	734884 ,'16-Jan-2012','Martin Luther King,''Jr. Day (Mon)',2;
	734919 ,'20-Feb-2012','Washington''s Birthday (Mon)',3;
	734965 ,'06-Apr-2012','Good Friday (Fri)',4;
	735017 ,'28-May-2012','Memorial Day (Mon)',5;
	735054 ,'04-Jul-2012','Independence Day (Wed)',6;
	735115 ,'03-Sep-2012','Labor Day (Mon)',7;
	735171 ,'29-Oct-2012','Hurricane Sandy (Mon)',10;
	735172 ,'30-Oct-2012','Hurricane Sandy (Tue)',10;
	735195 ,'22-Nov-2012','Thanksgiving (Thu)',8;
	735228 ,'25-Dec-2012','Christmas (Tue)',9;
	735235 ,'01-Jan-2013','New Year''s Day (Tue)',1;
	735255 ,'21-Jan-2013','Martin Luther King,''Jr. Day (Mon)',2;
	735283 ,'18-Feb-2013','Washington''s Birthday (Mon)',3;
	735322 ,'29-Mar-2013','Good Friday (Fri)',4;
	735381 ,'27-May-2013','Memorial Day (Mon)',5;
	735419 ,'04-Jul-2013','Independence Day (Thu)',6;
	735479 ,'02-Sep-2013','Labor Day (Mon)',7;
	735566 ,'28-Nov-2013','Thanksgiving (Thu)',8;
	735593 ,'25-Dec-2013','Christmas (Wed)',9;
	735600 ,'01-Jan-2014','New Year''s Day (Wed)',1;
	735619 ,'20-Jan-2014','Martin Luther King,Jr. Day (Mon)',2;
	735647 ,'17-Feb-2014','Washington''s Birthday (Mon)',3;
	735707 ,'18-Apr-2014','Good Friday (Fri)',4;
	735745 ,'26-May-2014','Memorial Day (Mon)',5;
	735784 ,'04-Jul-2014','Independence Day (Fri)',6;
	735843 ,'01-Sep-2014','Labor Day (Mon)',7;
	735930 ,'27-Nov-2014','Thanksgiving (Thu)',8;
	735958 ,'25-Dec-2014','Christmas (Thu)',9;
	735965 ,'01-Jan-2015','New Year''s Day (Thu)',1;
	735983 ,'19-Jan-2015','Martin Luther King,''Jr. Day (Mon)',2;
	736011 ,'16-Feb-2015','Washington''s Birthday (Mon)',3;
	736057 ,'03-Apr-2015','Good Friday (Fri)',4;
	736109 ,'25-May-2015','Memorial Day (Mon)',5;
	736148 ,'03-Jul-2015','Friday before Independence Day (Fri)',6;
	736214 ,'07-Sep-2015','Labor Day (Mon)',7;
	736294 ,'26-Nov-2015','Thanksgiving (Thu)',8;
	736323 ,'25-Dec-2015','Christmas (Fri)',9;
	736330 ,'01-Jan-2016','New Year''s Day (Fri)',1;
	736347 ,'18-Jan-2016','Martin Luther King,''Jr. Day (Mon)',2;
	736375 ,'15-Feb-2016','Washington''s Birthday (Mon)',3;
	736414 ,'25-Mar-2016','Good Friday (Fri)',4;
	736480 ,'30-May-2016','Memorial Day (Mon)',5;
	736515 ,'04-Jul-2016','Independence Day (Mon)',6;
	736578 ,'05-Sep-2016','Labor Day (Mon)',7;
	736658 ,'24-Nov-2016','Thanksgiving (Thu)',8;
	736690 ,'26-Dec-2016','Monday after Christmas (Mon)',9;
	736697 ,'02-Jan-2017','Monday after New Year''s Day (Mon)',1;
	736711 ,'16-Jan-2017','Martin Luther King,''Jr. Day (Mon)',2;
	736746 ,'20-Feb-2017','Washington''s Birthday (Mon)',3;
	736799 ,'14-Apr-2017','Good Friday (Fri)',4;
	736844 ,'29-May-2017','Memorial Day (Mon)',5;
	736880 ,'04-Jul-2017','Independence Day (Tue)',6;
	736942 ,'04-Sep-2017','Labor Day (Mon)',7;
	737022 ,'23-Nov-2017','Thanksgiving (Thu)',8;
	737054 ,'25-Dec-2017','Christmas (Mon)',9;
	737061 ,'01-Jan-2018','New Year''s Day (Mon)',1;
	737075 ,'15-Jan-2018','Martin Luther King,Jr. Day (Mon)',2;
	737110 ,'19-Feb-2018','Washington''s Birthday (Mon)',3;
	737149 ,'30-Mar-2018','Good Friday (Fri)',4;
	737208 ,'28-May-2018','Memorial Day (Mon)',5;
	737245 ,'04-Jul-2018','Independence Day (Wed)',6;
	737306 ,'03-Sep-2018','Labor Day (Mon)',7;
	737386 ,'22-Nov-2018','Thanksgiving (Thu)',8;
    737399 ,'05-Dec-2018','National Day of Mourning for President George H.W. Bush (Wed)',10;
	737419 ,'25-Dec-2018','Christmas (Tue)',9};

    datesholidayselected = Hnames(:,2:3,index);

end