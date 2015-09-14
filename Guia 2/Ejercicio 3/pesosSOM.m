% ============ ENTRADAS
% est -> [m n] tamaño del SOM
% datos -> matriz de datos 
% caso -> manera de generar los pesos
%       1 - al azar
%       2 - eligiendo patrones al azar
% ============ SALIDA
% W -> celda que contiene un vector de pesos para cada neurona
function [W] = pesosSOM( est , datos , caso )
    % Segun caso eligo una u otra manera de generar los pesos
    switch caso
        case 1
            % Si es 1 los genero al azar
            [W] = pesosSOMazar( est , datos );
        case 2
            % Si es 2 tomo patrones al azar
            [W] = pesosSOMpatron( est , datos );
        otherwise
            % Cualquier otro caso error
            disp('Error');
    end
end