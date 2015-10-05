function [E] = etiquetar(archivo,W)
    patrones = csvread( archivo );
    [n,m] = size(W); % W neuronas del mapa
    % Inicializar Contadores
    C = cellfun( @(x) zeros(1,2) , W , 'UniformOutput' , false ); % matriz  zeros(1,2) por que salida es -1 o 1.
    [fd,~] = size(patrones); %cantidad de patrones
    for i=1:fd % for para todos los patrones
        patron = patrones(i,1:end-1);%patron
        salida = patrones(i,end);%salida
        [filaGanadora,colGanadora] = coord_de_ganadora(W,patron);
        contador = C{filaGanadora,colGanadora};%seleccion del contador de la ganadora
        if salida == -1            
            contador(1) = contador(1) + 1;% Si la salida es -1, aumento el contador para esa salida
        else
            contador(2) = contador(2) + 1;% Si la salida es uno, aumento el contador para esa salida
        end
        C{filaGanadora,colGanadora} = contador;  % Lo actualizo
    end
    % Recorrer toda la matriz contadora por cada neurona
    %y Armo la matriz de clasificacion
    for i=1:n
        for j=1:m           
            contador = C{i,j}; % Agarro el vector contador           
            [~,clase] = max(contador); % maximo de ese vector
            % Etiquetado
            if clase == 1 % clase guarda el indice del en que columan esta el maximo-> si el maximo esta en indice 1 es clase -1
                E(i,j) = -1;
            else
                E(i,j) = 1;
            end
        end
    end
end


function [fila_neurona,col_neurona] = coord_de_ganadora( W , patron )
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false ); % diferencia a cada elemento de celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false ); %distancia a cada vector de la celda
    D = cell2mat(D);
    [v,fila_neurona] = min(D); %minimo de la matriz (Vector de minimos: Valor y fila)
    [v,col_neurona] = min(v); %minimo del vector (Minimo: Valor min. y columna)
    fila_neurona = fila_neurona(col_neurona);
end
