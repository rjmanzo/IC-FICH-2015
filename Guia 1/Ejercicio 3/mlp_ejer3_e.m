function [tasa_e,tasa_a,epoca_actual,W]= mlp_ejer3_e(archivo,criterio,gamma,alpha,tasa_e_max,epoca_max,neuronas)
   
    epoca_actual=1; %Contador de épocas 
    cant_salidas=neuronas(end); %cantidad de neuronas de la última capa son las salidas que tengo en mi red
    patrones_entr=load(archivo);
    [n,m]=size(patrones_entr);
    entradas=m-cant_salidas;
    nodos=[entradas neuronas(1:end-1)]; %cantidad de entradas por cada neurona;
    W=pesosW(nodos,neuronas); %pesos al asar
    capas=length(neuronas); %cantidad de capas
    deltaW_n=W; %iniciaclización del delta W del momento deinercia
    bandera=1;
    while(bandera)
        for i= 1:n % recorrida de patrones
            %forward
            Y=forward(W,patrones_entr,capas,cant_salidas,i);
            
%              X=[-1 patrones_entr(i,1:end-cant_salidas)]'; %obtengo un patron i 
%         for k=1:capas
%             V=W{k}*X;
%             Y{k}=(sigmoidea_ejer3(V,1)); 
%             X=[-1; Y{k}];
%         end
            
            
            %back
            Delta=back(Y,W,patrones_entr,capas,cant_salidas,i);  
            
%                   % 1ro -> Delta para la capa de salida
%         derivada=(1/2)*(1+Y{capas}).*(1-Y{capas});
%         error=patrones_entr(i,end-cant_salidas+1:end)'-Y{capas}; %forma general para mas de una salida
%         Delta{capas}=error.*derivada;
%         %2do -> Delta para las capas ocultas
%         for k=capas-1:-1:1
%             derivada=(1/2)*(1+Y{k}).*(1-Y{k});
%             Delta{k}=(W{k+1}(:,2:end)'*Delta{k+1}).*derivada;
%         end
            
            
            %Ajuste de Pesos
            [W,deltaW_n]=ajusteW(Y,W,Delta,deltaW_n,patrones_entr,capas,cant_salidas,gamma,alpha,i); 
%                       X=[-1 patrones_entr(i,1:end-cant_salidas)]; %Entradas al patron i     
%         for k=1:capas
%             dW=gamma*Delta{k}*X;
%             W{k}=W{k}+dW+alpha*deltaW_n{k};% momento de inercia,  acelera la convergencia cuando el gradiente sigue un sentic;
%             deltaW_n{k}=dW; %Guardo lo que tenia antes de sumar dW 
%             X=[-1; Y{k}]';
%         end
            
            
            
        end % fin de epoca 
        
      %Calculo  de tasa error de entrenamiento
      [tasa_e,tasa_a,Yp,V]=calc_error(W,patrones_entr,capas,cant_salidas);    
      bandera=corte(criterio,epoca_actual,epoca_max,tasa_e,tasa_e_max,bandera);        
      epoca_actual=epoca_actual+1
        
        %Cálculo de error por época para graficar:
            error_cuad=(Yp{capas}-patrones_entr(:,end-cant_salidas+1:end)).^2;
            error_epoca(epoca_actual,:)=mean(error_cuad);
        
    end
    figure('Name','Error vs Epocas en Entrenamiento','NumberTitle','off')
    plot(error_epoca);
    xlabel('epoca');
    ylabel('error');
    title('Error en Entrenamiento');
    %Graficamos clasificacion con los patrones de Entrenamiento
    graph_mlp(V,patrones_entr,'Graficamos clasificacion con los patrones de Entrenamiento');
    end


function [W]=pesosW(nodos,neuronas)
	for i=1:length(nodos)
		W{i}=randn(neuronas(i),nodos(i)+1)-0.5;
	end
end

function [Y]=forward(W,patrones_entr,capas,cant_salidas,index_patron)
 X=[-1 patrones_entr(index_patron,1:end-cant_salidas)]'; %obtengo un patron i 
        for k=1:capas
            V=W{k}*X;
            Y{k}=(sigmoidea_ejer3(V,1)); 
            X=[-1; Y{k}];
        end
end

function [Delta]=back(Y,W,patrones_entr,capas,cant_salidas,index_patron)
        % 1ro -> Delta para la capa de salida
        derivada=(1/2)*(1+Y{capas}).*(1-Y{capas});
        error=patrones_entr(index_patron,end-cant_salidas+1:end)'-Y{capas}; %forma general para mas de una salida
        Delta{capas}=error.*derivada;
        %2do -> Delta para las capas ocultas
        for k=capas-1:-1:1
            derivada=(1/2)*(1+Y{k}).*(1-Y{k});
            Delta{k}=(W{k+1}(:,2:end)'*Delta{k+1}).*derivada;
        end
end


function [W,deltaW_n]=ajusteW(Y,W,Delta,deltaW_n,patrones_entr,capas,cant_salidas,gamma,alpha,index_patron)
           X=[-1 patrones_entr(index_patron,1:end-cant_salidas)]; %Entradas al patron i     
        for k=1:capas
            dW=gamma*Delta{k}*X;
            W{k}=W{k}+dW+alpha*deltaW_n{k};% momento de inercia,  acelera la convergencia cuando el gradiente sigue un sentic;
            deltaW_n{k}=dW; %Guardo lo que tenia antes de sumar dW 
            X=[-1; Y{k}]';
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
                print('criterio no contemplado');
                bandera=0;
        end       

end