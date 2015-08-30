% Funcion de test para perceptron multicapa------
function [tasa_e,tasa_a]=mlp_ejer3_t(archivo,W,neuronas)
    %Inicializacion:
    capas=length(neuronas);
    cant_salidas=neuronas(end);
    patrones_entr=load(archivo); 
    [tasa_e,tasa_a,Yp,V]=calc_error(W,patrones_entr,capas,cant_salidas);
    %Graficamos clasificacion con los patrones de Test
    graph_mlp(V,patrones_entr,'Graficamos clasificacion con los patrones de Test');
end