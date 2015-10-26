function [costo,camino] = busquedaCompleta( padre , nodos_nr , datos, raiz )
    if size(nodos_nr,2) == 1
            costo = datos(raiz,nodos_nr);
            camino = [nodos_nr raiz];
    else
            nodos_nr(nodos_nr==padre) = [];
            [~,index] = sort( datos( padre , nodos_nr ) );
            nodos_nr = nodos_nr(index);
            caminosHijos=[];
            for i = 1 : size(nodos_nr,2)
                    %[costosHijos,caminoHijo] = costoUniforme( nodos_nr(i) , nodos_nr , datos );
                    [costos(i),caminosHijos(i,:)] = busquedaCompleta( nodos_nr(i) , nodos_nr , datos,raiz );
                  %  costos(i) = costosHijos + datos( padre , nodos_nr(i) );
            end
            caminos = [repmat(padre,size(caminosHijos,1),1) caminosHijos];
            costos= costos+datos( padre , nodos_nr );
            [costo, index] = min(costos) ;
            camino = caminos(index,:);
    end
end