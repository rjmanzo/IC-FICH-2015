% filaGanadora -> fila derecha la neurona ganadora
% colGanadora -> columna derecha la neurona ganadora
function [arriba,abajo,izquierda,derecha] = Limites( filaGanadora , colGanadora , vecindad , matris_som )
    % Valido el limite superior
    arriba = round(filaGanadora-vecindad);
    if arriba < 1 
        arriba = 1;
    end
    % Valido el limite inferior
    abajo = round(filaGanadora+vecindad);
    if abajo > matris_som(1)
        abajo = matris_som(1);
    end
    % Valido el limite izquierdo
    izquierda = round(colGanadora-vecindad);
    if izquierda < 1
        izquierda = 1;
    end
    % Valido el limite derecho
    derecha = round(colGanadora+vecindad);
    if derecha > matris_som(2)
        derecha = matris_som(2);
    end
end