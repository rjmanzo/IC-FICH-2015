function [mejorCamino,mejorCosto]=busqueda_costo_uniforme(path_archivo,nodoRaiz)
% Leo los datos
datos = csvread(path_archivo);

% Me fijo la cantidad de nodos
cantNodos = size(datos,1);

% Inserto el nodo raiz en la matriz de conexiones
matrizConexiones(1,:) = [ 0 1 nodoRaiz 0 ];

% Vector con los nodos no recorridos
nodosNoRecorridos = [1:cantNodos];

% Elimino el nodoRaiz de los nodosNoRecorridos
nodosNoRecorridos( nodosNoRecorridos == nodoRaiz ) = [];

% Expando el nodo raiz
hojas(1:length(nodosNoRecorridos),:) = [ ones(length(nodosNoRecorridos),1)  nodosNoRecorridos' datos(nodoRaiz,nodosNoRecorridos)'];

% Reordeno la matriz de hojas en base a las distancias acumuladas
hojas = sortrows( hojas , 3 );

while hojas(1,2) ~= nodoRaiz
    % Agrego el proximo nodo a expandir
    matrizConexiones = [ matrizConexiones; hojas(1,1) matrizConexiones(end,2)+1 hojas(1,2:3)   ];
    % Lo elimino de la matriz de hojas
    hojas(1,:) = [];
    % Armo el camino desde ese nodo hasta la raiz
    camino = matrizConexiones(end,3);
    padre = matrizConexiones(end,1);
    while padre ~= 0
        camino = [matrizConexiones(padre,3) camino];
        padre = matrizConexiones(padre,1);
    end
    % Armo un vector con todos los nodos
    nodosNoRecorridos = [1:cantNodos];
    % Saco los nodos que ya recorri
    nodosNoRecorridos = setdiff( nodosNoRecorridos , camino );
    % Me fijo si el vector de nodos no recorridos quedo vacio
    if size(nodosNoRecorridos,2) == 0
        % Si quedo vacio llegue al nodo objetivo
        hojas = [ hojas; matrizConexiones(end,2) nodoRaiz matrizConexiones(end,4)+datos(matrizConexiones(end,3),nodoRaiz)];
    else
        % Expando ese nodo
        hojas = [ hojas; repmat( matrizConexiones(end,2) , length(nodosNoRecorridos) , 1 ) nodosNoRecorridos' matrizConexiones(end,4)+datos(matrizConexiones(end,3),nodosNoRecorridos)'];
    end
    % Ordeno las hojas para la proxima iteracion
    hojas = sortrows( hojas , 3 );
    % Obtengo el mejor costo
    mejorCosto = hojas(1,3);
    % Reconstruyo el mejor camino
    mejorCamino = [hojas(1,2)];
    padre = hojas(1,1);
end

while padre ~= 0
    mejorCamino = [matrizConexiones(padre,3) mejorCamino];
    padre = matrizConexiones(padre,1);
end
end

