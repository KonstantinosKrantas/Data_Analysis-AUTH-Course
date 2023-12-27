% Krantas Konstantinos, Liotopoulos Kosmas

function [model_type, adjRsquared] = Group38Exe7Fun1(X,Y)

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

    n = length(X);
    
    syms t   % for the curve plots

    % linear regress
    p = polyfit(X,Y,1);
    b0_linear = p(2);
    b1_linear = p(1);

    y_pred = b0_linear + b1_linear*X;

    adjR2_1 = 1 - (n-1)/(n-2)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);

    line = b0_linear + b1_linear*t;


    figure

    subplot(3,2,1)
    scatter(X,Y);
    hold on
    %legend_string = sprintf("%.3f + %.3f*x, adjR^2 = %f",b0_linear,b1_linear,adjR2_1);
    legend_string = sprintf("Linear, adjR^2 = %f",adjR2_1);
    X_sorted = sort(X);
    fplot(line, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)


    % poly 2
    p = polyfit(X,Y,2);
    b0_poly2 = p(3);
    b1_poly2 = p(2);
    b2_poly2 = p(1);

    y_pred = b0_poly2 + b1_poly2*X + b2_poly2*X.^2;

    adjR2_2 = 1 - (n-1)/(n-3)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);

    poly2 = b0_poly2 + b1_poly2*t + b2_poly2*t^2;

    subplot(3,2,2)
    scatter(X,Y);
    hold on
    %legend_string = sprintf("%.3f + %.3f*x + %.3f*x^2, adjR^2 = %f",b0_poly2,b1_poly2,b2_poly2,adjR2_2);
    legend_string = sprintf("Poly2, adjR^2 = %f",adjR2_2);
    fplot(poly2, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)


    % poly 3
    p = polyfit(X,Y,3);
    b0_poly3 = p(4);
    b1_poly3 = p(3);
    b2_poly3 = p(2);
    b3_poly3 = p(1);

    y_pred = b0_poly3 + b1_poly3*X + b2_poly3*X.^2 + b3_poly3*X.^3;

    adjR2_3 = 1 - (n-1)/(n-4)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);

    poly3 = b0_poly3 + b1_poly3*t + b2_poly3*t^2 + b3_poly3*t^3;

    subplot(3,2,3)
    scatter(X,Y);
    hold on
    %legend_string = sprintf("%.3f + %,3f*x + %.3f*x^2 + %.3f*x^3, adjR^2 = %f",b0_poly3,b1_poly3,b2_poly3, b3_poly3, adjR2_3);
    legend_string = sprintf("Poly3, adjR^2 = %f",adjR2_3);
    fplot(poly3, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)


    % exponential
    Y_new = log(Y);
    p = polyfit(X,Y_new,1);
    a_exp = exp(p(2));      %Y_new = log(Y) = log(a_exp) + b_exp*X
    b_exp = p(1);

    %y_pred = p(2) + p(1)*X;

    y_pred = a_exp*exp(b_exp*X);

    adjR2_exp = 1 - (n-1)/(n-2)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);   % from the formula of adjR^2: k+1 = 2 here

    exponential = a_exp*exp(b_exp*t);

    subplot(3,2,4)
    scatter(X,Y);
    hold on

    legend_string = sprintf("Exponential, adjR^2 = %f",adjR2_exp);
    X_sorted = sort(X);
    fplot(exponential, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)


    % logarithmic
    for i = 1:length(X)
        if X(i)==0
            X = X + 1e-6;    %add a really small const to eliminate the log(0) problem
            break;
        end
    end

    X_log = log(X);
    p = polyfit(X_log,Y,1);
    a_log = p(2);     %Y = a + b*X_log
    b_log = p(1);

    y_pred = a_log + b_log*log(X);

    adjR2_log = 1 - (n-1)/(n-2)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);   % from the formula of adjR^2: k+1 = 2 here

    logarithmic = a_log + b_log*log(t);

    subplot(3,2,5)
    scatter(X,Y);
    hold on

    legend_string = sprintf("logarithmic, adjR^2 = %f",adjR2_log);
    X_sorted = sort(X);
    fplot(logarithmic, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)



    % inverse
    for i = 1:length(X)
        if X(i)==0
            X = X + 1e-6;    %add a really small const to eliminate the 1/0 problem
            break;
        end
    end

    X_inv = 1./X;
    p = polyfit(X_inv,Y,1);
    a_inv = p(2);     %Y = a + b*X_inv
    b_inv = p(1);

    y_pred = a_inv + b_inv*X_inv;

    adjR2_inv = 1 - (n-1)/(n-2)*sum((Y-y_pred).^2)/sum((Y-mean(Y)).^2);   % from the formula of adjR^2: k+1 = 2 here

    inverse = a_inv + b_inv/t;

    subplot(3,2,6)
    scatter(X,Y);
    hold on

    legend_string = sprintf("inverse, adjR^2 = %f",adjR2_inv);
    X_sorted = sort(X);
    fplot(inverse, [X_sorted(1),X_sorted(length(X))])
    subtitle(legend_string)


    adjR2_array = [adjR2_1, adjR2_2, adjR2_3, adjR2_exp, adjR2_log, adjR2_inv];

    [adjRsquared, model_type] = max(adjR2_array);   %returns the value and the index of max



end

