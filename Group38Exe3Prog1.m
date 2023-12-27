% Krantas Konstantinos, Liotopoulos Kosmas

clear all
close all

Heathrow = readmatrix("Heathrow.xlsx");

m = length(Heathrow(:,1));  %number of rows
n = length(Heathrow(1,:));  %number of columns

indicators = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG', 'TN', 'GR'};

p_param_array = [];
p_bootstrap_array = [];


%[p1, p2] = Group38Exe3Fun1(Heathrow(:,1),Heathrow(:,2));


for i = 1:9
    [p1, p2] = Group38Exe3Fun1(Heathrow(:,1),Heathrow(:,i+1));
    p_param_array(i) = p1;
    p_bootstrap_array(i) = p2;
    
    % if p<alpha, null hypothesis is rejected, so the mean values differ
    if p1 < 0.05
        fprintf("Parametric check: there is difference between the mean values of the 2 time periods for " + string(indicators(i)) + "\n")
    end

    if p2 < 0.05
        fprintf("Bootstrap check: there is difference between the mean values of the 2 time periods for " + string(indicators(i)) + "\n")
    end

end

% find indexes with the min p values (biggest mean difference)
[~,param_index] = min(p_param_array);
[~,boot_index] = min(p_bootstrap_array);

fprintf("\nIndicator with the biggest difference between the mean values of the 2 time periods:\n")
fprintf("Parametric check: " + string(indicators(param_index)) + "\n")
fprintf("Bootstrap check: " + string(indicators(boot_index)) + "\n")



%An mia p timh einai mikroterh apo to alpha, ayto shmainei oti exoyme
%aporipsh ths mhdenikhs ypotheshs kai ara oi meses times twn 2 periodwn
%diaferoyn gia ton sygkekrimeno deikth

%H mikroterh p timh ypodeiknyei ton deikth me thn megalyterh diafora stis
%meses times twn 2 periodwn

%Opws fainetai, ta apotelesmata gia toys 2 typoys elegxoy symfwnoyn 





