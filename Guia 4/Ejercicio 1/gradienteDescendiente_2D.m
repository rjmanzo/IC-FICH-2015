function [n,X,Y]= gradienteDescendiente_2D(f,Rango,iteracionesMaximas,a,b,tolerancia)
%Nota:podria terminar al encontrar un maximo
tic
syms x y;
%derivadas
dfx=diff(f,'x'); 
dfy=diff(f,'y'); 
p=rand();
p2=rand();
X=p*Rango(2)+Rango(1)*(1-p); 
Y=p2*Rango(3)+Rango(4)*(1-p2);
n=1; %Iteraciones
dfEval=[double(subs(dfx,[x y],[X Y])) ; double(subs(dfy,[x y],[X Y]))];
dfEvalAnt=dfEval;

%Primer grafica:
paso=(Rango(2)-Rango(1))/100;
[X2,Y2]=meshgrid(Rango(1):paso:Rango(2),Rango(3):paso:Rango(4));
mesh(X2,Y2,(X2.^2+Y2.^2).^0.25.*((sin(50*(X2.^2+Y2.^2).^0.1)).^2+1));
hold on
grafica=scatter3(X,Y,subs(f,[x y],[X Y]),1200,'.');

while (n<iteracionesMaximas && ( dfEval(1)>0+tolerancia || dfEval(1)<0-tolerancia) && ( dfEval(2)>0+tolerancia || dfEval(2)<0-tolerancia) && X>=Rango(1) && X<=Rango(2) && Y>=Rango(3) && Y<=Rango(4))
    alpha=dfEval-dfEvalAnt;
    X=X-a*dfEval(1)+b*alpha(1);
    Y=Y-a*dfEval(2)+b*alpha(2);
    dfEvalAntt=dfEval;
    dfEval=[double(subs(dfx,[x y],[X Y])) ; double(subs(dfy,[x y],[X Y]))];
    n=n+1;
    
    %Graficar:
    pause(0.5)
    delete(grafica);
    grafica=scatter3(X,Y,subs(f,[x y],[X Y]),1200,'.');
    drawnow;
end

toc
end

