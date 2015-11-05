function [costo] = distancia( camino , datos )
    costo = 0;
    for i = 1 : size(camino,2)-1
        nodo_i = camino(i);%nodo i
        nodo_f = camino(i+1);%nodo siguiente
        costo = costo + datos(nodo_i,nodo_f); %sumo distancias
    end
end