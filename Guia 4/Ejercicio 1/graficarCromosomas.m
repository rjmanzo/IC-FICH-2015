function graficarCromosomas (fitness,f2,mejorAptitud,posMejor,x,t)
    pause(t)
    global grafCromo
    delete(grafCromo)
    %Graficar:
    if(size(x,2)==1)
        figure(1)
        subplot(2,1,1)
        grafCromo(1)=scatter(x,fitness,600,'.');
        grafCromo(2)=scatter(x(posMejor),mejorAptitud,600,[1 0 0]);
        subplot(2,1,2)
        hold on
        grafCromo(3)=scatter(x,f2(x),600,'.');
        grafCromo(4)=scatter(x(posMejor),f2(x(posMejor)),600,[1 0 0]);
    elseif(size(x,2)==2)
        figure(1)
        subplot(2,1,1)
        grafCromo(1)=scatter3(x(:,1),x(:,2),fitness,600,'.');
        grafCromo(2)=scatter3(x(posMejor,1),x(posMejor,2),mejorAptitud,600,[1 0 0]);
        subplot(2,1,2)
        hold on
        grafCromo(3)=scatter3(x(:,1),x(:,2),f2(x(:,1),x(:,2)),600,'.');
        grafCromo(4)=scatter3(x(posMejor,1),x(posMejor,2),f2(x(posMejor,1),x(posMejor,2)),600,[1 0 0]);
    end
    drawnow;
end

