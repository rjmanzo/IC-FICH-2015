%%-- Funcion de entrenamiento para Perceptron multicapa---

function [tasa_e,epoca_ac,W]= mlp_ejer3_e(archivo,criterio,gamma,alpha,tasa_max,epoca_max,neuronas)
    
    epoca_ac=1; %Contador de épocas 
    cant_salidas=neuronas(end); %La cantidad de salidas es igual a la cantidad de neuronas de la última capa
    M=csvread(archivo);
    [n,m]=size(M);
    entradas=m-cant_salidas;
    nodos=[entradas neuronas(1:end-1)]; %vector con cantidad de entradas por cada neurona;
    W=celdas_pesosW(nodos,neuronas); %Se inicializan los pesos al azar
    capas=length(neuronas); %cantidad de capas
    dW_n=W; %iniciaclización del delta W usado para calcular el término de inercia
    error_epoca=zeros(1,cant_salidas); %Error por época
    bandera=1;
    
    %Entreno la red
    while(bandera)
     for i= 1:n %Se recorren todos los patrones
        X=[-1 M(i,1:end-cant_salidas)]'; %Entradas para patrón i-ésimo
        %Propagación hacia adelante
        for j=1:capas
            V=W{j}*X;
            Y{j}=(sigmoidea_ejer3(V,1)); 
            X=[-1; Y{j}];
        end
        
        %Propagación hacia atrás
        cola=(1/2)*(1+Y{capas}).*(1-Y{capas});
        error=M(i,end-cant_salidas+1:end)'-Y{capas}; %forma general para mas de una salida
        Delta{capas}=error.*cola;
        for j=capas-1:-1:1
            cola=(1/2)*(1+Y{j}).*(1-Y{j});
            Delta{j}=(W{j+1}(:,2:end)'*Delta{j+1}).*cola;
        end
        
        X=[-1 M(i,1:end-cant_salidas)]; %Entradas para patron i-ésimo
        
        %Ajuste de Pesos
        for j=1:capas
            dW=gamma*Delta{j}*X;
            W{j}=W{j}+dW+alpha*dW_n{j};%Se actualizan los pesos utilizando el momento de inercia;
            dW_n{j}=dW; %Guardo lo que tenia antes de sumar dW 
            X=[-1; Y{j}]';
        end

     end
        X=[-1*ones(n,1) M(:,1:end-cant_salidas)];
        for j=1:capas
            V=W{j}*X'; 
            Yp{j}=(sigmoidea_ejer3(V,1))';
            X=[-1*ones(n,1) Yp{j}];
        end
        V=signo_ejer3(Yp{capas});
        if (length(V(1,:))==1)
            cant_aciertos=sum((V==M(:,end-cant_salidas+1:end))); 
        else
            cant_aciertos=sum(all(V'==M(:,end-cant_salidas+1:end)')); %all perite que se comparen los vectores y no valor por valor
        end
        tasa_e=cant_aciertos/n
        %Control para terminar bucle:

        bandera=corte(criterio,epoca_ac,epoca_max,tasa_e,tasa_max,bandera);
        
        % %         if (abs(1-tasa_e)<=tasa_max)
        % %             flag_corte=1;
        % %         end
        
        epoca_ac=epoca_ac+1
        
        %Cálculo de error por época para graficar:
        error_cuad=(Yp{capas}-M(:,end-cant_salidas+1:end)).^2;
        error_epoca(epoca_ac,:)=mean(error_cuad);
        
    end
    plot(error_epoca);
    %%cep=epoca_ac;
    graph_mlp(V,M);
end

% Asignacion de pesos al azar de pesos W
function [W]=celdas_pesosW(nodos,neuronas)
	for i=1:length(nodos)
		W{i}=randn(neuronas(i),nodos(i)+1)-0.5;%nodos(i)+1 por el sesgo(x0)
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