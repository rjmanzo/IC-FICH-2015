% ============ ENTRADAS
% patrones -> patrones a graficar
function graficar( patrones )
    % Me fijo el tama�o de la matriz
    [n,m] = size(patrones);
    figure('Name','SOM: Conjunto de patrones clasificados');
    axis([-2 2 -2 2]);
    for i=1:n
        % Dibujo el patron
        scatter(patrones(i,1),patrones(i,2),36,'red');
        hold on;
    end
end