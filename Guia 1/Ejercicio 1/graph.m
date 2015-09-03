%graph(graph_title,W,M,2, 0.2, 5)
function graph(graph_title,W,M,range, step, tam_puntos)
        color=zeros(length(M),3); %todos los puntos en negro
        color(M(:,end)==1,2)=1; %La clase 1 es verde
        color(M(:,end)==-1,1)=1; %La clase 2 es Rojo
      
            x_graph=-range:step:range; %Rango para graficar        
            scatter(M(:,2),M(:,3),tam_puntos,color);
            hold on
            y_graph=W(1)/W(3)*(-1)*M(1,1)-(W(2)/W(3))*x_graph;% Multiplico por M(1,1) dado que este valor me modifica la ordenada a origen
            plot(x_graph,y_graph);
            axis([-range range -range range])
            xlabel('X1');
            ylabel('X2');
            title(graph_title);
            drawnow;
            hold off
            grid on
end