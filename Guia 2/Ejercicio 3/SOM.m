% ============ ENTRADAS
% archivo -> nombre del archivo que contiene los datos
% est -> vector con la estructura del SOM
% va -> velocidad de aprendizaje
% vec -> valor de la vecindad
% epocas -> vector de 3 elementos (epocas de cada etapa)
% salidas -> cantidad de salidas
% ============ SALIDA
% W -> celda con los pesos finales
function [W] = SOM(archivo,est,va,vec,epocas,salidas)
    % Leo los datos del archivo
    datos = csvread( strcat( 'Datos/' , archivo , '.csv' ) );
    datos = datos(:,1:end-salidas);
    % Me fijo el tamaño de la matriz de datos
    [f,~] = size( datos );
    % Genero los vectores de pesos de cada neurona del SOM
    W = pesosSOM( est , datos , 1 );
    % Grafico el SOM
    graficarSOM( W ) ;
    pause(2);
    % Creo un contador para las epocas
    cont_ep = 1;
    while( cont_ep < sum(epocas) )
        % Parametros Ordenamiento Global
        if cont_ep < epocas(1)
            mu = va
            A = vec
        % Parametros Transicion
        elseif cont_ep < sum(epocas(1:2))
            mu = va + (0.1-va)*(cont_ep-epocas(1))/epocas(2)
            A = vec + (1-vec)*(cont_ep-epocas(1))/epocas(2)
        % Parametros Ajuste fino
        else
            mu = 0.01
            vec = 0
        end
        % Hago un bucle para recorrer todos los patrones
        for i=1:f
            % Selecciono el patron de analisis
            patron = datos(i,:);
            % Busco la neurona mas cercana
            [fn,cn] = buscarCercano( W , patron );
            % Selecciono la neurona ganadora
            ng = W{fn,cn};
            % Valido los limites
            [ar,ab,iz,de] = validarLimite( fn , cn , vec , est );
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
        % Grafico el SOM ( cada 20 epocas )
        if mod( cont_ep , 20 ) == 0
            graficarSOM( W ) ;
        end
        % Aumento el contador de epocas
        cont_ep = cont_ep + 1 
    end
    % Grafico los datos del archivo
    graficar( datos );
end