% Krantas Konstantinos, Liotopoulos Kosmas

clear all
close all

Heathrow = readmatrix("Heathrow.xlsx");

m = length(Heathrow(:,1));  %number of rows
c = length(Heathrow(1,:));  %number of columns

indicators = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG', 'TN', 'GR'};


% Create a matrix called New_Heathrow, which contains data only from the
% years that have data for every indicator

NaN_rows = [];    % rows that contain NaN values and are about to be erased
counter = 1;

for i = 1:m
    for j = 1:c
        if isnan(Heathrow(i,j))     % if there is a NaN element for i-th year
            NaN_rows(counter) = i;  %include this year (row) in the erase-list 
            counter = counter + 1;
            break
        end
    end
end

New_Heathrow = Heathrow;       

New_Heathrow(NaN_rows, :) = [];   % New_Heathrow is now the matrix without NaN years 

n = length(New_Heathrow);  % Number of rows of New_Heathrow

% Regression for FG with all indicators
Y = New_Heathrow(:,10);

X = [New_Heathrow(:,2:9), New_Heathrow(:,11:12)];

X_regress = [ones(n,1), New_Heathrow(:,2:9), New_Heathrow(:,11:12)];   % prepare X for regress, adding the 'ones' column

[b,b_CI,~,~,stats] = regress(Y,X_regress);

error_variance = stats(4);

Rsquared = stats(1);

adjRsquared = 1 - (1-Rsquared)*(n-1)/(n-11);   %adjR2 = 1 - (1-R2)*(n-1)/(n-k-1)

fprintf("Model with all indicators for FG:\n")
fprintf("\nError variance = %f\n", error_variance)
fprintf("R^2 = %f\n", Rsquared)
fprintf("AdjR^2 = %f\n", adjRsquared)

if b_CI(1,1)*b_CI(1,2) > 0
    fprintf("Intercept term is statistically significant")
end

indicators_of_X = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'TN', 'GR'};    % indicators according to X matrix (for printing purposes)

for i = 1:10
    if b_CI(i+1,1)*b_CI(i+1,2) > 0
        fprintf("Coefficient for indicator " + string(indicators_of_X(i)) + " is statistically significant\n")
    end
end

fprintf("\n===============================================================\n")
%stepwise(X,Y)

%[b,se,pval,finalmodel,stats2] = stepwisefit(X,Y);

fprintf("\nStepwise regression model for FG:\n")

mdl = stepwiselm(X,Y);

fprintf("\nAnalytical table of the final linear model:\n")

% mdl.Formula
% mdl.CoefficientNames
% mdl.NumCoefficients
% mdl.NumEstimatedCoefficients

analytical_table = mdl.Coefficients

error_variance_stepwise = mdl.MSE;
Rsquared_stepwise = mdl.Rsquared.Ordinary;
adjRsquared_stepwise = mdl.Rsquared.Adjusted;

fprintf("Error variance = %f\n", error_variance_stepwise)
fprintf("R^2 = %f\n", Rsquared_stepwise)
fprintf("AdjR^2 = %f\n", adjRsquared_stepwise)

fprintf("\n===============================================================\n")

% PLS
reduced_dimension = 2;
[Xloadings,Yloadings,Xscores,Yscores,beta_pls] = plsregress(X,Y,reduced_dimension);  
y_pred_pls = [ones(n,1) X]*beta_pls;
res_pls = y_pred_pls - Y;
RSS_pls = sum(res_pls.^2);
TSS = sum((Y-mean(Y)).^2);
rsquared_pls = 1 - RSS_pls/TSS;
adjRsquared_pls = 1 - (1-rsquared_pls)*(n-1)/(n-11);   %adjR2 = 1 - (1-R2)*(n-1)/(n-k-1)
error_variance_pls = 1/(n-11)*RSS_pls;

fprintf("\nPLS regression model for FG:\n")
fprintf("Error variance = %f\n", error_variance_pls)
fprintf("R^2 = %f\n", rsquared_pls)
fprintf("AdjR^2 = %f\n", adjRsquared_pls)








% Regression for GR with all indicators
Y = New_Heathrow(:,12);

X = [New_Heathrow(:,2:11)];

X_regress = [ones(n,1), New_Heathrow(:,2:11)];   % prepare X for regress, adding the 'ones' column

[b,b_CI,~,~,stats] = regress(Y,X_regress);

error_variance = stats(4);

Rsquared = stats(1);

adjRsquared = 1 - (1-Rsquared)*(n-1)/(n-11);   %adjR2 = 1 - (1-R2)*(n-1)/(n-k-1)

fprintf("\n===============================================================\n")
fprintf("===============================================================\n")
fprintf("\nModel with all indicators for GR:\n")
fprintf("\nError variance = %f\n", error_variance)
fprintf("R^2 = %f\n", Rsquared)
fprintf("AdjR^2 = %f\n", adjRsquared)

