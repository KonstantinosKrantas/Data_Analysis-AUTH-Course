% Final Exercise 4

function[rl , ru, ci_bottom, ci_up, p1 , p2, final_len] = Ex4Fun1(vector1, vector2)
        logic_Vec1 = isnan(vector1);
        logic_Vec2 = isnan(vector2);
        k=0; %index ston final matrix
        for i=1:length(vector1)
            if(logic_Vec1(i)==0 && logic_Vec2(i) ==0) % check if there is NaN in any col
               k=k+1;
               final_Vector(k,1)= vector1(i);
               final_Vector(k,2)= vector2(i);
            end
        end
        y = final_Vector;
       
        final_len = k; % final length 

        
                % fisher
       R = corrcoef(final_Vector);
       
       r = R(2,1);

       z = 0.5*log((1+r)/(1-r));
       z1 = z - norminv(0.975)*sqrt(1/(final_len-3));
       z2 = z + norminv(0.975)*sqrt(1/(final_len-3));
       rl = tanh(z1);
       ru = tanh(z2);

                %bootstrap

       B=1000;
       alpha= 0.05;
       boot_R = bootstrp(B, @corr, final_Vector);
       
       for i=1:B
       bootCorr_Coef(i) = boot_R(i,2);
       end
       
       bootCorr = sort(bootCorr_Coef);
       ci_bottom = (bootCorr(B*alpha/2));
       ci_up = bootCorr(B-B*alpha/2);

       % c)
       
       t = r*sqrt((final_len-2)/(1-r^2));
       p1 = 2*(1- tcdf(abs(t), final_len-2)); % p value for parametric
      
       % permutation

       L=2000;
       X = zeros(final_len,L);
       
       for i=1:final_len
           xL(i,1) = final_Vector(i,1);
           yL(i,1) = final_Vector(i,2);
       end

       for i=1:L
            
            ind = randperm(final_len);
            X(:,i) = xL(ind);
            
            s = corrcoef(X(:,i),yL); %matrix of covariance
        
            r_new = s(1,2);
        
            zL(1,i) = 0.5*log((1+r_new)/(1-r_new));
      
            tL(1,i) = r_new*sqrt((final_len-2)/(1-r_new^2));
        end
        
        tL = sort(tL);
        
        if (t>= tL(25) && t< tL(975))
            h=0;
        else 
            h=1;
        end
        tL(L+1) = t;   %add the initial t-statistic in order to find the p-value
    
        t_sorted = sort(tL);
    
        for r = 1:L+1
            if t_sorted(r) == t
                p2 = 2*min(r/(L+1), 1-r/(L+1));
            end
        end   
              
        end