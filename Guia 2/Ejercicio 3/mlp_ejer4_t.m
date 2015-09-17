% Funcion de test para perceptron multicapa------
function [tasa_e,tasa_a]=mlp_ejer4_t(archivo,W,neuronas)
    %Inicializacion:
    capas=length(neuronas);
    cant_salidas=neuronas(end);
    patrones_entr=load(archivo); 
    [tasa_e,tasa_a,Yp,V]=calc_error_ejer4(W,patrones_entr,capas,cant_salidas);
    %Graficamos clasificacion con los patrones de Test
    %graph_mlp_ejer4(V,patrones_entr,'Graficamos clasificacion con los patrones de Test');
end