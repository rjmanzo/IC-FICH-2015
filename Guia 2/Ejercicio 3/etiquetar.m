function [E] = etiquetar(archivo,W)
    % Leo los datos del archivo
    datos = csvread( archivo );
    % Averiguo el tama�o de la celda
    [fw,cw] = size(W);
    % Inicializo una celda contadora
    C = cellfun( @(x) zeros(1,2) , W , 'UniformOutput' , false );
    % Averiguo el tama�o de la matriz de datos
    [fd,~] = size(datos);
    % Recorro todos los patrones
    for i=1:fd
        % Tomo el patron entrante
        patron = datos(i,1:end-1);
        % Tomo la salida del patron entrante
        salida = datos(i,end);
        % Busco la neurona ganadora
        [fg,cg] = coord_de_ganadora(W,patron);
        % Agarro el vector contador de esa neurona
        contador = C{fg,cg};
        if salida == -1
            % Si la salida es cero, aumento el contador para esa salida
            contador(1) = contador(1) + 1;
        else
            % Si la salida es uno, aumento el contador para esa salida
            contador(2) = contador(2) + 1;
        end
        % Lo actualizo
        C{fg,cg} = contador;
    end
    % Recorro toma la Celda y Armo la matriz de clasificacion
    for i=1:fw
        for j=1:cw
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
    [v,fila_neurona] = min(D); %minimo de la matriz
    [v,col_neurona] = min(v); %minimo del vector
    fila_neurona = fila_neurona(col_neurona);
end