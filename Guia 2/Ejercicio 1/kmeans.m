%Para probar:
%     archivo='Xor_trn';
%     k=4;
%     cant_salidas=1;
%     medias=zeros(k,2);
function [medias,M_sigma] = kmeans(archivo,k,cant_salidas)
    datos = csvread( archivo );
    [f,c] = size( datos );
    index = round(1+(k-1).*rand(f,1));
    datos = [ index  datos ];
    % Instancio una bandera en verdadero
    cambio = true;
    medias=zeros(k,c-cant_salidas);
    while( cambio )
        cambio = false;
        % medias
        for i=1:k
            conjuntoi=datos(datos(:,1)==i,2:end-cant_salidas);
            if (isempty(conjuntoi))
                 medias(i,:)=rand(1,c-cant_salidas)-0.5;
            else
                medias(i,:) = median(conjuntoi); 
            end
        end
        %  Reasignacion
        for i=1:f
            patron = datos(i,2:end-cant_salidas);
            % Calculo la distancia del patron a cada vector de medias
            for j=1:k
                distancia(j) = sum((patron - medias(j,:)).^2);
            end
            [~,g] = min(distancia);
            if( g ~= datos(i,1) )
                datos(i,1) = g;
                % Como hubo cambio, debo seguir entrenando
                cambio = true;
            end
        end
        % ================================================================
    end
    M_sigma=varianzas_RBF(datos(:,1:end-cant_salidas), medias); 
    
    % ============ Grafico los datos del XOR =======================
%     figure(2);
%     hold on
%     scatter(datos(datos(:,1)==1,2),datos(datos(:,1)==1,3),'blue');
%     scatter(datos(datos(:,1)==2,2),datos(datos(:,1)==2,3),'red');
%     scatter(datos(datos(:,1)==3,2),datos(datos(:,1)==3,3),'green');
%     scatter(datos(datos(:,1)==4,2),datos(datos(:,1)==4,3),'black');
%     scatter(medias(:,1),medias(:,2),10,'yellow','fill');
%     figure(3);
    % ============================================================
end