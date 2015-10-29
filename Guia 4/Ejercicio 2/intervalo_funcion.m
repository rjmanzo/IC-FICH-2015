%Funciones: Eligo las funciones a aplicar al modelo
function[intervalo]=seleccion_funcion(Nfunc)
switch(Nfunc)
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

%Establesco el intervalo de la funcion dependiendo de la seleccion
intervalo=[ini;fin];
delta=ini:paso/fin:fin-paso/fin;

if Nfunc==3    
    intervalo=[intervalo intervalo];
    for i=1:length(delta)
        Z(:,i)=aplicar_funcion(Nfunc,[delta; repmat(delta(i),1,length(delta))]);
    end
    [X,Y]=meshgrid(delta,delta);
    mesh(X,Y,Z);
    xlabel('x'),ylabel('y'),zlabel('f(x,y)');
    hold on
else
    Z=aplicar_funcion(Nfunc,delta);
    plot(delta,Z);
    hold on
    xlabel('x'),ylabel('f(x)');
end

title('Posiciones de particulas');
       
end