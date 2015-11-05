function [mejorCamino,mejorCosto]=busqueda_costo_uniforme(path_archivo,nodoRaiz)
% Leo los datos
datos = csvread(path_archivo);

% Me fijo la cantidad de nodos
cantNodos = size(datos,1);

% Inserto el nodo raiz en la matriz de conexiones
% [  padre   -- nodosNorecorridos   --  nodos  --     distancias acumuladas]
matrizConexiones(1,:) = [ 0 1 nodoRaiz 0 ];

% Vector con los nodos no recorridos
nodosNoRecorridos = [1:cantNodos];

% Elimino el nodoRaiz de los nodosNoRecorridos
nodosNoRecorridos( nodosNoRecorridos == nodoRaiz ) = [];

% Expando el nodo raiz [         nodosNorecorridos   --  nodos  --     distancias acumuladas]
hojas(1:length(nodosNoRecorridos),:) = [ ones(length(nodosNoRecorridos),1)  nodosNoRecorridos' datos(nodoRaiz,nodosNoRecorridos)'];

% Reordeno la matriz de hojas en base a las distancias acumuladas
hojas = sortrows( hojas , 3 );

while hojas(1,2) ~= nodoRaiz % cuando el proximo a expandir sea el el raiz donde inicie corto
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
    nodosNoRecorridos = [1:cantNodos];%todos los nodos
    nodosNoRecorridos = setdiff( nodosNoRecorridos , camino );%elimino nodos que ya pase
    % Me fijo si el vector de nodos no recorridos quedo vacio
    if size(nodosNoRecorridos,2) == 0
        % Si quedo vacio llegue al nodo objetivo
        hojas = [ hojas; matrizConexiones(end,2) nodoRaiz matrizConexiones(end,4)+datos(matrizConexiones(end,3),nodoRaiz)];
    else
        % Expando ese
        % nodo------------------------------------------------------------------------------------acumulo_distancias_desde_nodo_expandido_a_origen
        hojas = [ hojas; repmat( matrizConexiones(end,2) , length(nodosNoRecorridos) , 1 ) nodosNoRecorridos' matrizConexiones(end,4)+datos(matrizConexiones(end,3),nodosNoRecorridos)'];
    end
    
    hojas = sortrows( hojas , 3 );%ordeno hojas segun columna 3 (distancia acumulada) de menor a mayor
    mejorCosto = hojas(1,3);%costo mejor
    mejorCamino = [hojas(1,2)]; %nodo que es el mejor camino (contruyo mejor camino)
    padre = hojas(1,1);
end

while padre ~= 0
    mejorCamino = [matrizConexiones(padre,3) mejorCamino];
    padre = matrizConexiones(padre,1);
end
end

