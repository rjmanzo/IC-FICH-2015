function [medias,M_sigma] = kmeans(archivo,k,cant_salidas)
    patrones = csvread( archivo );
    [n,m] = size( patrones );
    % Genero un vector columna con valores entre 1 y k con n elementos
    index = round(1+(k-1).*rand(n,1));
    patrones = [ index  patrones ];
    cambio = true;
    medias=zeros(k,m-cant_salidas);
    while(cambio)
        % Cambio la bandera a falso
        cambio = false;
        for i=1:k
            conjuntoi=patrones(patrones(:,1)==i,2:end-cant_salidas);
            if (isempty(conjuntoi))
                 medias(i,:)=rand(1,m-cant_salidas)-0.5;%Conjunto al azar. Puede caer cerca de un conj. ya asignado
            else
                medias(i,:) = median(conjuntoi); 
            end
        end
        for i=1:n
            patron = patrones(i,2:end-cant_salidas);
            % Calculo la distancia del patron a cada vector de medias
            for j=1:k
                distancia(j) = sum((patron - medias(j,:)).^2);
            end
            [~,g] = min(distancia);
            % Pregunto si cambia de grupo
            if( g ~= patrones(i,1) )
                % Si cambió de grupo, hago el cambio
                patrones(i,1) = g;
                % Como hubo cambio, debo seguir entrenando
                cambio = true;
            end
        end
        % ================================================================
    end
    M_sigma=varianzas_RBF(patrones(:,1:end-cant_salidas), medias); %calculo varianza    
    
%     % ============ Grafico los patrones del XOR =======================
    %Original
%     figure('Name','Original');
%     title('Original');
%     hold on
%     scatter(patrones(patrones(:,4)==-1,2),patrones(patrones(:,4)==-1,3),'red');
%     scatter(patrones(patrones(:,4)==1,2),patrones(patrones(:,4)==1,3),'blue');
%     scatter(medias(:,1),medias(:,2),10,'yellow','fill');
%     
%     %Respuesta RBF
%     figure('Name','Respuesta RBF');
%     title('Respuesta RBF');
%     hold on
%     scatter(patrones(patrones(:,1)==1,2),patrones(patrones(:,1)==1,3),'magenta');
%     scatter(patrones(patrones(:,1)==2,2),patrones(patrones(:,1)==2,3),'green');
%     scatter(patrones(patrones(:,1)==3,2),patrones(patrones(:,1)==3,3),'blue');
%     scatter(patrones(patrones(:,1)==4,2),patrones(patrones(:,1)==4,3),'black');
%     scatter(medias(:,1),medias(:,2),10,'yellow','fill');
% %     % ============================================================
        
end