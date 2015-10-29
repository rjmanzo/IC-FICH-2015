clear all
close all
clc

%Parametros de inicializacion
Nfunc=1; %Numero de funcion a minimizar (Ver Guia 4 - ejer. 1)
cantParticulas=20;
c1_g=0.5; %Aceleracion: Comp. cognitiva 
c2_g=1-c1_g; %Aceleracion: Comp. Global
c1_l=20; %Aceleracion: Comp. cognitiva 
c2_l=40; %Aceleracion: Comp. Global
maxIter=200; %Max. de iteraciones 
p_inercial = 1;%Si quiero trabajar con peso inercial = 1, sino Default en -1 
entorno = 15; %Defino el entorno local para lEP

%Obtengo la expresion del intervalo de busqueda segun la funcion seleccionar en Nfunc  
[intervalo]=intervalo_funcion(Nfunc); 

% %Inicializo el temporarizador
% t1 = cputime;
% 
% particulas_global(intervalo,Nfunc,maxIter,p_inercial,cantParticulas,c1_g,c2_g);
% 
% %Tiempos y resultados (gEP)
% tiempoTotal_1=cputime - t1;
% display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal_1),' segundos'));

t2 = cputime;

particulas_local(intervalo,Nfunc,maxIter,p_inercial,cantParticulas,c1_l,c2_l,entorno);

%Tiempos y resultados (lEP)
tiempoTotal_2=cputime - t2;
display(strcat('Tiempo Total (lEP): ',num2str(tiempoTotal_2),' segundos'));






