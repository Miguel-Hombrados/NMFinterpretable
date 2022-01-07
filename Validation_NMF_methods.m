
method = 'NMF';  
P =50;
Klatent = 1;
stdnmf =  'y'
EXPERIMENTO = 'interp_1';
Ninit = 1;
normW = 'y';
LOCATIONS = {'ME','NH','VT','CT','RI','SEMASS','WCMASS','NEMASSBOST'};
sigma = 1;   %  For initializations
project_path = 'C:\Users\mahom\Documents\GitHub\NMFinterpretable';
path_save = [project_path '\Results\'];
for l=1:8   

    location = LOCATIONS{l};
    %filename = ['DATA_Train_Val_' location '.mat'];
    filename = ['DATA_Train_Val_' location '.mat'];
   

    [Load,Temperature,Dew,Dates,WeekDay,DoY] = Load_ISONE_PythonData_full([ project_path '\Data\Preprocessed\' filename]);
    %=========================================
    %=========================================
    [IndexHolidays,HolidaysDates] = FindFederalHolidays(Dates);
    IndexWeekday = weekday(datetime(Dates,'Locale','en_US'));
    IndexDayYear = day(datetime(Dates),'dayofyear');
    YearIndex = year(datetime(Dates))-min(year(datetime(Dates))) +1;
    %=========================================
    mfy = mask_dayyear(IndexDayYear);
    mh = mask_holidays(IndexHolidays);
    mw = mask_week(IndexWeekday);
    my = mask_year(YearIndex);
    M = [mfy;mw;my];
    %=========================================
    %=========================================
    Load = Load(:,:)';
    Temperature = double(Temperature(:,:)');
    TemperatureNN = Temperature;
    Dew = double(Dew(:,:)');

    %% INITIALIZE PARAMETERS
    F= size(Load,1);
    N= size(Load,2);

    threshold_err = 1e-4;
 
    ParametersNMF = struct('threshold',threshold_err);
    % NMF =================================  
    if strcmpi(method,'NMF')
        

       %[IndexH,Holidays] = FindFederalHolidays(Dates);
       %[WEEKDAY_num,WEEKDAY_name] = weekday(Dates);
       %WEEKEND_OR_NOT = isweekend(datetime(Dates));
       %[~,~,indexYear] = unique(year(Dates)); 
       % Load  = [Load;IndexH';double(DoY);WEEKEND_OR_NOT';WEEKDAY_num'];

       tic 
       if stdnmf == 'y'
            [Load_std,Stds_train_load] = NormalizationNMF(Load);
            Load_p = Load_std;
            
            %[TemperatureNN_std,Stds_train_TemperatureNN] = NormalizationNMF(TemperatureNN);
            %TemperatureNN_p = TemperatureNN_std;           
       else
            Load_p = Load;    
            TemperatureNN_p = TemperatureNN;
       end
       K = size(M,1) + Klatent;
       [Wini,Hini] = InitializeNMF(Load_p,F,N,K,'als',Ninit,normW,sigma);
       Hini = Hini.*[M; ones(Klatent,N)];
       [Wload_opt,Hload_opt,err,iteration] = NMF(Load_p, Wini, Hini , 1e-5,0,normW);

       RESULTS.Wload_opt = Wload_opt;
       RESULTS.Hload_opt = Hload_opt; 
       RESULTS.Kopt = Kopt;
       
       RESULTS.ValidationLoad = ValidationLoad;
       RESULTS.timeNMF = timeNMF;
       RESULTS.Loadtrain = Load;
       RESULTS.Description = ['Method: ' method '_Threshold: ' num2str(threshold_err) '_NbOfInitializations:  ' num2str(P) '_Std:  ' num2str(stdnmf) '_Ninit: ' num2str(Ninit)]
       
       % Test =============================================
        filenamet = ['DATA_Test_' location '.mat'];
        datat = load([ project_path '\Data\Preprocessed\' filenamet]);
        Loadtest = datat.Load';
        Temperaturet = datat.Temperature';
        Dewt = datat.DewPoint';
        
        Datest =  datat.Date;
        DoYt = datat.DayOfYear;
        WeekDayt = datat.Weekday;
        F = 24;
        Nt= size(Loadtest,2);
         
       if stdnmf =='y'
            RESULTS.Stds_train_load = Stds_train_load;
            RESULTS.Loadtrain_std = Load_std;
            Ntest = size(Loadtest,2);
            Loadtest_p = Loadtest./repmat(Stds_train_load,1,Ntest);
       else
            Loadtest_p = Loadtest;
       end

        %Wini = sigma*rand(F,Kopt);
        %Hini = sigma*rand(Kopt,Nt);
        option = 'als';
        [Wini,Hini] = InitializeNMF(Loadtest_p,F,Nt,Kopt,option,Ninit,normW);
        ParametersNMF.Wini = Wini;
        ParametersNMF.Hini = Hini;
        %WW = Wload_opt(:,1:end-1);
        WW = Wload_opt;
        [~,Hload_test,errlike] = solveNMF(Loadtest_p,Kopt,method,'W',WW,normW,ParametersNMF);
         %[Wopt,Hopt,errlike] = solveNMFbias(X,Kopt,method,'No',0,Parameters);
         RESULTS.Hload_test = Hload_test;
        
end
       
     %% SAVE MODELS
      file = ['Validation_' location '_' method '_std_' stdnmf '_EXP_' EXPERIMENTO  '.mat'];
      save([project_path '\Data\Exp_' EXPERIMENTO  '\' method '\' file ],'RESULTS');
    %[~,INDEX] = max(Hloadini);
    %[h100,h200,h300] = PlotHistogramsClusters3(Hload,Dates);

    
%      name_week = 'Hist_week_';
%      name_month = 'Hist_month_';
%      saveas(h200,[path_save name_week location '_' method '_k' num2str(K) '.png'])
%      saveas(h100,[path_save name_month location '_' method '_k' num2str(K) '.png'])

end

