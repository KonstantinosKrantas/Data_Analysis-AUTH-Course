
function [adjR_2, p_value] = Group38Exe8Fun1(vector1,vector2)
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

       x = final_Vector(:,1);
       y = final_Vector(:,2);

       p = polyfit(x,y,2);
       b2= p(1);
       b1= p(2);
       b0 = p(3);

       b=[b0,b1,b2];
       numerator =0;
       denomerator =0;
       y_mean = mean(y);

        for i=1:final_len
            numerator = numerator + (y(i)-(b0+b1*x(i)+b2*(x(i)^2)))^2;
            denomerator = denomerator + (y(i)-(y_mean))^2;
        end
        
        adjR_2 = 1-((final_len-1)/(final_len-3))*(numerator/denomerator); %epilego 2ou bathmou 

        modelfun = @(b,x)b(1)+b(2)*x+b(3)*x.^2;
        beta0 = [1 1 1];

        mdl = fitnlm(x,y,modelfun,beta0); % elegxo apotelesmata
        
        %c)

        L=5000;
        X = zeros(final_len,L);
        
        for i=1:L
            
            ind = randperm(final_len);
            X(:,i) = x(ind);
            
            p = polyfit(X(:,i),y,2);
            b2= p(1);
            b1= p(2);
            b0 = p(3);

            b=[b0,b1,b2];
            numerator =0;
            denomerator =0;
           
    
        for m=1:final_len
            numerator = numerator + (y(m)-(b0+b1*X(m)+b2*(X(m)^2)))^2;
            denomerator = denomerator + (y(m)-(y_mean))^2;
        end
        
        adjLR_2 = 1-((final_len-1)/(final_len-3))*(numerator/denomerator);
        adjL(1,i) =  adjLR_2;
       

        end
        
        adjL(L+1) = adjR_2;

        adj_sorted = sort(adjL);
        
         for r = 1:L+1
            if adj_sorted(r) == adjR_2
                p_value = 2*min(r/(L+1), 1-r/(L+1));
            end
        end   


end