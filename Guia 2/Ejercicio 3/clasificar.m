% ============ ENTRADAS
% archivo -> nombre del archivo con los patrones
% W -> celda con los vectores de pesos finales
% clases -> matriz con la etiqueta de cada neurona
% ============ SALIDA
% tasa_a -> tasa de acierto del SOM
function [tasa_a] = clasificar(archivo,W,clases)
    % Leo el archivo
    patrones = csvread( archivo);
    % Me fijo la cantidad de patrones
    [fd,~] = size(patrones);
    % Inicializo la taza de acierto en 0
    tasa_a = 0;
    % Para cada patron busco el cercano
    for i=1:fd
        % Selecciono el patron
        patron = patrones(i,1:end-1);
        % Selecciono la salida de ese patron
        salida = patrones(i,end);
        % Busco la neurona ganadora
        [filaGanadora,colGanadora] =  coord_de_ganadora( W , patron );
        % Selecciono la etiqueta de la neurona ganadora
        etiqueta = clases(filaGanadora,colGanadora);
        % Me fijo si acerto
        if etiqueta == salida
            tasa_a = tasa_a + 1 ;
        end
    end
    % Divido por la cantidad de muestras
    tasa_a = tasa_a/fd;
end

function [fila_neurona,col_neurona] = coord_de_ganadora( W , patron )
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false ); % diferencia a cada elemento de celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false ); %distancia a cada vector de la celda
    D = cell2mat(D);
    [v,fila_neurona] = min(D); %minimo de la matriz
    [v,col_neurona] = min(v); %minimo del vector
    fila_neurona = fila_neurona(col_neurona);
end