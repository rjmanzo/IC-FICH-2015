% ============= ENTRADAS
% vector = Vector acumulado
% valor   = Valor para el que se buscar intervalo
% ============= SALIDAS
% indice = indice del nodo al que corresponde
function [indice] = buscar( vector , valor )
        indice = 1;
        for i = 1 : length(vector)-1
                if valor > vector(i) && valor < vector(i+1)
                    indice = i+1;
                end
        end 
end