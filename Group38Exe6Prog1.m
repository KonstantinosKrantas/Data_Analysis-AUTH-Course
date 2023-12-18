clear all;
close all;
Data = readmatrix("Heathrow.xls");


for i=2:12
    k=0; %index for r^2 matrix
    if i~=11
       if i~=12
         figure(i-1)
       else
         figure(i-2)
       end
    end
    for j=2:12
        if(i~=j && i~=11 && j~=11)
            R_2 = Group38Exe6Fun1(Data(:,i),Data(:,j));
            k=k+1;
            
            X = Data(:,i);
            Y = Data(:,j);
            
            
            subplot(3,3,k);
            scatter(X,Y)
            legend_string = sprintf("R^2 = %f",R_2);
            subtitle(legend_string)

            % Exoume 10 figures gia kathe mia apo tis 10 exartimenes
            % metablites. To figure 1 exei exartimeni ton deutero
            % deikti(T),to figure 2 exei ton 3o (TN) kai antistoixa ta
            % epomena. To figure 10 exei ton teleutaio deikti (GR). Se
            % kathe figure parousiazetai to diagramma diasporas tis
            % antistoixis exartimenis metablitis me tis ypoloipes.
            % Xekinontas apo pano aristera kai proxorontas dexia,
            % paratiruoyme ta antisoixa diagrammata gia anexartiti
            % metabliti tin ekastote apo ta dedomena. Gia paradeigma sto
            % Figure 1 pano aristera exoyme ton 3o deikth, pano sto kentro
            % ton 4o, pano dexis ton 5o, sth mesaia sthlh kai aristera ton
            % 6o kai paei legontas. Ennoeitai den yparxoyn katholou to TN
            % kai ta diagrammata gia tin idia metabliti px T-T h GR-GR


            Matrix_of_RSquared(k) = R_2;
            pointer(k) = j; %deikths gia to kathe apotelesma
            if (j==12 || (i==12 && j==10))
                Sorted_Matrix = sort(Matrix_of_RSquared);
                len = length(Sorted_Matrix);
                for m=1:len

                    if (Sorted_Matrix(len) == Matrix_of_RSquared(m) )
                        highest_independent = pointer(m);
                    end

                     if (Sorted_Matrix(len-1) == Matrix_of_RSquared(m) )
                        second_highest_independent = pointer(m);
                    end
                end
                if i==12
                    Highest_RSquared_deikths(1,i-2) = highest_independent;
                    Highest_RSquared_deikths(2,i-2) = second_highest_independent;
                    Highest_RSquared_value(1,i-2) = Sorted_Matrix(len);
                    Highest_RSquared_value(2,i-2) = Sorted_Matrix(len-1);
                else
                     Highest_RSquared_deikths(1, i-1) = highest_independent;
                     Highest_RSquared_deikths(2,i-1) = second_highest_independent;
                     Highest_RSquared_value(1,i-1) = Sorted_Matrix(len);
                     Highest_RSquared_value(2,i-1) = Sorted_Matrix(len-1);
                end
            end

        end
    end
end

Highest_RSquared_deikths = Highest_RSquared_deikths
Highest_RSquared_value = Highest_RSquared_value

 %ston proto pinaka (Highest_RSquared_deikths)parousiazontai oi 2 anexartitew metablites me to
 %megalitero R^2. Sthn 1h sthlh exartimeni metabliti einai o deikths 2(T) ,
 %sthn 3h sthlh o TM kai antistoixa stis epomenes os tin teleutaia poy
 %einai h 10h sthlh me exartimenh to GR

 %ston deutero pinaka (Highest_RSquared_value)
 % parousiazontai oi times toy R^2 poy antistoixoun
 %stous deiktes tou parapano pinaka
