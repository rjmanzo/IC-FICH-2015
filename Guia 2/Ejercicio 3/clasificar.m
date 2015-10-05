function [tasa_a] = clasificar(archivo,W,clases)
    patrones = csvread( archivo);
    [fd,~] = size(patrones);
    tasa_a = 0;%tasa en cero al inicio    
    for i=1:fd% Para cada patron buscamos el cercano        
        patron = patrones(i,1:end-1); % Seleccionamos el patron     
        salida = patrones(i,end);   % Seleccionamos la salida de ese patron      
        [filaGanadora,colGanadora] =  coord_de_ganadora( W , patron ); %ganadora
        % Selecciono la etiqueta de la neurona ganadora
        etiqueta = clases(filaGanadora,colGanadora);       
        if etiqueta == salida % si acerto cuento
            tasa_a = tasa_a + 1 ;
        end
    end
    % Divido por la cantidad de muestras
    tasa_a = tasa_a/fd;
end

function [fila_neurona,col_neurona] = coord_de_ganadora( W , patron )
    D = cellfun( @(x) patron-x , W , 'UniformOutput' , false ); % diferencia a cada elemento de celda
    D = cellfun( @(x) norm(x) , D , 'UniformOutput' , false ); %distancia a cada vector de la celda
    D = cell2mat(D);
    [v,fila_neurona] = min(D); %minimo de la matriz
    [v,col_neurona] = min(v); %minimo del vector
    fila_neurona = fila_neurona(col_neurona);
end