% ============ ENTRADAS
% archivo -> nombre del archivo con los datos
% W -> celda con los vectores de pesos finales
% clases -> matriz con la etiqueta de cada neurona
% ============ SALIDA
% ta -> tasa de acierto del SOM
function [ta] = clasificar(archivo,W,clases)
    % Leo el archivo
    datos = csvread( archivo);
    % Me fijo la cantidad de datos
    [fd,~] = size(datos);
    % Inicializo la taza de acierto en 0
    ta = 0;
    % Para cada patron busco el cercano
    for i=1:fd
        % Selecciono el patron
        patron = datos(i,1:end-1);
        % Selecciono la salida de ese patron
        salida = datos(i,end);
        % Busco la neurona ganadora
        [fg,cg] =  coord_de_ganadora( W , patron );
        % Selecciono la etiqueta de la neurona ganadora
        et = clases(fg,cg);
        % Me fijo si acerto
        if et == salida
            ta = ta + 1 ;
        end
    end
    % Divido por la cantidad de muestras
    ta = ta/fd;
end

function [fila_neurona,col_neurona] = coord_de_ganadora( W , patron )
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false ); % diferencia a cada elemento de celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false ); %distancia a cada vector de la celda
    D = cell2mat(D);
    [v,fila_neurona] = min(D); %minimo de la matriz
    [v,col_neurona] = min(v); %minimo del vector
    fila_neurona = fila_neurona(col_neurona);
end