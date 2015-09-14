% ============ ENTRADAS
% datos -> datos a graficar
function graficar( datos )
    % Me fijo el tamaño de la matriz
    [f,c] = size(datos);
    figure(2);
    axis([-2 2 -2 2]);
    for i=1:f
        % Dibujo el patron
        scatter(datos(i,1),datos(i,2),36,'red');
        hold on;
    end
end