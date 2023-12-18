clear all;

Data = readmatrix("Heathrow.xls");

k=0;
j=0;
for i=2:12
    if(i~=10 && i~=11)

        [adjR_Squared, pValue] = Group38Exe8Fun1(Data(:,i),Data(:,10));
        k=k+1;
        adjR_Sq_Matrix(k)= adjR_Squared;
        pValue_Matrix(k) = pValue;
    
    end
end
pointers_are = [" T " ," TN ", " Tm ", " PP ", " V ", " RA ", " SN ", " TS ", " GR "]
AdjR_SqMatrix = adjR_Sq_Matrix
pValue_Matrix = double(pValue_Matrix)

% Genika ta adjR^2 einai arketa mikra, sinepos gia to epilegmeno montelo
% polyonumo 2ou bathmoy kanenas deikths den exigei se megalo bathmo tin
% exartimeni metabliti (FG).  Oi dyo deiktes poy exhgoyn kalytera to FG
% einai to RA kai to T (giati exoyn ta megalytera adjR^2)
% kai epeidi oi p times tous einai mikroteres apo 0.05
% tote symperainoume oti to montelo einai statistika shmantiko
