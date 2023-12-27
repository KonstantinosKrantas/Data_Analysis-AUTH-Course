% Krantas Konstantinos, Liotopoulos Kosmas

function [p_param,p_bootstrap] = Group38Exe3Fun1(years, indicator)

    pivot_point = -1;
    
    for i = 1:length(years)-1
        if years(i+1) ~= years(i) + 1
            pivot_point = i+1;
        end
    end

    if pivot_point == -1
        fprintf("ERROR. POINT OF DISCONTINUITY NOT FOUND")
        p_param = NaN;
        p_bootstrap = NaN;
        return
    end
    
    X1 = indicator(1:pivot_point-1);

    X2 = indicator(pivot_point:length(indicator));

    X1 = X1';
    X1 = X1(~isnan(X1))';        %removing NaN values

    X2 = X2';
    X2 = X2(~isnan(X2))';        %removing NaN values

    if length(X1) == 0 || length(X2) == 0     %case that there is not any data for X1 or X2
        p_param = NaN;
        p_bootstrap = NaN;
        return
    end

    [~,p_param,~] = ttest2(X1,X2);       %parametric check


    %bootstrap check, me epanathesh
    w = [X1 ; X2];

    B = 10000;    %number of bootstrap samples

    theta_hat_bootstrap = [];

    for i = 1:B
        bootstrap_sample = [];

        for j = 1:length(w)
            bootstrap_sample(j) = w(randi([1,length(w)]));
        end

        theta_hat = mean(bootstrap_sample(1:length(X1))) - mean(bootstrap_sample(length(X1)+1:length(w)));
        theta_hat_bootstrap(i) = theta_hat;
    end    

    theta_hat_bootstrap(B+1) = mean(X1)-mean(X2);     %prosthetoyme to arxiko statistiko

    theta_hat_bootstrap_sorted = sort(theta_hat_bootstrap);
    
    p_bootstrap = 0;

    for r = 1:B+1
        if theta_hat_bootstrap_sorted(r) == mean(X1)-mean(X2)     %briskoyme th thesh toy arxikoy statistikoy
                 p_bootstrap = 2*min(r/(B+1), 1-r/(B+1));       %ypologismos 2-sided p timhs apo elegho bootstrap
        end
    end


end







