
method = 'NMFmask';  
P =50;
Klatent = 1;
stdnmf =  'y'
EXPERIMENTO = 'interp_1_2';
Ninit = 1;
normW = 'y';
option = 'als';
LOCATIONS = {'ME','NH','VT','CT','RI','SEMASS','WCMASS','NEMASSBOST'};
sigma = 1;   %  For initializations
project_path = 'C:\Users\mahom\Documents\GitHub\NMFinterpretable';
path_save = [project_path '\Results\'];
for l=1:8   

    location = LOCATIONS{l};
    %filename = ['DATA_Train_Val_' location '.mat'];
    filename = ['DATA_Train_Val_11_18_' location '.mat'];
   

    [Load,Temperature,Dew,Dates,WeekDay,DoY] = Load_ISONE_PythonData_full([ project_path '\Data\Exp_interp_1\Preprocessed\' filename]);
    %=========================================
    %=========================================
    [Mask,Template] = CreateSparseMask(Dates,'1');
    %=========================================
    %=========================================
    Load = Load(:,:)';
    Temperature = double(Temperature(:,:)');
    TemperatureNN = Temperature;
    Dew = double(Dew(:,:)');

    %% INITIALIZE PARAMETERS
    F= size(Load,1);
    N= size(Load,2);

    threshold_err = 1e-7;
 
    ParametersNMF = struct('threshold',threshold_err);
    % NMF =================================  
    if strcmpi(method,'NMFmask')
       tic 
       if stdnmf == 'y'
            [Load_std,Stds_train_load] = NormalizationNMF(Load);
            Load_p = Load_std;
   
       if stdnmf == 'n'
            Load_p = Load;    
            TemperatureNN_p = TemperatureNN;
            Stds_train_load = ones(F,1);
       end
       K = size(Mask,1) + Klatent;
       tic
       [Wini,Hini] = InitializeNMF(Load_p,F,N,K,option,Ninit,normW,sigma);
       Hini_mask = Hini.*[Mask; ones(Klatent,N)];
       [Wload_opt,Hload_opt,err,iteration] = NMF(Load_p, Wini,Hini_mask , threshold_err,0,normW);
       timeNMFtrain = toc;
       
       RESULTS.Mask = Mask;
       RESULTS.Template = Template;
       RESULTS.Klatent = Klatent;
       RESULTS.method = method;
       RESULTS.P = num2str(P);
       RESULTS.Ninit = num2str(Ninit);
       RESULTS.normW = normW;
       RESULTS.stdnmf = stdnmf;
       RESULTS.location = location;
       RESULTS.Wload_opt = Wload_opt;
       RESULTS.Hload_opt = Hload_opt; 
       RESULTS.Kopt = K;
       RESULTS.timeNMFtrain = timeNMFtrain;
       RESULTS.initopt = option;
       RESULTS.Loadtrain = Load;
       RESULTS.Description = ['Experiment: ' num2str(EXPERIMENTO) '_Method: ' method '_Threshold: ' num2str(threshold_err) '_NbOfInitializations(P):  ' num2str(P) '_Std:  ' num2str(stdnmf) '_Ninit: ' num2str(Ninit)  '_normW: '  normW  ' init_method: ' option ]
       RESULTS.Loadtrain = Load;
       RESULTS.Mask = [M; ones(Klatent,N)];
       
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
         
        RESULTS.Stds_train_load = Stds_train_load;
       if stdnmf =='y'

            RESULTS.Loadtrain_std = Load_std;
            Ntest = size(Loadtest,2);
            Loadtest_p = Loadtest./repmat(Stds_train_load,1,Ntest);
       else
            Loadtest_p = Loadtest;
       end

        %Wini = sigma*rand(F,Kopt);
        %Hini = sigma*rand(Kopt,Nt);
        RESULTS.Loadtest = Loadtest;
        Ntest= size(Loadtest,2);
        WW = Wload_opt;
        [Wini,Hini] = InitializeNMFtest(Loadtest_p,WW,F,Ntest,K,option,Ninit,normW,sigma)
        ParametersNMF.Wini = Wini;
        ParametersNMF.Hini = Hini;
 
        [~,Hload_test,errlike] = solveNMF(Loadtest_p,K,method,'W',WW,normW,ParametersNMF);
        Errorper_rec_test = 100*mean(vecnorm(repmat(Stds_train_load,1,Ntest).*(Wload_opt*Hload_test)-Loadtest,2)./vecnorm(Loadtest,2));
        RESULTS.Errorper_rec_test= Errorper_rec_test; 
        RESULTS.Hload_test = Hload_test;
        
end
       
  %% SAVE MODELS
      description = ['EXP' num2str(EXPERIMENTO) '_' location '_met' method '_std' stdnmf  '_Thr_' num2str(threshold_err) '_NbOfIni(P)_' num2str(P) '_Ninit_' num2str(Ninit)  '_normW_'  normW '_K_'  num2str(K)];
      file = ['NMF_mask_' description  '.mat'];
      save([project_path '\Data\Exp_interp_1\Exp_' EXPERIMENTO  '\' file ],'RESULTS');
end
end
