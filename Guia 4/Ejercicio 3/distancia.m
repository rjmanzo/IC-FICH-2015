% ========== ENTRADA
% camino = vector con el camino hecho
% datos  = matriz con las distancias
% ========== SALIDA
% costo  = Distancia total del camino recorrido
% ==========
function [costo] = distancia( camino , datos )
    % Inicializo el costo
    costo = 0;
    for i = 1 : size(camino,2)-1
        % Nodo inicio
        nodo_i = camino(i);
        % Nodo final
        nodo_f = camino(i+1);
        % Acumulo la distancia
        costo = costo + datos(nodo_i,nodo_f);
    end
end