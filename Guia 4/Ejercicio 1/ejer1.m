% Variables
%{
    tamPoblacion (tamPob)----------------->Tamaño de poblacion
    tamCromosoma----------->Cantidad de genes por cromosoma
    tasaMutacion (tasaM)------------------>Tasa de mutaciones, porcentaje, definida por genes
    iteracionesMaximas=200 (maxIt)-------------->Cantidad maxima de iteraciones
    porcentagePadres (porcPadres)------------->Porcentaje de padres a seleccionar
    aptitudRequerida------->Aptitud minima requerida
    Rango (L)---------------------->Rango de x o dominio
    k---------------------->Tamaño de conjunto con seleccin competencia
    f---------------------->Funcion de aptitud
    f2--------------------->Funcion real (solo para graficar)
%}

clear all
close all
clc
%---------------------------------------------------------------------
%-------------ALGORITMO GENETICO----------------------------------
 tamPoblacion=50;
 tamCromosoma=10;
 tasaMutacion=1;
 iteracionesMaximas=200;
 porcentagePadres=50;
 k=2;

 
%%
%%FUNCION 1 - GENETICO
%  aptitudRequerida=418;
%  Rango=[-512 512];
%  f= @(x) x.*sin(sqrt(abs(x)));
%  f2=@(x) -x.*sin(sqrt(abs(x)));
%  [n,x]=ag(tamPoblacion,tamCromosoma,tasaMutacion,iteracionesMaximas,porcentagePadres,aptitudRequerida,Rango,k,f,f2 )
%%
 
%%
%%FUNCION 2 - GENETICO
 aptitudRequerida=9;
 Rango=[0 20];
 f=  @(x) -(x+5*sin(3*x)+8*cos(5*x));
 f2= @(x) (x+5*sin(3*x)+8*cos(5*x));
 [n,x]=ag(tamPoblacion,tamCromosoma,tasaMutacion,iteracionesMaximas,porcentagePadres,aptitudRequerida,Rango,k,f,f2 )
%%

%%
%%FUNCION 3 - GENETICO
% aptitudRequerida=-0.1;
% Rango=[-100 100 -100 100];
% f= @(x,y)-(x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);
% f2=@(x,y) (x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);
% tamCromosoma=100;
% tamPoblacion=100;
% [n,x]=ag(tamPoblacion,tamCromosoma,tasaMutacion,iteracionesMaximas,porcentagePadres,aptitudRequerida,Rango,k,f,f2 )
%%


 
% %---------------------------------------------------------------------
% %-------------CON GRADIENTE DESCENDIENTE------------------------------
syms x y;
cantIt=200;
tolerancia=0.01;

%%
%%FUNCION 1 - GRADIENTE
% figure()
% f=-x.*sin(sqrt(abs(x)));
% Rango=[-512,512];
% a=2; %prioriza el valor de la derivada
% b=1; %prioriza la diferencia de las derivadas 
% [n,x]=gradienteDescendiente(f,Rango,cantIt,a,b,tolerancia) 
% double(subs(f,x)) %mejor valor encontrado
 %%
 
%%
%%FUNCION 2 - GRACIENTE
figure()
 f=x+5*sin(3*x)+8*cos(5*x);
 Rango=[0,20];
 a=0.002;
 b=0.001;
 [n,x]=gradienteDescendiente(f,Rango,cantIt,a,b,tolerancia) %
 double(subs(f,x)) %mejor valor encontrado
%%

%%
%%FUNCION 3 - GRACDIENTE
% figure()
% f=(x.^2+y.^2).^0.25.*((sin(50*(x.^2+y.^2).^0.1)).^2+1);
% Rango=[-100 100 -100 100];
% a=0.01;
% b=0.02;
% [n,X,Y]=gradienteDescendiente_2D(f,Rango,cantIt,a,b,tolerancia);
% (X^2+Y^2)^0.25*((sin(50*(X^2+Y^2).^0.1)).^2+1) %mejor valor encontrado
%%