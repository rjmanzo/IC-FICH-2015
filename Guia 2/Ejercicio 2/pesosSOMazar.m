% ============ ENTRADAS
% est -> [m n] tamaño del SOM
% datos -> matriz de datos 
% ============ SALIDA
% W -> celda que contiene un vector de pesos para cada neurona
function [W] = pesosSOMazar( est , datos )
    % Me fijo el tamaño de la matriz de datos
    [~,c] = size( datos );
    % Creo la celda
    W = cell( est(1) , est(2) );
     for i=1:est(1)
         for j=1:est(2)
             % Genero al azar cada vector de pesos
            W{i,j} = -0.5 + rand(1,c);
         end
     end
end