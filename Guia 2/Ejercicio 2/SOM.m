function [W] = SOM(archivo,matris_som,gamma,vecindad,epocas_etapas,cant_salidas)
    datos = csvread( archivo );
    datos = datos(:,1:end-cant_salidas);
    % Me fijo el tama�o de la matriz de datos
    [n,~] = size( datos );
    % Genero los vectores de pesos de cada neurona del SOM
    W = pesosSOM( matris_som , datos , 1 );
    % Grafico el SOM
    graficarSOM( W ) ;
    pause(2);
    % Creo un contador para las epocas_etapas
    cont_ep = 1;
    while( cont_ep < sum(epocas_etapas) )
        % Parametros Ordenamiento Global
        if cont_ep < epocas_etapas(1)
            mu = gamma
            A = vecindad
        % Parametros Transicion
        elseif cont_ep < sum(epocas_etapas(1:2))
            mu = gamma + (0.1-gamma)*(cont_ep-epocas_etapas(1))/epocas_etapas(2)
            A = vecindad + (1-vecindad)*(cont_ep-epocas_etapas(1))/epocas_etapas(2)
        % Parametros Ajuste fino
        else
            mu = 0.01
            vecindad = 0
        end
        % Hago un bucle para recorrer todos los patrones
        for i=1:n
            % Selecciono el patron de analisis
            patron = datos(i,:);
            % Busco la neurona mas cercana
            [fn,cn] = buscarCercano( W , patron );
            % Selecciono la neurona ganadora
            ng = W{fn,cn};
            % Valido los limites
            [ar,ab,iz,de] = validarLimite( fn , cn , vecindad , matris_som );
            % Analizo la vecindad
            for fv=ar:ab
                for cv=iz:de
                    % Pregunto si la neurona vecina esta dentro de la vecindad
                    if abs((fn-fv))+abs((cn-cv)) <= A 
                        % Selecciono la neurona vecina
                        nv = W{fv,cv};
                        % Calculo el error con el patron entrante
                        e = patron - nv;
                        % Actualizo la neurona
                        W{fv,cv} = W{fv,cv}+mu*e;
                    end
                end
            end
        end
        % Grafico el SOM ( cada 20 epocas_etapas )
        if mod( cont_ep , 2 ) == 0
            graficarSOM( W ) ;
             pause(2);
        end
        % Aumento el contador de epocas_etapas
        cont_ep = cont_ep + 1 
    end
    % Grafico los datos del archivo
    graficar( datos );
end