function [W,tasa_a,epoca_actual]= rbf(gaussianas,mu,tasa_max_err,epoca_max,cant_salidas)

    epoca_actual=1;
    [n,m]=size(gaussianas);
    gaussianas=[-ones(n,1) gaussianas];
    W=rand(cant_salidas,m-cant_salidas+1)-0.5;%inicializo pesos
    %error_epoca=zeros(1,cant_salidas); %Error por �poca
    corte=0;
    while(corte==0 && epoca_actual<=epoca_max)
     for i=1:n %muestro gaussianas
        X=gaussianas(i,1:end-cant_salidas)';
        V=W*X;
        Y=V';
        error=gaussianas(i,end-cant_salidas+1:end)-Y; %forma general para mas de una salida
        dW=mu*error'*X';
        W=W+dW;%Se actualizan los pesos
     end
        V=W*gaussianas(:,1:end-cant_salidas)';
        Y=sign(V');
        if (length(Y(1,:))==1)
            aciertos=sum((Y==gaussianas(:,end-cant_salidas+1:end)));
        else
            aciertos=sum(all(Y'==gaussianas(:,end-cant_salidas+1:end)'));
        end
        tasa_a(epoca_actual)=aciertos/n;
        if (abs(1-tasa_a(epoca_actual))<=tasa_max_err)
            corte=1;
        end
        epoca_actual=epoca_actual+1;
        
        %C�lculo de error por �poca para graficar:
            %error_cuad=(Y-gaussianas(:,end-cant_salidas+1:end)).^2;
            %error_epoca(epoca_actual,:)=mean(error_cuad);
        
    end
    figure('Name','Tasa Error Enrenamiento','NumberTitle','off')
    plot(1.-tasa_a);
    xlabel('epoca');
    ylabel('Tasa');
    title('tasa de errores');
    
    %plot(error_epoca);
end