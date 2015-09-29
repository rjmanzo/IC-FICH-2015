function [W,tasa_a,epoca_actual]= rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas,criterio)

    epoca_actual=1;
    [n,m]=size(gaussianas);
    gaussianas=[-ones(n,1) gaussianas];
    W=rand(cant_salidas,m-cant_salidas+1)-0.5;%inicializo pesos
    bandera=1;
    while(bandera)
     for i=1:n %muestro gaussianas
        X=gaussianas(i,1:end-cant_salidas)';
        V=W*X;
        Y=V';
        error=gaussianas(i,end-cant_salidas+1:end)-Y; %forma general para mas de una salida
        dW=gamma*error'*X';
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
        tasa_e(epoca_actual)=1-tasa_a(epoca_actual);     
        %Control para terminar bucle:
        bandera=corte(criterio,epoca_actual,epoca_max,tasa_e(epoca_actual),tasa_max_err,bandera);
            
        epoca_actual=epoca_actual+1;    
        
    end
    figure('Name','Tasa Error Entrenamiento - RBF','NumberTitle','off')
    plot(tasa_e);
    xlabel('epoca');
    ylabel('Tasa');
    title('tasa de errores - RBF');
    
    
end


%%------------- Funcion de Corte--------
%epoca_max      ->  Cantidad max de epocas de entrenamiento
%tasa_max	->  Error maximo aceptable
%Criterio:
%1. - termina con la cant. maxima de iteraciones 
%2. - termina cuando la tasa_e de la epoca n es menor/igual a la tasa maxima de error 
%3. - Conjuncion de los criterios 1. y 2. (Sale por el mejor)

function [bandera]= corte(criterio,epoca_ac,epoca_max,tasa_e,tasa_max,bandera)
        switch criterio
            case 1
                if (epoca_ac>epoca_max)
                    bandera=0;
                end
            case 2
                if (tasa_e<=tasa_max)
                    bandera=0;
                end
            case 3
                if (tasa_e<=tasa_max ||epoca_ac>epoca_max  ) % el que se cumple primero
                    bandera=0;
                end
            otherwise
                print('el criterio no existe');
                bandera=0;
        end       

end