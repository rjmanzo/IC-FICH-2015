clear all
close all
clc

%Inicializacion de parametros
path_archivo_N1=strcat('../Datos/7cities.csv');  
path_archivo_N2=strcat('../Datos/10cities.csv');  

%Parametros hormiga
N = 5; %Cantidad de hormigas
b = 1; %Cantidad maxima de feromonas iniciales en un camino
p = 0.3; %Porcentaje de feromonas que se eliminan por evaporacion
Q=1;% Uniforme
alpha = 1;
beta = 1;

%Parametros Busq. Coste Uniforme
%Establezco el nodoRaiz dependiendo del archivo de entrada 
nodoRaiz_N1 = 7; % 7cities
nodoRaiz_N2 = 5; % 10cities

%%
%7cities---- Tiempos y resultados para BUSQUEDA COSTO UNIFORME------------------------
%Inicializo el temporarizador t1
% t1 = cputime;
% [mejorCaminoCU_N1,mejorCostoCU_N1]=busqueda_costo_uniforme(path_archivo_N1,nodoRaiz_N1);
% %Tiempos y resultados t1
% tiempoTotal_1=cputime - t1;
% display(strcat('7cities: tiempo total(Busq.Costo Uniforme): ',num2str(tiempoTotal_1),' segundos'));
%%

%%
%7cities  - COLONIA DE HORMIGAS
%Inicializo el temporarizador t2
% t2 = cputime;
% 
% [mejorCaminoHormiga_N1,mejorCostoHormiga_N1]=colonia_hormigas(path_archivo_N1,nodoRaiz_N1,N,b,p,alpha,beta,Q);
% 
% %Tiempos y resultados t2
% tiempoTotal_2=cputime - t2;
% display(strcat('7cities: tiempo total(AS): ',num2str(tiempoTotal_2),' segundos'));
%%






%%
%10cities - BUSQUEDA COSTO UNIFORME
%Inicializo el temporarizador t3
% t3 = cputime;
% 
% [mejorCaminoCU_N2,mejorCostoCU_N2]=busqueda_costo_uniforme(path_archivo_N2,nodoRaiz_N2);
% 
% %Tiempos y resultados t3
% tiempoTotal_3=cputime - t3;
% display(strcat('10cities: tiempo total(Busq.Costo Uniforme): ',num2str(tiempoTotal_3),' segundos'));
%%


%% 
% 10cities- COLONIA DE HORMIGAS
t4 = cputime;

[mejorCaminoHormiga_N2,mejorCostoHormiga_N2]=colonia_hormigas(path_archivo_N2,nodoRaiz_N2,N,b,p,alpha,beta,Q);

%Tiempos y resultados t4
tiempoTotal_4=cputime - t4;
display(strcat('10cities: tiempo total(AS): ',num2str(tiempoTotal_4),' segundos'));
%%