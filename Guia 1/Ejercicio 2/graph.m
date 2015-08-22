%graph(graph_title,W,M,2, 0.2, 5)
function graph(graph_title,W,M,range, step, tam_puntos)
        color=zeros(length(M),3); %todos ceros (negro)
        color(M(:,end)==1,2)=1; %La clase 1 es verde
        color(M(:,end)==-1,3)=1; %La clase 2 es celeste
        color(M(:,end)==-1,2)=1;
         
        [x1,x2]=meshgrid(-range:step:range); %Rango para graficar
        % scatter3(X,Y,Z,S,C) . C=color, S tamaño de circulo
        scatter3(M(:,2),M(:,3),M(:,4),tam_puntos,color);
            hold on
            x3=W(1)/W(4)-(W(2)/W(4))*x1-(W(3)/W(4))*x2;
            surf(x1,x2,x3,'FaceColor','interp')
            axis([-range range -range range -range range]) % ejes del cubo
            xlabel('X1');
            ylabel('X2');
            zlabel('X3');
            title(graph_title);
            drawnow;
            hold off
            grid on
            
end