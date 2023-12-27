% Krantas Konstantinos, Liotopoulos Kosmas

clear all
close all

Heathrow = readmatrix("Heathrow.xlsx");

m = length(Heathrow(:,1));  %number of rows
c = length(Heathrow(1,:));  %number of columns

indicators = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG', 'TN', 'GR'};
modeltypes = {'Linear', 'Poly2', 'Poly3', 'Exponential', 'Logarithmic', 'Inverse'};

for i = 1:8
    X = Heathrow(:,i+1);
    Y = Heathrow(:,10);
    
    [model_type, adjRsquared] = Group38Exe7Fun1(X,Y);

    sgtitle("X = " + string(indicators(i)))   %creates overall title for a figure with subplots

    fprintf("For X=" + string(indicators(i)) + ":\n");
    fprintf("Selected model is: " + string(modeltypes(model_type)) + ", with adjR^2 = %f\n", adjRsquared);

end

X = Heathrow(:,12);
Y = Heathrow(:,10);

[model_type, adjRsquared] = Group38Exe7Fun1(X,Y);
fprintf("For X=" + string(indicators(11)) + ":\n");
fprintf("Selected model is: " + string(modeltypes(model_type)) + ", with adjR^2 = %f\n", adjRsquared);



%COMMENTS

%Genika parathroyme oti oi prosarmoges den einai kales, epomenws o deikths
%FG den prosdiorizetai toso kala apo enan, mono, allo deikth

%Ta 3 megalytera adjR^2 antistoixoyn, stoys deiktes RA, T kai TM

%O deikths RA me polywnymiko montelo 2oy vathmoy, me adjR^2 = 0.349021
%fainetai na ekshgei kalytera ton deikth FG

%O deikths T me montelo: y = a + b/x (inverse model) einai o deikths me ton
%deytero megalytero prosarmosmeno syntelesth, adjR^2 = 0.213278

%O tritos se seira deikths me vash to adjR^2 einai o TM, opoy me
%polywnymiko montelo 2oy vathmoy exei adjR^2=0.158216

%Arketoi deiktes exoyn adjR^2 poly konta sto 0, gegonos poy ypodhlwnei poly
%kakh prosarmogh, me ton deikth SN, malista, na exei arnhtikh timh adjR^2,
%pragma to opoio deixnei oti kanena apo ta ypo dokimh montela den
%prosarmozoyn kalytera to FG apo to aplo montelo meshs timhs (oson afora
%ton deikth SN)




