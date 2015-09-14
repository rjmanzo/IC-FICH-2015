% ============ ENTRADAS
% fn -> fila de la neurona ganadora
% cn -> columna de la neurona ganadora
% vec -> vecindad
% est -> estructura del SOM
% ============ SALIDA
% ar -> limite superior
% ab -> limite inferior
% li -> limite izquierdo
% de -> limite derecho
function [ar,ab,iz,de] = validarLimite( fn , cn , vec , est )
    % Valido el limite superior
    ar = round(fn-vec);
    if ar < 1 
        ar = 1;
    end
    % Valido el limite inferior
    ab = round(fn+vec);
    if ab > est(1)
        ab = est(1);
    end
    % Valido el limite izquierdo
    iz = round(cn-vec);
    if iz < 1
        iz = 1;
    end
    % Valido el limite derecho
    de = round(cn+vec);
    if de > est(2)
        de = est(2);
    end
end