
function [mejorCamino,mejorCosto]=colonia_hormigas(path_archivo,nodo_i,b,p,alpha,beta)
	% Leo los datos
	datos = csvread(path_archivo);
	% Inicializo la cantidad de feromonas
	feromonas = b*rand(size(datos));
	% matriz auxiliar
	aux = zeros(size(feromonas));
	% Costo del mejor camino
	mejorCosto = distancia( [nodo_i setdiff( randperm(size(datos,1) ) , nodo_i ) nodo_i] , datos );
	% Mejor camino
	mejorCamino = zeros(1,size(datos,1)+1);
	% Mientras varie la matriz de feromonasd entre iteraciones
	while sum( sum( feromonas) ) -  aux ~= 0
			% Guardo la matriz de feromonas
			aux = sum( sum( feromonas ) );
			% Inicializo los caminos
			caminos = zeros(N,size(datos,1)+1);
			% Inicializo los costos
			costos = zeros(N,1);
			% Para todas las hormigas busco el camino
			for k = 1 : N
					% Ubico la hormiga en el nodo inicial
					camino = [nodo_i];
					nodos_nr = [1:size(datos,1)];
					nodos_nr(nodo_i) = [];
					while size(nodos_nr,2) ~= 0
							prob = [];
							% Calculo las probabilidades
							for j = nodos_nr
									numerador = feromonas( camino( end ) , j ) ^ alpha / datos( camino( end ) , j ) ^ beta;
									denominador = sum( feromonas( camino( end ) , nodos_nr ) .^ alpha ./ datos( camino( end ) , nodos_nr ) .^ beta  );
									prob(j) = numerador / denominador;
							end
							% Acumulo
							prob = cumsum(prob(prob~=0));
							% Tiro un valor al azar
							a = rand;
							% Veo a que nodo corresponde
							prox = buscar(prob,a);
							% Agrego el nodo al camino
							camino = [camino nodos_nr(prox)];
							% Lo elimino de los nodos recorridos
							nodos_nr(prox) = [];
					end
					% Le agrego la vuelta al nodo inicial
					camino = [camino nodo_i];
					% Le agergo el costo a la lista de costos
					costos(k) = distancia(camino,datos);
					% Le agrego el camino a la lista de caminos
					caminos(k,:) = camino;
			end
			% Elimino feromonas por evaporacion
			feromonas = (1-p)*feromonas;
			% Agrego feromonas segun la importancia de la conexion
			for i = 1 : size(caminos,1)
					for j = 1 : size(caminos,2)-1
						   feromonas( caminos(i,j) , caminos(i,j+1) ) = feromonas( caminos(i,j) , caminos(i,j+1) ) + Q/datos( caminos(i,j) , caminos(i,j+1) );
					end
			end
	%         drawnow;
	%         imagesc(feromonas);
			% Busco el camino de menor costo
			[val,index] = min( costos );
			% Si es mejor que el que ya tenia, lo cambio y guardo el mejor camino
			if mejorCosto > val
				mejorCosto = val;
				mejorCamino = caminos(index,:);
			end
	end
end

