function graph_mlp(Y,M)   
%     Parámetros:
%         Y   ->  Salida obtenida
%         M   ->  Matriz con entradas y salida esperada
    tam=10; %Tamaño de puntos
    [NaN, Dim]=size(M);
    [NaN, Cant_salidas]=size(Y);
    Dim=Dim-1;
    if (Dim==2 && Cant_salidas==1)%Solo se grafica si los datos pueden ser representados en 2D
        figure;
        color=zeros(length(M),3); %color de puntos RGB inicializados con negro
        color(M(:,end)==1,2)=1;  %La clase 1 es verde
        color(M(:,end)==-1,1)=1; %La clase 2 es Roja
        subplot(1,2,1);
        scatter(M(:,1),M(:,2),tam,color);
        title('Clasificación real');
        xlabel('X1')
        xlabel('X2')
        color=zeros(length(M),3); %color de puntos RGB inicializados con negro
        color(Y==1,2)=1;  %La clase 1 es verde
        color(Y==-1,1)=1; %La clase 2 es Roja
        %Como color no se inicializa con cero antes de asignar nuevamente
        %los colores, quedan con color amarillo los puntos que fueron mal
        %clasificados
        subplot(1,2,2);
        scatter(M(:,1),M(:,2),tam,color);
        title('Clasificación obtenida');
        xlabel('X1')
        xlabel('X2')
    end    
end
