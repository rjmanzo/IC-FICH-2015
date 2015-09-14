% ============ ENTRADAS
% archivo -> nombre del archivo con los datos
% W -> celda con los vectores de pesos finales
% clases -> matriz con la etiqueta de cada neurona
% ============ SALIDA
% ta -> tasa de acierto del SOM
function [ta] = clasificar(archivo,W,clases)
    % Leo el archivo
    datos = csvread( strcat( 'Datos/' , archivo , '.csv' ) );
    % Me fijo la cantidad de datos
    [fd,~] = size(datos);
    % Inicializo la taza de acierto en 0
    ta = 0;
    % Para cada patron busco el cercano
    for i=1:fd
        % Selecciono el patron
        patron = datos(i,1:end-1);
        % Selecciono la salida de ese patron
        salida = datos(i,end);
        % Busco la neurona ganadora
        [fg,cg] = buscarCercano( W , patron );
        % Selecciono la etiqueta de la neurona ganadora
        et = clases(fg,cg);
        % Me fijo si acerto
        if et == salida
            ta = ta + 1 ;
        end
    end
    % Divido por la cantidad de muestras
    ta = ta/fd;
end