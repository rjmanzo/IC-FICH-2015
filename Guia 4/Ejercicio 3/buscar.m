function [indice] = buscar( vector , valor ) %vector de prob acumuladas, valor: valor que el que busca intervalo
        indice = 1;
        for i = 1 : length(vector)-1
                if valor > vector(i) && valor < vector(i+1)
                    indice = i+1; %indice = indice del nodo al que corresponde
                end
        end 
end