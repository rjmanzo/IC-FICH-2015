function graphSOM( W )
    [n,m] = size(W);
    figure(1);
    for i=1:n
        for j=1:m
            p = W{i,j};%neurona
            % Dibujo el patron
            scatter(p(1),p(2),36,'blue','o','fill');
            hold on;
            if i ~= n %ultima fila?
                % Si no estoy, agarro la neurona de abajo
                p_a = W{i+1,j};
                plot( [p(1) p_a(1)] , [p(2) p_a(2)] , 'red');  %linea entre ellos             
            end
            if j ~= m %ultima columna
                % Si no estoy, agarro la neurona de la derecha
                p_d = W{i,j+1};
                plot( [p(1) p_d(1)] , [p(2) p_d(2)] , 'red');   %linea entre ellos            
            end
        end
    end
    hold off;
end