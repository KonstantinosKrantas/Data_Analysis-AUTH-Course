% Krantas Konstantinos, Liotopoulos Kosmas

clear all
close all

Heathrow = readmatrix("Heathrow.xlsx");

m = length(Heathrow(:,1));  %number of rows
n = length(Heathrow(1,:));  %number of columns

ci_param_array = [];
ci_bootstrp_array = [];


for i = 1:9
    [ci1, ci2] = Group38Exe2Fun1(Heathrow(11:m,i+1));
    ci_param_array(i,:) = ci1;
    ci_bootstrp_array(i,:) = ci2;
end
    
mean_value = mean(Heathrow(1:10,2:n-2));

%ci_param_array

%ci_bootstrp_array

indicators = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG', 'TN', 'GR'};

for i = 1:9
    if isnan(mean_value(i))
        fprintf("There are not any data of " + string(indicators(i)) + " for 1949-1958\n")     %case of no data
        continue
    end

    if mean_value(i) >= ci_param_array(i,1) && mean_value(i) <= ci_param_array(i,2)
        fprintf("Mean value of 1949-1958 for " + string(indicators(i)) + " is included in parametric CI\n")
    else
        fprintf("Mean value of 1949-1958 for " + string(indicators(i)) + " is NOT included in parametric CI\n")
    end

    if mean_value(i) >= ci_bootstrp_array(i,1) && mean_value(i) <= ci_bootstrp_array(i,2)
        fprintf("Mean value of 1949-1958 for " + string(indicators(i)) + " is included in bootstrap CI\n")
    else
        fprintf("Mean value of 1949-1958 for " + string(indicators(i)) + " is NOT included in bootstrap CI\n")
    end

end


%Genika ta perissotera diasthmata empistosynhs einai arketa paromoia, me
%eksairesh isws ayta gia ton deikth PP (parametric: [581.0160  668.7824]
%kai bootstrap: [586.9066  669.6474] ) poy paroysiazoyn megalh diafora kyriws sto
%katw akro, h opoia omws, analogika me to eyros toy diasthmatos, den einai toso shmantikh. 

%Epipleon, parathroyme oti ta diasthmata bootstrap einai pio stena se sxesh
%me ta antistoixa parametrika.

%Opws fainetai apo ta apotelesmata, h mesh timh ths prwths periodoy exei
%allaksei thn periodo 1973-2017 gia toys deiktes: T,TM,V,RA,TS,FG afoy h
%mesh timh ths prwths periodoy den periexetai sta diasthmata empistosynhs
%ths deyterhs periodoy. Malista, gia ton deikth FG paroysiazetai poly
%shmantikh metabolh ths meshs timhs apo thn prwth periodo sth deyterh.



