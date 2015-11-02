function graficarFunciones(f,f2,L,aptitudRequerida)
    if(length(L)==2)
        figure('Name','funcion x','NumberTitle','off')
        subplot(2,1,1)
        x2=L(1):0.2:L(2);
        plot(x2,f(x2));
        hold on
        plot([L(1) L(2)],[aptitudRequerida aptitudRequerida],'r')
        subplot(2,1,2)
        x2=L(1):0.2:L(2);
        plot(x2,f2(x2));
        drawnow;
    elseif (length(L)==4)
        figure('Name','funcion xy','NumberTitle','off')
        subplot(2,1,1)        
        [x2,y2]=meshgrid(L(1):1:L(2),L(3):5:L(4));
        mesh(x2,y2,f(x2,y2),'FaceColor','interp')
        title('aptitud')
        hold on
        subplot(2,1,2)
        [x2,y2]=meshgrid(L(1):1:L(2),L(3):5:L(4));
        mesh(x2,y2,f2(x2,y2),'FaceColor','interp')
        title('funcion')
    end
end

