function[]=graficar_particulas(intervalo,posiciones,valores)
    global grafPartic
    delete(grafPartic)
    if(size(posiciones,1)==2)
        grafPartic=scatter3(posiciones(1,:),posiciones(2,:),valores,500,'*');
        hold on
        axis([intervalo(:,1)' intervalo(:,2)']);
    else
        grafPartic=scatter(posiciones,valores,20,'*');
        hold on
        if(intervalo(2)==512)
            axis([intervalo(1) intervalo(2) -500 500]);
        else
            axis([intervalo(1) intervalo(2) -20 50]);
        end
    end
    drawnow
end