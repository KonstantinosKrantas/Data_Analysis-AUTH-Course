

clear all;

Data = readmatrix("Heathrow.xls");
k=0;    %index for matrixes
m=0; % index for fisher matrix when r is not 0 
n =0; % index for bootstrap matrix when r is not 0 
l=0; % index for pvalue_parametric matrix when p is less than 0.05
x=0; % index for pvalue_randomized matrix when p is less than 0.05
for i=2:9;  %start is 2nd col because first one is dates
    for j=i+1:10
        
        k=k+1;
        [rl , ru, ci_bottom, ci_up, p1 , p2, size ] = Group38Exe4Fun1(Data(:,i),Data(:,j));
        ci1(1,k)= rl;  % ci for fisher
        ci1(2,k) = ru;
        if(0<rl || 0>ru)
            m=m+1;
            correlated_pointers_fisher(1,m) = i;
            correlated_pointers_fisher(2,m) = j;
        end

        ci2 (1,k) = ci_bottom;  %ci for bootstrap
        ci2(2,k) = ci_up;
        if(0<ci_bottom || 0>ci_up)
            n=n+1;
            correlated_pointers_boot(1,n) = i;
            correlated_pointers_boot(2,n) = j;
        end

        p_parametric(k) = p1;
        
        if(p1<0.05)
            l=l+1;
            correlated_pointers_p_parametric(1,l) = i;
            correlated_pointers_p_parametric(2,l) = j;
            correlated_pointers_p_parametric(3,l) = p1;
        end

        p_random(k) = p2;
        if(p2<0.05)
            x=x+1;
            correlated_pointers_p_random(1,x) = i;
            correlated_pointers_p_random(2,x) = j;
            correlated_pointers_p_random(3,x) = p2;


        end

    end  
end

corr_bootstrap = correlated_pointers_boot
corr_fisher = correlated_pointers_fisher

%paratiroume oti den symfonoun apolyta oi 2 methodoi kathos me ti methodo
%bootstrap exoume 2 parapano deiktes poy fainetai na exoyn sysxetish (tis perissoteres fores). Ostoso
%ektos auton ton 2 deikton (4-6 kai 5-9 tis perissoteres fores) tautizontai apolyta ta
%apotelesmata tous


corr_parametric = correlated_pointers_p_parametric
corr_randomized = correlated_pointers_p_random

%paratiro oti otan xrisimopoio fisher kai parametric exo akrivos ta idia
%apotelesmata, eno se kathe epanalipsi tou algorithmou den allazoun ta apotelesmata tis
% kathe methodoy opos kai anamenetai
% eno sta alla 2 kapoies fores ta
%apotelesmata diaforopoiountai logo diaforetikhs tyxaiopoihshs deigmaton
% apo epanalipsi se epanalipsi tou algorithmou

sorted_param = sort(corr_parametric(3, :));
sorted_random = sort(corr_randomized(3, :));

for i=1: length(sorted_param)
    if(sorted_param(1)==corr_parametric(3,i))
        best_param_couple(1,1) = corr_parametric(1,i);
        best_param_couple(2,1) = corr_parametric(2,i);
        
    end
    if(sorted_param(2)==corr_parametric(3,i))
        best_param_couple(1,2) = corr_parametric(1,i);
        best_param_couple(2,2) = corr_parametric(2,i);
       
        
    end
    if(sorted_param(3)==corr_parametric(3,i))
        best_param_couple(1,3) = corr_parametric(1,i);
        best_param_couple(2,3) = corr_parametric(2,i);
        
    end
end

for i=1: length(sorted_random)
    if(sorted_random(1)==corr_randomized(3,i))
        best_random_couple(1,1) = corr_randomized(1,i);
        best_random_couple(2,1) = corr_randomized(2,i);
        if (sorted_random(1)==sorted_random(2))
           sorted_random(1) = -1; % delete that p value from matrix so it is not used twice
        end
    end
    if(sorted_random(2)==corr_randomized(3,i))
        best_random_couple(1,2) = corr_randomized(1,i);
        best_random_couple(2,2) = corr_randomized(2,i);
        if (sorted_random(2)==sorted_random(3))
           sorted_random(2) = -1; % delete that p value from matrix so it is not used twice
        end
    end
    if(sorted_random(3)==corr_randomized(3,i))
        best_random_couple(1,3) = corr_randomized(1,i);
        best_random_couple(2,3) = corr_randomized(2,i);
        
    end
end

best_couples_parametric = best_param_couple
best_couples_randomized = best_random_couple


% paratiro pos ta 3 zeugi den tautizontai, to koino einai to zeugos 2-3 to
% opoio exei emfanos thn pio statistika simantiki sisxetisi
        
