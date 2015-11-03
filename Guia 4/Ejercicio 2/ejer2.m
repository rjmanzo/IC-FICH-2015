%clear all
close all
clc

%Parametros de inicializacion
Nfunc=3; %Numero de funcion a minimizar (Ver Guia 4 - ejer. 1)
cantParticulas=20;
c1=0.5; %Aceleracion: Comp. cognitiva 
c2=1-c1; %Aceleracion: Comp. Global
maxIter=200; %Max. de iteraciones 
TolCorte=1.0e-03;
p_inercial = 1;%Si quiero trabajar con peso inercial = 1, sino Default en -1 

%Obtengo la expresion del intervalo de busqueda segun la funcion seleccionar en Nfunc  
[intervalo]=intervalo_funcion(Nfunc); 

%Inicializo el temporarizador
t = cputime;

particulas_global(intervalo,Nfunc,maxIter,TolCorte,p_inercial,cantParticulas,c1,c2);

%Tiempos y resultados (gEP)
tiempoTotal=cputime - t;
display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));

