function [S_act] = activacion_conjuntos_salida(p_mean,S)
% Dependiendo del valor promedio de los puntos P1 y P2, determino que
% reglas del conj. borroso de salida le corresponde el mapea

if(p_mean ==0 || p_mean<=50)
    S_act = [S(1,1) S(1,2);
        S(2,1) S(2,2);
        0 0];
else if(p_mean >50 || p_mean<=100)
        S_act = [S(1,1) S(1,2);
            S(2,1) S(2,2);
            S(3,1) S(3,2)];
    else if(p_mean >100 || p_mean<=150)
            S_act = [S(2,1) S(2,2);
                S(3,1) S(3,2);
                S(4,1) S(4,2)];
        else if(p_mean >150 || p_mean<=200)
                S_act = [S(2,1) S(2,2);
                    S(3,1) S(3,2);
                    S(4,1) S(4,2)];
            else if(p_mean >150 || p_mean<=200)
                    S_act = [0 0;
                        S(3,1) S(3,2);
                        S(4,1) S(4,2)];
                end
            end
        end
    end
end

end

