function [W,H,err,iteration] = NMFmask(X, Wini, Hini ,Hmask ,threshold,verbose,normW,varargin)
% X = F times N
% W = F times K
% H = K times N
% fixed_flag = Either 'W' or 'H' it allows to fix one of them with the
% inital value, so it will not be optimized. 
x = 1;
err = Inf;
errdif = 1;
Errors = [];
flag_fixedW = 0;
flag_fixedH = 0;
affine = 'n'; % If 'y', the algorithms assumes a DC component that is substracted to reduce invariant solutions.
aini = rand(size(X,1),1);
%while err>threshold && errdif > 1e-3 && x<1e7   
while  errdif > threshold &&  x<5e2
    if x ==1
        H = Hini;
        W = Wini;
        a = aini;
        if length(varargin)>0
            fixed_flag = varargin{1};
            if fixed_flag =='W'
                flag_fixedW = 1;
            end
            if fixed_flag =='H'
                flag_fixedH = 1;
            end
        end
    end   
    if affine == 'y'
       Xp = W*H + a; 
    else
       Xp = W*H;
    end
    
    
    err0 = 100*norm(X-Xp,'fro')/norm(X,'fro');
    
    if flag_fixedW ==0
        W = W.*((X*H')./(W*(H*H')));
        if strcmp(normW,'y')
            [W] = NormalizeW(W,1);
        end
    end
    
    if flag_fixedH ==0
        H = H.*((W'*X)./(W'*W*H));
        H = H.*Hmask;
    end
    
    if affine == 'y'
       Xp = W*H + a; 
    else
       Xp = W*H;
    end
    
    err = 100*norm(X-Xp,'fro')/norm(X,'fro');
    if x>1
        errdif = abs(errp - err);
        errp = err;
    else
        errp = err;
    end
    Errors = [Errors err];
    if isnan(err)
       disp('Nan'); 
    end
        
    if mod(x,1)==0
        disp(['Iteration: ' num2str(x) '===>  Error: ' num2str(err) ' errdif: ' num2str(errdif)])
    end
    
    if verbose ==1
        figure(1000)
        plot(x,err,'*b');
        grid on
        hold on
        drawnow
    end
    
    x = x+1;
end
iteration = x;

end