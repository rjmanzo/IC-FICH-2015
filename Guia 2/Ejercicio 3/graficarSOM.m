% ============ ENTRADAS
% W -> cell con los pesos de las neuronas
function graficarSOM( W )
    % Me fijo el tamaño de la celda
    [f,c] = size(W);
    figure(1);
    for i=1:f
        for j=1:c
            % Me quedo con la neurona
            p = W{i,j};
            % Dibujo el patron
            scatter(p(1),p(2),36,'blue','o','fill');
            hold on;
            % Me fijo si no estoy en la ultima fila
            if i ~= f
                % Si no estoy, agarro la neurona de abajo
                p_a = W{i+1,j};
                % Grafico una linea entre estos 2
                plot( [p(1) p_a(1)] , [p(2) p_a(2)] , 'red');               
            end
            % Me fijo si no estoy en la ultima columna
            if j ~= c
                % Si no estoy, agarro la neurona de la derecha
                p_d = W{i,j+1};
                % Grafico una linea entre estos 2
                plot( [p(1) p_d(1)] , [p(2) p_d(2)] , 'red');               
            end
        end
    end
    hold off;
end