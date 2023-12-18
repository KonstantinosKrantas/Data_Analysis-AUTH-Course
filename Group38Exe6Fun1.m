%exercise 6


function R_2 = Group38Exe6Fun1(vector1, vector2)
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
       
        
        final_len = k; % final length 

        %b)
        y = final_Vector(:,2);
        x = final_Vector(:,1);
        
        X = [ones(size(x)) x];
        
        b = regress(y,X);

        b0 = b(1,1);
        b1 = b(2,1);
        numerator =0;
        denomerator =0;
        y_mean = mean(y);

        for i=1:final_len
            numerator = numerator + (y(i)-(b0+b1*x(i)))^2;
            denomerator = denomerator + (y(i)-(y_mean))^2;
        end
        R_2 = 1 - numerator/denomerator;

        % UNCOMMENT TA PARAKATO GIA NA EMFANIZETAI TO DIAGRAMMA DIASPORAS
        
%        mdl = fitlm(x,y);
%         figure(1)
%         plot(mdl)
%         x_sorted = sort(x);
%         y_sorted = sort(y);
%         txt= ['R^2: ' num2str(R_2)];
%         text(x_sorted(1)-0.3,y_sorted(final_len),txt)

        
end