if b_CI(1,1)*b_CI(1,2) > 0
    fprintf("Intercept term is statistically significant")
end

indicators_of_X = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG','TN'};    % indicators according to X matrix (for printing purposes)

for i = 1:10
    if b_CI(i+1,1)*b_CI(i+1,2) > 0
        fprintf("Coefficient for indicator " + string(indicators_of_X(i)) + " is statistically significant\n")
    end
end

fprintf("\n===============================================================\n")
%stepwise(X,Y)

%[b,se,pval,finalmodel,stats2] = stepwisefit(X,Y);

fprintf("\nStepwise regression model for GR:\n")

mdl = stepwiselm(X,Y);

fprintf("\nAnalytical table of the final linear model:\n")

% mdl.Formula
% mdl.CoefficientNames
% mdl.NumCoefficients
% mdl.NumEstimatedCoefficients

analytical_table = mdl.Coefficients

error_variance_stepwise = mdl.MSE;
Rsquared_stepwise = mdl.Rsquared.Ordinary;
adjRsquared_stepwise = mdl.Rsquared.Adjusted;

fprintf("Error variance = %f\n", error_variance_stepwise)
fprintf("R^2 = %f\n", Rsquared_stepwise)
fprintf("AdjR^2 = %f\n", adjRsquared_stepwise)

fprintf("\n===============================================================\n")

% PLS
reduced_dimension = 2;
[Xloadings,Yloadings,Xscores,Yscores,beta_pls] = plsregress(X,Y,reduced_dimension);  
y_pred_pls = [ones(n,1) X]*beta_pls;
res_pls = y_pred_pls - Y;
RSS_pls = sum(res_pls.^2);
TSS = sum((Y-mean(Y)).^2);
rsquared_pls = 1 - RSS_pls/TSS;
adjRsquared_pls = 1 - (1-rsquared_pls)*(n-1)/(n-11);   %adjR2 = 1 - (1-R2)*(n-1)/(n-k-1)
error_variance_pls = 1/(n-11)*RSS_pls;

fprintf("\nPLS regression model for GR:\n")
fprintf("Error variance = %f\n", error_variance_pls)
fprintf("R^2 = %f\n", rsquared_pls)
fprintf("AdjR^2 = %f\n", adjRsquared_pls)




% COMMENTS

% Gia ton deikth FG, h methodos ths bhmatikhs palindromhshs dinei to
% megalytero adjR^2 (0.554934) se sxesh me auto ths methodoy me oloys toys
% deiktes (0.544550) kai to PLS (-0.166325). Epomenws, einai logiko na
% epileksoume th methodo ths bhmatikhs palindromhshs, h opoia malista
% "krataei" mono 2 aneksarthtes metablhtes (deiktes), toys Tm kai PP.
% Oi dyo aytoi deiktes, malista einai oi monoi statistika shmantikoi, kata
% th methodo me oloys toys deiktes.

% To montelo PLS dinei arnhtiko adjR^2, gegonos poy ypodhlwnei oti den
% einai katallhlo gia thn grammikh palindromhsh

% Epomenws, efoson to montelo me toys deiktes Tm kai PP dinei adjR^2 > 0.5,
% tha mporoysame na poyme oti o deikths FG ekshgeitai sxetika ikanopoihtika
% apo toys 2 aytoys deiktes, an kai gia ikanopoihtikoterh ekshghsh tha
% thelame idanika adjR^2 > 0.8

% Gia ton deikth GR, ta antistoixa adjR^2 einai kata ti mikrotera.
% Kai pali, h methodos bhmatikhs palindromhshs dinei to megalytero AdjR^2
% (0.439588) se sxesh me ayto ths methodoy me oloys toys deiktes (0.423761)
% alla kai to PLS (-0.035432). Epomenws, einai logiko na
% epileksoume th methodo ths bhmatikhs palindromhshs, h opoia malista
% "krataei" mono 2 aneksarthtes metablhtes (deiktes), toys TM kai TS.

% Sth methodo me oloys toys deiktes, statistika shmantikos einai mono o
% deikths TS

% To montelo PLS dinei, kai pali, arnhtiko adjR^2, gegonos poy ypodhlwnei oti den
% einai katallhlo gia thn grammikh palindromhsh

% Genika, gia ton deikth GR, akoma kai h methodos ths bhmatikhs
% palindromhshs de dinei ikanopoihtika megalo adjR^2, wste na poyme oti
% kapoioi deiktes ton ekshgoyn ikanopoihtika.
% Wstoso, an thelame na vroyme toys deiktes poy ekshgoyn ton GR kalytera se
% sxesh me toys ypoloipoys, tote aytoi tha htan oi TM kai TS







