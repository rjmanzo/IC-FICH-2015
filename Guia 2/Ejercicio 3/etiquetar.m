function [E] = etiquetar(archivo,W)
    % Leo los patrones del archivo
    patrones = csvread( archivo );
    % Averiguo el tama�o de la celda
    [n,m] = size(W);
    % Inicializo una celda contadora
    C = cellfun( @(x) zeros(1,2) , W , 'UniformOutput' , false );
    % Averiguo el tama�o de la matriz de patrones
    [fd,~] = size(patrones);
    % Recorro todos los patrones
    for i=1:fd
        % Tomo el patron entrante
        patron = patrones(i,1:end-1);
        % Tomo la salida del patron entrante
        salida = patrones(i,end);
        % Busco la neurona ganadora
        [filaGanadora,colGanadora] = coord_de_ganadora(W,patron);
        % Agarro el vector contador de esa neurona
        contador = C{filaGanadora,colGanadora};
        if salida == -1
            % Si la salida es cero, aumento el contador para esa salida
            contador(1) = contador(1) + 1;
        else
            % Si la salida es uno, aumento el contador para esa salida
            contador(2) = contador(2) + 1;
        end
        % Lo actualizo
        C{filaGanadora,colGanadora} = contador;
    end
    % Recorro toma la Celda y Armo la matriz de clasificacion
    for i=1:n
        for j=1:m
            % Agarro el vector contador
            contador = C{i,j};
            % Busco el maximo de ese vector
            [~,clase] = max(contador);
            % Etiqueto la neurona con la clase
            if clase == 1
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
