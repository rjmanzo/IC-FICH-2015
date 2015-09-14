% ============ ENTRADAS
% est -> [m n] tamaño del SOM
% datos -> matriz de datos
% ============ SALIDA
% W -> celda que contiene un vector de pesos para cada neurona
function [W] = pesosSOMpatron( est , datos )
    % Me fijo el tamaño de la matriz de datos
    [f c] = size( datos );
    % Creo la celda
    W = cell( est(1) , est(2) );
    for i=1:est(1)
       for j=1:est(2)
           % Eligo un patron al azar
           W{i,j} = datos(round((f-1)*rand(1)+1),:);
       end
    end
end