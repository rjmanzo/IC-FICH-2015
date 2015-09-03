%%------------- Funcion de Entrenamiento para Perceptron Simple--------
   
function [tasa_e,epoca_ac, W]=Ps_training_(archivo,criterio,epoca_max,gamma,tasa_max, graph_title)

    %Inicializacion:
        v_trn=load(archivo); %%Cargo el vector de entramientos
        [n,m]=size(v_trn);
        W=rand(1,m)-0.5;
        M= zeros(n,m+1); %% Creo la matriz expandida
        M(:,1)=-1; %% Primera fila todos -1 (Ref. X0)
        M(:,2:end)=v_trn; %%Reemplazo mi matriz de entrenamiento 
        epoca_ac=0;
        bandera=1; %% Corte de b

    % Entrenamiento
    while(bandera)
        for i=1:n % Se recorre los patrones
            x=M(i,1:end-1); 
            v=dot(W,x); %Producto punto
            y=f_signo_(v); %% Puede ser cualquier funcion 
            mm=M(i,end);
            e=mm-y;
            DeltaW=gamma*e*x;%ppio de minima perturbacion, si error es cero, no modifica los pesos
            W=W+DeltaW;
            if (DeltaW~=0)
                %graph(graph_title,W,M,2, 0.2, 5)
            end
            
        end
        
        graph_(graph_title,W,M,2,0.2, 5)
        %Calcular error(error entrenamiento):
            v=M(:,1:end-1)*W';
            y=f_signo_(v);
            e=M(:,end)-y;
            ne=sum(e~=0);
            epoca_ac=epoca_ac+1;
            tasa_e(epoca_ac)=ne/n;
        %Control para terminar bucle:
            bandera=corte(criterio,epoca_ac,epoca_max,tasa_e(epoca_ac),tasa_max,bandera);
            
    end


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