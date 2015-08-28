function [tasa_e,tasa_a,epoca_actual,W]= mlp_ejer3_e(archivo,criterio,gamma,alpha,tasa_e_max,epoca_max,neuronas)
   
    epoca_actual=1; %Contador de épocas 
    cant_salidas=neuronas(end); %cantidad de neuronas de la última capa son las salidas que tengo en mi red
    patrones_entr=load(archivo);
    [n,m]=size(patrones_entr);
    entradas=m-cant_salidas;
    nodos=[entradas neuronas(1:end-1)]; %cantidad de entradas por cada neurona;
    W=pesosW(nodos,neuronas); 
    capas=length(neuronas); %cantidad de capas
    deltaW_n=W; %iniciaclización del delta W del momento deinercia
    bandera=1;
    while(bandera)
     for i= 1:n % recorrida de patrones
        X=[-1 patrones_entr(i,1:end-cant_salidas)]'; %obtengo un patron i       
        %forward
%         for k=1:capas
%             V=W{k}*X;
%             Y{k}=(sigmoidea_ejer3(V,1)); 
%             X=[-1; Y{k}];
%         end
        Y=forward(X,W,capas);
        
        %back
        derivada=(1/2)*(1+Y{capas}).*(1-Y{capas});
        error=patrones_entr(i,end-cant_salidas+1:end)'-Y{capas}; %forma general para mas de una salida
        Delta{capas}=error.*derivada;
        for k=capas-1:-1:1
            derivada=(1/2)*(1+Y{k}).*(1-Y{k});
            Delta{k}=(W{k+1}(:,2:end)'*Delta{k+1}).*derivada;
        end
        X=[-1 patrones_entr(i,1:end-cant_salidas)]; %Entradas al patron i
       
        %Ajuste de Pesos
        for k=1:capas
            dW=gamma*Delta{k}*X;
            W{k}=W{k}+dW+alpha*deltaW_n{k};% momento de inercia,  acelera la convergencia cuando el gradiente sigue un sentic;
            deltaW_n{k}=dW; %Guardo lo que tenia antes de sumar dW 
            X=[-1; Y{k}]';
        end
       %W=ajusteW(X,Y,W,Delta,deltaW_n,gamma,alpha,capas);

     end % fin de epoca
     
      %Calculo  de tasa error de entrenamiento
        X=[-1*ones(n,1) patrones_entr(:,1:end-cant_salidas)];
        for k=1:capas
            V=W{k}*X'; 
            Yp{k}=(sigmoidea_ejer3(V,1))';
            X=[-1*ones(n,1) Yp{k}];
        end
        V=signo_ejer3(Yp{capas});
        if (length(V(1,:))==1)
            aciertos=sum((V==patrones_entr(:,end-cant_salidas+1:end))); 
        else
            % tenemos mas de una salida se deben comparar los vectores
            % salida y_p (pasadas x la signo) con las salidas deseadas y
            aciertos=sum(all(V'==patrones_entr(:,end-cant_salidas+1:end)'));
        end
        tasa_a=aciertos/n;
        tasa_e=1-tasa_a 
       % Fin calculo de tasa error de entrenamiento        
        
        bandera=corte(criterio,epoca_actual,epoca_max,tasa_e,tasa_e_max,bandera);        
        epoca_actual=epoca_actual+1
        
        %Cálculo de error por época para graficar:
            error_cuad=(Yp{capas}-patrones_entr(:,end-cant_salidas+1:end)).^2;
            error_epoca(epoca_actual,:)=mean(error_cuad);
        
    end
    plot(error_epoca);
    graph_mlp(V,patrones_entr);
end


function [W]=pesosW(nodos,neuronas)
	for i=1:length(nodos)
		W{i}=randn(neuronas(i),nodos(i)+1)-0.5;
	end
end

function [Y]=forward(X,W,capas)
        for k=1:capas
            V=W{k}*X;
            Y{k}=(sigmoidea_ejer3(V,1)); 
            X=[-1; Y{k}];
        end
end


function [W]=ajusteW(X,Y,W,Delta,deltaW_n,gamma,alpha,capas)
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