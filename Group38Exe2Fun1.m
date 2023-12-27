% Krantas Konstantinos, Liotopoulos Kosmas


function [ci_param, ci_bootstrp] = Group38Exe2Fun1(v)

    [~,~,ci_param] = ttest(v);
    
    v = v';
    v = v(~isnan(v))';        %removing NaN values
    
    B = 10000;    %bootstrap samples
    ci_bootstrp = bootci(B, @mean, v);

end
 
