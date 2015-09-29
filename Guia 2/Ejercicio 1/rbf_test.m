function [ tasa_a_t ] = rbf_test( gaussianas,W,cant_salidas)
        [n,~]=size(gaussianas);
        gaussianas=[-ones(n,1) gaussianas];
        Y=sign((W*gaussianas(:,1:end-cant_salidas)')');
        if (length(Y(1,:))==1)
            aciertos=sum((Y==gaussianas(:,end-cant_salidas+1:end)));
            
        else
            aciertos=sum(all(Y'==gaussianas(:,end-cant_salidas+1:end)')); %all perite que se comparen los vectores y no valor por valor
        end
        tasa_a_t=aciertos/n;
end

