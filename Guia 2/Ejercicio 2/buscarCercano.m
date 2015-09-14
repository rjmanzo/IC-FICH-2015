% ============ ENTRADAS
% W -> cell con los pesos de las neuronas
% patron -> patron con el que comparar
% ============ SALIDA
% f -> fila de la neurona mas cercana
% c -> columna de la neurona mas cercana
function [f,c] = buscarCercano( W , patron )
    % Calculo la diferecia con cada elemento de la celda
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false );
    % Calculo la norma de cada vector de la celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false );
    % Convierto la celda a matriz
    D = cell2mat(D);
    % Busco el minimo de la matriz
    [v,f] = min(D);
    % Busco el minimo de el vector
    [v,c] = min(v);
    f = f(c);
end