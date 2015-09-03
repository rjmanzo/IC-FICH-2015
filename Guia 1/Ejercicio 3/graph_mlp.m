function graph_mlp(Y,M,tituloFig)   
    tam=10; %Tamaño de puntos
    [NaN, Dim]=size(M);
    [NaN, Cant_salidas]=size(Y);
    Dim=Dim-1;
    if (Dim==2 && Cant_salidas==1)%Solo se grafica si los datos pueden ser representados en 2D
       figure('Name',tituloFig,'NumberTitle','off')
        color=zeros(length(M),3); %color de puntos RGB inicializados con negro
        color(M(:,end)==1,3)=1;  %La clase 1 es azul
        color(M(:,end)==-1,1)=1; %La clase 2 es roja
        subplot(1,2,1);
        % scatter3(X,Y,Z,S,C) . C=color, S tamaño de circulo
        scatter(M(:,1),M(:,2),tam,color);
        title('Clasificación real');
        xlabel('X1')
        xlabel('X2')
        color=zeros(length(M),3); %color de puntos RGB inicializados con negro
        color(Y==1,3)=1;  %La clase 1 es azul
        color(Y==-1,1)=1; %La clase 2 es Roja
        %mal clasificados magenta
        subplot(1,2,2);
        scatter(M(:,1),M(:,2),tam,color);
        title('Clasificación obtenida');
        xlabel('X1')
        xlabel('X2')
    end    
end
