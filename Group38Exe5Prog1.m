% Krantas Konstantinos, Liotopoulos Kosmas

clear all
close all

Heathrow = readmatrix("Heathrow.xlsx");

m = length(Heathrow(:,1));  %number of rows
c = length(Heathrow(1,:));  %number of columns

indicators = {'T', 'TM', 'Tm', 'PP', 'V', 'RA', 'SN', 'TS', 'FG', 'TN', 'GR'};

X_selected = [2,3,4,6,7];   % X selected are; T, TM, Tm, V and RA

for k = 1:length(X_selected)

    X = Heathrow(:,X_selected(k));
    Y = Heathrow(:,10);
    %scatter(X,Y)
    
    
    % Remove pairs with at least one NaN value
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
    
    r = corr2(X,Y);    % Pearson estimation
    
    t = r*sqrt((n-2)/(1-r^2));
    
    
    if t<0
        p_param = 2*tcdf(t,n-2);
    else
        p_param = 2*(1-tcdf(t,n-2));
    end
    
    
    [I,p,final_length] = Group38Exe5Fun1(X,Y);

    fprintf("\nFor X=" + string(indicators(X_selected(k)-1)) + ", Y=FG:\n")
    fprintf("r = %f, with p = %f\n", r,p_param)
    fprintf("I = %f, with p = %f\n", I,p)

end


% COMMENTS

% Epilexthikan gia X oi deiktes T, TM, Tm, V kai RA, enw gia Y o deikths FG

% Genikws, den parathreitai oyte isxyrh grammikh oyte isxyrh mh grammikh
% sysxetish, afoy ta metra twn r kai I einai sxetika mikra se oloys toys
% deiktes

% Gia X = T kai X = TM, parathroyme oti gia ta metra twn syntelestwn sysxetishs
% Pearsman isxyei |r| > 0.4 kai gia tis antistoixes amoibaies plhrofories
% isxyei I ~= 0.1. Ayto shmainei oti yparxei elafra grammikh
% sysxetish (logw twn r), h opoia anixneyetai kai apo thn amoibaia
% plhroforia, h timh ths opoias einai sxetika megalh (se sxesh me alla
% zeygh), kati poy mporei na ofeiletai kai se yparksh mh grammikhs
% sysxetishs. Oi p times gia ta 2 ayta zeygh, toso gia to r oso kai gia thn
% I einai mikroteres toy 0.05, pragma poy ypodhlwnei oti einai statistika
% shmantika ta metra toys.

% Gia X=Tm, parathreitai mikro r kai sxetika megalo I (~=0.2), wstoso h p
% times toys einai poly megales kai malista gia thn amoibaia plhroforia
% isxyei p>0.05, gegonos poy ypodhlwnei oti to metro I den einai statistika
% shmantiko.

% Gia X=V, parathreitai mia mikrh grammikh sysxetish (r~=0.35), omws to I
% einai poly mikro, pragma poy shmainei oti sigoyra den yparxei megalh mh
% grammikh sysxetish. Oi p times einai poly mikres, epomenws ta metra twn r
% kai I einai statistika shmantika

% Telos, gia X=RA, parathreitai to megalytero, sygkritika me ta ypoloipa
% zeygh, metro r (|r|~=0.57), pragma poy ypodeiknyei isxyroterh grammikh
% sysxetish, enw to I einai sxetika mikro, gegonos poy shmainei oxi kai
% toso isxyrh mh grammikh sysxetish. Oi p times einai kai pali poly mikres,
% ara einai statistika shmantika ta metra twn r kai I.




