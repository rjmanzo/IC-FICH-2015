function [n,x] = gradienteDescendiente(f,Rango,maximoIteraciones,a,b,tolerancia)   
    %{
        f=-x.*sin(sqrt(abs(x)));
        Rango=[-512 512];
        maximoIteraciones=200;
        a=2; %prioriza el valor de la derivada
        b=1; %prioriza la diferencia de las derivadas
        tolerancia=0.01; %Se busca obtener un minimo con determinada tolerancia
    %}
    tic
    dfx=diff(f,'x');
    p=rand();
    x=p*Rango(2)+Rango(1)*(1-p);
    n=1; 
    dfxEnX=double(subs(dfx,x));
    dfxEnXAnt=dfxEnX;

    %Primer grafica:
    paso=(Rango(2)-Rango(1))/100;
    x2=Rango(1):paso:Rango(2);
    plot(x2,double(subs(f,x2)));
    hold on
    grafica=scatter(x,subs(f,x),600,'.');

    while (n<maximoIteraciones && ( dfxEnX>0+tolerancia || dfxEnX<0-tolerancia) && x>=Rango(1) && x<=Rango(2))
        alpha=dfxEnX-dfxEnXAnt;
        x=x-a*dfxEnX+b*alpha;
        dfxEnXAnt=dfxEnX;
        dfxEnX=double(subs(dfx,x));
        n=n+1;

        pause(0.5)
        delete(grafica);
        grafica=scatter(x,double(subs(f,x)),600,'.');
        drawnow;
    end
toc
end

