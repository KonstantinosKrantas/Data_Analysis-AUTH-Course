% Krantas Konstantinos, Liotopoulos Kosmas

function [I,p,final_length] = Group38Exe5Fun1(X,Y)

    % length(X) = length(Y)
 
    NaN_indexes = [];
    counter = 1;
    
    for i = 1:length(X)
    
        if isnan(X(i)) || isnan(Y(i))
            NaN_indexes(counter) = i;    %find indexes of X or Y with NaN values
            counter = counter+1;
        end
        
    end
    
    %remove NaN values
    X(NaN_indexes) = [];    
    Y(NaN_indexes) = [];

    final_length = length(X);   %return the length of vectors without NaNs

    X_discrete = [];   
    Y_discrete = [];

    % discretize continuous values according to the median rule
    for i = 1:length(X)

        if X(i) <= median(X)    
            X_discrete(i) = 0;
        else
            X_discrete(i) = 1;
        end

        if Y(i) <= median(Y)
            Y_discrete(i) = 0;
        else
            Y_discrete(i) = 1;
        end

    end

    X_discrete;   
    Y_discrete;

    f_x = [1-sum(X_discrete)/length(X_discrete), sum(X_discrete)/length(X_discrete)];

    H_x = -sum(f_x.*log(f_x)/log(2));

    f_y = [1-sum(Y_discrete)/length(Y_discrete), sum(Y_discrete)/length(Y_discrete)];

    H_y = -sum(f_y.*log(f_y)/log(2));

    f_x_y = [];

    counter1 = 0;
    counter2 = 0;
    counter3 = 0;
    counter4 = 0;

    % calculate the joint pdf
    for i = 1:length(X_discrete)

        if X_discrete(i) == 0 && Y_discrete(i) == 0
            counter1 = counter1+1;
        end

        if X_discrete(i) == 0 && Y_discrete(i) == 1
            counter2 = counter2+1;
        end

        if X_discrete(i) == 1 && Y_discrete(i) == 0
            counter3 = counter3+1;
        end

        if X_discrete(i) == 1 && Y_discrete(i) == 1
            counter4 = counter4+1;
        end

    end

    f_x_y(1) = counter1/length(X_discrete);
    f_x_y(2) = counter2/length(X_discrete);
    f_x_y(3) = counter3/length(X_discrete);
    f_x_y(4) = counter4/length(X_discrete);

    f_x_y = f_x_y(f_x_y~=0);   % if a value in f_x_y is 0, don't take it into consideration for H_x_y (lim x-->0 x*logx = 0, but 0*log0=NaN)

    H_x_y = -sum(f_x_y.*log(f_x_y)/log(2));

    I = H_x + H_y - H_x_y;   %Mutual Information


    %randomization check
    R = [];
    R(:,1) = X;
    R(:,2) = Y;

    s = cov(R);  %matrix of covariance

    r = corr2(X,Y);

    t0 = r*sqrt((final_length-2)/(1-r^2));

    L = 10000;   %number of randomized samples

    t = [];   % values of t-statistic for the L randomized samples

    for i=1:L

        X_L = X(randperm(final_length));    % the i-th randomized sample

        s = cov(X_L,Y); %matrix of covariance
    
        r = s(1,2)/sqrt(s(1,1)*s(2,2));
    
        t(i) = r*sqrt((final_length-2)/(1-r^2));
    end
    
    t(L+1) = t0;   %add the initial t-statistic in order to find the p-value

    t_sorted = sort(t);
    
    for r = 1:L+1
        if t_sorted(r) == t0
            p = 2*min(r/(L+1), 1-r/(L+1));
        end
    end



end

