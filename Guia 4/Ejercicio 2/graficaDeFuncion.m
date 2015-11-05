function[intervalo]=graficaDeFuncion(numeroFuncion)
switch(numeroFuncion)
    case 1
        ini=-512;fin=512;
        paso=100;
    case 2
        ini=0;fin=20;
        paso=2;
    otherwise
        ini=-100;fin=100;
        paso=100;        
end
intervalo=[ini;fin];
delta=ini:paso/fin:fin-paso/fin;

if numeroFuncion==3    
    intervalo=[intervalo intervalo];
    for i=1:length(delta)
        Z(:,i)=aplicar_funcion(numeroFuncion,[delta; repmat(delta(i),1,length(delta))]);
    end
    [X,Y]=meshgrid(delta,delta);
    mesh(X,Y,Z);
    xlabel('X'),ylabel('Y'),zlabel('F(X,Y)');
    hold on
else
    Z=aplicar_funcion(numeroFuncion,delta);
    plot(delta,Z);
    hold on
    xlabel('X'),ylabel('F(X)');
end
title('Posiciones de particulas');
       
end