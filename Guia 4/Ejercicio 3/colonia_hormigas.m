function [mejorCamino,mejorCosto]=colonia_hormigas(path_archivo,nodo_i,N,b,p,alpha,beta,Q)
	datos = csvread(path_archivo);
	feromonas = b*rand(size(datos)); %feromonas al azar
	aux = zeros(size(feromonas)); %auxiliar de feromonas
	% Costo del mejor camino ->setdiff(A,B): datos de A que no estan en B 
	mejorCosto = distancia( [nodo_i setdiff( randperm(size(datos,1) ) , nodo_i ) nodo_i] , datos );
	% Mejor camino
	mejorCamino = zeros(1,size(datos,1)+1);
	while sum( sum( feromonas) ) -  aux ~= 0	% Mientras varie la matriz de feromonasd entre iteraciones
			aux = sum( sum( feromonas ) );
			caminos = zeros(N,size(datos,1)+1); %caminos todos vacios
			costos = zeros(N,1); %costo todo cero 
			for k = 1 : N %para cada hormiga k=1,2... N
					camino = [nodo_i]; %hormiga en el inicio
					nodos_nr = [1:size(datos,1)];
					nodos_nr(nodo_i) = []; %nodos no recorridos
					while size(nodos_nr,2) ~= 0
							probabilidad = [];
							% Calculo las probabilidades
							for j = nodos_nr
									numerador = feromonas( camino( end ) , j ) ^ alpha / datos( camino( end ) , j ) ^ beta;
									denominador = sum( feromonas( camino( end ) , nodos_nr ) .^ alpha ./ datos( camino( end ) , nodos_nr ) .^ beta  );
									probabilidad(j) = numerador / denominador;
							end
							
							probabilidad = cumsum(probabilidad(probabilidad~=0));
							a = rand;% valor azar que me retorna en que rango voy a caer
							prox = buscar(probabilidad,a); %me retorna el indice
							camino = [camino nodos_nr(prox)]; %agrego nodo al camino(agrego un paso al camino)
							nodos_nr(prox) = []; %lo borro de nodos recorridos
                    end %hasta que nodos no recorridos sea cero                    
					camino = [camino nodo_i]; %vuelta al nodo inicial
					costos(k) = distancia(camino,datos); %se agrega el costo del camino encontrado para hormiga k
					caminos(k,:) = camino; %agregar camino de la hormiga k a la lista de caminos
            end     
            %para cada conexion i,j se reduce la feromona
			feromonas = (1-p)*feromonas; %eliminar por evaporacion			
			[n,m]=size(caminos);
            for i = 1 : n% depositar feromonas segun la importancia(bondad) de la conexion(camino)
					for j = 1 : m-1
						   feromonas( caminos(i,j) , caminos(i,j+1) ) = feromonas( caminos(i,j) , caminos(i,j+1) ) + Q/datos( caminos(i,j) , caminos(i,j+1) );
					end
			end
	%         drawnow;
	%         imagesc(feromonas);
			
			[val,index] = min( costos );% camino de menor costo
			
			if mejorCosto > val % si mejoro se actualiza
				mejorCosto = val;
				mejorCamino = caminos(index,:);
			end
	end
end

